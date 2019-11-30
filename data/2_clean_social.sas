libname soc '/folders/myfolders/wellbeing-datasets/social_integration';
libname mylib '/folders/myfolders/wellbeing-datasets/cleaned';

proc import datafile='/folders/myfolders/wellbeing-datasets/social_integration/cs08a_2p_EN.sav' 
			dbms=sav out=social01_0 (drop= cs08a375 - cs08a378) replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/social_integration/cs09b_1p_EN.sav' 
			dbms=sav out=social02_0 (drop= cs09b375 - cs09b378) replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/social_integration/cs10c_1p_EN.sav' 
			dbms=sav out=social03_0 (drop= cs10c375 - cs10c378) replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/social_integration/cs11d_EN_3.0p.sav' 
			dbms=sav out=social04_0 (drop= cs11d375 - cs11d378) replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/social_integration/cs12e_1.0p_EN.sav' 
			dbms=sav out=social05_0 (drop= cs12e375 - cs12e378) replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/social_integration/cs13f_2.0p_EN.sav' 
			dbms=sav out=social06_0 (drop= cs13f375 - cs13f378) replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/social_integration/cs14g_EN_2.0.sav' 
			dbms=sav out=social07_0 (drop= cs14g375 - cs14g378) replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/social_integration/cs15h_EN_1.0p.sav' 
			dbms=sav out=social08_0 (drop= cs15h375 - cs15h378) replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/social_integration/cs16i_EN_1.0p.sav' 
			dbms=sav out=social09_0 (drop= cs16i375 - cs16i378) replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/social_integration/cs17j_EN_1.0p.sav' 
			dbms=sav out=social10_0 (drop= cs17j375 - cs17j378) replace; run;

data social01; set social01_0; wave = 1; run;
data social02; set social02_0; wave = 2; run;
data social03; set social03_0; wave = 3; run;
data social04; set social04_0; wave = 4; run;
data social05; set social05_0; wave = 5; run;
data social06; set social06_0; wave = 6; run;
data social07; set social07_0; wave = 7; run;
data social08; set social08_0; wave = 8; run;
data social09; set social09_0; wave = 9; run;
data social10; set social10_0; wave = 10; run;


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

%rename_vars(social01);
%rename_vars(social02);
%rename_vars(social03);
%rename_vars(social04);
%rename_vars(social05);
%rename_vars(social06);
%rename_vars(social07);
%rename_vars(social08);
%rename_vars(social09);
%rename_vars(social10);


/* Merge all  */
data all_social;
set 
social01
social02
social03
social04
social05
social06
social07
social08
social09
social10;
by no_encr wa;
rename wa = wave;
rename no_encr = nomem_encr;
run;


/* Preliminary drop */
data all_social2;
set all_social;
label cs293 = 'How often do you do the following? Go to a bar or cafe';   /* rm accent */;
drop
/* open text */ 
cs065     
cs078
cs123
cs322
cs333
cs344
cs355
cs366;
run;


proc means data = all_social2 N NMISS; run;
proc contents data =all_social2 order = varnum; run;

/* Keep vars based on "keep" column in data cleaning spreadsheet */
data all_social3;
set all_social2;
keep
nomem_encr
cs_m
cs001 - cs063
cs070
cs077
cs082 - cs083
cs087 - cs090
cs102 - cs104
cs124 - cs127
cs130
cs132 - cs139
cs141 - cs159
cs242 - cs245
cs251 - cs254
cs260 - cs268
cs283 - cs298
wave;
run;

/* data mylib.clean_social; */
/* set all_social3; */
/* run; */

/* Remove cheating vars */
data mylib.clean_social2;
set all_social3;
drop
cs001
cs002
cs070
cs283;
run;

/* proc datasets lib=work kill; run; */



