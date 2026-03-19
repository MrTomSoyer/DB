------------------- ЗАДАНИЕ 2 -------------------------

--Название и продолжительность самого длительного трека.
SELECT name, duration
FROM tracks t
WHERE duration = (
	SELECT MAX(duration )
	FROM tracks 
)
	
--Название треков, продолжительность которых не менее 3,5 минут (210 секунд).
SELECT name, duration
FROM tracks
WHERE duration >= 210

--Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT name
FROM collections
WHERE year_of_release BETWEEN 2018 AND 2020

--Исполнители, чьё имя состоит из одного слова.
SELECT name
FROM performers
WHERE TRIM(name) NOT LIKE '% %'

--Название треков, которые содержат слово «мой» или «my».
SELECT name
FROM tracks
--WHERE TRIM(name) ILIKE '%мой%' 
--	OR TRIM(name) ILIKE '%My%' 
WHERE name ~* '\m(my|мой)\M'
	
------------------- ЗАДАНИЕ 3 -------------------------

--Количество исполнителей в каждом жанре.
SELECT g.name genre_name, COUNT(*) performer_count
FROM performers_genres pg
JOIN genres g ON pg.genre_id = g.id
GROUP BY g.id, g.name
ORDER BY g.id ASC

--Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(*) count_tracks
FROM tracks t 
JOIN albums a ON t.album_id = a.id 
WHERE a.year_of_release BETWEEN 2019 AND 2020

--Средняя продолжительность треков по каждому альбому.
SELECT a.name name_album, AVG(t.duration ) avg_duration
FROM tracks t 
RIGHT JOIN albums a ON t.album_id = a.id 
GROUP BY a.name 

--Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT p.name
FROM performers p
WHERE p.id NOT IN (
    SELECT pa.performer_id
    FROM performers_albums pa
    JOIN albums a ON pa.album_id = a.id
    WHERE a.year_of_release = 2020
)

--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).
SELECT c.name
FROM performers p 
JOIN performers_albums pa ON p.id = pa.performer_id
JOIN albums a ON a.id = pa.album_id
JOIN tracks t ON t.album_id = a.id
JOIN collections_tracks ct ON ct.track_id = t.id
JOIN collections c ON c.id = ct.collection_id
WHERE p.name = 'The Beatles'
GROUP BY c.name
