/* Delete the tables if they already exist */
drop table if exists Movie;
drop table if exists Reviewer;
drop table if exists Rating;

/* Create the schema for our tables */
create table Movie(mID int, title text, year int, director text);
create table Reviewer(rID int, name text);
create table Rating(rID int, mID int, stars int, ratingDate date);

/* Populate the tables with our data */
insert into Movie values(101, 'Gone with the Wind', 1939, 'Victor Fleming');
insert into Movie values(102, 'Star Wars', 1977, 'George Lucas');
insert into Movie values(103, 'The Sound of Music', 1965, 'Robert Wise');
insert into Movie values(104, 'E.T.', 1982, 'Steven Spielberg');
insert into Movie values(105, 'Titanic', 1997, 'James Cameron');
insert into Movie values(106, 'Snow White', 1937, null);
insert into Movie values(107, 'Avatar', 2009, 'James Cameron');
insert into Movie values(108, 'Raiders of the Lost Ark', 1981, 'Steven Spielberg');

insert into Reviewer values(201, 'Sarah Martinez');
insert into Reviewer values(202, 'Daniel Lewis');
insert into Reviewer values(203, 'Brittany Harris');
insert into Reviewer values(204, 'Mike Anderson');
insert into Reviewer values(205, 'Chris Jackson');
insert into Reviewer values(206, 'Elizabeth Thomas');
insert into Reviewer values(207, 'James Cameron');
insert into Reviewer values(208, 'Ashley White');

insert into Rating values(201, 101, 2, '2011-01-22');
insert into Rating values(201, 101, 4, '2011-01-27');
insert into Rating values(202, 106, 4, null);
insert into Rating values(203, 103, 2, '2011-01-20');
insert into Rating values(203, 108, 4, '2011-01-12');
insert into Rating values(203, 108, 2, '2011-01-30');
insert into Rating values(204, 101, 3, '2011-01-09');
insert into Rating values(205, 103, 3, '2011-01-27');
insert into Rating values(205, 104, 2, '2011-01-22');
insert into Rating values(205, 108, 4, null);
insert into Rating values(206, 107, 3, '2011-01-15');
insert into Rating values(206, 106, 5, '2011-01-19');
insert into Rating values(207, 107, 5, '2011-01-20');
insert into Rating values(208, 104, 3, '2011-01-02');

/**
Find the names of all reviewers who rated Gone with the Wind.
**/

select distinct name
from Reviewer, Rating
where Reviewer.rid=Rating.rid
      and Rating.mid in
      (select mid from Movie where title='Gone with the Wind');

/**
For any rating where the reviewer is the same as the director of the movie,
return the reviewer name, movie title, and number of stars.
**/

select distinct name, title, stars
from Reviewer, Movie, Rating
where Reviewer.rid=Rating.rid and  Movie.mid=Rating.mid
  and Reviewer.name=Movie.director;

/**
Return all reviewer names and movie names together in a single list, alphabetized.
(Sorting by the first name of the reviewer and first word in the title is fine;
no need for special processing on last names or removing "The".)
**/

select distinct name
from Reviewer

Union

select distinct title
from Movie

order by name;

/**Find the titles of all movies not reviewed by Chris Jackson. **/

select distinct title
from Movie
where title not in
(
select distinct title
from Movie
where mid in
  (
  select mid from Rating
  where rid in
    (select rid from Reviewer
      where name='Chris Jackson'
    )
  )
);

/**********************/

select distinct title
from movie
where mid not in
          (
            select mid
            from rating
            where rid in (
                          select distinct rid
                          from reviewer
                          where name='Chris Jackson'
            )
          );

/**
For all pairs of reviewers such that both reviewers gave a rating to the same movie,
return the names of both reviewers.
 Eliminate duplicates,
 don't pair reviewers with themselves,
 and include each pair only once.
For each pair, return the names in the pair in alphabetical order.
**/


select re1.name,re2.name
from Reviewer re1, Reviewer re2
where re1.name<re2.name
and (re1.rid,re2.rid) in
  (
  select distinct R1.rid, R2.rid
  from Rating R1, Rating R2
  where R1.rid<>R2.rid
    and R1.mid=R2.mid
  )
  order by re1.name;

/**********************/

