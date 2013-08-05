install Program ".DEFAULT" [
  (* Target *)
  Name		"unicl";

  (* Sources *)
  Sources [
    "unicl.c";
  ];

  CRequires [
    "alcomp";
    "m";
  ];

  Var ("OM_CPPFLAGS", "-I$(includedir)/aldor");
]
