libname bkgd '/folders/myfolders/wellbeing-datasets/background';
libname pers '/folders/myfolders/wellbeing-datasets/personality';
libname mylib '/folders/myfolders/wellbeing-datasets/cleaned';

/* Import all datasets */
proc import datafile='/folders/myfolders/wellbeing-datasets/personality/cp08a_1p_EN.sav' 
			dbms=sav out=pers08 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/personality/cp09b_1.0p_EN.sav' 
			dbms=sav out=pers09 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/personality/cp10c_1.0p_EN.sav' 
			dbms=sav out=pers10 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/personality/cp11d_1.0p_EN.sav' 
			dbms=sav out=pers11 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/personality/cp12e_1.0p_EN.sav' 
			dbms=sav out=pers12 replace; run;
			
proc import datafile='/folders/myfolders/wellbeing-datasets/personality/cp13f_EN_1.0p.sav' 
			dbms=sav out=pers13 (drop=cp13f189 cp13f190 cp13f191 cp13f192) replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/personality/cp14g_EN_1.0p.sav' 
			dbms=sav out=pers14 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/personality/cp15h_EN_1.0p.sav' 
			dbms=sav out=pers15 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/personality/cp17i_EN_1.0p.sav' 
			dbms=sav out=pers17 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/personality/cp18j_EN_1.0p.sav' 
			dbms=sav out=pers18 replace; run;


/* Only keep features that are in all sets */
data pers08_drop;
set pers08;
wavewve = 1;
keep
nomem_encr
cp08a_m
wavewve
cp08a010
cp08a011
cp08a012 - cp08a013
cp08a014 - cp08a018
cp08a019
cp08a020 - cp08a069
cp08a070 - cp08a079
cp08a080 - cp08a082
cp08a083 - cp08a098
cp08a099 - cp08a134
cp08a135
cp08a136 - cp08a145 
cp08a146 - cp08a165
cp08a166 - cp08a183 ;
run;

data pers09_drop;
set pers09;
wavewve = 2;
keep 
nomem_encr
cp09b_m
wavewve
cp09b010
cp09b011
cp09b012 - cp09b013
cp09b014 - cp09b018
cp09b019
cp09b020 - cp09b069
cp09b070 - cp09b079
cp09b080 - cp09b082
cp09b083 - cp09b098
cp09b099 - cp09b134
cp09b135
cp09b136 - cp09b145 
cp09b146 - cp09b165
cp09b166 - cp09b183 ;
run;

data pers10_drop;
set pers10;
if cp10c195 = 2 then delete;     /* rm short version, maybe put back later */
wavewve = 3;
keep 
nomem_encr
cp10c_m
wavewve
cp10c010
cp10c011
cp10c012 - cp10c013
cp10c014 - cp10c018
cp10c019
cp10c020 - cp10c069
cp10c070 - cp10c079
cp10c080 - cp10c082
cp10c083 - cp10c098
cp10c099 - cp10c134
cp10c135
cp10c136 - cp10c145 
cp10c146 - cp10c165
cp10c166 - cp10c183 ;
run;

data pers11_drop;
set pers11;
wavewve = 4;
keep 
nomem_encr
cp11d_m
wavewve
cp11d010
cp11d011
cp11d012 - cp11d013
cp11d014 - cp11d018
cp11d019
cp11d020 - cp11d069
cp11d070 - cp11d079
cp11d080 - cp11d082
cp11d083 - cp11d098
cp11d099 - cp11d134
cp11d135
cp11d136 - cp11d145 
cp11d146 - cp11d165
cp11d166 - cp11d183 ;
run;

data pers12_drop;
set pers12;
if cp12e197 = 1 then delete;      /* rm short version, maybe put back later */
wavewve = 5;
keep 
nomem_encr
cp12e_m
wavewve
cp12e010
cp12e011
cp12e012 - cp12e013
cp12e014 - cp12e018
cp12e019
cp12e020 - cp12e069
cp12e070 - cp12e079
cp12e080 - cp12e082
cp12e083 - cp12e098
cp12e099 - cp12e134
cp12e135
cp12e136 - cp12e145 
cp12e146 - cp12e165
cp12e166 - cp12e183 ;
run;

data pers13_drop;
set pers13;
wavewve = 6;
keep 
nomem_encr
cp13f_m
wavewve
cp13f010
cp13f011
cp13f012 - cp13f013
cp13f014 - cp13f018
cp13f019
cp13f020 - cp13f069
cp13f070 - cp13f079
cp13f080 - cp13f082
cp13f083 - cp13f098
cp13f099 - cp13f134
cp13f135
cp13f136 - cp13f145 
cp13f146 - cp13f165
cp13f166 - cp13f183 ;
run;

