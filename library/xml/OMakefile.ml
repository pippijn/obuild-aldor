install Library ".DEFAULT" [
  (* Target *)
  Name		"xml";
  Description	"Aldor XML Library";
  Version	"0.0.1";

  (* Sources *)
  Domains [
    "src/xml_base";
    "src/xml_basiccats";
    "src/xml_basics";
    "src/xml_boot";
    "src/xml_Doc";
    "src/xml_Dom0";
    "src/xml_Dom1";
    "src/xml_gener";
    "src/xml_mygen";
    "src/xml_Out";
    "src/xml_unicode";
  ];

  Interfaces [
    "include/xmllib";
  ];

  AldorRequires [
    "aldor";
  ];

  (* Greater optimisation values loop forever *)
  Var ("ALDOROPT", "-Q6");
]
