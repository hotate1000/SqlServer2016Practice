-- RTRIM関数
SELECT 社員番号, RTRIM(氏名) + 'さん' FROM 社員;
SELECT RTRIM('   テスト   ') + 'さん';
SELECT LTRIM('   テスト   ') + 'さん';
SELECT RTRIM(LTRIM('   テスト   ')) + 'さん';


-- 全角スペースの削除
SELECT REPLACE('   　鈴木　   ','　','') + 'さん';


-- 右から〇文字、左から〇文字取得
SELECT RIGHT(商品名, 8), LEFT(商品名, 8) FROM 商品;


-- 頭文字と後文字を削除する
SELECT SUBSTRING(商品名, 4, 4) FROM 商品;


-- 型変換
-- 文字変更
SELECT '佐藤' + CAST(111 AS char);
SELECT RTRIM(CONVERT(char, 111)) + '佐藤';
-- 数値変換
SELECT CAST((SELECT AVG(単価) FROM 商品) AS int);
-- NULLの書き換え
SELECT ISNULL(単価,0) FROM 商品;


-- 条件分岐
SELECT 受注日, 
CASE DATEPART(weekday, 受注日)
	WHEN 1 THEN '日'
	WHEN 2 THEN '月'
	WHEN 3 THEN '火'
	WHEN 4 THEN '水'
	WHEN 5 THEN '木'
	WHEN 6 THEN '金'
	WHEN 7 THEN '土'
	ELSE 'エラー'
	END	
FROM 受注;