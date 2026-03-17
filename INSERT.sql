INSERT INTO genres 
	VALUES 
		(1, 'Pop'), 
		(2, 'Rock'), 
		(3, 'Rap'),
		(4, 'R&B');

INSERT INTO performers 
	VALUES 
		(1, 'Mona'), 
		(2, 'Beyonce'), 
		(3, 'The Beatles'), 
		(4, 'Queen'), 
		(5, 'Баста'), 
		(6, '50 Cent');

INSERT INTO performers_genres 
	VALUES 
		(1, 1), 
		(2, 1), (2, 4), 
		(3, 2), (3, 1),
		(4, 2), 
		(5, 3), (5, 4),
		(6, 3), (6, 4);
		
INSERT INTO albums 
	VALUES 
		(1, 'Дневник памяти', 2024),
		(2, 'The Lion King: The Gift', 2019),
		(3, 'Abbey Road', 1969),
		(4, 'News of the World', 1977),
		(5, 'Баста 20', 2019),
		(6, 'The Final Album', 2012),
		(7, 'The Lion King: The Gift (Deluxe Edition)', 2020);
			
INSERT INTO performers_albums 
	VALUES
		(1, 1),
		(2, 2),	(2, 7),
		(3, 3),
		(4, 4),
		(5, 5),
		(6, 6);
		
INSERT INTO tracks
	VALUES 
		(1, 'Иордан', 126, 1),
		(2, 'My Power', 242, 2),
		(3, 'Come Together', 259, 3),
		(4, 'We Will Rock You', 122, 4),
		(5, 'Сансара', 238, 5),
		(6, 'Hold On', 225, 6),
		(7, 'Бонсай', 150, 1),
		(8, 'Bigger', 226, 7);
		
INSERT INTO collections 
	VALUES 
		(1, 'Сингл', 1),
		(2, 'Дневник памяти', 2024),
		(3, 'The Lion King: The Gift', 2019),
		(4, 'Abbey Road', 1969),
		(5, '1', 2000),
		(6, 'News of the World', 1977),
		(7, 'Greatest Hits', 1981),
		(8, 'Баста 20', 2019),
		(9, 'The Final Album', 2012);
		
INSERT INTO collections_tracks
	VALUES
		(2, 1), (2, 7)
		(3, 2), (3, 8)
		(4, 3),
		(5, 3),
		(6, 4),
		(7, 4),
		(8, 5),
		(9, 6);
