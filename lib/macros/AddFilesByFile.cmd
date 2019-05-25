echo [MACRO]AddFilesByFile %1
rem extract %1 to mounted directory with wimlib

call wimextract "%WB_SRC%" %WB_SRC_INDEX% @"%~1" --dest-dir="%_WB_MNT_PATH%" --no-acls --nullglob
