#include "aldor.as"
#include "algebra.as"

#if BuildExtioLib
#else
#library ExtioLib "extio"
#endif
{
	import from ExtioLib;
	inline from ExtioLib;
}

------------------------------------

#if REGISTER_COMPUTER_ALGEBRA_SYSTEMS
{
    (register$ComputerAlgebraSystemTools) MapleTools;
    (register$ComputerAlgebraSystemTools) MathematicaFullFormTools;
}
#endif
