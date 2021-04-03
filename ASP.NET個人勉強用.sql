-- 立ち上げ
CREATE DATABASE testDB_2103;
GO
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
EXEC sp_rename 'Person.perfectures_id',N'perfecture_id',N'COLUMN'

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
  (1,N'北海道'),
  (2,N'青森県'),
  (3,N'岩手県'),
  (4,N'宮城県'),
  (5,N'秋田県'),
  (6,N'山形県'),
  (7,N'福島県'),
  (8,N'茨城県'),
  (9,N'栃木県'),
  (10,N'群馬県'),
  (11,N'埼玉県'),
  (12,N'千葉県'),
  (13,N'東京都'),
  (14,N'神奈川県'),
  (15,N'新潟県'),
  (16,N'富山県'),
  (17,N'石川県'),
  (18,N'福井県'),
  (19,N'山梨県'),
  (20,N'長野県'),
  (21,N'岐阜県'),
  (22,N'静岡県'),
  (23,N'愛知県'),
  (24,N'三重県'),
  (25,N'滋賀県'),
  (26,N'京都府'),
  (27,N'大阪府'),
  (28,N'兵庫県'),
  (29,N'奈良県'),
  (30,N'和歌山県'),
  (31,N'鳥取県'),
  (32,N'島根県'),
  (33,N'岡山県'),
  (34,N'広島県'),
  (35,N'山口県'),
  (36,N'徳島県'),
  (37,N'香川県'),
  (38,N'愛媛県'),
  (39,N'高知県'),
  (40,N'福岡県'),
  (41,N'佐賀県'),
  (42,N'長崎県'),
  (43,N'熊本県'),
  (44,N'大分県'),
  (45,N'宮崎県'),
  (46,N'鹿児島県'),
  (47,N'沖縄県');


-- IDENTITY無効化 
SET IDENTITY_INSERT Perfecture ON;
SET IDENTITY_INSERT Perfecture OFF;

-- テーブル内データ削除
TRUNCATE TABLE Perfecture;
SELECT * FROM Perfecture;

-- 文字コード変更
ALTER TABLE Perfecture 
ALTER COLUMN Name nvarchar(MAX) COLLATE JAPANESE_CI_AS

