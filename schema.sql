CREATE DATABASE catalog;
USE catalog;


CREATE TABLE author(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL
);

CREATE TABLE label(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  title VARCHAR(255) NOT NULL,
  color VARCHAR(255) NOT NULL
);

CREATE TABLE genre(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255) NOT NULL,
);

CREATE TABLE book(
  ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  publish_date DATE NOT NULL,
  archived BOOLEAN NOT NULL,
  publisher VARCHAR(255) NOT NULL,
  cover_state VARCHAR(255) NOT NULL,
  label_id INT,
  author_id INT,
  genre_id INT,
  FOREIGN KEY (label_id) REFERENCES label(ID),
  FOREIGN KEY (author_id) REFERENCES author(ID),
  FOREIGN KEY(genre_id) REFERENCES genre(ID)
);

CREATE TABLE musicAlbum(
  ID INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  publish_date DATE NOT NULL,
  on_spotify BOOLEAN NOT NULL,
  archived BOOLEAN NOT NULL,
  FOREIGN KEY (label_id) REFERENCES label(ID),
  FOREIGN KEY (author_id) REFERENCES author(ID),
  FOREIGN KEY(genre_id) REFERENCES genre(ID)
);

CREATE TABLE game(
  INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  multiplayer VARCHAR(30) NOT NULL,
  last_played_at DATE NOT NULL,
  publish_date DATE NOT NULL,
  archived BOOLEAN NOT NULL,
  label_id INT,
  author_id INT,
  genre_id INT,
  FOREIGN KEY (label_id) REFERENCES label(ID),
  FOREIGN KEY (author_id) REFERENCES author(ID),
  FOREIGN KEY(genre_id) REFERENCES genre(ID)
);

CREATE TABLE item(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  publish_date DATE, 
  archived BOOLEAN,
  label_id INT, 
  author_id INT,
  genre_id INT NOT NULL,
  FOREIGN KEY (genre_id) REFERENCES genre(id),
  FOREIGN KEY (author_id) REFERENCES author(id),
  FOREIGN KEY (label_id) REFERENCES label(id)
);

