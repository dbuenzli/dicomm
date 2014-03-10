(*---------------------------------------------------------------------------
   Copyright (c) 2014 Daniel C. Bünzli. All rights reserved.
   Distributed under the BSD3 license, see license at the end of the file.
   %%NAME%% release %%VERSION%%
  ---------------------------------------------------------------------------*)

(** Non-blocking streaming DICOM data element decoder. 

    [Dicomm] is a non-blocking streaming decoder to
    {{!section:decode}decode} DICOM data elements.

    Consult the {{!model}data model}, {{!props}features and limitations} and 
    {{!examples}examples} of use. 
    
    {e Release %%VERSION%% — %%MAINTAINER%% }
    {3 References}
    {ul 
    {- NEMA.
    {e {{:http://medical.nema.org/standard.html}
        The DICOM Standard}}, 2011.}} *)

(** {1:model Data model} *) 

type syntax = [ `File | `LE_explicit | `BE_explicit | `LE_implicit ]
(** The type for transfer syntaxes. See {!decoder}. *)

type vr = 
  [ `AE | `AS | `AT | `CS | `DA | `DS | `DT | `FL | `FD | `IS | `LO | `LT 
  | `OB | `OF | `OW | `PN | `SH | `SL | `SQ | `SS | `ST | `TM | `UI | `UL 
  | `UN | `US | `UT ]
(** The type for value representations. *) 

val pp_vr : Format.formatter -> vr -> unit
(** [pp_vr ppf vr] prints an unspecified representation of [vr] on [ppf]. *)

(** Data elements tags and data dictionary. 

    The data dictionary information is as found in 
    {{:http://medical.nema.org/Dicom/2011/11_06pu.pdf}PS 3.6 2011} §6,7,8. *) 
module Tag : sig

  (** {1 Tags} *) 

  type t 
  (** The type for data elements tags. *) 

  val group : t -> int 
  (** [group t] is [t]'s group number. *) 

  val element : t -> int 
  (** [group t] is [t]'s element number. *) 

  val of_group_element : int -> int -> t
  (** [of_group_element g e] is a tag from the group [g] and the element
      [e]. *) 

  val name : t -> string option
  (** [name t] is the name of the data element with tag [t]. *) 

  val keyword : t -> string option 
  (** [keyword t] is the keyword of the data element with tag [t]. *) 

  val vr : t -> 
    [ vr | `OB_or_OW | `US_or_SS | `US_or_OW | `US_or_SS_or_OW ] option
  (** [vr t] is the value representation of the data element with tag [t]. *)

  val vm : t ->
    [ `One | `One_2 | `One_3 | `One_8 | `One_32 | `One_99 | `One_n 
    | `Two | `Two_n | `Two_2n | `Three | `Three_n | `Three_3n 
    | `Four | `Six | `Six_n | `Nine | `Sixteen ] option
  (** [vm t] is the value multiplicity of the data element with tag [t]. *) 

  val retired : t -> bool option
  (** [retired t] is [true] if the data element with tag [t] is retired
      by the standard. *) 

  val equal : t -> t -> bool 
  (** [equal t t'] is [true] if [t] and [t'] are equal. *)

  val compare : t -> t -> int 
  (** [compare t t'] orders [t] and [t'] first by group and then 
      by element both in integer order. *) 

  val pp : Format.formatter -> t -> unit
  (** [pp ppf t] prints an unspecified representation of [t] on [ppf]. *) 
end

(** Unique identifiers (UID). 

    UID names are as found in 
    {{:http://medical.nema.org/Dicom/2011/11_06pu.pdf}PS 3.6 2011}, tables
    A-1, A-2, A-3. *)
module Uid : sig

  (** {1 UIDs} *) 

  type t = string 
  (** The type for DICOM unique identifiers. *) 
  
  val name : t -> string option
  (** [name uid] is the UID's name according to the standard. *)

  val to_syntax : t -> [`LE_explicit | `BE_explicit | `LE_implicit ]
  (** [to_syntax uid] is [uid]'s transfer syntax. Anything unknown is
      mapped to [`LE_explicit] (default syntax for compressed
      formats). *) 
end

type time = [ `Stamp of float * float option | `Daytime of float ] 
(** The type for representing times. 
    {ul
    {- [`Stamp (u, tz)] is used for [`DA] and [`DT] value representations. 
       [u] should be interpreted as an absolute time in POSIX seconds 
       since 1970-01-01 00:00:00 UTC. [tz] is a timezone offset in seconds.
       If [tz] is [None], time is in local time.}
    {- [`Daytime s] is used for [`TM], it's a time point in a day in seconds 
       since 00:00:00.}} *)

