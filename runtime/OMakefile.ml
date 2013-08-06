(*******************************************************
 * :: C part of the runtime library
 *******************************************************)

install Library ".DEFAULT" [
  (* Target *)
  Name		"runtime";
  Description	"Aldor runtime library";
  Version	"1.1.0";

  (* Sources *)
  Sources [
    "bigint.c";
    "btree.c";
    "dword.c";
    "foam_c.c";
    "foam_cfp.c";
    "foam_i.c";
    "opsys.c";
    "output.c";
    "stdc.c";
    "store.c";
    "table.c";
    "timer.c";
    "util.c";
    "xfloat.c";
  ];

  Headers [
    "cconfig.h";
    "foam_c.h";
    "foamopt.h";
    "optcfg.h";
    "platform.h";
  ];

  CRequires [
    "m";
  ];

  Var ("OM_CFLAGS", "$(STRICT_CFLAGS)");
  Var ("OM_CPPFLAGS", "-DFOAM_RTS=1 -I../compiler");

  Var ("STATIC", "false");
  Var ("SHARED", "true");

  Rule ("%.c", "../compiler/%.c", [
    "ln-or-cp $< $@";
  ]);
  Rule ("%.h", "../compiler/%.h", [
    "ln-or-cp $< $@";
  ]);

  (* Install the headers and along with the runtime library. *)
  Rule (
    "$(pkg-config-name $(Name))",
    "$(install-target $(includedir), $(Headers))",
    []
  );
]
