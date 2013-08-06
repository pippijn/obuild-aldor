install Program ".DEFAULT" [
  (* Target *)
  Name		"aldor";

  (* Sources *)
  Sources [
    "main.c";
  ];

  CRequires [
    "alcomp";
    "m";
  ];

  Array ("Configs", [
    "aldor.conf";
    "basic.typ";
    "sample.terminfo";
  ]);

  Var ("OM_CPPFLAGS", "-I$(includedir)/aldor");

  (* Install config files along with the compiler program. *)
  Rule (
    "$(bindir)/$(Name)$(EXEEXT)",
    "$(install-target $(includedir), $(Configs))",
    []
  );
];
