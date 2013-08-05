install Library ".DEFAULT" [
  (* Target *)
  Name		"charset";
  Description	"Library for characteristic sets";
  Version	"1.0.1";

  (* Sources *)
  Domains [
    "src/algos/cs_astls";
    "src/algos/cs_bssts";
    "src/algos/cs_bstls";
    "src/algos/cs_castl";
    "src/algos/cs_ccomp";
    "src/algos/cs_decom";
    "src/algos/cs_gbalg";
    "src/algos/cs_gbtls";
    "src/algos/cs_msat";
    "src/algos/cs_resum";
    "src/algos/cs_rgbal";
    "src/algos/cs_rgbtl";
    "src/algos/cs_sdecm";
    "src/algos/cs_sgbal";
    "src/algos/cs_srgba";
    "src/algos/cs_trang";
    "src/algos/cs_umsat";
    "src/dpoly/cs_detot";
    "src/dpoly/cs_dprpt";
    "src/dpoly/cs_dprt";
    "src/dpoly/cs_dr";
    "src/dpoly/cs_dt";
    "src/exponent/cs_cpde";
    "src/exponent/cs_ect";
    "src/exponent/cs_le";
    "src/exponent/cs_lse";
    "src/exponent/cs_sle";
    "src/order/cs_dveot";
    "src/order/cs_dvleo";
    "src/order/cs_dvlo";
    "src/order/cs_dvmo";
    "src/order/cs_dvoeo";
    "src/order/cs_dvoo";
    "src/order/cs_dvot";
    "src/poly/cs_dpcom";
    "src/poly/cs_dpgcd";
    "src/poly/cs_dplto";
    "src/reduction/cs_as";
    "src/reduction/cs_prem";
    "src/reduction/cs_prwd";
    "src/reduction/cs_redut";
    "src/reduction/cs_trred";
    "src/util/cs_integ";
    "src/util/cs_rank";
    "src/util/cs_versi";
    "src/vars/cs_dv";
    "src/vars/cs_dvt";
    "src/vars/cs_dvtls";
    "src/vars/cs_eodvt";
    "src/vars/cs_mvt";
    "src/vars/cs_odv";
    "src/vars/cs_odvt";
    "src/vars/cs_ovl2";
    "src/vars/cs_ovlh";
    "src/vars/cs_vmrgr";

    (*"src/algos/cs_chide";*)
    (*"src/algos/cs_cstls";*)
    (*"src/algos/cs_sgbpr";*)
    (*"src/algos/cs_zdchi";*)
    (*"src/dpoly/cs_dedpr";*)
    (*"src/exponent/cs_ce";*)
    (*"src/poly/cs_ddegs";*)
    (*"src/poly/cs_dmain";*)
    (*"src/poly/cs_dmdeg";*)
    (*"src/poly/cs_dmdgs";*)
    (*"src/poly/cs_dpidm";*)
    (*"src/poly/cs_pgcd";*)
    (*"src/poly/cs_plain";*)
    (*"src/poly/cs_rarpr";*)
    (*"src/poly/cs_rarr";*)
    (*"src/poly/cs_rcarr";*)
    (*"src/reduction/cs_dpred";*)
    (*"src/reduction/cs_pred";*)
    (*"src/util/cs_difpr";*)
    (*"src/vars/cs_vmtls";*)
  ];

  Interfaces [
    "include/charset";
  ];

  AldorRequires [
    "aldor";
    (*"algebra";*)
  ];
]
