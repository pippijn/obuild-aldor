#include "extio"

import from TextWriter;
import from String;
import from Character;

try {
    throw Exception;
} catch E in {
    E has ExceptionType => {
	stdout << "the try/catch block threw the folowing exception:" 
	       << newline;
	(print$E) stdout;
    }
}