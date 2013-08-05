install Library ".DEFAULT" [
  (* Target *)
  Name		"aldor";
  Description	"Aldor standard library";
  Version	"1.1.0";

  (* Sources *)
  Domains [
    "src/arith/sal_arith";
    "src/arith/sal_binpow";
    "src/arith/sal_bool";
    "src/arith/sal_bsearch";
    "src/arith/sal_complex";
    "src/arith/sal_dfloat";
    "src/arith/sal_fltcat";
    "src/arith/sal_ftools";
    "src/arith/sal_int";
    "src/arith/sal_intcat";
    "src/arith/sal_itools";
    "src/arith/sal_lincomb";
    "src/arith/sal_mint";
    "src/arith/sal_oarith";
    "src/arith/sal_pointer";
    "src/arith/sal_random";
    "src/arith/sal_segment";
    "src/arith/sal_sfloat";
    "src/base/ald_pfunc";
    "src/base/sal_base";
    "src/base/sal_bstream";
    "src/base/sal_byte";
    "src/base/sal_char";
    "src/base/sal_copy";
    "src/base/sal_gener";
    "src/base/sal_htype";
    "src/base/sal_itype";
    "src/base/sal_manip";
    "src/base/sal_order";
    "src/base/sal_otype";
    "src/base/sal_partial";
    "src/base/sal_serial";
    "src/base/sal_syntax";
    "src/base/sal_torder";
    "src/base/sal_tstream";
    "src/datastruc/ald_flags";
    "src/datastruc/ald_queue";
    "src/datastruc/ald_symbol";
    "src/datastruc/ald_symtab";
    "src/datastruc/sal_array";
    "src/datastruc/sal_barray";
    "src/datastruc/sal_bdata";
    "src/datastruc/sal_bstruc";
    "src/datastruc/sal_ckarray";
    "src/datastruc/sal_cklist";
    "src/datastruc/sal_ckmembk";
    "src/datastruc/sal_data";
    "src/datastruc/sal_ddata";
    "src/datastruc/sal_fstruc";
    "src/datastruc/sal_hash";
    "src/datastruc/sal_kntry";
    "src/datastruc/sal_list";
    "src/datastruc/sal_lstruc";
    "src/datastruc/sal_memblk";
    "src/datastruc/sal_parray";
    "src/datastruc/sal_pkarray";
    "src/datastruc/sal_set";
    "src/datastruc/sal_slist";
    "src/datastruc/sal_sortas";
    "src/datastruc/sal_sset";
    "src/datastruc/sal_stream";
    "src/datastruc/sal_string";
    "src/datastruc/sal_table";
    "src/gmp/sal_fltgmp";
    "src/gmp/sal_gmptls";
    "src/gmp/sal_intgmp";
    "src/lang/sal_lang";
    "src/util/ald_trace";
    "src/util/eio_rsto";
    "src/util/rtexns";
    "src/util/sal_agat";
    "src/util/sal_cmdline";
    "src/util/sal_file";
    "src/util/sal_timer";
    "src/util/sal_version";
  ];

  Interfaces [
    "include/aldor";
    "include/aldorinterp";
    "include/aldorio";
    "include/aldortest";
    "src/aldor_gloop";
    "src/aldor_gloopd";
  ];

  Sources [
    "src/util/sal_util.c";
  ];
]
