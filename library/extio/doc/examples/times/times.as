#include "extio"

import from Times;
import from MachineInteger;
import from TextWriter;
import from Character;
import from String;

local list: List MachineInteger := empty;
list := [ i for i in 0 .. 10000 ];

--ready, steady, GO!
local startPTimer: Partial Times := times();

--to kill some time, some sorting is done
for i in 0 .. 1000 repeat
{
    list := sort!( list, < );
    list := sort!( list, > );
}

--stop timing
local endPTimer: Partial Times := times();

assert ~ failed? startPTimer;
assert ~ failed? endPTimer;

stdout << "The timings for sorting:" << newline;
stdout << (retract endPTimer - retract startPTimer) << newline;
stdout << ticksPerSecond << " ticks is 1 second" << newline;