val pp_time : Format.formatter -> time -> unit
(** [pp_time ppf t] prints an unspecified representation of [t] on [ppf]. *)

type ('a, 'b) bigarray = ('a, 'b, Bigarray.c_layout) Bigarray.Array1.t
(** The type for bigarrays. *) 

type value = 
  [ `String of [ `One of string | `Many of string list ]
  | `UInt8 of (int, Bigarray.int8_unsigned_elt) bigarray
  | `Int16 of (int, Bigarray.int16_signed_elt) bigarray 
  | `UInt16 of (int, Bigarray.int16_unsigned_elt) bigarray 
  | `Int32 of (int32, Bigarray.int32_elt) bigarray 
  | `UInt32 of (int32, Bigarray.int32_elt) bigarray 
  | `Float32 of (float, Bigarray.float32_elt) bigarray
  | `Float64 of (float, Bigarray.float64_elt) bigarray
  | `Tag of [ `One of Tag.t | `Many of Tag.t list ] 
  | `Time of [ `One of time | `Many of time list ] ]
(** The type for values. VR are mapped to cases as given below.
    {ul
    {- [`String] for [`AE], [`AS], [`CS], [`DA], [`DT], [`LO], [`LT], 
       [`PN], [`SH], [`ST], [`TM], [`UI], [`UT].}
    {- [`UInt8] for [`OB], [`UN]}
    {- [`Int16] for [`SS]} 
    {- [`UInt16] for [`US], [`OW]}
    {- [`Int32] for [`IS], [`SL].}
    {- [`UInt32] for [`UL].}
    {- [`Float32] for [`FL], [`OF]}
    {- [`Float64] for [`DS], [`FD]}
    {- [`Tag] for [`AT]}
    {- [`Time] is TODO}}
    This should be documented in VR cases but ocamldoc doesn't support
    documentation in polymporphic variants. *)

val pp_value : ?limit:int -> Format.formatter -> [< value ] -> unit
(** [pp_value limit ppf v] prints an unspecified textual representation 
    of [v] on [ppf]. [limit] is the maximal number of printed element 
    arrays. *)
  
type element = Tag.t * vr * value
(** The type for data elements. *) 

