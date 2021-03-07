use sampleDB

-- テーブルの作成
CREATE TABLE 部門(
	部門番号 int PRIMARY KEY,
	部門名 char(50)
);
GO

-- データを登録する
INSERT INTO 部門(部門番号, 部門名)
VALUES(10, '総務部'),
	(20, '営業部');
GO

-- テーブルにカラムを追加する
ALTER TABLE 社員 ADD 部門番号 int;
GO

-- カラムデータの更新
USE sampleDB
UPDATE 社員 SET 部門番号=10;
GO
UPDATE 社員 SET 部門番号=20 WHERE 社員番号=4;
GO

-- 外部キー制約を追加する
ALTER TABLE 社員
ADD CONSTRAINT FK_部門番号
FOREIGN KEY (部門番号) REFERENCES (部門 部門番号)
GO