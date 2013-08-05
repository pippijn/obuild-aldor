--the following #assert fills the repository.
--Refer to the documentation of ComputerAlgebraSystemTools 
--for further information.
#assert REGISTER_COMPUTER_ALGEBRA_SYSTEMS

#include "extio"

import from ExpressionTree;
import from List ExpressionTree;
import from Integer;
import from String;
import from Symbol;
import from Character;
import from TextWriter;
import from ComputerAlgebraSystemTools;

local aldorExTree := ExpressionTreePlus . [ extree 1, extree 3 ];

stdout << "As Aldor ExpressionTree: " << newline
   << "      " << aldorExTree << newline;

printInCas( cas: ComputerAlgebraSystemType ):() == {
    free aldorExTree;
    import from cas;
    stdout << "As " << identifier << " expression: " << newline 
           << "      " << encodeAsString!( copy aldorExTree ) << newline;
}

for cas in generator() repeat
{ 
    printInCas cas;
}