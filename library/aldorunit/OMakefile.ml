install Library ".DEFAULT" [
  (* Target *)
  Name		"aldorunit";
  Description	"Aldor unit testing";
  Version	"1.0.3";

  (* Sources *)
  Domains [
    "src/exceptions/tst_afe";
    "src/exceptions/tst_afet";
    "src/framework/tst_tct";
    "src/framework/tst_tctl";
    "src/framework/tst_tstl";
    "src/version/tst_vers";
  ];

  Interfaces [
    "include/aldorunit";
  ];

  AldorRequires [
    "aldor";
    "algebra";
    "extio";
  ];

  Var ("OM_AFLAGS", "-DLibraryAldorUnitRequiresLibraryExtIO -DLibraryAldorUnitRequiresLibraryAlgebra");

  (* Optimisation breaks algebra *)
  Var ("ALDOROPT", "-Q1");
]
