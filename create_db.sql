CREATE TABLE regions (
  regionid  INTEGER PRIMARY KEY AUTOINCREMENT,
  region    VARCHAR
);

CREATE TABLE cities (
  cityid    INTEGER PRIMARY KEY AUTOINCREMENT,
  city      VARCHAR,
  regionid  INTEGER,
  FOREIGN KEY(regionid) REFERENCES regions(regionid)
);

CREATE TABLE persons (
  personid    INTEGER PRIMARY KEY AUTOINCREMENT,
  firstname   VARCHAR,
  lastname    VARCHAR,
  middlename  VARCHAR,
  regionid    INTEGER,
  cityid      INTEGER,
  phone       VARCHAR,
  email       VARCHAR,
  comment     TEXT,
  FOREIGN KEY(regionid) REFERENCES regions(regionid),
  FOREIGN KEY(cityid)   REFERENCES cities(cityid)
);

INSERT INTO regions(region) VALUES('Krasnodar Krai');
INSERT INTO regions(region) VALUES('Rostov Oblast');
INSERT INTO regions(region) VALUES('Stavropol Krai');

INSERT INTO cities(city, regionid) VALUES('Krasnodar', 1);
INSERT INTO cities(city, regionid) VALUES('Kropotkin', 1);
INSERT INTO cities(city, regionid) VALUES('Slavyansk', 1);

INSERT INTO cities(city, regionid) VALUES('Rostov', 2);
INSERT INTO cities(city, regionid) VALUES('Shakhty', 2);
INSERT INTO cities(city, regionid) VALUES('Bataysk', 2);

INSERT INTO cities(city, regionid) VALUES('Stavropol', 3);
INSERT INTO cities(city, regionid) VALUES('Pyatigorsk', 3);
INSERT INTO cities(city, regionid) VALUES('Kislovodsk', 3);
