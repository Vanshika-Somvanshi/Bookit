-- BookIt Movie Ticket Booking - Database Initialization Script
-- Safe to re-run: uses IF NOT EXISTS / INSERT IGNORE

CREATE TABLE IF NOT EXISTS theatre (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100),
  location VARCHAR(30),
  location_details VARCHAR(250),
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS features (
  id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(100),
  description VARCHAR(1000),
  icon VARCHAR(2000),
  image_path VARCHAR(100),
  theatre_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (theatre_id) REFERENCES theatre(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS movie (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50),
  image_path VARCHAR(150),
  language VARCHAR(15),
  genre_1 VARCHAR(15),
  genre_2 VARCHAR(15),
  synopsis VARCHAR(500),
  rating DECIMAL(2,1),
  duration VARCHAR(10),
  top_cast VARCHAR(30),
  release_date DATE,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS hall (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(10),
  total_seats INT,
  theatre_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (theatre_id) REFERENCES theatre(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS showtimes (
  id INT NOT NULL AUTO_INCREMENT,
  movie_start_time VARCHAR(20),
  show_type CHAR(2),
  showtime_date DATE,
  price_per_seat INT,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS seat (
  id INT NOT NULL AUTO_INCREMENT,
  name CHAR(2),
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS person (
  email VARCHAR(100) NOT NULL,
  first_name VARCHAR(20),
  last_name VARCHAR(20),
  password VARCHAR(100),
  phone_number CHAR(11),
  account_balance INT,
  person_type VARCHAR(8),
  PRIMARY KEY (email)
);

CREATE TABLE IF NOT EXISTS payment (
  id INT NOT NULL AUTO_INCREMENT,
  payment_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  amount INT,
  method VARCHAR(30),
  customer_email VARCHAR(100) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (customer_email) REFERENCES person(email)
);

CREATE TABLE IF NOT EXISTS ticket (
  id INT NOT NULL AUTO_INCREMENT,
  price INT,
  purchase_date DATE,
  payment_id INT NOT NULL,
  seat_id INT NOT NULL,
  hall_id INT NOT NULL,
  movie_id INT NOT NULL,
  showtimes_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (showtimes_id) REFERENCES showtimes(id),
  FOREIGN KEY (payment_id) REFERENCES payment(id),
  FOREIGN KEY (seat_id) REFERENCES seat(id),
  FOREIGN KEY (hall_id) REFERENCES hall(id),
  FOREIGN KEY (movie_id) REFERENCES movie(id)
);

CREATE TABLE IF NOT EXISTS hallwise_seat (
  hall_id INT NOT NULL,
  seat_id INT NOT NULL,
  PRIMARY KEY (hall_id, seat_id),
  FOREIGN KEY (hall_id) REFERENCES hall(id) ON DELETE CASCADE,
  FOREIGN KEY (seat_id) REFERENCES seat(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS movie_directors (
  movie_id INT NOT NULL,
  director VARCHAR(30),
  PRIMARY KEY (movie_id, director),
  FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS movie_genre (
  movie_id INT NOT NULL,
  genre VARCHAR(30),
  PRIMARY KEY (movie_id, genre),
  FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS shown_in (
  movie_id INT NOT NULL,
  showtime_id INT NOT NULL,
  hall_id INT NOT NULL,
  PRIMARY KEY (movie_id, showtime_id, hall_id),
  FOREIGN KEY (movie_id) REFERENCES movie(id) ON DELETE CASCADE,
  FOREIGN KEY (showtime_id) REFERENCES showtimes(id) ON DELETE CASCADE,
  FOREIGN KEY (hall_id) REFERENCES hall(id) ON DELETE CASCADE
);

-- Seed data (INSERT IGNORE skips if already present)

INSERT IGNORE INTO theatre (id, name, location, location_details) VALUES
(1, 'Bashundhara Shopping Mall', 'Panthapath', 'Show Motion Limited Level 8, Bashundhara City 13/3 Ka, Panthapath, Tejgaon, Dhaka-1205'),
(2, 'Shimanto Shambhar', 'Dhanmondi', 'Shimanto Shamvar Road no 2, Dhanmondi, Dhaka-1205'),
(3, 'SKS Tower', 'Mohakhali', 'SKS Tower, Mohakhali, Dhaka-1205'),
(4, 'Bangabandhu Military Museum', 'Bijoy Shoroni', 'Bangabandhu Military Museum, Bijoy Shoroni, Dhaka-1216');

INSERT IGNORE INTO features (id, title, description, icon, image_path, theatre_id) VALUES
(1, 'Unparalleled Cinematic Experience', 'Immerse yourself in stunning visuals and crystal-clear sound, as our state-of-the-art IMAX technology transports you directly into the heart of the action.', NULL, '/Images/features/imax.jpg', 1),
(2, 'Delight in Dolby Atmos', 'Experience sound like never before with Dolby Atmos, the epitome of audio technology that takes you on an immersive sonic journey.', NULL, '/Images/features/sound.jpg', 1),
(3, 'Tantalizing Treats', 'At our movie theatre, we take your movie-watching experience beyond the screen by offering a delectable array of food items at our concession stand.', NULL, '/Images/features/food.jpg', 1),
(4, 'Luxurious Escape', 'Step into a world of opulence and relaxation, designed to cater to your every need before and after the main event.', NULL, '/Images/features/lounge.jpg', 1);

INSERT IGNORE INTO movie (id, name, image_path, language, synopsis, rating, duration, top_cast, release_date) VALUES
(1, 'Spider-Man: Across the Spider-Verse', '/Images/movies/spiderman.jpg', 'English', 'Miles Morales catapults across the Multiverse, where he encounters a team of Spider-People charged with protecting its very existence.', 8.8, '2h 16m', 'Oscar Isaac', '2023-06-23'),
(2, 'Extraction 2', '/Images/movies/extraction2.jpg', 'English', 'After barely surviving his grievous wounds from his mission in Dhaka, Bangladesh, Tyler Rake is back, and his team is ready to take on their next mission.', 7.0, '2h 3m', 'Chris Hemsworth', '2023-06-13'),
(3, 'Murder Mystery 2', '/Images/movies/murderMystery.jpg', 'English', 'Full-time detectives Nick and Audrey are struggling to get their private eye agency off the ground.', 5.7, '1h 30m', 'Jennifer Aniston', '2023-03-31'),
(4, 'Mission: Impossible - Dead Reckoning Part One', '/Images/movies/missionImpossible.jpg', 'English', 'Ethan Hunt and the IMF team must track down a terrifying new weapon that threatens all of humanity if it falls into the wrong hands.', 8.0, '2h 43m', 'Tom Cruise', '2023-07-10'),
(5, 'Oppenheimer', '/Images/movies/oppenheimer.jpg', 'English', 'During World War II, Lt. Gen. Leslie Groves Jr. appoints physicist J. Robert Oppenheimer to work on the top-secret Manhattan Project.', 9.4, '3h', 'Cillian Murphy', '2023-07-21'),
(6, 'Barbie', '/Images/movies/barbie.jpg', 'English', 'Barbie and Ken are having the time of their lives in the colorful and seemingly perfect world of Barbie Land.', 7.6, '1h 54m', 'Margot Robbie', '2023-07-21'),
(7, 'Meg 2: The Trench', '/Images/movies/meg2.jpg', 'English', 'Jonas Taylor leads a research team on an exploratory dive into the deepest depths of the ocean.', 5.5, '1h 56m', 'Jason Statham', '2023-08-04');

INSERT IGNORE INTO movie_directors (movie_id, director) VALUES
(1, 'Joaquim Dos Santos'), (1, 'Justin K. Thompson'), (1, 'Kemp Powers'),
(2, 'Sam Hargrave'),
(3, 'Jeremy Garelick'),
(4, 'Christopher McQuarrie'),
(5, 'Christopher Nolan'),
(6, 'Greta Gerwig'),
(7, 'Ben Wheatley');

INSERT IGNORE INTO movie_genre (movie_id, genre) VALUES
(1, 'Animation'), (1, 'Action'), (1, 'Adventure'),
(2, 'Action'), (2, 'Thriller'),
(3, 'Mystery'), (3, 'Comedy'),
(4, 'Action'), (4, 'Adventure'), (4, 'Thriller'),
(5, 'History'), (5, 'Drama'), (5, 'Biography'),
(6, 'Adventure'), (6, 'Comedy'), (6, 'Fantasy'),
(7, 'Action'), (7, 'Adventure'), (7, 'Horror');

INSERT IGNORE INTO hall (id, name, total_seats, theatre_id) VALUES
(1, 'Hall 1', 48, 1), (2, 'Hall 2', 48, 1), (3, 'Hall 3', 48, 1), (4, 'Hall 4', 48, 1),
(5, 'Hall 1', 48, 2), (6, 'Hall 2', 48, 2), (7, 'Hall 3', 48, 2), (8, 'Hall 4', 48, 2);

INSERT IGNORE INTO seat (id, name) VALUES
(1,'A1'),(2,'A2'),(3,'A3'),(4,'A4'),(5,'A5'),(6,'A6'),(7,'A7'),(8,'A8'),
(9,'B1'),(10,'B2'),(11,'B3'),(12,'B4'),(13,'B5'),(14,'B6'),(15,'B7'),(16,'B8'),
(17,'C1'),(18,'C2'),(19,'C3'),(20,'C4'),(21,'C5'),(22,'C6'),(23,'C7'),(24,'C8'),
(25,'D1'),(26,'D2'),(27,'D3'),(28,'D4'),(29,'D5'),(30,'D6'),(31,'D7'),(32,'D8'),
(33,'E1'),(34,'E2'),(35,'E3'),(36,'E4'),(37,'E5'),(38,'E6'),(39,'E7'),(40,'E8'),
(41,'F1'),(42,'F2'),(43,'F3'),(44,'F4'),(45,'F5'),(46,'F6'),(47,'F7'),(48,'F8');

INSERT IGNORE INTO showtimes (id, movie_start_time, show_type, showtime_date, price_per_seat) VALUES
(1,'11:00 am','2D','2023-08-19',350),(2,'2:30 pm','3D','2023-08-19',450),(3,'6:00 pm','3D','2023-08-19',450),
(4,'11:00 am','2D','2023-08-20',350),(5,'2:30 pm','3D','2023-08-20',450),(6,'6:00 pm','3D','2023-08-20',450),
(7,'11:00 am','2D','2023-08-21',350),(8,'2:30 pm','3D','2023-08-21',450),(9,'6:00 pm','3D','2023-08-21',450),
(10,'11:00 am','2D','2023-08-22',350),(11,'2:30 pm','3D','2023-08-22',450),(12,'6:00 pm','3D','2023-08-22',450);

INSERT IGNORE INTO shown_in (movie_id, showtime_id, hall_id) VALUES
(1,1,1),(5,1,2),(3,1,3),(4,1,4),(1,1,5),(5,1,6),(3,1,7),(4,1,8),
(5,2,1),(6,2,2),(1,2,3),(2,2,4),(5,2,5),(6,2,6),(1,2,7),(2,2,8),
(5,3,1),(6,3,2),(1,3,3),(2,3,4),(4,3,5),(6,3,6),(1,3,7),(2,3,8),
(1,4,1),(5,4,2),(3,4,3),(4,4,4),(1,4,5),(5,4,6),(3,4,7),(4,4,8),
(5,5,1),(6,5,2),(1,5,3),(2,5,4),(5,5,5),(6,5,6),(1,5,7),(2,5,8),
(5,6,1),(6,6,2),(1,6,3),(2,6,4),(4,6,5),(6,6,6),(1,6,7),(2,6,8),
(1,7,1),(5,7,2),(3,7,3),(4,7,4),(1,7,5),(5,7,6),(3,7,7),(4,7,8),
(5,8,1),(6,8,2),(1,8,3),(2,8,4),(5,8,5),(6,8,6),(1,8,7),(2,8,8),
(5,9,1),(6,9,2),(1,9,3),(2,9,4),(4,9,5),(6,9,6),(1,9,7),(2,9,8),
(1,10,1),(2,10,2),(3,10,3),(4,10,4),(1,10,5),(2,10,6),(3,10,7),(4,10,8),
(5,11,1),(6,11,2),(1,11,3),(2,11,4),(5,11,5),(6,11,6),(1,11,7),(2,11,8),
(5,12,1),(6,12,2),(1,12,3),(2,12,4),(4,12,5),(6,12,6),(1,12,7),(2,12,8);

INSERT IGNORE INTO hallwise_seat (hall_id, seat_id) VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,21),(1,22),(1,23),(1,24),(1,25),(1,26),(1,27),(1,28),(1,29),(1,30),(1,31),(1,32),(1,33),(1,34),(1,35),(1,36),(1,37),(1,38),(1,39),(1,40),(1,41),(1,42),(1,43),(1,44),(1,45),(1,46),(1,47),(1,48),
(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(2,9),(2,10),(2,11),(2,12),(2,13),(2,14),(2,15),(2,16),(2,17),(2,18),(2,19),(2,20),(2,21),(2,22),(2,23),(2,24),(2,25),(2,26),(2,27),(2,28),(2,29),(2,30),(2,31),(2,32),(2,33),(2,34),(2,35),(2,36),(2,37),(2,38),(2,39),(2,40),(2,41),(2,42),(2,43),(2,44),(2,45),(2,46),(2,47),(2,48),
(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),(3,10),(3,11),(3,12),(3,13),(3,14),(3,15),(3,16),(3,17),(3,18),(3,19),(3,20),(3,21),(3,22),(3,23),(3,24),(3,25),(3,26),(3,27),(3,28),(3,29),(3,30),(3,31),(3,32),(3,33),(3,34),(3,35),(3,36),(3,37),(3,38),(3,39),(3,40),(3,41),(3,42),(3,43),(3,44),(3,45),(3,46),(3,47),(3,48),
(4,1),(4,2),(4,3),(4,4),(4,5),(4,6),(4,7),(4,8),(4,9),(4,10),(4,11),(4,12),(4,13),(4,14),(4,15),(4,16),(4,17),(4,18),(4,19),(4,20),(4,21),(4,22),(4,23),(4,24),(4,25),(4,26),(4,27),(4,28),(4,29),(4,30),(4,31),(4,32),(4,33),(4,34),(4,35),(4,36),(4,37),(4,38),(4,39),(4,40),(4,41),(4,42),(4,43),(4,44),(4,45),(4,46),(4,47),(4,48),
(5,1),(5,2),(5,3),(5,4),(5,5),(5,6),(5,7),(5,8),(5,9),(5,10),(5,11),(5,12),(5,13),(5,14),(5,15),(5,16),(5,17),(5,18),(5,19),(5,20),(5,21),(5,22),(5,23),(5,24),(5,25),(5,26),(5,27),(5,28),(5,29),(5,30),(5,31),(5,32),(5,33),(5,34),(5,35),(5,36),(5,37),(5,38),(5,39),(5,40),(5,41),(5,42),(5,43),(5,44),(5,45),(5,46),(5,47),(5,48),
(6,1),(6,2),(6,3),(6,4),(6,5),(6,6),(6,7),(6,8),(6,9),(6,10),(6,11),(6,12),(6,13),(6,14),(6,15),(6,16),(6,17),(6,18),(6,19),(6,20),(6,21),(6,22),(6,23),(6,24),(6,25),(6,26),(6,27),(6,28),(6,29),(6,30),(6,31),(6,32),(6,33),(6,34),(6,35),(6,36),(6,37),(6,38),(6,39),(6,40),(6,41),(6,42),(6,43),(6,44),(6,45),(6,46),(6,47),(6,48),
(7,1),(7,2),(7,3),(7,4),(7,5),(7,6),(7,7),(7,8),(7,9),(7,10),(7,11),(7,12),(7,13),(7,14),(7,15),(7,16),(7,17),(7,18),(7,19),(7,20),(7,21),(7,22),(7,23),(7,24),(7,25),(7,26),(7,27),(7,28),(7,29),(7,30),(7,31),(7,32),(7,33),(7,34),(7,35),(7,36),(7,37),(7,38),(7,39),(7,40),(7,41),(7,42),(7,43),(7,44),(7,45),(7,46),(7,47),(7,48),
(8,1),(8,2),(8,3),(8,4),(8,5),(8,6),(8,7),(8,8),(8,9),(8,10),(8,11),(8,12),(8,13),(8,14),(8,15),(8,16),(8,17),(8,18),(8,19),(8,20),(8,21),(8,22),(8,23),(8,24),(8,25),(8,26),(8,27),(8,28),(8,29),(8,30),(8,31),(8,32),(8,33),(8,34),(8,35),(8,36),(8,37),(8,38),(8,39),(8,40),(8,41),(8,42),(8,43),(8,44),(8,45),(8,46),(8,47),(8,48);
