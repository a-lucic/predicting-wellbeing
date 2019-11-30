libname bkgd '/folders/myfolders/wellbeing-datasets/background';
libname pers '/folders/myfolders/wellbeing-datasets/personality';
libname soc '/folders/myfolders/wellbeing-datasets/social_integration';
libname mylib '/folders/myfolders/wellbeing-datasets/cleaned';

data personality;
/* set mylib.clean_personality; */
set mylib.clean_personality2;
run;

data background;
set mylib.clean_background;
run;

data social;
/* set mylib.clean_social; */
set mylib.clean_social2;
run;

/* Make sure dates match up */
proc freq data = personality; table month; run;
proc freq data = background; table month; run;

proc sort data = personality; by nomem_encr month; run;
proc sort data = background; by nomem_encr month; run;

data merge_back_pers;
merge background (in=a) personality(in=b);
by nomem_encr month;
if a and b;
run;

proc means data=merge_back_pers NMISS N; run;

/* Merge with social by wave */
data big_merge;
merge merge_back_pers(in=a) social(in=b);
by nomem_encr wave;
if a and b;
run;

proc export data=big_merge dbms=csv
outfile='/folders/myfolders/wellbeing-datasets/cleaned/clean_back_pers_soc2.csv'
replace;
run;