-------------------------------------------------------------------------
--
-- cs_dveot.as
--
-------------------------------------------------------------------------

#include "charset.as"

+++\begin{addescription}{marks elimination orders}
+++Let $\Theta Y$ be derivatives with $\Theta$ denoting a set of derivations. An elimination order is a total order $\leq$ on $\Theta Y$ for which
+++$$\forall \theta, \bar{\theta}, \hat{\theta} \in \Theta \;\; \forall \bar{y}, \hat{y} \in Y \; : \; \bar{y} \neq \hat{y} \land \bar{\theta}\bar{y} \leq \hat{\theta}\hat{y} \implies (\theta \bar{\theta})\bar{y} \leq \hat{\theta}\hat{y}$$ holds.
+++\end{addescription}
+++\begin{adremarks}
+++The ``elimination'' property cannot be modelled within \Aldor. Nevertheless, as this property allows short cuts for certain algorithms (e.g.: \adtype{DifferentialPolynomialReductionTools}), it is advantageous to know whether or not an order has this property. Therefore, \adthistype is used to mark orders having the elimination property.
+++\end{adremarks}
DifferentialVariableEliminationOrderToolsType: Category == with {

    DifferentialVariableOrderToolsType;

};
