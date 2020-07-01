PROC IMPORT OUT= WORK.xinlu 
            DATAFILE= "\\Client\C$\Users\zhangxinlu\Downloads\Sample-dat
a-sets-for-linear-regression1.xlsx" 
            DBMS=EXCEL REPLACE;
     RANGE="'Transit demand$'"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;
