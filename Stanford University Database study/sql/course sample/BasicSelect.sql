/**************************************************************
  BASIC SELECT STATEMENTS
  Works for SQLite, MySQL, Postgres
**************************************************************/
create table Student
  (
    sID INT primary key,
    sName VARCHAR(15),
    GPA decimal,
    sizeHS INT
  );

  create table College
    (
      cName VARCHAR(15) primary key,
      state VARCHAR(15),
      enrollment INT
    );

    create table Apply
      (
        sID INT ,
        cName VARCHAR(15),
        major VARCHAR(15),
        decision VARCHAR(15),
        primary key (sID,cName,major)
      );

      INSERT INTO Student(
      VALUES
          (001, 'zhang', 3.9,800),
          (002, 'zhang',3.8,1000),
          (003, 'xilu',3.0,500),
          (004, 'li',2.7,300),
          (005, 'wang',2.0,1000),
          (006, 'wang',4.0,800)
      );

      INSERT INTO Student(
      VALUES
          (011, 'lu', 4.0,800)
      );

      insert into College(
        VALUES
        ('MIT', 'MA',100000),
        ('Stanford','CA',140000),
        ('Berkeley','CA',80000),
        ('Cornell','NY',120000)
      );

      insert into Apply(
        VALUES
        (001,'MIT', 'CS','Y'),
        (001,'Stanford','CS','N'),
        (001,'Berkeley','EE','N'),
        (001,'Cornell','EE','Y'),
        (002,'MIT','biostat','Y'),
        (002,'Cornell','biostat','N'),
        (002,'Cornell','CS','N'),
        (003,'Stanford','CS','Y'),
        (003,'Stanford','biochemistry','N'),
        (004,'MIT','biochemistry','N'),
        (004,'Berkeley','biochemistry','N'),
        (004,'Stanford','biochemistry','N'),
        (005,'Stanford','biochemistry','N'),
        (005,'Stanford','EE','N'),
        (005,'MIT','EE','N'),
        (005,'MIT','biostat','Y'),
        (006,'MIT','biostat','Y'),
        (006,'MIT','EE','Y'),
        (006,'Berkeley','EE','Y'),
        (006,'Berkeley','CS','Y'),
        (006,'Stanford','CS','Y'),
        (006,'Stanford','EE','Y')
      );



/**************************************************************
  IDs, names, and GPAs of students with GPA > 3.6
**************************************************************/

select sID, sName, GPA
from Student
where GPA > 3.6
order by GPA desc;

/*** Same query without GPA ***/

select sID, sName
from Student
where GPA > 3.6
order by GPA desc;

/**************************************************************
  Student names and majors for which they've applied
**************************************************************/

select sName, major
from Student, Apply
where Student.sID = Apply.sID;

/*** Same query with Distinct, note difference from algebra ***/

select distinct sName, major
from Student, Apply
where Student.sID = Apply.sID
order by major desc, sName;

/**************************************************************
  Names and GPAs of students with sizeHS < 1000 applying to
  CS at Stanford, and the application decision
**************************************************************/

select sname, GPA,sizeHS, decision
from Student, Apply
where Student.sID = Apply.sID
  and sizeHS < 1000 and major = 'CS' and cname = 'Stanford';

/**************************************************************
  All large campuses with CS applicants
**************************************************************/
/*** with "cname" is ambiguous***/
select cName
from College, Apply
where College.cName = Apply.cName
  and enrollment > 20000 and major = 'CS';

/*** Fix error ***/

select College.cName
from College, Apply
where College.cName = Apply.cName
  and enrollment > 20000 and major = 'CS';

/*** Add Distinct ***/

select distinct College.cName
from College, Apply
where College.cName = Apply.cName
  and enrollment > 20000 and major = 'CS';

/**************************************************************
  Application information
**************************************************************/

select Student.sID, sName, GPA, Apply.cName, enrollment
from Student, College, Apply
where Apply.sID = Student.sID and Apply.cName = College.cName;

/*** Sort by decreasing GPA ***/
/*** whatever major is ***/
select distinct Student.sID, sName, GPA, Apply.cName, enrollment
from Student, College, Apply
where Apply.sID = Student.sID and Apply.cName = College.cName
order by GPA desc;

/*** Then by increasing enrollment ***/

select distinct Student.sID, sName, GPA, Apply.cName, enrollment
from Student, College, Apply
where Apply.sID = Student.sID and Apply.cName = College.cName
order by GPA desc, enrollment,Apply.cName;

/**************************************************************
  Applicants to bio majors
**************************************************************/

select distinct sID, major
from Apply
where major like '%bio%'
order by major desc, sID;

/*** Same query with Select * ***/

select *
from Apply
where major like '%bio%';

/**************************************************************
  Select * cross-product of sID and c Name
**************************************************************/

select *
from Student, College;

/**************************************************************
  Add scaled GPA based on sizeHS
  Also note missing Where clause
**************************************************************/

select sID, sName, GPA, sizeHS, GPA*(sizeHS/1000.0)
from Student;

/*** Rename result attribute ***/

select sID, sName, GPA, sizeHS, GPA*(sizeHS/1000.0) as scaledGPA
from Student;

select *, GPA*(sizeHS/1000.0) as scaledGPA
from Student;
