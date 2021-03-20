-- 7syou
-- テーブルの結合
USE NorthJ
SELECT 区分名, 商品.*
FROM 商品
INNER JOIN 商品区分
ON 商品.区分コード = 商品区分.区分コード;


SELECT 仕入先.仕入先名, 商品区分.区分名, 商品.*
FROM 商品
INNER JOIN 商品区分
ON 商品.区分コード = 商品区分.区分コード
INNER JOIN 仕入先
ON 商品.仕入先コード = 仕入先.仕入先コード


SELECT 商品.商品名, SUM(受注明細.単価 * 受注明細.数量) AS 商品コードあたりの合計 FROM 受注明細
INNER JOIN 商品
ON 受注明細.商品コード = 商品.商品コード
GROUP BY 商品.商品名;


SELECT SUM(受注明細.単価 * 受注明細.数量), 商品区分.区分名 FROM 受注明細
INNER JOIN 商品
ON 受注明細.商品コード = 商品.商品コード
INNER JOIN 商品区分
ON 商品.区分コード = 商品区分.区分コード
GROUP BY 商品区分.区分名


-- 年次の表示
SELECT SUM(受注明細.単価 * 受注明細.数量), YEAR(受注.受注日) FROM 受注明細
INNER JOIN 受注
ON 受注明細.受注コード = 受注.受注コード
GROUP BY YEAR(受注.受注日)
ORDER BY YEAR(受注.受注日);


-- 表示方法の操作
SELECT 区分名,
SUM(CASE YEAR(受注日)
	WHEN '1996' THEN 受注明細.単価 * 受注明細.数量 ELSE NULL END) AS '1996',
SUM(CASE YEAR(受注日)
	WHEN '1997' THEN 受注明細.単価 * 受注明細.数量 ELSE NULL END) AS '1997',
SUM(CASE YEAR(受注日)
	WHEN '1998' THEN 受注明細.単価 * 受注明細.数量 ELSE NULL END) AS '1998',
SUM(受注明細.単価 * 受注明細.数量) AS '全体'
FROM 受注明細
INNER JOIN 受注 ON 受注明細.受注コード = 受注.受注コード
INNER JOIN 商品 ON 受注明細.商品コード = 商品.商品コード
INNER JOIN 商品区分 ON 商品.区分コード = 商品区分.区分コード
GROUP BY ROLLUP(区分名);


-- ビューの作成
CREATE VIEW 受注商品一覧
AS
SELECT 受注.受注コード, 受注日, 受注明細.単価, 数量, 商品名, 区分名
FROM 受注明細
INNER JOIN 受注 ON 受注明細.受注コード = 受注.受注コード
INNER JOIN 商品 ON 受注明細.商品コード = 商品.商品コード
INNER JOIN 商品区分 ON 商品.区分コード = 商品区分.区分コード

ALTER VIEW 受注商品一覧
AS
SELECT YEAR(受注日) AS 年, MONTH(受注日) AS 月,
  受注明細.単価 * 数量 AS 受注金額,
  受注.受注コード, 受注日, 受注明細.単価, 数量, 商品名, 区分名
FROM 受注明細
INNER JOIN 受注 ON 受注明細.受注コード = 受注.受注コード
INNER JOIN 商品 ON 受注明細.商品コード = 商品.商品コード
INNER JOIN 商品区分 ON 商品.区分コード = 商品区分.区分コード


-- 相関サブクエリ
SELECT 年, SUM(受注金額) AS 今年度, (SELECT SUM(受注金額) FROM 受注商品一覧 WHERE 年 = T1.年 - 1)
FROM 受注商品一覧 AS T1
GROUP BY 年
ORDER BY 年;

SELECT 年, 月, SUM(受注金額), (SELECT SUM(受注金額) FROM 受注商品一覧 WHERE 年 = T1.年 - 1 AND 月 = T1.月)
FROM 受注商品一覧 AS T1
GROUP BY 年,月
ORDER BY 年,月;

-- 相関サブクエリ・合計していく
SELECT 年, 月, SUM(受注金額),
(SELECT SUM(受注金額) FROM 受注商品一覧 WHERE 年 = T1.年 AND 月 <= T1.月)
FROM 受注商品一覧 T1
GROUP BY 年,月
ORDER BY 年,月;


-- 8syou
bcp sampleDB.dbo.社員 out C:¥SQLpractice¥shain.txt /S Win10/T /c /t ","