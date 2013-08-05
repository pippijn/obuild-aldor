-------------------------------------------------------------------------
--
-- cs_detot.as
--
-------------------------------------------------------------------------

#include "algebra"

+++\begin{addescription}{collects tools for dealing with (differential) expression trees}
+++\end{addescription}
DifferentialExpressionTreeOperatorTools : with {

    +++\begin{addescription}{holds the \adname[ExpressionTreePlus]{uniqueId} of \adtype{ExpressionTreePlus}}
    +++\end{addescription}
    +++\begin{adremarks}
    +++The definition of \adthisname itself is trivial. Nevertheless, \adthisname is extremely useful, when the \adname[ExpresionTreeOperator]{uniqueId} of more than one \adtype{ExpressionTreeOperator} is needed in a scope. In such a setting, importing implicitly or explicitely from all the needed \adtype{ExpressionTreeOperator}{}s typically causes compiler glitches. Therefore, \adthisname can be used in such settings to use the \adname[ExpressionTreePlus]{uniqueId} of \adtype{ExpressionTreePlus} without importing from \adtype{ExpressionTreePlus}. As a result, there are less problems when compiling code.
    +++\end{adremarks}
    ExpressionTreePlusId    : MachineInteger;

    +++\begin{addescription}{holds the \adname[ExpressionTreeMinus]{uniqueId} of \adtype{ExpressionTreeMinus}}
    +++\end{addescription}
    +++\begin{adremarks}
    +++The definition of \adthisname itself is trivial. Nevertheless, \adthisname is extremely useful, when the \adname[ExpresionTreeOperator]{uniqueId} of more than one \adtype{ExpressionTreeOperator} is needed in a scope. In such a setting, importing implicitly or explicitely from all the needed \adtype{ExpressionTreeOperator}{}s typically causes compiler glitches. Therefore, \adthisname can be used in such settings to use the \adname[ExpressionTreeMinus]{uniqueId} of \adtype{ExpressionTreeMinus} without importing from \adtype{ExpressionTreeMinus}. As a result, there are less problems when compiling code.
    +++\end{adremarks}
    ExpressionTreeMinusId   : MachineInteger;

    +++\begin{addescription}{holds the \adname[ExpressionTreeTimes]{uniqueId} of \adtype{ExpressionTreeTimes}}
    +++\end{addescription}
    +++\begin{adremarks}
    +++The definition of \adthisname itself is trivial. Nevertheless, \adthisname is extremely useful, when the \adname[ExpresionTreeOperator]{uniqueId} of more than one \adtype{ExpressionTreeOperator} is needed in a scope. In such a setting, importing implicitly or explicitely from all the needed \adtype{ExpressionTreeOperator}{}s typically causes compiler glitches. Therefore, \adthisname can be used in such settings to use the \adname[ExpressionTreeTimes]{uniqueId} of \adtype{ExpressionTreeTimes} without importing from \adtype{ExpressionTreeTimes}. As a result, there are less problems when compiling code.
    +++\end{adremarks}
    ExpressionTreeTimesId   : MachineInteger;

    +++\begin{addescription}{holds the \adname[ExpressionTreeQuotient]{uniqueId} of \adtype{ExpressionTreeQuotient}}
    +++\end{addescription}
    +++\begin{adremarks}
    +++The definition of \adthisname itself is trivial. Nevertheless, \adthisname is extremely useful, when the \adname[ExpresionTreeOperator]{uniqueId} of more than one \adtype{ExpressionTreeOperator} is needed in a scope. In such a setting, importing implicitly or explicitely from all the needed \adtype{ExpressionTreeOperator}{}s typically causes compiler glitches. Therefore, \adthisname can be used in such settings to use the \adname[ExpressionTreeQuotient]{uniqueId} of \adtype{ExpressionTreeQuotient} without importing from \adtype{ExpressionTreeQuotient}. As a result, there are less problems when compiling code.
    +++\end{adremarks}
    ExpressionTreeQuotientId: MachineInteger;
    
    +++\begin{addescription}{holds the \adname[ExpressionTreeList]{uniqueId} of \adtype{ExpressionTreeList}}
    +++\end{addescription}
    +++\begin{adremarks}
    +++The definition of \adthisname itself is trivial. Nevertheless, \adthisname is extremely useful, when the \adname[ExpresionTreeOperator]{uniqueId} of more than one \adtype{ExpressionTreeOperator} is needed in a scope. In such a setting, importing implicitly or explicitely from all the needed \adtype{ExpressionTreeOperator}{}s typically causes compiler glitches. Therefore, \adthisname can be used in such settings to use the \adname[ExpressionTreeList]{uniqueId} of \adtype{ExpressionTreeList} without importing from \adtype{ExpressionTreeList}. As a result, there are less problems when compiling code.
    +++\end{adremarks}
    ExpressionTreeListId    : MachineInteger;

    +++\begin{addescription}{holds the \adname[ExpressionTreeExpt]{uniqueId} of \adtype{ExpressionTreeExpt}}
    +++\end{addescription}
    +++\begin{adremarks}
    +++The definition of \adthisname itself is trivial. Nevertheless, \adthisname is extremely useful, when the \adname[ExpresionTreeOperator]{uniqueId} of more than one \adtype{ExpressionTreeOperator} is needed in a scope. In such a setting, importing implicitly or explicitely from all the needed \adtype{ExpressionTreeOperator}{}s typically causes compiler glitches. Therefore, \adthisname can be used in such settings to use the \adname[ExpressionTreeExpt]{uniqueId} of \adtype{ExpressionTreeExpt} without importing from \adtype{ExpressionTreeExpt}. As a result, there are less problems when compiling code.
    +++\end{adremarks}
    ExpressionTreeExptId    : MachineInteger;

    +++\begin{addescription}{denotes the symbol for derivation}
    +++\end{addescription}
    +++\begin{adremarks}
    +++To build expression trees involving derivations, a pair of two expression trees is built. The first expression tree holds the expression to apply the derivation to. The second eqpression denotes the derivation to apply. This pair is then prefixed by \adthisname.
    +++\end{adremarks}
    PrefixSymbolDiff        : Symbol;

    +++\begin{addescription}{holds the \adname[ExpressionTreePrefix]{uniqueId} of \adtype{ExpressionTreePrefix}}
    +++\end{addescription}
    +++\begin{adremarks}
    +++The definition of \adthisname itself is trivial. Nevertheless, \adthisname is extremely useful, when the \adname[ExpresionTreeOperator]{uniqueId} of more than one \adtype{ExpressionTreeOperator} is needed in a scope. In such a setting, importing implicitly or explicitely from all the needed \adtype{ExpressionTreeOperator}{}s typically causes compiler glitches. Therefore, \adthisname can be used in such settings to use the \adname[ExpressionTreePrefix]{uniqueId} of \adtype{ExpressionTreePrefix} without importing from \adtype{ExpressionTreePrefix}. As a result, there are less problems when compiling code.
    +++\end{adremarks}
    ExpressionTreePrefixId  : MachineInteger;

    +++\begin{addescription}{obtains the \adname[ExpressionTreeOperator]{name} of an \adtype{ExpressionTreeOperator}}
    +++\end{addescription}
    grabOperatorName        : (op:ExpressionTreeOperator)->Symbol;

    +++\begin{addescription}{obtains the \adname[ExpressionTreeOperator]{uniqueId} of an \adtype{ExpressionTreeOperator}}
    +++\end{addescription}
    grabOperatorUniqueId    : (op:ExpressionTreeOperator)->MachineInteger;

} == add {
    import from Symbol;
    import from String;

    ExpressionTreePlusId    : MachineInteger == uniqueId$ExpressionTreePlus;
    ExpressionTreeMinusId   : MachineInteger == uniqueId$ExpressionTreeMinus;
    ExpressionTreeTimesId   : MachineInteger == uniqueId$ExpressionTreeTimes;
    ExpressionTreeQuotientId: MachineInteger == uniqueId$ExpressionTreeQuotient;
    ExpressionTreeListId    : MachineInteger == uniqueId$ExpressionTreeList;
    ExpressionTreeExptId    : MachineInteger == uniqueId$ExpressionTreeExpt;
    PrefixSymbolDiff        : Symbol         == -"diff";
    ExpressionTreePrefixId  : MachineInteger == uniqueId$(ExpressionTreePrefix PrefixSymbolDiff);

    grabOperatorName(op:ExpressionTreeOperator):Symbol == {
	import from op;
	import from Symbol;
	return name;
    }

    grabOperatorUniqueId(op:ExpressionTreeOperator):MachineInteger == {
	import from op;
	import from Symbol;
	return uniqueId;
    }


};
