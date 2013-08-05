install Library ".DEFAULT" [
  (* Target *)
  Name		"axldem";
  Description	"AxiomXL demo library";
  Version	"1.1.0";

  (* Sources *)
  Domains [
    "src/dirprod";
    "src/gb";
    "src/ibits";
    "src/lmdict";
    "src/matopdom";
    "src/matrix";
    "src/nni";
    "src/poly";
    "src/poly3";
    "src/polycat";
    "src/prime";
    "src/quanc8";
    "src/random";
    "src/spf";
    "src/vector";
  ];

  Interfaces [
    "include/axldem";
  ];

  AldorRequires [
    "axllib";
  ];
]
