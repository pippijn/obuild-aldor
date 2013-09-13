install Library ".DEFAULT" [
  (* Target *)
  Name		"ax0";
  AldorName	"Axiom";
  Description	"Axiom bridge";
  Version	"1.1.0";

  (* Sources *)
  Domains [
    "src/ax/aggcat";
    "src/ax/any";
    "src/ax/array1";
    "src/ax/array2";
    "src/ax/basecliq";
    "src/ax/equation1";
    "src/ax/equation2";
    "src/ax/float";
    "src/ax/fr";
    "src/ax/fraction";
    "src/ax/fspace";
    "src/ax/indexedp";
    "src/ax/integer";
    "src/ax/kl";
    "src/ax/list";
    "src/ax/matcat";
    "src/ax/matrix";
    "src/ax/misc";
    "src/ax/mkfunc";
    "src/ax/multpoly";
    "src/ax/op";
    "src/ax/patmatch1";
    "src/ax/patmatch2";
    "src/ax/pattern";
    "src/ax/poly";
    "src/ax/polycat";
    "src/ax/seg";
    "src/ax/sex";
    "src/ax/sf";
    "src/ax/si";
    "src/ax/stream";
    "src/ax/symbol";
    "src/ax/variable";
    "src/ax/vector";

    "src/attrib";
    "src/axextend";
    "src/axlit";
    "src/lang";
    "src/minimach";
    "src/stub";
  ];

  Interfaces [
    "include/ax0";
  ];

  Includes [
    "include/axllib";
  ];

  Rule ("src/lang.as", "../axllib/src/lang.as", [
    "ln-or-cp $< $@";
  ]);

  Rule ("include/axllib.as", "../axllib/include/axllib.as", [
    "ln-or-cp $< $@";
  ]);

  Var ("ALDOR_CLIB", "false");
]
