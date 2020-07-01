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

/**Find the titles of all movies directed by Steven Spielberg. **/

select title
from  Movie
where director='Steven Spielberg';
/**Find all years that have a movie that received a rating of 4 or 5,
and sort them in increasing order. **/

select distinct year
from Movie
where mid in(
              select distinct mid
              from Rating
              where stars=4 or stars=5
            )
order by year;

/** Find the titles of all movies that have no ratings. **/

select title
from movie
where mid not in
    (select distinct mid
     from Rating);

/**Some reviewers didn't provide a date with their rating.
Find the names of all reviewers
who have ratings with a NULL value for the date. **/

select name
from reviewer
where rid in (
              select distinct rid
              from rating
              where ratingdate is null);

/**Write a query to return the ratings data in a more readable format:
reviewer name, movie title, stars, and ratingDate.
Also, sort the data, first by reviewer name,
then by movie title,
and lastly by number of stars. **/

select name, title, stars, ratingDate
from Movie, Reviewer, Rating
where Movie.mid=Rating.mid and Reviewer.rid=Rating.rid
order by name, title,stars;

/**
For all cases where the same reviewer rated the same movie twice
and gave it a higher rating the second time,
return the reviewer's name and the title of the movie.
**/

with two_review as
 (
select *
from rating where (rid,mid) in
  (
      select distinct rid, mid
      from rating
      group by (rid, mid)
      having count(*)=2
  )
)



select name, title
from Reviewer, Movie
where (Reviewer.rid,Movie.mid) in
  ( select rid, mid
    from two_review t1
    where ratingDate>= all(select ratingDate from two_review t2
                            where t1.rid=t2.rid and t1.mid=t2.mid)
      and stars >= all(select stars from two_review t2
                            where t1.rid=t2.rid and t1.mid=t2.mid)
  );

/*********************/
  select name, title
  from Movie M, Reviewer R
  where (R.rid,M.mid) in
      (
        select distinct t1.rid, t2.mid
        from two_review t1, two_review t2
        where t1.rid=t2.rid and t1.mid=t2.mid
          and  t1.stars>t2.stars and t1.ratingDate>t2.ratingDate
        );
/*********************/
select name, title
from  Reviewer, Movie
where (Reviewer.rid, Movie.mid) in
(
  select distinct rid, mid
  from Rating
  group by rid, mid
  having count(*)=2
)
and Reviewer.rid in
( select rid from Rating where (ratingDate>=(select max(ratingDate) from Rating R2
                                                where Rating.rid=R2.rid )
                                and stars >= (select max(stars) from Rating R2
                                                where Rating.rid=R2.rid ))
);


/*********************/



select name, title
from  Reviewer, Movie, Rating
where (Rating.rid, Rating.mid) in
(
  select distinct rid, mid
  from Rating
  group by (rid, mid)
  having count(*)=2
)
and Movie.mid=Rating.mid
and Reviewer.rid=Rating.rid
and ratingDate>= all(select ratingDate from Rating r2
                              where Rating.rid=r2.rid and Rating.mid=r2.mid)
and stars >= all(select stars from Rating r2
                              where Rating.rid=r2.rid and Rating.mid=r2.mid);

/*********************/
select reviewer.name, movie.title
from reviewer, movie
where (reviewer.rid , movie.mid) in
(select rating.rid, rating.mid
  from
   (
  select distinct rid, mid
  from Rating
  group by (rid, mid)
  having count(*)=2
) temp,
 rating
where rating.mid=temp.mid
      and
      rating.rid=temp.rid
      and
      rating.stars>= all(select stars from Rating r2
                                    where rating.rid=r2.rid and rating.mid=r2.mid)
      and
      rating.ratingDate>=all(select ratingDate from Rating r2
                                    where Rating.rid=r2.rid and Rating.mid=r2.mid)
            );




/**
For each movie that has at least one rating,
find the highest number of stars that movie received.
Return the movie title and number of stars.
Sort by movie title.
**/
select distinct title, stars
from Movie, Rating
where Movie.mid=Rating.mid
  and stars>=all(select stars from Rating R2
                   where Rating.mid=R2.mid)
order by title;

/**********/

select distinct title, stars
from Movie, Rating
where Movie.mid=Rating.mid
  and stars>=(select max(stars) from Rating R2
                   where Rating.mid=R2.mid)
order by title;


/**
For each movie, return the title and the 'rating spread',
that is, the difference between highest and lowest ratings given to that movie.
Sort by rating spread from highest to lowest,
then by movie title.
**/

select title, abs(max(stars)-min(stars)) as rating_spread
from Rating,Movie
where Movie.mid=Rating.mid
group by title
order by rating_spread desc, title ;

/**
Find the difference between the average rating of movies released before 1980
and the average rating of movies released after 1980.
(Make sure to calculate the average rating for each movie,
then the average of those averages for movies before 1980 and movies after.
Don't just calculate the overall average rating before and after 1980.)
**/

select avg(before.stars)-avg(after.stars) as avg
from
 (select mid,avg(stars) as stars
  from Rating
  where mid in (select mid from Movie
              where year<1980)
  group by mid) before,

 (select mid,avg(stars) as stars
  from Rating
  where mid in (select mid from Movie
              where year>1980)
  group by mid) after;
