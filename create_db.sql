CREATE TABLE regions (
  regionid  INTEGER PRIMARY KEY,
  region    VARCHAR
);

CREATE TABLE cities (
  cityid    INTEGER PRIMARY KEY,
  city      VARCHAR,
  regionid  INTEGER,
  FOREIGN KEY(regionid) REFERENCES regions(regionid)
);

CREATE TABLE persons (
  personid    INTEGER PRIMARY KEY,
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

INSERT INTO regions VALUES(0, 'Krasnodar Krai');
INSERT INTO regions VALUES(1, 'Rostov Oblast');
INSERT INTO regions VALUES(2, 'Stavropol Krai');

INSERT INTO cities VALUES(0, 'Krasnodar', 0);
INSERT INTO cities VALUES(1, 'Kropotkin', 0);
INSERT INTO cities VALUES(2, 'Slavyansk', 0);

INSERT INTO cities VALUES(3, 'Rostov', 1);
INSERT INTO cities VALUES(4, 'Shakhty', 1);
INSERT INTO cities VALUES(5, 'Bataysk', 1);

INSERT INTO cities VALUES(6, 'Stavropol', 2);
INSERT INTO cities VALUES(7, 'Pyatigorsk', 2);
INSERT INTO cities VALUES(8, 'Kislovodsk', 2);
