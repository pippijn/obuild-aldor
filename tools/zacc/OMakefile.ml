install Program ".DEFAULT" [
  (* Target *)
  Name		"zacc";

  (* Sources *)
  Sources [
    "cenum.c";
    "zacc.c";
    "zaccgram.y";
    "zaccscan.l";
  ];

  (* Headers *)
  Headers [
    "cenum.h";
    "zacc.h";
    "zaccgram.h";
    "zcport.h";
  ];

  Var ("OM_YFLAGS", "-d");
]
