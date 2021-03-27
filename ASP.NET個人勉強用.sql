-- 立ち上げ
USE testDB_2103;
GO
DROP TABLE Person;
GO
CREATE TABLE Person(
[id]   int         IDENTITY(1,1) NOT NULL,
[name] varchar(50) NOT NULL,
[age]  int         NOT NULL,
PRIMARY KEY (id)
);
GO
INSERT INTO Person(name, age)
VALUES('masuda', 20),
      ('tomoaki', 30),
      ('yamada', 40);
GO
SELECT * FROM Person;

