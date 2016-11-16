(*---------------------------------------------------------------------------
   Copyright (c) 2014 Daniel C. Bünzli. All rights reserved.
   Distributed under the BSD3 license, see license at the end of the file.
   %%NAME%% release %%VERSION%%
  ---------------------------------------------------------------------------*)

let str = Format.sprintf
let pp = Format.fprintf
let rec pp_list ?(pp_sep = Format.pp_print_cut) pp_v ppf = function
| [] -> ()
| v :: vs ->
    pp_v ppf v; if vs <> [] then (pp_sep ppf (); pp_list ~pp_sep pp_v ppf vs)

let exec = Filename.basename Sys.executable_name
let log msg = Format.eprintf ("%s: " ^^ msg ^^ "@?") exec
let log_error inf e =
  Format.eprintf "@[<2>%s:%s:@ %a@]@." exec inf Dicomm.pp_error e

let pp_pos ppf d =
  let f, l = Dicomm.decoded_range d in
  pp ppf "0x%04X-0x%04X" f l

(* IO tools *)

let io_buffer_size = 65536                          (* IO_BUFFER_SIZE 4.0.0 *)
let unix_buffer_size = 65536                      (* UNIX_BUFFER_SIZE 4.0.0 *)

let rec unix_read fd s j l = try Unix.read fd s j l with
| Unix.Unix_error (Unix.EINTR, _, _) -> unix_read fd s j l

let string_of_channel use_unix ic =
  let b = Buffer.create unix_buffer_size in
  let input, s =
    if use_unix
    then unix_read (Unix.descr_of_in_channel ic), Bytes.create unix_buffer_size
    else input ic, Bytes.create io_buffer_size
  in
  let rec loop b input s =
    let rc = input s 0 (Bytes.length s) in
    if rc = 0
    then (if ic <> stdin then close_in ic; Buffer.contents b) else
    (Buffer.add_substring b (Bytes.unsafe_to_string s) 0 rc; loop b input s)
  in
  loop b input s

let src_for inf sin use_unix =
  try
    let ic = if inf = "-" then stdin else open_in inf in
    if sin then `String (string_of_channel use_unix ic) else `Channel ic
  with Sys_error e -> log "%s\n" e; exit 1

let close_src src =
  try match src with `Channel ic when ic <> stdin -> close_in ic | _ -> () with
  | Sys_error e -> log "%s\n" e; exit 1

let src_for_unix inf =
  try if inf = "-" then Unix.stdin else Unix.(openfile inf [O_RDONLY] 0) with
  | Unix.Unix_error (e, _, v) -> log "%s: %s\n" (Unix.error_message e) v; exit 1

let close_src_unix fd = try if fd <> Unix.stdin then Unix.close fd with
| Unix.Unix_error (e, _, v) -> log "%s: %s\n" (Unix.error_message e) v; exit 1

(* Decode only. *)

let decode_ inf src =
  let error = log_error inf in
  let rec loop d = match Dicomm.decode d with `Await -> assert false
  | `Lexeme _ -> loop d
  | `End -> ()
  | `Error e -> error e; loop d
  in
  loop (Dicomm.decoder ~syntax:`File src);
  close_src src

let decode_unix inf usize fd =
  let error = log_error inf in
  let rec loop fd s d = match Dicomm.decode d with
  | `Lexeme _ -> loop fd s d
  | `End -> ()
  | `Error e -> error e; loop fd s d
  | `Await ->
      let rc = unix_read fd s 0 (Bytes.length s) in
      Dicomm.Manual.src d s 0 rc; loop fd s d
  in
  loop fd (Bytes.create usize) (Dicomm.decoder ~syntax:`File `Manual);
  close_src_unix fd

let decode sin use_unix usize inf =
  if sin || not use_unix then decode_ inf (src_for inf sin use_unix) else
  decode_unix inf usize (src_for_unix inf)

(* Dump *)

let pp_decode inf d ppf v =
  pp ppf "%s:%a%a@." inf pp_pos d Dicomm.pp_decode v

let dump_ inf src =
  let rec loop inf d = match Dicomm.decode d with `Await -> assert false
  | v ->
      (pp_decode inf d) Format.std_formatter v;
      if v <> `End then loop inf d
  in
  loop inf (Dicomm.decoder ~syntax:`File src);
  close_src src

let dump_unix inf usize fd =
  let rec loop fd s d = match Dicomm.decode d with
  | `Await ->
      let rc = unix_read fd s 0 (Bytes.length s) in
      Dicomm.Manual.src d s 0 rc; loop fd s d
  | v -> (pp_decode inf d) Format.std_formatter v; if v <> `End then loop fd s d
  in
  loop fd (Bytes.create usize) (Dicomm.decoder ~syntax:`File `Manual);
  close_src_unix fd

let dump sin use_unix usize inf =
  if sin || not use_unix then dump_ inf (src_for inf sin use_unix) else
  dump_unix inf usize (src_for_unix inf)

(* Print. *)

let pp_tag_name ppf tag = match Dicomm.Tag.name tag with
| None when (Dicomm.Tag.group tag mod 2 <> 0) -> pp ppf "private"
| None -> pp ppf "unknown"
| Some name -> pp ppf "%s" name

let pp_uid ppf uid = match Dicomm.Uid.name uid with
| None -> pp ppf "%s" uid
| Some n -> pp ppf "%s@ (%s)" n uid

let pp_value ?limit vr ppf v = match vr with
| `UI ->
    begin match v with
    | `String (`One uid) -> pp_uid ppf uid
    | `String (`Many uids) ->
        let pp_sep ppf () = pp ppf ",@ " in
        pp_list ~pp_sep pp_uid ppf uids
    | _ -> assert false
    end
