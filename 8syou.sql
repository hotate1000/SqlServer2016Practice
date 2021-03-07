
-- テーブルのコピー
USE sampleDB
SELECT * INTO 社員コピー
FROM 社員;


-- テーブルの情報のみコピーする
USE sampleDB
SELECT * INTO 社員コピー２
FROM 社員;
WHERE 社員番号 = -1;


-- テーブルのデータのみコピーする
INSERT INTO 社員コピー
SELECT * FROM 社員コピー;


-- IDENTITYの使用
CREATE TABLE idTEST (
  autoNum int IDENTITY(1,1),
  col1 char(10),
  col2 char(10)
);
GO
-- データの入力
INSERT INTO idTEST (col1, col2) VALUES('aaa','aaa');
INSERT INTO idTEST (col1, col2) VALUES('bbb','bbb');
INSERT INTO idTEST (col1, col2) VALUES('ccc','ccc');
GO
-- DEFAULT値の設定
CREATE TABLE idTEST (
  autoNum int IDENTITY(1,1),
  col1 char(10),
  col2 char(10) DEFAULT 'zzz'
);
GO
-- DEFAULT値の後出し追加
ALTER TABLE idTEST 
ADD col3 date DEFAULT GETDATE()
