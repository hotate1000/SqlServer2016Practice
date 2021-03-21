USE sampleDB;
GO

--　テーブルの作成
CREATE TABLE 社員(
  社員番号  int       NOT NULL,
  氏名      char(50)  NOT NULL,
  給与      int       NULL,
  入社日    date      NULL 
)
GO

-- データの登録
INSERT INTO 社員 (社員番号, 氏名, 給与, 入社日)
VALUES(1, '山田 一郎', 500000, '1998/04/01');
GO
INSERT INTO 社員 (社員番号, 氏名, 給与, 入社日)
VALUES(2, '鈴木 太郎', 300000, '1999/04/01');
GO
INSERT INTO 社員 (社員番号, 氏名, 給与, 入社日)
VALUES(3, '横田 みさき', NULL, NULL);
GO
INSERT INTO 社員 (社員番号, 氏名, 給与, 入社日)
VALUES(4, '松田 大作', 700000, '1985/04/01'),
      (5, '田中 次郎', 500000, '1996/04/01'),
      (6, '佐藤 三郎', 500000, '1997/04/01');
GO

-- 条件検索
SELECT * FROM 社員 WHERE 社員番号 = 2;
GO

-- データの更新
UPDATE 社員
SET 給料 = 400000
WHERE 社員番号 = 2;
GO

-- データの削除
DELETE FROM 社員 WHERE 社員番号 = 4;
DELETE FROM 社員 WHERE 社員番号 = 5;
DELETE FROM 社員 WHERE 社員番号 = 6;
GO

-- 一時テーブル
SELECT * FROM #TEST
INSERT INTO #TEST VALUES(1, 'A');