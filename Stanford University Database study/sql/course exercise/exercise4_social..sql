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
For every situation where student A likes student B,
 but student B likes a different student C,
 return the names and grades of A, B, and C.
 **/

 select distinct  h1.name,h1.grade,h2.name,h2.grade, h3.name, h3.grade
 from Highschooler h1, Highschooler h2, Highschooler h3
 where h1.id in (select id1 from likes where id2=h2.id)
        and h2.id in (select id1 from likes where id2=h3.id and id2<>h1.id);

/**
Find those students for whom all of their friends are in different grades from themselves.
Return the students' names and grades.
**/

select distinct h1.name, h1.grade
from  Highschooler H1
where id in (select id1 from Friend)
      and
      id not in ( select id1 from Friend where
                    id2 in (select id from  Highschooler
                            where Highschooler.grade=H1.grade
                            )
                  );

 /**
 What is the average number of friends per student?
 (Your result should be just one number.)
 **/


 select sum(friend_each.count)*1.0/ total_student.idno
 from(
  select count(distinct id2) as count
  from friend
  group by id1
 ) friend_each,
   (
     select count(distinct Highschooler.id) as idno
     from Highschooler
   ) total_student
 group by total_student.idno;


/**
Find the number of students who are either friends with Cassandra
or are friends of friends of Cassandra.
Do not count Cassandra, even though technically she is a friend of a friend.
**/

select  count (distinct f1.id1)
from friend f1, friend f2
where  f1.id1 <>f2.id1
    and f1.id2=f2.id2
    and (f1.id2 in (select id from Highschooler
                    where Highschooler.name='Cassandra')
          or
          f2.id1 in (select id from Highschooler
                          where Highschooler.name='Cassandra')
          );


/**
Find the name and grade of the student(s) with the greatest number of friends.
**/

select distinct name, grade
from Highschooler
where Highschooler.id in
(
select id1
from Friend
group by id1
having count(*)>= (select max(count) from
                  (select count(*) as count
                    from Friend
                    group by id1) temp
                  )
)
