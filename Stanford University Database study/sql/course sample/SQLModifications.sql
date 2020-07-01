/**************************************************************
  INSERT, DELETE, AND UPDATE STATEMENTS
  Works for Postgres
  SQLite doesn't support All
  MySQL doesn't allow deletes from Apply with subquery on
    Apply (then College deletion behaves differently)
**************************************************************/

/**************************************************************
  Insert new college
**************************************************************/

insert into College values ('Carnegie Mellon', 'PA', 11500);

/**************************************************************
  Have all students who didn't apply anywhere apply to
  CS at Carnegie Mellon
**************************************************************/

/*** First see who will be inserted ***/

select *
from Student
where sID not in (select sID from Apply);

/*** Then insert them ***/

insert into Apply
  select sID, 'Carnegie Mellon', 'CS', null
  from Student
  where sID not in (select sID from Apply);

insert into Apply
  select sID, 'Carnegie Mellon', 'EE', 'Y'
  from student
  where sID in (select sID from Apply where major='EE' and decision='N')

/*** Admit to Carnegie Mellon EE all students who were turned down
     in EE elsewhere ***/

/*** First see who will be inserted ***/

select *
from Student
where sID in (select sID from Apply
              where major = 'EE' and decision = 'N');

/*** Then insert them ***/

insert into Apply
  select sID, 'Carnegie Mellon', 'EE', 'Y'
  from Student
  where sID in (select sID from Apply
                where major = 'EE' and decision = 'N');

/**************************************************************
  Delete all students who applied to more than two different
  majors
**************************************************************/

/*** First see who will be deleted ***/

select sID, count(distinct major)
from Apply
group by sID
having count(distinct major) > 2;

/*** Then delete them ***/

delete from Student
where sID in
  (select sID
   from Apply
   group by sID
   having count(distinct major) > 2);

/*** Delete same ones from Apply ***/
/*** NOTE SOME SYSTEMS DISALLOW  ***/

delete from Apply
where sID in
  (select sID
   from Apply
   group by sID
   having count(distinct major) > 2);

/**************************************************************
  Delete colleges with no CS applicants
**************************************************************/

/*** First see who will be deleted ***/

select * from College
where cName not in (select cName from Apply where major = 'CS');

/*** Then delete them ***/

delete from College
where cName not in (select cName from Apply where major = 'CS');

/**************************************************************
  Accept applicants to Carnegie Mellon with GPA < 3.6 but turn
  them into economics majors
**************************************************************/

/*** First see who will be updated ***/

select * from Apply
where cName = 'Carnegie Mellon'
  and sID in (select sID from Student where GPA < 3.6);

/*** Then update them ***/

update Apply
set decision = 'Y', major = 'economics'
where cName = 'Carnegie Mellon'
  and sID in (select sID from Student where GPA < 3.6);

/**************************************************************
  Turn the highest-GPA EE applicant into a CSE applicant
**************************************************************/


insert into Student values (789,'Ruhua', Null, 11500);
insert into Apply values (789,'Carnegie Mellon', 'EE', Null);


/*** First see who will be updated ***/

select * from Apply
where major = 'EE'
  and sID in
    (select sID from Student
     where GPA >= all
        (select GPA from Student
         where sID in (select sID from Apply where major = 'EE')));

/** If there is NULL value in GPA of student who apply 'EE' **/

UPdate Apply
set major='CSE'
Where major='EE'
	And sID in (Select S1.sID From Student S1
		       Where S1.GPA >= all
                (Select GPA From Student
                  Where GPA is not Null
                  and (sID in (Select sID from Apply Where major='EE'))
                )
              );
/*** Then update them ***/

update Apply
set major = 'CSE'
where major = 'EE'
  and sID in
    (select sID from Student
     where GPA >= all
        (select GPA from Student
         where sID in (select sID from Apply where major = 'EE')));

/**************************************************************
  Give everyone the highest GPA and smallest HS
**************************************************************/

update Student
set GPA = (select max(GPA) from Student),
    sizeHS = (select min(sizeHS) from Student);

/**************************************************************
  Accept everyone
**************************************************************/

update Apply
set decision = 'Y';
