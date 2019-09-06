/*
In order to analyze the inputs from our survey, we need to create a database to load it to our data exploration tool R.
In order to create our MYSQL database, we will create a schema, table and load the data to the created database.
*/

DROP TABLE IF EXISTS movie_ratings;

CREATE TABLE movie_ratings
(
  name varchar(100) NOT NULL,
  movie_name varchar(100) NOT NULL,
  type varchar(10) NOT NULL,
  gender varchar(10) NOT NULL,
  age int,
  rating int NULL
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/movie_ratings.csv' 
INTO TABLE movie_ratings
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(name, movie_name, type, gender, age, @rating)

SET rating = nullif(@rating, -1);

/*
We created our table and loaded the collected survey into our database. 
The individuals that did not watch the movie, did not provide any ratings feedback. 
These were noted as "-1" in the data, during the load of the data into our MySQL database, we change these values to NULL.
*/

/* We can filter through the data set to see some basic information */

SELECT * FROM movie_ratings ORDER BY rating DESC;

SELECT * FROM movie_ratings WHERE name='Tara';

SELECT * FROM movie_ratings WHERE rating > 3;

/* The information around the genre, length and other features of these movies are publicly available.
We can google and get this information and create a separate table and load the data set into it.*/

DROP TABLE IF EXISTS movie_data;

CREATE TABLE movie_data
(
  movie_name varchar(100) NOT NULL,
  year int NOT NULL,
  genre varchar(100) NOT NULL,
  cost int NOT NULL
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/movie_data_set.csv' 
INTO TABLE movie_data
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
(movie_name, year, genre, cost);

SELECT * FROM movie_data

CREATE TABLE movie_table AS
SELECT name, type, gender, age, rating, genre, year, cost FROM movie_ratings JOIN movie_data ON movie_ratings.movie_name=movie_data.movie_name;

SELECT * FROM movie_table;
