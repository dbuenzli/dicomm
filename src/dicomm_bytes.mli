(*---------------------------------------------------------------------------
   Copyright (c) 2014 Daniel C. Bünzli. All rights reserved.
   Distributed under the ISC license, see terms at the end of the file.
   %%NAME%% %%VERSION%%
  ---------------------------------------------------------------------------*)

(** Non-blocking, best effort zero-copy, byte stream.

   {b Warning.} This is a private module do not use directly.

   The client asks for [n] bytes with [Bytes.get]. [n] bytes can be
   read from [Bytes.start] in [Bytes.bytes] whenever either
   [Bytes.get] returned [`Ok] or if it returned [`Await] after calls
   to [Bytes.await] eventually returned [`Ok]. If any of these calls
   return [`End] then only [Bytes.len] bytes (< [n]) are available. If
   you are interested in the string, using [Bytes.copy] is preferable
   to extracting the substring from [Bytes.bytes] *)

(** {1 Byte stream} *)

type src = [ `Channel of Pervasives.in_channel | `Manual | `String of string ]
(** The type for byte sources. *)

type t
(** The type for byte streams. *)

val create : [< src] -> t
(** [create src] is a new byte stream taking its bytes from [src]. *)

val source : t -> Bytes.t -> int -> int -> unit
(** [source bs s j l] provides [bs] with [l] bytes to read, starting
    at [j] in [s]. For [`Manual] sources only. *)

val skip : t -> int -> [ `Await | `End | `Ok ]
(** [skip bs len] skips [len] bytes. *)

val get : t -> int -> [ `Await | `End | `Ok ]
(** [get bs len] reads [len] bytes. *)

val await : t -> [ `Await | `End | `Ok ]
(** [await bs] awaits more bytes to fullfill {!get} or {!skip} request. *)

val bytes : t -> Bytes.t
(** [bytes bs] holds the last (but not only) requested bytes. *)

val start : t -> int
(** [start bs] is the start index to read in [bytes d]. *)

val len : t -> int
(** [len bs] is the number of bytes to read in [bytes bs] *)

val copy : t -> string
(** [copy bs] is a copy for the last requested bytes. *)

val count : t -> int
(** [count bs] is the total number of bytes read so far. *)

val src : t -> src
(** [src bs] is [bs]'s source. *)

(** {1 DICOM specific} *)

val copy_unpad_bytes : t -> string
(** [copy_unpad_bytes bs] is like {!copy} but removes an eventual
    trailing '\x00' byte. *)

val copy_unpad_string : t -> string
(** [copy_unpad bs] is like {!copy} but removes an eventual
    trailing '\x20' or '\x00' (DICOM mandates '\x20' for
    strings but some images are padded with '\x00' in the wild). *)

val copy_many_unpad_string : t -> string list
(** [copy_many_unpad bs c] is like {!copy_unpad} but split the resulting
    string at '\\' chars. *)

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
