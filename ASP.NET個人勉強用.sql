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



-- テーブル型の追加
ALTER TABLE Person
ADD [perfectures_id] int;
-- テーブルの型名変更
EXEC sp_rename 'Person.perfectures_id','perfecture_id','COLUMN'

-- テーブルの追加
CREATE TABLE Perfecture(
  [id]   int PRIMARY KEY,
  [name] varchar(10) 
)

-- 外部キー制約の追加
ALTER TABLE Person ADD
CONSTRAINT FK_Perfecture_Person
FOREIGN KEY(perfecture_id) 
REFERENCES Perfecture(id)
ON DELETE CASCADE
ON UPDATE CASCADE
;

-- 都道府県データ
INSERT INTO Perfecture ([id], [name])
VALUES 
  (1,'北海道'),
  (2,'青森県'),
  (3,'岩手県'),
  (4,'宮城県'),
  (5,'秋田県'),
  (6,'山形県'),
  (7,'福島県'),
  (8,'茨城県'),
  (9,'栃木県'),
  (10,'群馬県'),
  (11,'埼玉県'),
  (12,'千葉県'),
  (13,'東京都'),
  (14,'神奈川県'),
  (15,'新潟県'),
  (16,'富山県'),
  (17,'石川県'),
  (18,'福井県'),
  (19,'山梨県'),
  (20,'長野県'),
  (21,'岐阜県'),
  (22,'静岡県'),
  (23,'愛知県'),
  (24,'三重県'),
  (25,'滋賀県'),
  (26,'京都府'),
  (27,'大阪府'),
  (28,'兵庫県'),
  (29,'奈良県'),
  (30,'和歌山県'),
  (31,'鳥取県'),
  (32,'島根県'),
  (33,'岡山県'),
  (34,'広島県'),
  (35,'山口県'),
  (36,'徳島県'),
  (37,'香川県'),
  (38,'愛媛県'),
  (39,'高知県'),
  (40,'福岡県'),
  (41,'佐賀県'),
  (42,'長崎県'),
  (43,'熊本県'),
  (44,'大分県'),
  (45,'宮崎県'),
  (46,'鹿児島県'),
  (47,'沖縄県');