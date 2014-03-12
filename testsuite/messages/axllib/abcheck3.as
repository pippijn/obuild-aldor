#include "axllib.as"

Foo: with {
   # : Foo -> SingleInteger;
} == add {
   import from SingleInteger;

   #(v:Foo):SingleInteger == # rep v;
}