val pp_element : Format.formatter -> element -> unit
(** [pp_element names ppf v] prints and unspecified textual representation
    of [v] on [ppf]. If [names] is [true] (defaults to [false]*) 

type lexeme = [ `E of element | `Ss of Tag.t | `Se of Tag.t | `I ]
(** The type for DICOM lexemes. [`Ss] and [`Se] are respectively for
    starting and ending sequences of data elements items (SQ value
    representation).

    A {e well-formed} sequence of lexemes belongs to the language of 
    the [dicom] grammar:
{[
  dicom = `E e / `Es t *(`I dicom) `Ee t / dicom
]}

   A {{!section:decode}decoder} returns only well-formed sequences
   of lexemes or [`Error]s are returned. 
*)

val pp_lexeme : Format.formatter -> [< lexeme ] -> unit 
(** [pp_lexeme names ppf l] prints an unspecified textual representation of 
    [l] on ppf. *)

(** {1:decode Decode} *)

type error = [ 
  | `Eoi of [ 
      | `File_preamble | `File_dicom_prefix | `Tag_or_eoi | `Tag
      | `Reserved of Tag.t | `Vr of Tag.t | `Value_length of Tag.t 
      | `Value of Tag.t ]
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

(** The type for decoding errors. *) 

val pp_error : Format.formatter -> [< error ] -> unit 
(** [pp_error e] prints an unspecified representation of [e] on [ppf]. *)

type src = [ `Channel of Pervasives.in_channel | `Manual | `String of string ]
(** The type for input sources. With a [`Manual] source the client must
    provide input with {!Manual.src}. *)

type decoder 
(** The type for decoders. *)

val decoder : ?vr:(Tag.t -> vr) -> syntax:syntax -> [< src ] -> decoder
(** [decoder private_tag file src] is a DICOM decoder that inputs DICOM data
    elements from [src] according to [syntax].

    If [syntax] is [`File], the decoder first parses a DICOM file
    preamble and the DICM prefix reporting an error if it fails to do
    so. Decodes then return the DICOM file meta information and the
    decoder automatically switch to the right syntax for decoding the
    data object. 

    If decoding is done using the implicit syntax [vr] is called on 
    tags that return [None] on [Tag.vr] to determine the value representation
    to use (defaults to [fun _ -> `UN]). *)

val decode : decoder -> [ `Await | `End | `Error of error | `Lexeme of lexeme ]
(** [decode d] is:
    {ul 
    {- [`Await] if [d] has a [`Manual] source and awaits more imput. 
       The client must use {!Manual.src} to provide it.}
    {- [`Lexeme l] if a lexeme [l] was decoded.}
    {- [`End] if the end of input was reached.}
    {- [`Error e] if a decoding error occured. If the client is interested
       in a best-effort decoding it can still continue to decode after an error
       see {!errors}.}} *)

val decoded_range : decoder -> int * int
(** [decoded_range d] is the range of bytes spanning the last [`Lexeme] or
    [`Error] decoded by [d]. *)

val decoder_src : decoder -> src 
(** [decoder_src d] is [d]'s input source. *)

val decoder_syntax : decoder -> syntax
(** [decoder_syntax d] is [d]'s decoded syntax. *) 

val pp_decode : Format.formatter -> 
  [< `Await | `End | `Error of error | `Lexeme of lexeme ] -> unit 
(** [pp_decode ppf v] prints an unspecified representation of [v] on 
    [ppf]. *)

(** {1:manual Manual sources} *) 

(** Manual sources. 

    {b Warning.} Use only with [`Manual] decoders and encoders. 
*)
module Manual : sig
  val src : decoder -> string -> int -> int -> unit 
  (** [src d s j l] provides [d] with [l] bytes to read, starting at [j]
      in [s]. This byte range is read by calls to [!decode] with [d] until 
      [`Await] is returned. To signal the end of input call the function 
      with [l = 0]. *)
end

(** {1:errors Error recovery}

    After a decoding error, if best-effort decoding is performed. The following
    happens before continuing: 
    {ul 
    {- [`Eoi _], `End is eventually returned.}
    {- [`File_syntax_unspecified], continues with [`LE_implicit].}
    {- [`File_syntax_vr_not_uid], ignores the VR and parses as an UID.}
    {- [`Parse_int], [`Parse_float], [`Parse_time] skips the data element.}
    {- [`Unknown_vr], continues assuming a [UN] value representation.}
    {- [`Value_length_overflow], skips the data element.}
    {- [`Value_length_undefined], skips the data element whose value 
       is assumed to be of 0xFFFFFFFF bytes (this may not be very useful).}
    {- [`Value_length_mismatch], skips the data element.}}
    
    {1:props Features and limitations}
    
    On decoding: 
    {ul
    {- Values are always returned unpadded. Strings are unpadded 
       by '\x20' or '\x00' (DICOM mandates '\x20' for 
       strings but some images are padded with '\x00' in the wild).}
    {- Value representation that exceed their length are not reported 
       as errors.}
    {- Value representation [`AS] is unparsed and returned as 
       a string.}
    {- Value representation [`IS] are parsed with [Int32.of_string] and
       [`FS] with [float_of_string].}
    {- Value representation and multiplicity of data elements are not 
       checked for errors against the standard. You can do so by using
       functions from the {!Tag} module.}
    {- In the implicit syntax, if a tag may have multiple VR (see 
       the result of {!Tag.vr}). In that case we unconditionally map 
       [`OB_or_OW] to [`OW], [`US_or_SS] to [`US], [`US_or_OW] to [`US] 
       [`US_or_SS_or_OW] to [`US]. Depending on contextual information 
       you may want to reinterpret that data differently, 
       see PS 3.5 Annex A.1.}
    {- Item and sequence delimitation items are not returned.} 
    {- Size limitations on 32 bits platforms. Values are limited by 
       {!Sys.max_string_length}, In each of these cases the error 
       [`Size_overflow] is returned and the data element is skipped. 
       Note that none of this should happen on 64 bits platforms.
       This limitation could be lifted in future versions of the library.}}


    {1:pixels Pixel data} 

    On decoding for DICOM bitmap data, the pixel representation 
    tag [(0028,0103)] is captured and if tag [(7FE0, 0010)] has 
    a 16 bits representation the value is mapped to `UInt16 or `Int16
    accordingly.

    {1:examples Examples} *)

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
