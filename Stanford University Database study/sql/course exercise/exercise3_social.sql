/* Delete the tables if they already exist */
drop table if exists Highschooler;
drop table if exists Friend;
drop table if exists Likes;

/* Create the schema for our tables */
create table Highschooler(ID int, name text, grade int);
create table Friend(ID1 int, ID2 int);
create table Likes(ID1 int, ID2 int);

/* Populate the tables with our data */
insert into Highschooler values (1510, 'Jordan', 9);
insert into Highschooler values (1689, 'Gabriel', 9);
insert into Highschooler values (1381, 'Tiffany', 9);
insert into Highschooler values (1709, 'Cassandra', 9);
insert into Highschooler values (1101, 'Haley', 10);
insert into Highschooler values (1782, 'Andrew', 10);
insert into Highschooler values (1468, 'Kris', 10);
insert into Highschooler values (1641, 'Brittany', 10);
insert into Highschooler values (1247, 'Alexis', 11);
insert into Highschooler values (1316, 'Austin', 11);
insert into Highschooler values (1911, 'Gabriel', 11);
insert into Highschooler values (1501, 'Jessica', 11);
insert into Highschooler values (1304, 'Jordan', 12);
insert into Highschooler values (1025, 'John', 12);
insert into Highschooler values (1934, 'Kyle', 12);
insert into Highschooler values (1661, 'Logan', 12);

insert into Friend values (1510, 1381);
insert into Friend values (1510, 1689);
insert into Friend values (1689, 1709);
insert into Friend values (1381, 1247);
insert into Friend values (1709, 1247);
insert into Friend values (1689, 1782);
insert into Friend values (1782, 1468);
insert into Friend values (1782, 1316);
insert into Friend values (1782, 1304);
insert into Friend values (1468, 1101);
insert into Friend values (1468, 1641);
insert into Friend values (1101, 1641);
insert into Friend values (1247, 1911);
insert into Friend values (1247, 1501);
insert into Friend values (1911, 1501);
insert into Friend values (1501, 1934);
insert into Friend values (1316, 1934);
insert into Friend values (1934, 1304);
insert into Friend values (1304, 1661);
insert into Friend values (1661, 1025);
insert into Friend select ID2, ID1 from Friend;

insert into Likes values(1689, 1709);
insert into Likes values(1709, 1689);
insert into Likes values(1782, 1709);
insert into Likes values(1911, 1247);
insert into Likes values(1247, 1468);
insert into Likes values(1641, 1468);
insert into Likes values(1316, 1304);
insert into Likes values(1501, 1934);
insert into Likes values(1934, 1501);
insert into Likes values(1025, 1101);

/**
Find the names of all students
who are friends with someone named Gabriel.
**/

select distinct name
from Highschooler
where ID in
(select ID1 from Friend
 where ID2 in (
   select distinct ID
   from  Highschooler
   where name='Gabriel'
 ))

or ID in
(select ID2 from Friend
 where ID1 in (
   select distinct ID
   from  Highschooler
   where name='Gabriel'
 ));

 /**
 For every student who likes someone 2 or more grades younger than themselves,
 return that student's name and grade,
 and the name and grade of the student they like.
 **/

 select h1.name,h1.grade, h2.name, h2.grade
 from Highschooler h1, Highschooler h2
 where (h1.id, h2.id) in (select * from likes)
 and 2<= (h1.grade-h2.grade;

/** sqlite**/

select h1.name,h1.grade, h2.name, h2.grade
from Highschooler h1, Highschooler h2
where h1.id in (select id1 from likes where likes.id2=h2.id)
and 2<= (h1.grade-h2.grade);

/**
For every pair of students who both like each other,
return the name and grade of both students.
Include each pair only once,
with the two names in alphabetical order.
**/

select distinct h1.name,h1.grade, h2.name, h2.grade
from Highschooler h1, Highschooler h2
where (h1.id, h2.id) in (select * from likes)
and (h2.id, h1.id) in (select * from likes)
and h2.name>h1.name
order by h1.name;

/** sqlite**/

select distinct h1.name,h1.grade, h2.name, h2.grade
from Highschooler h1, Highschooler h2
where h1.id in (select id1 from likes where likes.id2=h2.id)
and h2.id in (select id1 from likes where likes.id2=h1.id)
and h2.name>h1.name
order by h1.name;

/**
Find all students who do not appear in the Likes table
(as a student who likes or is liked)
and return their names and grades. Sort by grade,
then by name within each grade.
**/

select name, grade
from Highschooler
where id not in
(
  select id1 as id from Likes
  union
  select id2 as id from Likes
)
order by grade,name;

/**
For every situation where student A likes student B,
but we have no information about whom B likes
(that is, B does not appear as an ID1 in the Likes table),
return A and B's names and grades
**/

select h1.name,h1.grade, h2.name, h2.grade
from Highschooler h1, Highschooler h2
where h1.id in (select id1 from likes where likes.id2=h2.id)
and h2.id not in
(select id1 from likes);

/**
Find names and grades of students
 who only have friends in the same grade.
 Return the result sorted by grade,
 then by name within each grade.
 **/

 select distinct  name, H1.grade
 from Highschooler H1
 where id in (
              select id1 from friend
              where id2
              in (
                  select id from Highschooler
                  where H1.grade=Highschooler.grade
                  )
                  and id2<>H1.id
                )
Except
select distinct  name, H1.grade
from Highschooler H1
where id in (
             select id1 from friend
             where id2
             in (
                 select id from Highschooler
                 where H1.grade<>Highschooler.grade
                 )
                 and id2<>H1.id
               )
order by grade, name;

/**
For each student A who likes a student B where the two are not friends,
find if they have a friend C in common (who can introduce them!).
For all such trios, return the name and grade of A, B, and C.
**/

select h1.name as Aname,h1.grade as Agrade,
       h2.name as Bname,h2.grade as Bgrade,
       h3.name as Cname, h3.grade as Cgrade
from Highschooler h1, Highschooler h2, Highschooler h3
where h1.id in (select id1 from likes where likes.id2=h2.id)
and h1.id not in (select id1 from Friend where Friend.id2=h2.id)
and h3.id in (select id1 from Friend where Friend.id2=h2.id)
and h3.id in (select id1 from Friend where Friend.id2=h1.id)

 /**
 Find the difference between the number of students in the school
 and the number of different first names.
 **/

select count(*)-count(distinct name)
from Highschooler;

/**
Find the name and grade of all students
who are liked by more than one other student.
**/

select name, grade
from Highschooler
where id in(
  select id2
  from likes
  group by id2
  having count(*)>1
            );
