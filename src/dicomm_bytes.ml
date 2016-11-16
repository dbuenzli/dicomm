(*---------------------------------------------------------------------------
   Copyright (c) 2014 Daniel C. Bünzli. All rights reserved.
   Distributed under the ISC license, see terms at the end of the file.
   %%NAME%% %%VERSION%%
  ---------------------------------------------------------------------------*)


let io_buffer_size = 65536                          (* IO_BUFFER_SIZE 4.0.0 *)

let invalid_bounds j l =
  invalid_arg (Printf.sprintf "invalid bounds (index %d, length %d)" j l)

type src = [ `Channel of Pervasives.in_channel | `Manual | `String of string ]

  (* We try to use as much as possible the string provided in the
    input chunk [i] provided by [source]. If the number of requested
    bytes overlaps two input chunks we go through the buffer [buf]. *)

type t =
  { src : src;
    mutable i : Bytes.t;                    (* Current input chunk. *)
    mutable i_pos : int;            (* Next input position to read. *)
    mutable i_max : int;               (* Maximal position to read. *)
    mutable buf : Buffer.t; (* Buffer for gets overlapping two [i]. *)
    mutable bytes : Bytes.t;   (* Reference on string to read from. *)
    mutable bytes_is_i : bool;         (* [true] if [bytes] is [i]. *)
    mutable start : int;                  (* Position to read from. *)
    mutable req : int;           (* Last number of bytes requested. *)
    mutable need : int;            (* Number of bytes still needed. *)
    mutable count : int;      (* total number of bytes read so far. *)
    mutable skip : bool;               (* [true] if skipping bytes. *) }

let create src =
  let i, i_pos, i_max = match src with
  | `Manual -> Bytes.empty, 1, 0                  (* implies i_rem d = 0. *)
  | `Channel _ -> Bytes.create io_buffer_size, 1, 0              (* idem. *)
  | `String s -> Bytes.unsafe_of_string s, 0, String.length s - 1
  in
  { src = (src :> src);
    i; i_pos; i_max;
    buf = Buffer.create (io_buffer_size * 2);
    bytes = i; start = 0; bytes_is_i = true;
    req = 0; need = 0; count = 0; skip = false; }

let i_rem d = d.i_max - d.i_pos + 1    (* remaining byte to read in [d.i]. *)
let eoi d =
  d.i <- Bytes.empty; d.i_pos <- max_int; d.i_max <- 0 (* set eoi in [d]. *)

let source d s j l =
  if (j < 0 || l < 0 || j + l > Bytes.length s) then invalid_bounds j l else
  if (l = 0) then eoi d else
  (d.i <- s; d.i_pos <- j; d.i_max <- j + l - 1)

let rec await d =
  let rem = i_rem d in
  if rem < 0 then `End else
  if d.need <= rem then begin
    if d.skip then begin
      d.i_pos <- d.i_pos + d.need;
      d.count <- d.count + d.req;
      d.need <- 0;
      d.skip <- false;
    end else begin
      if Buffer.length d.buf = 0 then begin
        d.bytes <- d.i;
        d.bytes_is_i <- true;
        d.start <- d.i_pos;
        d.i_pos <- d.i_pos + d.need;
        d.count <- d.count + d.req;
        d.need <- 0;
      end else begin
        Buffer.add_substring d.buf (Bytes.unsafe_to_string d.i) d.i_pos d.need;
          d.bytes <- Bytes.unsafe_of_string (Buffer.contents d.buf);
        Buffer.clear d.buf;
        d.bytes_is_i <- false;
        d.start <- 0;
        d.i_pos <- d.i_pos + d.need;
        d.count <- d.count + d.req;
        d.need <- 0;
      end
    end;
    `Ok
    end else begin
    if d.skip then d.need <- d.need - rem else
    begin
      d.need <- d.need - rem;
      Buffer.add_substring d.buf (Bytes.unsafe_to_string d.i) d.i_pos rem
    end;
    `Await
  end

let rec refill d = match d.src with             (* get new input in [d.i]. *)
| `Manual -> `Await
| `String _ -> `End
| `Channel ic ->
    let rc = input ic d.i 0 (Bytes.length d.i) in
    source d d.i 0 rc;
    match await d with
    | `Await -> refill d
    | `End | `Ok as v -> v

let skip d n =
  let rem = i_rem d in
  if rem < 0 then `End else
  if n <= rem then begin                          (* non-overlapping skip. *)
    d.req <- n;
    d.need <- 0;
    d.i_pos <- d.i_pos + n;
    d.count <- d.count + n;
      `Ok
  end else begin                                      (* overlapping skip. *)
    d.req <- n;
    d.need <- n - rem;
    d.skip <- true;
    refill d
  end

let get d n =
  let rem = i_rem d in
  if rem < 0 then `End else
  if n <= rem then begin                           (* non-overlapping get. *)
    d.req <- n;
    d.need <- 0;
    d.bytes <- d.i;
    d.bytes_is_i <- true;
    d.start <- d.i_pos;
    d.i_pos <- d.i_pos + n;
    d.count <- d.count + n;
    `Ok
  end else begin                                       (* overlapping get. *)
    d.req <- n;
    d.need <- n - rem;
    Buffer.add_substring d.buf (Bytes.unsafe_to_string d.i) d.i_pos rem;
    refill d
  end

let bytes d = d.bytes
let start d = d.start
let len d = d.req - d.need
let copy d =
  if d.bytes_is_i then Bytes.sub_string d.bytes d.start (len d) else
  (Bytes.unsafe_to_string d.bytes)

let count d = d.count
let src d = d.src

(* DICOM specific *)

let copy_unpad_bytes d =
  let len = len d in
  if len = 0 then "" else
  let max = d.start + len - 1 in
  let len' = if Bytes.get d.bytes max = '\x00' then len - 1 else len in
  if d.bytes_is_i then Bytes.sub_string d.bytes d.start len' else
  if len <> len' then Bytes.sub_string d.bytes 0 len' (* FIXME: avoid cp *) else
  Bytes.unsafe_to_string d.bytes

let copy_unpad_string d =
  let len = len d in
  if len = 0 then "" else
  let max = d.start + len - 1 in
  let pad = Bytes.get d.bytes max in
  let len' = if pad = '\x00' || pad = '\x20' then len - 1 else len in
  if d.bytes_is_i then Bytes.sub_string d.bytes d.start len' else
  if len <> len' then Bytes.sub_string d.bytes 0 len' else (* FIXME: avoid cp *)
  Bytes.unsafe_to_string d.bytes

let copy_many_unpad_string d =
  let len = len d in
  if len = 0 then [] else
  let max = d.start + len - 1 in
  let pad = Bytes.get d.bytes max in
  let len = if pad = '\x00' || pad = '\x20' then len - 1 else len in
  let max = d.start + len - 1 in
  let acc = ref [] in
  let loc = ref max in
  try
    while true do
      let sep = Bytes.rindex_from d.bytes !loc '\\' in
      if sep < d.start then raise Not_found;
      acc := Bytes.sub_string d.bytes (sep + 1) (!loc - sep) :: !acc;
      loc := sep - 1
    done;
    assert false
  with Not_found ->
    Bytes.sub_string d.bytes d.start (!loc - d.start + 1) :: !acc

(*---------------------------------------------------------------------------
   Copyright (c) 2014 Daniel C. Bünzli

   Permission to use, copy, modify, and/or distribute this software for any
   purpose with or without fee is hereby granted, provided that the above
   copyright notice and this permission notice appear in all copies.

   THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
   WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
   MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
   ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  ---------------------------------------------------------------------------*)
