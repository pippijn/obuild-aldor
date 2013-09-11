install Program ".DEFAULT" [
  (* Target *)
  Name		"foamj";

  (* Sources *)
  Sources [
    "genjava.c";
    "javacode.c";
    "javaobj.c";
    "main.c";
  ];

  Headers [
    "genjava.h";
    "javacode.h";
    "javaobj.h";
  ];

  CRequires [
    "alcomp";
    "m";
  ];

  Var ("OM_CFLAGS", "$(STRICT_CFLAGS)");
  Var ("OM_CPPFLAGS", "-I$(includedir)/aldor");
];
