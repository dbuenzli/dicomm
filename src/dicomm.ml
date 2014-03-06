(*---------------------------------------------------------------------------
   Copyright (c) 2014 Daniel C. Bünzli. All rights reserved.
   Distributed under the BSD3 license, see license at the end of the file.
   %%NAME%% release %%VERSION%%
  ---------------------------------------------------------------------------*)

let pp = Format.fprintf
let rec pp_list ?(pp_sep = Format.pp_print_cut) pp_v ppf = function 
| [] -> ()
| v :: vs ->
    pp_v ppf v; if vs <> [] then (pp_sep ppf (); pp_list ~pp_sep pp_v ppf vs)

let rec pp_bigarray ?limit ?(pp_sep = Format.pp_print_cut) pp_v ppf ba = 
  let max = Bigarray.Array1.dim ba - 1 in 
  let max = match limit with None -> max | Some l -> min l max in
  if max < 0 then () else
  begin 
    pp_v ppf ba.{0}; 
    for i = 1 to max do pp_sep ppf (); pp_v ppf ba.{i} done;
    if max <> Bigarray.Array1.dim ba - 1 then pp ppf "%a..." pp_sep ();
  end

(* Unsafe string byte manipulations. If you don't believe the author's
   invariants, replacing with safe versions makes everything safe in
   the module. He won't be upset. *)

let unsafe_char s j = String.unsafe_get s j
let unsafe_byte s j = Char.code (String.unsafe_get s j)

(* Data model *) 

type syntax = [ `File | `LE_explicit | `BE_explicit | `LE_implicit ]

type vr = 
  [ `AE | `AS | `AT | `CS | `DA | `DS | `DT | `FL | `FD | `IS | `LO | `LT 
  | `OB | `OF | `OW | `PN | `SH | `SL | `SQ | `SS | `ST | `TM | `UI | `UL 
  | `UN | `US | `UT ]

let vr_to_string = function 
| `AE -> "AE" | `AS -> "AS" | `AT -> "AT" | `CS -> "CS" | `DA -> "DA" 
| `DS -> "DS" | `DT -> "DT" | `FL -> "FL" | `FD -> "FD" | `IS -> "IS" 
| `LO -> "LO" | `LT -> "LT" | `OB -> "OB" | `OF -> "OF" | `OW -> "OW" 
| `PN -> "PN" | `SH -> "SH" | `SL -> "SL" | `SQ -> "SQ" | `SS -> "SS" 
| `ST -> "ST" | `TM -> "TM" | `UI -> "UI" | `UL -> "UL" | `UN -> "UN" 
| `US -> "US" | `UT -> "UT" 

let pp_vr ppf vr = pp ppf "%s" (vr_to_string vr)

let int_to_vr = 
  let module Int = struct 
    type t = int 
    let compare : int -> int -> int = Pervasives.compare 
  end
  in
  let module Imap = Map.Make (Int) in
  let vr_to_int s = ((Char.code s.[0]) lsl 8) lor (Char.code s.[1]) in
  let add_vr acc (s, v) = Imap.add (vr_to_int s) v acc in
  let int_to_vr = List.fold_left add_vr Imap.empty
      [ "AE", `AE; "AS", `AS; "AT", `AT; "CS", `CS; "DA", `DA; "DS", `DS; 
        "DT", `DT; "FL", `FL; "FD", `FD; "IS", `IS; "LO", `LO; "LT", `LT; 
        "OB", `OB; "OF", `OF; "OW", `OW; "PN", `PN; "SH", `SH; "SL", `SL; 
        "SQ", `SQ; "SS", `SS; "ST", `ST; "TM", `TM; "UI", `UI; "UL", `UL; 
        "UN", `UN; "US", `US; "UT", `UT; ]
  in
  fun i -> try Some (Imap.find i int_to_vr) with Not_found -> None 
              
module Tag = struct
  module Tmap = Map.Make (Int32)
  module Tset = Set.Make (Int32)
  type t = int32

  let group t = Int32.(to_int (shift_right_logical t 16))
  let element t = Int32.(to_int (logand t 0x0000FFFFl))
  let of_group_element g e = Int32.(logor (shift_left (of_int g) 16) (of_int e))

  let dict = 
    let add acc (t, v) = Tmap.add t v acc in
    List.fold_left add Tmap.empty Dicomm_data.elements
      
  let mask_to_reprs =    (* maps masks to equivalence class representatives. *) 
    let to_list m = Tmap.fold (fun k v acc -> (k, v) :: acc) m [] in
    let add_mask acc (repr, mask) =
      let reprs = try Tmap.find mask acc with Not_found -> Tset.empty in 
      Tmap.add mask (Tset.add repr reprs) acc
    in
    to_list (List.fold_left add_mask Tmap.empty Dicomm_data.element_ranges)

  let lookup t nth = 
    try Some (nth (Tmap.find t dict)) 
    with Not_found ->
      let rec find_repr = function 
      | (mask, reprs) :: rest ->
          let repr = Int32.logand t mask in 
          if Tset.mem repr reprs then Some repr else find_repr rest
      | [] -> None
      in
      match find_repr mask_to_reprs with 
      | None -> None 
      | Some repr -> 
          try Some (nth (Tmap.find repr dict)) 
          with Not_found -> assert false

  let name t = lookup t (fun (n, _, _, _, _) -> n)
  let keyword t = lookup t (fun (_, k, _, _, _) -> k)
  let vr t = match lookup t (fun (_, _, vr, _, _) -> vr) with 
  | None -> if element t = 0x0000 then Some `UL (* group length *) else None 
  | Some _ as r -> r

  let vm t = lookup t (fun (_, _, _, vm, _) -> vm)
  let retired t = lookup t (fun (_, _, _, _, r) -> r)
  let pp ppf t = pp ppf "@[(%04X,%04X)@]" (group t) (element t)

  let item = 0xFFFE_E000l
  let item_delim = 0xFFFE_E00Dl
  let seq_delim = 0xFFFE_E0DDl
end

module Uid = struct
  type t = string
  
  let name = 
    let module Smap = Map.Make (String) in
    let add acc (k, v) = Smap.add k v acc in
    let names = List.fold_left add Smap.empty Dicomm_data.uid_names in 
    fun uid -> try Some (Smap.find uid names) with Not_found -> None

  let to_syntax = function
  | "1.2.840.10008.1.2" -> `LE_implicit
  | "1.2.840.10008.1.2.1" -> `LE_explicit 
  | "1.2.840.10008.1.2.2" -> `BE_explicit
  | _ -> `LE_explicit
end

type time = Dicomm_time.t
let pp_time = Dicomm_time.pp

type ('a, 'b) bigarray = ('a, 'b, Bigarray.c_layout) Bigarray.Array1.t
type value =
  [ `String of [ `One of string | `Many of string list ]
  | `UInt8 of (int, Bigarray.int8_unsigned_elt) bigarray
  | `Float32 of (float, Bigarray.float32_elt) bigarray
  | `Float64 of (float, Bigarray.float64_elt) bigarray
  | `Int16 of (int, Bigarray.int16_signed_elt) bigarray 
  | `UInt16 of (int, Bigarray.int16_unsigned_elt) bigarray 
  | `Int32 of (int32, Bigarray.int32_elt) bigarray 
  | `UInt32 of (int32, Bigarray.int32_elt) bigarray 
  | `Tag of [ `One of Tag.t | `Many of Tag.t list ] 
  | `Time of [ `One of time | `Many of time list ]]

let pp_value ?limit ppf v =
  let pp_sep ppf () = pp ppf ",@ " in
  let pp_list pp_v = pp_list ~pp_sep pp_v in 
  let pp_ba pp_v = pp_bigarray ?limit ~pp_sep pp_v in
  match v with
  | `String (`One s) -> 
      pp ppf "%s" s 
  | `String (`Many l) -> 
      pp ppf "@[%a@]" (pp_list Format.pp_print_string) l
  | `UInt8 ba -> 
      let pp_char ppf v = pp ppf "%s" (Char.escaped (Char.chr v)) in
      (pp_bigarray ?limit ~pp_sep:(fun ppf () -> ()) pp_char) ppf ba
  | `Int16 ba ->
      (pp_ba (fun ppf v -> pp ppf "%d" v)) ppf ba
  | `UInt16 ba ->
      (pp_ba (fun ppf v -> pp ppf "%d" v)) ppf ba
  | `Int32 ba ->
      (pp_ba (fun ppf v -> pp ppf "%ld" v)) ppf ba 
  | `UInt32 ba ->
      (pp_ba (fun ppf v -> pp ppf "%lu" v)) ppf ba
  | `Float32 ba ->
      (pp_ba (fun ppf v -> pp ppf "%g" v)) ppf ba
  | `Float64 ba ->
      (pp_ba (fun ppf v -> pp ppf "%g" v)) ppf ba
  | `Tag (`One t) -> 
      pp ppf "%a" Tag.pp t
  | `Tag (`Many l) -> 
      pp ppf "@[%a@]" (pp_list Tag.pp) l
  | `Time (`One dt) -> 
      pp ppf "%a" pp_time dt
  | `Time (`Many l) -> 
      pp ppf "@[%a@]" (pp_list pp_time) l

type element = Tag.t * vr * value

let pp_element ppf (tag, vr, v) =
  let limit = None in
  pp ppf "@[%a %a @[%a@]@]" Tag.pp tag pp_vr vr (pp_value ?limit) v 

type lexeme = [ `E of element | `Ss of Tag.t | `Se of Tag.t | `I ]

let pp_lexeme ppf = function 
| `E e -> pp ppf "@[`E %a@]" pp_element e
| `Ss tag -> pp ppf "@[`Ss %a@]" Tag.pp tag
| `I -> pp ppf "@[`I@]" 
| `Se tag -> pp ppf "@[`Se %a@]" Tag.pp tag

module Bytes = Dicomm_bytes

(* Decode *) 

type error = [ 
  | `Eoi of [ 
      | `File_preamble | `File_dicom_prefix | `Tag_or_eoi 
      | `Reserved of Tag.t | `Vr of Tag.t | `Value_length of Tag.t 
      | `Value of Tag.t | `Tag ]
  | `Value_length_overflow of Tag.t
  | `Value_length_undefined of Tag.t
  | `Value_length_mismatch of Tag.t * int * int 
  | `Unknown_vr of Tag.t * string
  | `Parse_int of Tag.t * string
  | `Parse_float of Tag.t * string 
  | `Parse_time of Tag.t * string
  | `Parse_file_dicom_prefix 
  | `File_syntax_unspecified 
  | `File_syntax_vr_not_uid of vr ]

let pp_error ppf = function 
| `Eoi e -> 
    pp ppf "@[end of input but@ expected@ "; 
    begin match e with 
    | `File_preamble -> pp ppf "128@ bytes@ file@ preamble" 
    | `File_dicom_prefix -> pp ppf "file@ `DICM'@ prefix"
    | `Vr tag -> pp ppf "value@ representation@ for@ %a" Tag.pp tag
    | `Reserved tag -> pp ppf "reserved@ bytes@ for@ %a" Tag.pp tag
    | `Value_length tag -> pp ppf "value length@ for@ %a" Tag.pp tag
    | `Value tag -> pp ppf "value@ for %a" Tag.pp tag
    | `Tag_or_eoi -> pp ppf "tag@ or@ end@ of@ input"
    | `Tag -> pp ppf "tag" 
    end;
    pp ppf "@]"
| `Value_length_overflow tag -> 
    pp ppf "@[value@ length@ overflow@ for@ %a@]" Tag.pp tag
| `Value_length_undefined tag -> 
    pp ppf "@[value@ length@ undefined@ for@ %a@]" Tag.pp tag
| `Value_length_mismatch (tag, len, csize) -> 
    pp ppf "@[value@ length@ %d@ not@ a@ multiple@ of@ %d@ for@ %a@]"
      len csize Tag.pp tag
| `Unknown_vr (tag, vr) -> 
    pp ppf "@[unknown@ VR %S for@ %a@]" vr Tag.pp tag
| `Parse_int (tag, is) -> 
    pp ppf "@[could@ not@ parse@ integer@ string@ (%S)@ for@ %a@]" is Tag.pp tag
| `Parse_float (tag, fs) -> 
    pp ppf "@[could@ not@ parse@ decimal@ string@ (%S)@ for@ %a@]" fs Tag.pp tag
| `Parse_file_dicom_prefix -> 
    pp ppf "@[could@ not@ parse@ file@ `DICM'@ prefix@]" 
| `Parse_time(tag, ts) -> 
    pp ppf "@[could@ not@ parse@ time@ (%S)@ for @ %a@]" ts Tag.pp tag
| `File_syntax_unspecified -> 
    pp ppf "@[unspecified file transfer syntax@]" 
| `File_syntax_vr_not_uid vr -> 
    pp ppf "@[file transfer syntax VR not an UID (%s) @]" (vr_to_string vr)

let err_eoi_file_preamble = `Error (`Eoi `File_preamble) 
let err_eoi_file_prefix = `Error (`Eoi `File_dicom_prefix) 
let err_eoi_vr tag = `Error (`Eoi (`Vr tag)) 
let err_eoi_reserved tag = `Error (`Eoi (`Reserved tag)) 
let err_eoi_value_length tag = `Error (`Eoi (`Value_length tag)) 
let err_eoi_value tag = `Error (`Eoi (`Value tag))
let err_eoi_tag_or_eoi = `Error (`Eoi `Tag_or_eoi)
let err_eoi_tag = `Error (`Eoi `Tag)
let err_unknown_tag_vr tag = `Error (`Unknown_tag_vr tag)
let err_unknown_vr tag vr = `Error (`Unknown_vr (tag, vr))
let err_val_len_overflow tag = `Error (`Value_length_overflow tag)
let err_val_len_undefined tag = `Error (`Value_length_undefined tag)
let err_val_len_mismatch tag len csize =
  `Error (`Value_length_mismatch (tag, len, csize))

let err_parse_int tag is = `Error (`Parse_int (tag, is))
let err_parse_float tag ds = `Error (`Parse_float (tag, ds))
let err_parse_time tag ts = `Error (`Parse_time (tag, ts))
let err_parse_file_prefix = `Error (`Parse_file_dicom_prefix)
let err_file_syntax_unspecified = `Error (`File_syntax_unspecified)
let err_file_syntax_vr_not_uid vr = `Error (`File_syntax_vr_not_uid vr)

type decode = [ `Await | `End | `Error of error | `Lexeme of lexeme ]

let pp_decode ppf = function 
| `Lexeme l -> pp ppf "@[`Lexeme @[(%a)@]@]" pp_lexeme l 
| `Await -> pp ppf "`Await" 
| `End -> pp ppf "`End"
| `Error e -> pp ppf "@[`Error @[(%a)@]@]" pp_error e

type src = Dicomm_bytes.src
type decoder = 
  { vr : Tag.t -> vr;                    (* Determine VR for unknown tags. *) 
    mutable i : Bytes.t;                      (* Non-blocking byte stream. *) 
    mutable syntax : syntax;                            (* Decoded syntax. *) 
    mutable spos : int;                      (* last saved start position. *)
    mutable stack : (Tag.t * int) list;    (* Stack of open tag sequences. *) 
    mutable k : decoder -> decode                 (* decoder continuation. *) }

let save_pos d = d.spos <- Bytes.count d.i

(* Getting and skipping bytes. *)

let never d = assert false 

let ret (v : [< decode]) k d = d.k <- k; v  
let ret_eoi d = (save_pos d; `End)
let ret_element tag vr v k d = ret (`Lexeme (`E (tag, vr, v))) k d

let await ~err k d = 
  let rec loop ~err k d = match Bytes.await d.i with
  | `Ok -> k d
  | `Await -> ret `Await (loop ~err k) d
  | `End -> ret err ret_eoi d
  in
  ret `Await (loop ~err k) d 

let skip n ~err k d = match Bytes.skip d.i n with 
| `Ok -> k d
| `Await -> await ~err k d
| `End -> ret err ret_eoi d 
            
let large_skip hi lo ~err k d =
  let rec loop hi lo ~err k d = 
    if hi = 0 then skip lo ~err k d else 
    skip 65535 ~err (loop (hi - 1) lo ~err k) d
  in
  (save_pos d; loop hi lo ~err k d)

let skip n ~err k d = save_pos d; skip n ~err k d
let get n ~err k d =
  save_pos d;
  match Bytes.get d.i n with 
  | `Ok -> k d
  | `Await -> await ~err k d  
  | `End -> ret err ret_eoi d

let try_get n ~err k d =                         (* exactly [n] bytes or eoi *) 
  save_pos d;
  match Bytes.get d.i n with 
  | `Ok -> k `Ok d
  | `Await -> 
      let rec loop k d = match Bytes.await d.i with
      | `Ok -> k `Ok d
      | `Await -> ret `Await (loop k) d
      | `End -> if Bytes.len d.i <> 0 then ret err ret_eoi d else k `End d
      in
      ret `Await (loop k) d 
  | `End -> if Bytes.len d.i <> 0 then ret err ret_eoi d else k `End d

(* Parsing bytes *) 

let p_file_prefix d = 
  let s = Bytes.bytes d.i in
  let i = Bytes.start d.i in
  unsafe_char s i       = 'D' &&
  unsafe_char s (i + 1) = 'I' &&
  unsafe_char s (i + 2) = 'C' &&
  unsafe_char s (i + 3) = 'M'

let p_tag b1 b0 d i =
  let s = Bytes.bytes d.i in 
  let i = Bytes.start d.i + (i * 4) in
  let g0 = unsafe_byte s (i + b0) in 
  let g1 = unsafe_byte s (i + b1) in 
  let g = (g1 lsl 8) lor g0 in 
  let i = i + 2 in 
  let e0 = unsafe_byte s (i + b0) in 
  let e1 = unsafe_byte s (i + b1) in 
  let e = (e1 lsl 8) lor e0 in 
  Int32.(logor (shift_left (of_int g) 16) (of_int e))
  
let p_tag_be d i = p_tag 0 1 d i
let p_tag_le d i = p_tag 1 0 d i

let p_vr d = 
  let s = Bytes.bytes d.i in 
  let i = Bytes.start d.i in 
  let vr1 = unsafe_byte s i in 
  let vr0 = unsafe_byte s (i + 1) in 
  int_to_vr ((vr1 lsl 8) lor vr0)

let p_length b3 b2 b1 b0 d =     (* handles 32 bits platforms gracefully. *) 
  let s = Bytes.bytes d.i in 
  let i = Bytes.start d.i in 
  let b0 = unsafe_byte s (i + b0) in 
  let b1 = unsafe_byte s (i + b1) in 
  let b2 = unsafe_byte s (i + b2) in 
  let b3 = unsafe_byte s (i + b3) in
  let lo = (b1 lsl 8) lor b0 in 
  let hi = (b3 lsl 8) lor b2 in
  let hi_32 = hi lsl 16 in 
  if hi = 0xFFFF && lo = 0xFFFF then `Undefined else 
  if hi_32 <= 0 && hi <> 0 then `Overflow (hi, lo) else 
  `Int (hi_32 lor lo)

let p_length_le d = p_length 3 2 1 0 d
let p_length_be d = p_length 0 1 2 3 d

let p_uint8 d i = 
  let s = Bytes.bytes d.i in 
  let i = Bytes.start d.i + i in 
  unsafe_byte s i

let p_uint16 b1 b0 d i = 
  let s = Bytes.bytes d.i in
  let i = Bytes.start d.i + (i * 2) in 
  let b0 = unsafe_byte s (i + b0) in
  let b1 = unsafe_byte s (i + b1) in
  ((b1 lsl 8) lor b0)

let p_uint16_le d i = p_uint16 1 0 d i 
let p_uint16_be d i = p_uint16 0 1 d i

let p_int16 b1 b0 d i = 
  let s = Bytes.bytes d.i in 
  let i = Bytes.start d.i + (i * 2) in 
  let b0 = unsafe_byte s (i + b0) in
  let b1 = unsafe_byte s (i + b1) in
  let v = ((b1 lsl 8) lor b0) in 
  v - (v lsr 15 * 0x10000)

let p_int16_le d i = p_int16 1 0 d i 
let p_int16_be d i = p_int16 0 1 d i

let p_int32 b3 b2 b1 b0 d i = 
  let s = Bytes.bytes d.i in 
  let i = Bytes.start d.i + (i * 4) in 
  let b0 = unsafe_byte s (i + b0) in 
  let b1 = unsafe_byte s (i + b1) in 
  let b2 = unsafe_byte s (i + b2) in 
  let b3 = unsafe_byte s (i + b3) in
  let lo = (b1 lsl 8) lor b0 in 
  let hi = (b3 lsl 8) lor b2 in 
  Int32.(logor (shift_left (of_int hi) 16) (of_int lo))

let p_int32_le d i = p_int32 3 2 1 0 d i
let p_int32_be d i = p_int32 0 1 2 3 d i 
let p_uint32_le = p_int32_le
let p_uint32_be = p_int32_be
let p_float32_le d i = Int32.float_of_bits (p_int32_le d i)
let p_float32_be d i = Int32.float_of_bits (p_int32_be d i)

let p_float64_le d i = 
  let lo = p_int32_le d i in 
  let hi = p_int32_le d (i + 1) in 
  Int64.(float_of_bits (logor (shift_left (of_int32 hi) 32) (of_int32 lo)))

let p_float64_be d i = 
  let hi = p_int32_be d i in 
  let lo = p_int32_be d (i + 1) in 
  Int64.(float_of_bits (logor (shift_left (of_int32 hi) 32) (of_int32 lo)))

(* Decoders *) 

let d_try_tag p_tag k d =                            (* decodes a tag or eoi *) 
  try_get 4 ~err:err_eoi_tag_or_eoi begin fun r d -> match r with 
  | `Ok -> k (p_tag d 0) d
  | `End -> ret_eoi d 
  end d

let d_tag p_tag k d = 
  get 4 ~err:(err_eoi_tag) begin fun d -> k (p_tag d 0) d end d

let d_vr tag k d =
  get 2 ~err:(err_eoi_vr tag) begin fun d -> match p_vr d with
  | None -> ret (err_unknown_vr tag (Bytes.copy d.i)) (k tag `UN) d
  | Some vr -> (k tag vr) d
  end d

let many_values tag = match Tag.vm tag with 
| None | Some `One -> false 
| _ -> true

let skip_if_unhandled_length tag vr len k k' d = match len with 
| `Undefined -> 
    let skip = large_skip 0xFFFF 0xFFFF ~err:(err_eoi_value tag) k in
    ret (err_val_len_undefined tag) skip d
| `Overflow (hi, lo) ->
    let err = err_eoi_value tag in
    ret (err_val_len_overflow tag) (large_skip hi lo ~err k) d 
| `Int len when len > Sys.max_string_length -> 
    ret (err_val_len_overflow tag) (skip len ~err:(err_eoi_value tag) k) d 
| `Int len -> k' len d
 
let d_string tag vr len k d =
  skip_if_unhandled_length tag vr len k begin fun len d -> 
    get len ~err:(err_eoi_value tag) begin fun d ->
      let v = match many_values tag with 
      | true -> `String (`Many (Bytes.copy_many_unpad_string d.i)) 
      | false -> `String (`One (Bytes.copy_unpad_string d.i))
      in
      ret_element tag vr v k d
    end d
  end d

let d_number_string tag (vr : [ `IS | `DS ]) len k d = 
  skip_if_unhandled_length tag vr len k begin fun len d ->
    get len ~err:(err_eoi_value tag) begin fun d -> 
      let rec fill result parse err ba j = function
      | i :: is -> 
          let fail = 
            try ba.{j} <- parse (String.trim i); false 
            with Failure _ -> true 
          in
          if fail then (ret (err tag i) k d) else 
          fill result parse err ba (j + 1) is 
      | [] -> ret_element tag (vr :> vr) (result ba) k d
      in
      let numbers = match many_values tag with 
      | true -> Bytes.copy_many_unpad_string d.i
      | false -> [ Bytes.copy_unpad_string d.i ]
      in
      let count = List.length numbers in
      match vr with 
      | `IS -> 
          let ba = Bigarray.(Array1.create int32 c_layout count) in
          let result ba = `Int32 ba in
          fill result Int32.of_string err_parse_int ba 0 numbers
      | `DS -> 
          let ba = Bigarray.(Array1.create float64 c_layout count) in 
          let result ba = `Float64 ba in
          fill result float_of_string err_parse_float ba 0 numbers
    end d
  end d

let d_tags p_tag tag vr len k d = 
  skip_if_unhandled_length tag vr len k begin fun len d ->
    let err = err_eoi_value tag in
    let tsize = 4 in
    if len mod tsize <> 0 
    then ret (err_val_len_mismatch tag len tsize) (skip len ~err k) d else
    get len ~err begin fun d -> 
      let count = len / tsize in
      let acc = ref [] in 
      for i = count - 1 downto 0 do acc := (p_tag d i) :: !acc done; 
      let v = match !acc with [one] -> `One one | l -> `Many l in
      ret_element tag (vr :> vr) (`Tag v) k d
    end d
  end d
        
let d_array kind ksize result p_comp tag vr len k d = 
  let err = err_eoi_value tag in 
  match len with 
  | `Overflow (hi, lo) -> 
      ret (err_val_len_overflow tag) (large_skip hi lo ~err k) d 
  | `Undefined -> 
      (* TODO, here according to the transfer syntax 
         and for tag (7FE0, 0010) and VR `OB or `OW 
         we should decode, see PS 3.5 annex A. *) 
      let skip = large_skip 0xFFFF 0xFFFF ~err k in 
      ret (err_val_len_undefined tag) skip d
  | `Int len when len > Sys.max_string_length -> 
      ret (err_val_len_overflow tag) (skip len ~err k) d 
  | `Int len ->
      if len mod ksize <> 0 
      then ret (err_val_len_mismatch tag len ksize) (skip len ~err k) d else
      get len ~err begin fun d ->
        let count = len / ksize in
        let ba = Bigarray.(Array1.create kind c_layout count) in
        for i = 0 to count - 1 do ba.{i} <- p_comp d i done;
        ret_element tag vr (result ba) k d
      end d

let d_uint8_array tag vr len k d = 
  let result ba = `UInt8 ba in
  d_array Bigarray.int8_unsigned 1 result p_uint8 tag vr len k d 
  
let d_int16_array p_int16 tag vr len k d = 
  let result ba = `Int16 ba in
  d_array Bigarray.int16_signed 2 result p_int16 tag vr len k d 

let d_uint16_array p_uint16 tag vr len k d =
  let result ba = `UInt16 ba in
  d_array Bigarray.int16_unsigned 2 result p_uint16 tag vr len k d 

let d_int32_array p_int32 tag vr len k d = 
  let result ba = `Int32 ba in
  d_array Bigarray.int32 4 result p_int32 tag vr len k d 

let d_uint32_array p_uint32 tag vr len k d = 
  let result ba = `UInt32 ba in
  d_array Bigarray.int32 4 result p_uint32 tag vr len k d 

let d_float32_array p_float32 tag vr len k d =
  let result ba = `Float32 ba in
  d_array Bigarray.float32 4 result p_float32 tag vr len k d 

let d_float64_array p_float64 tag vr len k d =
  let result ba = `Float64 ba in
  d_array Bigarray.float64 8 result p_float64 tag vr len k d 
  
let d_value p_tag p_int16 p_uint16 p_int32 p_uint32 p_float32 p_float64 
    tag vr len k d = 
  match vr with
  | `CS | `SH | `LO | `ST | `LT | `UT
  | `PN | `AE | `AS | `UI
  | `DA | `TM | `DT -> d_string tag vr len k d
  | `IS | `DS as vr -> d_number_string tag vr len k d
  | `SS -> d_int16_array p_int16 tag vr len k d
  | `US | `OW as vr -> d_uint16_array p_uint16 tag vr len k d
  | `SL -> d_int32_array p_int32 tag vr len k d 
  | `UL -> d_uint32_array p_uint32 tag vr len k d 
  | `FL | `OF -> d_float32_array p_float32 tag vr len k d
  | `FD -> d_float64_array p_float64 tag vr len k d
(*  | `OB when len = `Undefined -> *)
  | `OB | `UN -> d_uint8_array tag vr len k d
  | `AT -> d_tags p_tag tag vr len k d 
  | `SQ -> assert false

let d_value_le tag vr len k d = 
  d_value
    p_tag_le p_int16_le p_uint16_le p_int32_le p_uint32_le p_float32_le 
    p_float64_le tag vr len k d 
    
let d_value_be tag vr len k d =
  d_value
    p_tag_be p_int16_be p_uint16_be p_int32_be p_uint32_be p_float32_be 
    p_float64_be tag vr len k d 
    
let rec d_items p_tag d_element len k d = match len with 
| `Undefined ->
    d_tag p_tag begin fun tag d -> match tag with 
    | tag when tag = Tag.seq_delim ->
        get 4 ~err:(err_eoi_value_length tag) begin fun d -> 
          let t, _ = List.hd d.stack in 
          d.stack <- List.tl d.stack;
          ret (`Lexeme (`Se t)) k d
        end d
    | tag when tag = Tag.item ->
        get 4 ~err:(err_eoi_value_length tag) begin fun d -> 
          ret (`Lexeme `I) (d_items p_tag d_element len k) d
        end d
    | tag when tag = Tag.item_delim ->
        get 4 ~err:(err_eoi_value_length tag)
          (d_items p_tag d_element len k) d
    | tag -> 
        d_element tag (d_items p_tag d_element len k) d
    end d
| `Int len as l -> 
    let t, pos = List.hd d.stack in
    if Bytes.count d.i - pos = len 
    then (d.stack <- List.tl d.stack; ret (`Lexeme (`Se t)) k d) else
    d_tag p_tag begin fun tag d -> match tag with 
    | tag when tag = Tag.item ->
        get 4 ~err:(err_eoi_value_length tag) begin fun d -> 
          ret (`Lexeme `I) (d_items p_tag d_element l k) d
        end d
    | tag when tag = Tag.item_delim ->
        get 4 ~err:(err_eoi_value_length tag)
          (d_items p_tag d_element l k) d
    | tag -> 
        d_element tag (d_items p_tag d_element l k) d
    end d

let d_sequence p_tag d_element tag len k d = match len with 
| `Overflow (hi, lo) -> 
    let err = err_eoi_value tag in
    ret (err_val_len_overflow tag) (large_skip hi lo ~err k) d 
| `Int _ | `Undefined as len -> 
    d.stack <- (tag, Bytes.count d.i) :: d.stack; 
    ret (`Lexeme (`Ss tag)) (d_items p_tag d_element len k) d
      
let rec d_element_lei tag k d =
  get 4 ~err:(err_eoi_value_length tag) begin fun d ->
    let len = p_length_le d in
    let (vr : vr) = match Tag.vr tag with 
    | None -> d.vr tag 
    | Some (#vr as vr) -> vr 
    | Some (`OB_or_OW) -> `OW 
    | Some (`US_or_SS | `US_or_OW | `US_or_SS_or_OW) -> `US
    in 
    match vr with 
    | `SQ -> d_sequence p_tag_le d_element_lei tag len k d
    | vr -> d_value_le tag vr len k d
  end d
  
let rec d_element_explicit p_tag p_uint16 p_length d_value tag k d =
  d_vr tag begin fun tag vr d -> match vr with 
  | `OB | `OW | `OF | `UT | `UN | `SQ as vr -> 
      save_pos d;
      skip 2 ~err:(err_eoi_reserved tag) begin fun d -> 
        save_pos d;
        get 4 ~err:(err_eoi_value_length tag) begin fun d -> 
          match vr with 
          | `SQ -> 
              let d_element = 
                d_element_explicit p_tag p_uint16 p_length d_value 
              in
              d_sequence p_tag d_element tag (p_length d) k d
          | vr -> d_value tag vr (p_length d) k d
        end d
      end d
  | #vr as vr ->
      save_pos d;
      get 2 ~err:(err_eoi_value_length tag) begin fun d -> 
        d_value tag vr (`Int (p_uint16 d 0)) k d
      end d
  end d

let d_element_lee tag k d = 
  d_element_explicit p_tag_le p_uint16_le p_length_le d_value_le tag k d

let d_element_bee tag k d = 
  d_element_explicit p_tag_be p_uint16_be p_length_be d_value_be tag k d

let rec d_elements_lei k d =
  d_try_tag p_tag_le begin fun tag d ->
    d_element_lei tag (d_elements_lei k) d
  end d

let rec d_elements_lee k d = 
  d_try_tag p_tag_le begin fun tag d ->
    d_element_lee tag (d_elements_lee k) d
  end d

let rec d_elements_bee k d =
  d_try_tag p_tag_be begin fun tag d -> 
    d_element_bee tag (d_elements_bee k) d
  end d

(* Decode DICOM files *) 

let d_transfer_syntax tag k d =   (* decode transfer syntax and adjust dec. *)
  let d_uid tag k d =
    get 2 ~err:(err_eoi_value_length tag) begin fun d ->
      get (p_uint16_le d 0) ~err:(err_eoi_value tag) begin fun d ->
        let uid = Bytes.copy_unpad_string d.i in
        d.syntax <- Uid.to_syntax uid;
        ret_element tag `UI (`String (`One uid)) k d
      end d
    end d
  in
  d_vr tag begin fun tag vr d -> 
    if vr = `UI then d_uid tag k d else
    ret (err_file_syntax_vr_not_uid vr) (d_uid tag k) d
  end d 

let rec d_file_meta k d =          (* decode group 0002 and adjust syntax. *) 
  d_try_tag p_tag_le begin fun tag d ->
    if Tag.group tag = 0x0002 then begin 
      if Tag.element tag = 0x0010 
      then d_transfer_syntax tag (d_file_meta k) d 
      else d_element_lee tag (d_file_meta k) d
    end else begin
      match d.syntax with 
      | `LE_implicit -> 
          d_element_lei tag (d_elements_lei k) d
      | `LE_explicit -> 
          d_element_lee tag (d_elements_lee k) d
      | `BE_explicit ->
          let tag = p_tag_be d 0 in (* tag in be, FIXME: brittle do swap here *)
          d_element_bee tag (d_elements_bee k) d
      | `File -> 
          d.syntax <- `LE_implicit; 
          ret err_file_syntax_unspecified
            (d_element_lei tag (d_elements_lei k)) d 
    end
  end d
    
let d_file d =          (* skip 128 bytes, decode DICM prefix and file meta. *) 
  skip 128 ~err:err_eoi_file_preamble begin function d -> 
    get 4 ~err:err_eoi_file_prefix begin function d ->
      if p_file_prefix d 
      then (d_file_meta never) d 
      else ret err_parse_file_prefix (d_file_meta never) d
    end d
  end d

(* Decoding interface *) 

let decode_fun = function 
| `LE_implicit -> d_elements_lei never
| `LE_explicit -> d_elements_lee never
| `BE_explicit -> d_elements_bee never
| `File -> d_file

let decoder ?(vr = fun _ -> `UN) ~syntax src =
  let k = decode_fun syntax in
  { vr; i = Bytes.create src; syntax; spos = 0; stack = []; k }

let decode d = d.k d
let decoded_range d = d.spos, Bytes.count d.i
let decoder_src d = Bytes.src d.i
let decoder_syntax d = d.syntax

module Manual = struct
  let src d = Bytes.source d.i
end

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