data pers14_drop;
set pers14;
wavewve = 7;
keep 
nomem_encr
cp14g_m
wavewve
cp14g010
cp14g011
cp14g012 - cp14g013
cp14g014 - cp14g018
cp14g019
cp14g020 - cp14g069
cp14g070 - cp14g079
cp14g080 - cp14g082
cp14g083 - cp14g098
cp14g099 - cp14g134
cp14g135
cp14g136 - cp14g145 
cp14g146 - cp14g165
cp14g166 - cp14g183 ;
run;

data pers15_drop;
set pers15;
if cp15h197 = 1 then delete;   /* remove short version */
wavewve = 8;
keep 
nomem_encr
cp15h_m
wavewve
cp15h010
cp15h011
cp15h012 - cp15h013
cp15h014 - cp15h018
cp15h019
cp15h020 - cp15h069
cp15h070 - cp15h079
cp15h080 - cp15h082
cp15h083 - cp15h098
cp15h099 - cp15h134
cp15h135
cp15h136 - cp15h145 
cp15h146 - cp15h165
cp15h166 - cp15h183 ;
run;

data pers17_drop;
set pers17;
wavewve = 9;
keep 
nomem_encr
cp17i_m
wavewve
cp17i010
cp17i011
cp17i012 - cp17i013
cp17i014 - cp17i018
cp17i019
cp17i020 - cp17i069
cp17i070 - cp17i079
cp17i080 - cp17i082
cp17i083 - cp17i098
cp17i099 - cp17i134
cp17i135
cp17i136 - cp17i145 
cp17i146 - cp17i165
cp17i166 - cp17i183 ;
run;

data pers18_drop;
set pers18;
if cp18j197 = 1 then delete ;     /* short version */
wavewve = 10;
keep 
nomem_encr
cp18j_m
wavewve
cp18j010
cp18j011
cp18j012 - cp18j013
cp18j014 - cp18j018
cp18j019
cp18j020 - cp18j069
cp18j070 - cp18j079
cp18j080 - cp18j082
cp18j083 - cp18j098
cp18j099 - cp18j134
cp18j135
cp18j136 - cp18j145 
cp18j146 - cp18j165
cp18j166 - cp18j183 ;
run;


/* Macro for renaming variables */
%macro rename_vars(table);
  %let table=%upcase(&table);
  %let rename_list=;
proc sql noprint;
	SELECT cats(NAME,"=", catt(substr(NAME,1,2), substr(NAME,6)))
	INTO :rename_list SEPARATED BY " "
	FROM dictionary.columns
	WHERE LIBNAME="WORK" AND MEMNAME="&table";
quit;

  %put rename_list: %bquote(&rename_list);

  %if %bquote(&rename_list) ne %then
    %do;
      proc datasets lib=%scan(WORK.&table,-2);
        modify %scan(&table,-1);
          rename &rename_list;
        run;
      quit;
    %end;
%mend;

%rename_vars(pers08_drop);
%rename_vars(pers09_drop);
%rename_vars(pers10_drop);
%rename_vars(pers11_drop);
%rename_vars(pers12_drop);
%rename_vars(pers13_drop);
%rename_vars(pers14_drop);
%rename_vars(pers15_drop);
%rename_vars(pers17_drop);
%rename_vars(pers18_drop);


data all_personality;
set 
pers08_drop
pers09_drop
pers10_drop
pers11_drop
pers12_drop
pers13_drop
pers14_drop
pers15_drop
pers17_drop
pers18_drop;
by no_encr cp_m;
run;


/* Delete records with missing targets, rename targets */
data all_personality2;
set all_personality;
if cp010 = . then delete;    /* happiness */
if cp011 = . then delete;    /* satisfaction */
if cp013 = . then delete;    /* trait mood */

if cp014 = . then delete;    /* diener 1 */
if cp015 = . then delete;    /* diener 2 */
if cp016 = . then delete;    /* diener 3 */
if cp017 = . then delete;    /* diener 4 */
if cp018 = . then delete;    /* diener 5 */


diener = cp014 + cp015 + cp016 + cp017 + cp018;
     if 5 <= diener <= 9 then diener_cat = 1;
else if 10 <= diener <= 14 then diener_cat = 2;
else if 15 <= diener <= 19 then diener_cat = 3;
else if 20 <= diener <= 24 then diener_cat = 4;
else if 25 <= diener <= 29 then diener_cat = 5;
else if 30 <= diener <= 35 then diener_cat = 6;
else diener_cat = -999;

rename no_encr = nomem_encr;
rename cp_m = month;
run;


proc sql;
select count(distinct(nomem_encr))
from all_personality2;
run;

proc freq data = all_personality2; 
table diener_cat;
run;

/* data mylib.clean_personality; */
/* set all_personality2; */
/* run; */

data mylib.clean_personality2;
set all_personality2;
drop
cp038
cp068
cp076
cp080
cp081
cp147-cp149
cp152
cp154
cp165;
run;





















