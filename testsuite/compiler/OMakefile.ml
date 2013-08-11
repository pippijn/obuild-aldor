install Program ".DEFAULT" [
  (* Target *)
  Name		"aldor-test";

  (* Sources *)
  Sources [
    "abquick.c";
    "testall.c";
    "testlib.c";
    "test_ablogic.c";
    "test_absyn.c";
    "test_bitv.c";
    "test_flog.c";
    "test_fname.c";
    "test_foam.c";
    "test_format.c";
    "test_jflow.c";
    "test_list.c";
    "test_ostream.c";
    "test_printf.c";
    "test_scobind.c";
    "test_srcpos.c";
    "test_stab.c";
    "test_syme.c";
    "test_tform.c";
    "test_tfsat.c";
    "test_tibup.c";
    "test_tinfer.c";
  ];

  Headers [
    "abquick.h";
    "testall.h";
    "testlib.h";
  ];

  CRequires [
    "alcomp";
    "m";
  ];

  Rule ("check", "$(Name).log", []);
  Rule ("$(Name).log", "$(Name)$(EXEEXT)", [
    "$< > $@"
  ]);

  Var ("OM_CPPFLAGS", "-I$(includedir)/aldor");
]
