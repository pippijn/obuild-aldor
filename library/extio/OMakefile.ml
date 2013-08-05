install Library ".DEFAULT" [
  (* Target *)
  Name		"extio";
  Description	"Extended I/O";
  Version	"1.0.4";

  (* Sources *)
  Domains [
    "src/cas/eio_casc";
    "src/cas/eio_cast";
    "src/cas/eio_mapl";
    "src/cas/eio_math";
    "src/cas/eio_matp";
    "src/chars/eio_ansi";
    "src/chars/eio_char";
    "src/datastru/eio_cht";
    "src/datastru/eio_chtc";
    "src/datastru/eio_expl";
    "src/datastru/eio_expt";
    "src/datastru/eio_list";
    "src/datastru/eio_repo";
    "src/datastru/eio_rept";
    "src/datastru/eio_tree";
    "src/exceptions/eio_aex";
    "src/exceptions/eio_ex";
    "src/exceptions/eio_ext";
    "src/exceptions/eio_fex";
    "src/exceptions/eio_gex";
    "src/exceptions/eio_lex";
    "src/exceptions/eio_nfe";
    "src/exceptions/eio_nfet";
    "src/exceptions/eio_rex";
    "src/exceptions/eio_rmx";
    "src/exceptions/eio_sex";
    "src/exceptions/eio_tex";
    "src/util/eio_linb";
    "src/util/eio_stok";
    "src/util/eio_time";
    "src/util/eio_vers";
  ];

  Interfaces [
    "include/extio";
  ];

  AldorRequires [
    "aldor";
    "algebra";
  ];

  Var ("OM_AFLAGS", "-DLibraryExtIORequiresLibraryAlgebra");
]
