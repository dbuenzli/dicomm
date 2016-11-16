#!/usr/bin/env ocaml
#use "topfind"
#require "topkg"
open Topkg

let () =
  Pkg.describe "dicomm" @@ fun c ->
  Ok [ Pkg.mllib "src/dicomm.mllib";
       Pkg.bin "test/dicomtrip"; ]
