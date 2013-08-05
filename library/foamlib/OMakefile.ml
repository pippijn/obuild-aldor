install Library ".DEFAULT" [
  (* Target *)
  Name		"foamlib";
  AldorName	"Axl";
  Description	"FOAM runtime support library";
  Version	"1.1.0";

  (* Sources *)
  Domains [
    "src/array";
    "src/basic";
    "src/bool";
    "src/character";
    "src/file";
    "src/fname";
    "src/foamcat";
    "src/format";
    "src/gener";
    "src/lang";
    "src/langx";
    "src/list";
    "src/lv";
    "src/machine";
    "src/opsys";
    "src/oslow";
    "src/parray";
    "src/partial";
    "src/pointer";
    "src/segment";
    "src/sfloat";
    "src/sinteger";
    "src/string";
    "src/textwrit";
    "src/tuple";
  ];

  Interfaces [
    "include/foamlib";
  ];

  Var ("ALDOR_JLIB", "true");
]
