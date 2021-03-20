-- 数を数える
SELECT COUNT(*) FROM 社員;
GO


-- NULLに数値を入れて計算する
SELECT 部門番号, AVG(ISNULL(給与,100000)) FROM 社員 GROUP BY 部門番号;
GO


-- グループ時の平均
-- WHEREはGROPUP前
SELECT 部門番号, COUNT(*) FROM 社員
WHERE 給与 >= 500000
GROUP BY 部門番号
HAVING COUNT(*) > 2;
GO


-- グループを纏めての検索
SELECT * FROM 社員 
INNER JOIN 部門
  ON 社員.部門番号 = 部門.部門番号;
GO
SELECT S.氏名, B.*
FROM 社員 AS S INNER JOIN 部門 AS B
  ON S.部門番号 = B.部門番号;
GO
SELECT 部門.部門番号, 部門.部門名, COUNT(*)
FROM 社員 INNER JOIN 部門
	ON 社員.部門番号 = 部門.部門番号
GROUP BY 部門.部門番号, 部門.部門名;
GO


-- 新しいデータの登録
INSERT INTO 部門 VALUES(30, '情報システム');


-- テーブル結合
USE sampleDB
SELECT * 
FROM 社員 INNER JOIN 部門
ON 社員.部門番号 = 部門.部門番号;

SELECT 社員.*, 部門名
FROM 社員 RIGHT OUTER JOIN 部門
ON 社員.部門番号 = 部門.部門番号
-- 一つ上と同じ
SELECT 社員.*, 部門名
FROM 部門 LEFT OUTER JOIN 社員
ON 社員.部門番号 = 部門.部門番号
SELECT 社員.*, 部門名
FROM 部門 RIGHT OUTER JOIN 社員
ON 社員.部門番号 = 部門.部門番号
-- 一つ上と同じ
SELECT 社員.*, 部門名
FROM 社員 LEFT OUTER JOIN 部門
ON 社員.部門番号 = 部門.部門番号
GO


-- 重複データの削除
SELECT DISTINCT 部門番号 FROM 社員;
GO


-- サブクリエ（単品検索）
SELECT * FROM 社員
WHERE 給与 >= (SELECT AVG(給与) FROM 社員);
GO
SELECT * FROM 社員
WHERE 給与 = (SELECT MAX(給与) FROM 社員);
GO
SELECT * FROM 社員
WHERE 給与 = 500000;
GO


-- サブクリエ（複数検索）
SELECT * FROM 社員
INNER JOIN
(SELECT 部門番号, MAX(給与) AS A FROM 社員 GROUP bY 部門番号) AS B
ON 社員.部門番号 = B.部門番号
AND 社員.給与 = B.A;
GO


-- データの連結
SELECT 社員番号,氏名 FROM 社員
UNION ALL
SELECT 部門番号,部門名 FROM 部門
ORDER BY 社員番号;
GO


-- 条件分岐
SELECT 
CASE 部門番号
  WHEN 10 THEN '総務部'
  WHEN 20 THEN '営業部'
  ELSE 'その他'
END AS 部門名条件分岐表示
, * FROM 社員;

SELECT 
CASE 
  WHEN 部門番号=10 THEN '総務部'
  WHEN 部門番号=20 THEN '営業部'
  ELSE 'その他'
END AS 部門名上書き
, * FROM 社員;

SELECT 
CASE 
	WHEN 入社日 >= '1999/1/1' THEN 'A'
	WHEN 入社日 >= '1990/1/1' THEN 'B'
	WHEN 入社日 >= '1980/1/1' THEN 'C'
	ELSE 'その他'
END AS '判定'
, * FROM 社員 ORDER BY '判定';


-- 条件分岐
SELECT 
CASE 
	WHEN 入社日 >= '1999/1/1' THEN 'A'
	WHEN 入社日 >= '1990/1/1' THEN 'B'
	WHEN 入社日 >= '1980/1/1' THEN 'C'
	ELSE 'その他'
END AS '判定'
, AVG(給与) FROM 社員


-- 条件分岐（グループを纏めての検索）
SELECT 
CASE 
	WHEN 入社日 >= '1999/1/1' THEN 'A'
	WHEN 入社日 >= '1990/1/1' THEN 'B'
	WHEN 入社日 >= '1980/1/1' THEN 'C'
	ELSE 'その他'
END AS '判定'
, AVG(給与) 
FROM 社員
GROUP BY 
CASE 
	WHEN 入社日 >= '1999/1/1' THEN 'A'
	WHEN 入社日 >= '1990/1/1' THEN 'B'
	WHEN 入社日 >= '1980/1/1' THEN 'C'
	ELSE 'その他'
END
GO

SELECT 
	T1.判定,AVG(T1.給与) AS 給与 FROM 
	(SELECT 
	CASE 
		WHEN 入社日 >= '1999/1/1' THEN 'A'
		WHEN 入社日 >= '1990/1/1' THEN 'B'
		WHEN 入社日 >= '1980/1/1' THEN 'C'
		ELSE 'その他'
	END AS 判定,
	給与
	FROM 社員) AS T1
GROUP BY T1.判定;

