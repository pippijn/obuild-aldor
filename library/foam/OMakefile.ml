install Library ".DEFAULT" [
  (* Target *)
  Name		"foam";
  AldorName	"Runtime";
  Description	"Aldor runtime library";
  Version	"1.1.0";

  (* Sources *)
  Domains [
    "src/runtime";
  ];

  (* Domains used internally by runtime.as, must be inlined
   * completely and will not be linked into the C library or
   * packed into the Aldor library. *)
  InternalDomains [
    "src/aldorcatrep";
    "src/aldordomainrep";
    "src/basictuple";
    "src/box";
    "src/catdispatchvector";
    "src/catobj";
    "src/dd";
    "src/dispatchvector";
    "src/domain";
    "src/dv";
    "src/lazyimport";
    "src/pointerdomain";
    "src/ptrcache";
    "src/ptrcatobj";
    "src/stringtable";
  ];

  Includes [
    "include/runtimelib";
  ];

  AldorRequires [
    "foamlib";
  ];

  Flags [
    "runtime.as",	"-Wruntime";
  ];

  Var ("ALDOR_JLIB", "true");
  Var ("ALDOROPT", "$(ALDOROPT) -Qinline-all");
]
