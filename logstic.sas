title "Sashelp.shoes --- Fictitious Shoe Company Data";
proc contents data=sashelp.shoes varnum;
ods select position;
run;

data work.shoerange;
set  sashelp.shoes;
if  (. <Sales < 100000) then SalesRange='Lower';
else if (100000<= Sales <200000) then SalesRange='Middle';
else if (200000<= Sales ) then SalesRange='Upper';
run;

proc print data=work.shoerange;
run;

proc freq data=work.shoerange;
tables Salesrange;
run;

proc means data=work.shoerange nway ;
class  Salesrange;
var Sales;
output out=data2 mean=Sales_mean;
run;

/*project 3*/
title "The First Five Observations Out of heart data";
proc print data=sashelp.heart (obs=5) noobs;
run;

data work.lowchol work.highchol work.misschol ;
 set sashelp.heart;
 if (.<cholesterol < 200) then output work.lowchol ;
 else if (cholesterol >= 200) then output work.highchol;
 else if (cholesterol=.) then  output work.misschol;
 run;

 proc print data=work.misschol (obs=5) noobs;
run;

data WORK.TEMP;
Char1='0123456789';
Char2=substr(Char1,3,4);
 run;

 proc print data=WORK.TEMP;
 run;
proc format;
value score 1 - 50 = 'Fail'
 51 - 100 = 'Pass';
run; /*format setting*/

proc print data = SASUSER.CLASS;
var test;
format test score.;
 run; /*preformating formate to dataset*/


 data work.lowchol work.highchol;
 set sashelp.heart;
 if (.<cholesterol < 200) then output work.lowchol ;
 output;
 run;

 proc print data= WORK.XINLU (obs=5) noobs;
 run;
title "frequency of binary data";
 proc freq data= WORK.XINLU;
 tables Group;
 run;
ods graphics on;
Proc Logistic Data = WORK.XINLU descending;

proc contents data=WORK.XINLU order=varnum ;
run;

proc logistic data=WORK.XINLU descending;
  class Gender / param=ref ;
  model Group = Age Gender Hpl HpR NAccL NAccR Hp Nacc Glu
                / selection=stepwise
                     slentry=0.3 
/*SLENTRY=value
specifies the significance level of the score chi-square for entering an effect into the model 
					 in the FORWARD or STEPWISE method. */
                     slstay=0.35
					/* backward out model*/
                     details
                     lackfit;
run;

proc logistic data=WORK.XINLU descending;
  class Gender / param=ref ;
  model Group = Age Gender Hpl HpR NAccL NAccR Hp Nacc Glu;
  contrast 'Gender 1 vs 0' Gender 1 0 / estimate=parm;
run;

proc logistic data=WORK.XINLU descending;
  class Gender / param=ref ;
  model Group = Age Gender Hpl HpR NAccL NAccR Hp Nacc Glu;
  contrast 'Age=0.1' intercept 1 Age 0.1 Gender 1 0 Hpl 3 HpR 0.2 NAccL 0.1 NAccR 0.3 Hp 0.6 Nacc 1.2 Glu 1.5 / estimate=prob;
  contrast 'Age=0.2' intercept 1 Age 0.2 Gender 1 0 Hpl 3 HpR 0.2 NAccL 0.1 NAccR 0.3 Hp 0.6 Nacc 1.2 Glu 1.5  / estimate=prob;
run;


   data Arthritis;
      input Treatment $ Response ;
      datalines;
   Active 0.8  Active 0.3 Active 0.9 Active 0.7 Active 1.2
   Placebo 1.2 Placebo 0.1 Placebo 0.9 Placebo 0.2 Placebo 1.3
   ;

   proc print data=Arthritis;
   run;
proc iml;
x = T(1:10);
y = {2,2,3,5,5,6,6,8,9,10};
ID = repeat(1, nrow(x)) // repeat(2, nrow(x));
z = x // y;
create KSData var {ID z};
append;
close KSData;
quit;

proc print data=KSData;
run;

proc npar1way data=KSData edf;
   class ID;
   var z;
run;

title 'Comparison of Loan Types';
ods select Histogram Quantiles;
proc univariate data=WORK.XINLU;
   var Glu ;
   class Group;
   histogram  Glu / kernel
                                odstitle = title;
   inset n='Number of Homes' / position=ne;
   label LoanType = 'Type of center';
run;
options gstyle;
proc univariate data=WORK.XINLU;
   var Glu ;
   class Group;
   qqplot / exp(threshold=0 scale=est)grid;
   run;

proc npar1way data=WORK.XINLU edf;
   class Group;
   var Hpl;
run;


proc logistic data=WORK.XINLU descending;
  model Group =  Glu / iplots influence lackfit
clparm=both clodds=both;
run;

proc print data=WORK.XINLU;
run;


DATA data;
SET data=WORK.XINLU;
LOGVAR=log(GlU);
RUN;
