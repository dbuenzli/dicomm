(*---------------------------------------------------------------------------
   Copyright (c) 2014 Daniel C. Bünzli. All rights reserved.
   Distributed under the BSD3 license, see license at the end of the file.
   %%NAME%% release %%VERSION%%
  ---------------------------------------------------------------------------*)

(** DICOM data 

    {b Warning.} This is a private module do not use directly. *)

type vr = 
  [ `AE | `AS | `AT | `CS | `DA | `DS | `DT | `FD | `FL | `IS | `LO | `LT 
  | `OB | `OF | `OW | `PN | `SH | `SL | `SQ | `SS | `ST | `TM | `UI | `UL 
  | `UN | `US | `UT | `OB_or_OW | `US_or_SS | `US_or_OW | `US_or_SS_or_OW ]

type vm = 
  [ `One | `One_2 | `One_3 | `One_8 | `One_32 | `One_99 | `One_n 
  | `Two | `Two_n | `Two_2n | `Three | `Three_n | `Three_3n | `Four 
  | `Six | `Six_n | `Nine | `Sixteen ]

val elements : (int32 * (string * string * vr * vm * bool)) list
(** [elements] pair data element tags with their specification 
    [(name, keyword, vr, vm, retired)] as found in PS 3.6 2011 §6,7,8 and 
    PS 3.7 2011 Annex E. *)

val element_ranges : (int32 * int32) list 
(** [element_ranges] pairs a tag [t] with a mask [m]. Given a tag [t'] if 
    [t' land m = t] then lookup for [t] in {!elements} for its definition. *)
    
val uid_names : (string * string) list 
(** [uid_names] pairs UIDs and their names as found in PS 3.6 2011
    Annex A). *)

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