select distinct re1.name,re2.name
from Reviewer re1, Reviewer re2, Rating ra1, Rating ra2
where re1.name<re2.name and re1.rid=ra1.rid and re2.rid=ra2.rid
    and ra1.mid=ra2.mid
order by re1.name;

/**
For each rating that is the lowest (fewest stars) currently in the database,
return the reviewer name, movie title, and number of stars.
**/


select  distinct name, title, stars
from Reviewer, Movie, Rating
where stars<= all(select stars from Rating)
and Movie.mid=Rating.mid and Reviewer.rid=Rating.rid;

/**
List movie titles and average ratings,
from highest-rated to lowest-rated.
If two or more movies have the same average rating,
list them in alphabetical order. **/

select title,avg(stars) as stars
from Movie, Rating
where Movie.mid=Rating.mid
group by title
order by stars desc,title;

/**
Find the names of all reviewers who have contributed three or more ratings.
**/

select name
from Reviewer
where rid in
  (select rid
          from Rating
        group by rid
          having count(rid)>=3);

/**
(As an extra challenge, try writing the query without HAVING or without COUNT.)
**/

select name
from Reviewer
where 3 <=
  (select count(*)
          from Rating
          where Reviewer.rid=Rating.rid)

/**
Some directors directed more than one movie.
For all such directors,
return the titles of all movies directed by them,
along with the director name.
Sort by director name, then movie title.
**/

select distinct  title,director
from Movie
where director in
  (
    select director
    from Movie
    group by director
    having count(*)>1
  )
  order by director;

 /**(As an extra challenge, try writing the query both with and without COUNT.) **/

 select distinct m1.title,m1.director
 from Movie m1, Movie m2
 where m1.director=m2.director
 and m1.title<>m2.title
 order by m1.director;

/**
Find the movie(s) with the highest average rating.
Return the movie title(s) and average rating.
(Hint: This query is more difficult to write in SQLite than other systems;
you might think of it as finding the highest average rating
and then choosing the movie(s) with that average rating.)
**/

select title, avg(stars)
from Movie, Rating
where Movie.mid= Rating.mid
group by title
having avg(stars) in (
  select avg(stars) as avg
  from Rating
  group by mid
  order by avg desc
  limit 1
);


/********************/

select title,avg
from
  (select mid,avg(stars) as avg
from Rating
group by mid) avg_rate,
  Movie
where Movie.mid=avg_rate.mid
and avg>= all ( select avg(stars) as avg
                from Rating group by mid
                ) ;


/**SQLite**/

select title,avg
from
  (select mid,avg(stars) as avg
from Rating
group by mid) avg_rate,
  Movie
where Movie.mid=avg_rate.mid
and avg=  (  select avg(stars) as avg
                from Rating group by mid
                 order by avg desc
                limit 1
                ) ;


/**
Find the movie(s) with the lowest average rating.
Return the movie title(s) and average rating.
(Hint: This query may be more difficult to write in SQLite than other systems;
you might think of it as finding the lowest average rating
and then choosing the movie(s) with that average rating.)
**/

select title, avg(stars)
from Movie, Rating
where Movie.mid= Rating.mid
group by title
having avg(stars) in (
  select avg(stars) as avg
  from Rating
  group by mid
  order by avg
  limit 1
);

select title,avg
from
  (select mid,avg(stars) as avg
from Rating
group by mid) avg_rate,
  Movie
where Movie.mid=avg_rate.mid
and avg=  (  select avg(stars) as avg
                from Rating group by mid
                 order by avg
                limit 1
                ) ;


/**
For each director,
return the director's name together with the title(s) of the movie(s) they directed
that received the highest rating among all of their movies,
and the value of that rating.
Ignore movies whose director is NULL.
**/

select distinct  temp.director,title, temp.max
from Movie, Rating,
        (
        select director, max(stars) as max
        from Movie, Rating
        where Movie.mid=Rating.mid and director is not null
        group by director
      ) temp
where Movie.mid=Rating.mid and Movie.director=temp.director
      and Rating.stars=temp.max


/********************/

with temp as
(Select director, title, rate
from Movie,
  (select mid,max(stars) as rate
    from Rating
    group by mid
  ) max_rat
where   Movie.mid=max_rat.mid
and director is not null
)

select director, title, rate
from temp t1
where rate>= (select max(rate) from temp where temp.director=t1.director)
order by director;
