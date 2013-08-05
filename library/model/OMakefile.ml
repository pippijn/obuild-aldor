install Library ".DEFAULT" [
  (* Target *)
  Name		"model";
  Description	"Sample library";
  Version	"0.1.4";

  (* Sources *)
  Domains [
    "src/dm_demo";
    "src/dm_vers";
  ];

  Interfaces [
    "include/model";
  ];

  AldorRequires [
    "aldor";
  ];
]
