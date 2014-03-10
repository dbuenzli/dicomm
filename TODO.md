* Sort out the encoding business and map everything to UTF-8 
* Decode OB, OW with undefined size. 
* Parse `TM `DT `DA
* Unpadding of `UN or `OB ?
* Add a ~raw attribute, when false we should automatically handles pixel 
  data normalization, i.e. handles bits allocated, bits_stored and high bit,
  and mapping planar bitmaps to non planar ones.
* Doc, examples
* Check that tags are in order, report if they are not and continue.
* On regular `End check that d.stack is empty.
* Encoder
