libname bkgd '/folders/myfolders/wellbeing-datasets/background';
libname pers '/folders/myfolders/wellbeing-datasets/personality';
libname mylib '/folders/myfolders/wellbeing-datasets/cleaned';

/* Import all datasets */
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_200805_EN_2.0p.sav' 
			dbms=sav out=back200805 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_200808_EN_2.0p.sav' 
			dbms=sav out=back200808 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_200905_EN_2.0p.sav' 
			dbms=sav out=back200905 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_200906_EN_2.0p.sav' 
			dbms=sav out=back200906 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_201005_EN_2.0p.sav' 
			dbms=sav out=back201005 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_201006_EN_2.0p.sav' 
			dbms=sav out=back201006 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_201105_EN_2.0p.sav' 
			dbms=sav out=back201105 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_201106_EN_2.0p.sav' 
			dbms=sav out=back201106 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_201205_EN_2.0p.sav' 
			dbms=sav out=back201205 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_201206_EN_2.0p.sav' 
			dbms=sav out=back201206 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_201305_EN_1.0p.sav' 
			dbms=sav out=back201305 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_201306_EN_1.0p.sav' 
			dbms=sav out=back201306 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_201411_EN_1.0p.sav' 
			dbms=sav out=back201411 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_201412_EN_1.0p.sav' 
			dbms=sav out=back201412 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_201511_EN_1.0p.sav' 
			dbms=sav out=back201511 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_201512_EN_1.0p.sav' 
			dbms=sav out=back201512 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_201705_EN_1.0p.sav' 
			dbms=sav out=back201705 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_201706_EN_1.0p.sav' 
			dbms=sav out=back201706 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_201805_EN_1.0p.sav' 
			dbms=sav out=back201805 replace; run;
proc import datafile='/folders/myfolders/wellbeing-datasets/background/avars_201806_EN_1.0p.sav' 
			dbms=sav out=back201806 replace; run;

data all_back;
set 
back200805
back200808
back200905
back200906
back201005
back201006
back201105
back201106
back201205
back201206
back201305
back201306
back201411
back201412
back201511
back201512
back201705
back201706
back201805
back201806;
by nomem_encr wave;
drop 
nohouse_encr
herkomstgroep
lftdcat
brutocat
nettocat
werving;
rename wave = month;
run;

/* Check number of missing values - maybe get rid of 200805 set */
proc means data=all_back NMISS N; run;

/* Imputed version of income arent available in wave 1 */
/* Keep only one version of income */
data all_back2;
set all_back;
if nettoink_f = . then nettoink_f = nettoink;
drop brutoink nettoink netinc brutoink_f brutohh_f nettohh_f;
run;

proc means data = all_back2 N NMISS; var nettoink_f ; run;


data mylib.clean_background;
set all_back2;
run;

/* proc datasets lib=work kill; run; */