| _ -> Dicomm.pp_value ?limit ppf v

let pp_lexeme ?limit ppf = function
| `E (tag, vr, v) ->
    pp ppf "%a %a @[%a : %a@]@,"
      Dicomm.Tag.pp tag Dicomm.pp_vr vr pp_tag_name tag (pp_value ?limit vr) v
| `Ss tag ->
    pp ppf "%a SQ @[<v>%a:@," Dicomm.Tag.pp tag pp_tag_name tag
| `I -> pp ppf "Item@,"
| `Se _ -> pp ppf "@]@,"

let print_ ?limit inf src =
  let ppf = Format.std_formatter in
  let rec loop inf d = match Dicomm.decode d with
  | `Await -> assert false
  | `Lexeme l -> pp ppf  "%a" (pp_lexeme ?limit) l; loop inf d
  | `End -> ()
  | `Error e ->
      pp Format.err_formatter "%s:%a: @[%a@]@."
        inf pp_pos d Dicomm.pp_error e; loop inf d
  in
  pp ppf "@[<v>";
  loop inf (Dicomm.decoder ~syntax:`File src);
  pp ppf "@]@.";
  close_src src

let print_unix ?limit inf usize fd =
  let ppf = Format.std_formatter in
  let rec loop fd s d = match Dicomm.decode d with
  | `Await ->
      let rc = unix_read fd s 0 (Bytes.length s) in
      Dicomm.Manual.src d s 0 rc; loop fd s d
  | `Lexeme l -> pp ppf  "%a" (pp_lexeme ?limit) l; loop fd s d
  | `End -> ()
  | `Error e ->
      pp Format.err_formatter "%s:%a: @[%a@]@." inf pp_pos d Dicomm.pp_error e;
      loop fd s d
  in
  pp ppf "@[<v>";
  loop fd (Bytes.create usize) (Dicomm.decoder ~syntax:`File `Manual);
  pp ppf "@]@.";
  close_src_unix fd

let print limit sin use_unix usize inf =
  if sin || not use_unix
  then print_ ?limit inf (src_for inf sin use_unix)
  else print_unix ?limit inf usize (src_for_unix inf)

(* dicomtrip *)

let main () =
  let usage = Printf.sprintf
      "Usage: %s [OPTION]... [DICOMFILE]...\n\
       Print human readable DICOM file information on stdout.\n\
       Options:" exec
  in
  let cmd = ref `Print in
  let set_cmd v () = cmd := v in
  let files = ref [] in
  let add_file f = files := f :: !files in
  let sin = ref false in
  let use_unix = ref false in
  let usize = ref unix_buffer_size in
  let limit = ref (Some 128) in
  let nat s r v = if v > 0 then r := v else log "%s must be > 0, ignored\n" s in
  let options = [
    "-print", Arg.Unit (set_cmd `Print),
    " Elements in human readable form.";
    "-dec", Arg.Unit (set_cmd `Decode),
    " Decode only";
    "-limit", Arg.Int (fun i -> limit := Some i),
    "<int> max number of array elements to print (defaults to 128).";
    "-unlimited", Arg.Unit (fun () -> limit := None),
    " always print all the elements of arrays.";
    "-dump", Arg.Unit (set_cmd `Dump),
    " Dump decodes and their position, one per line";
    "-sin", Arg.Set sin,
    " Input as string and decode the string";
    "-unix", Arg.Set use_unix,
    " Use Unix IO";
    "-usize", Arg.Int (nat "-usize" usize),
    "<int> Unix IO buffer sizes in bytes"; ]
  in
  Arg.parse (Arg.align options) add_file usage;
  let files = match !files with [] -> [ "-" ] | f -> List.rev f in
  let cmd = match !cmd with
  | `Print -> print !limit !sin !use_unix !usize
  | `Dump -> dump !sin !use_unix !usize
  | `Decode -> decode !sin !use_unix !usize
  in
  List.iter cmd files

let () = main ()

(*---------------------------------------------------------------------------
   Copyright (c) 2014 Daniel C. Bünzli.
   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions
   are met:

   1. Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.

   3. Neither the name of Daniel C. Bünzli nor the names of
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  ---------------------------------------------------------------------------*)
