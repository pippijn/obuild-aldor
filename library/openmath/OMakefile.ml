install Library ".DEFAULT" [
  (* Target *)
  Name		"openmath";
  Description	"OpenMath Library";
  Version	"0.0.1";

  (* Sources *)
  Domains [
    "src/om_base";
    "src/om_boot";
    "src/om_cdq";
    "src/om_stsq";
  ];

  Interfaces [
    "include/openmath";
  ];

  AldorRequires [
    "aldor";
    "xml";
  ];
]
