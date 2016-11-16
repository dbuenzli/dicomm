(*---------------------------------------------------------------------------
   Copyright (c) 2014 Daniel C. Bünzli. All rights reserved.
   Distributed under the ISC license, see terms at the end of the file.
   %%NAME%% %%VERSION%%
  ---------------------------------------------------------------------------*)

type t = [ `Daytime of float | `Stamp of float * float option ]

let stamp_of_da s i len = failwith "TODO"
(*
  try
    let s = Bytes.bytes d.i in
    let i = Bytes.start d.i in
    let sub s len = int_of_string (String.sub s (i + s) len) in
    let yyyy, mm, dd =
      if len = 10 then (sub 0 4), (sub 5 2), (sub 8 2) else
      if len = 8 then (sub 0 4), (sub 4 2), (sub 6 2) else
      failwith ""
    in
    if
  with Failure _ -> None
*)


let stamp_of_dt s j len = failwith "TODO"
  (* N.B. context sensitive if no TZ, see doc about VR in the standard. *)

let daytime_of_tm s j len = failwith "TODO"
let pp ppf t = failwith "TODO"

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
