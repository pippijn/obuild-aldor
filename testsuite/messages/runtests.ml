(* +=====~~~-------------------------------------------------------~~~=====+ *)
(* |                          Test suite description                       | *)
(* +=====~~~-------------------------------------------------------~~~=====+ *)

TestFramework.(run "testsuite" [
  { empty with
    tool = "aldor";
    suffixes = [".as"];
    options = Some "-Ginterp -Mno-emax";
    dirs = [
      "axllib";
      "regression";
    ];
    filter = (fun line ->
      try
        Scanf.sscanf line "\"%s@\", line %d: " (fun fname lineno ->
          Printf.sprintf "\"%s\", line %d: " (Filename.basename fname) lineno
        )
      with
      | End_of_file
      | Scanf.Scan_failure _ ->
          line
    );
  };
])
