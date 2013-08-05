#include "extio"

import from StringTokenizer;
import from CharacterNames;
import from Character;
import from String;
import from TextWriter;

local str: String := "This String is chopped into parts";

local count:MachineInteger := 0;

for part in tokenize( latinSmallLetterI, str ) repeat
{
    count := next count;
    stdout << "part #" << count << ": " << part << newline;
}
