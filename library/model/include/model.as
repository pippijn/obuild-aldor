#include "aldor.as"

#if BuildModelLib
#else
#library ModelLib "model"
#endif
{
	import from ModelLib;
	inline from ModelLib;
}
