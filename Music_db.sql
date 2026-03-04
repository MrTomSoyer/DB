CREATE TABLE IF NOT EXISTS genres(
	id INTEGER PRIMARY KEY,
	name VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS performers(
	id INTEGER PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS performers_genres (
	performer_id INTEGER NOT NULL REFERENCES performers(id),
	genre_id INTEGER NOT NULL REFERENCES genres(id),
	PRIMARY KEY (performer_id, genre_id)
);

CREATE TABLE IF NOT EXISTS albums(
	id INTEGER PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	year_of_release INTEGER CHECK (year_of_release > 0)
);

CREATE TABLE IF NOT EXISTS performers_albums(
	performer_id INTEGER NOT NULL REFERENCES performers(id),
	album_id INTEGER NOT NULL REFERENCES albums(id),
	PRIMARY KEY (performer_id, album_id) 
);

CREATE TABLE IF NOT EXISTS tracks(
	id INTEGER PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	duration INTEGER NOT NULL CHECK (duration > 0),
	album_id INTEGER NOT NULL REFERENCES albums(id)
);

CREATE TABLE IF NOT EXISTS collections(
	id INTEGER PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	year_of_release INTEGER CHECK (year_of_release > 0)
);

CREATE TABLE IF NOT EXISTS collections_tracks(
	collection_id INTEGER NOT NULL REFERENCES collections(id),
	track_id INTEGER NOT NULL REFERENCES tracks(id),
	PRIMARY KEY (collection_id, track_id)
);
