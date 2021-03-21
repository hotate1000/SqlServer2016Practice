-- 変数の宣言
DECLARE @x int, @y int, @z varchar(20) = 'yyy'
SELECT @x = 10, @y = 20
SELECT @x,@y,@z;


-- テーブルの内容を変数に宣言
DECLARE @shimei varchar(50), @hiredate datetime;
SELECT @shimei = 氏名, @hiredate = 入社日 FROM 社員 WHERE 社員番号=1;
SELECT @shimei, @hiredate;


-- メッセージの表示
DECLARE @x int;
SELECT @x = 77;
PRINT '変数の値は' + CAST(@x AS varchar);


-- 条件分岐
DECLARE @x int;
SET @x = DATEPART(hour, GETDATE());
SELECT @x;

IF(@x > 12)
	BEGIN
		PRINT '条件成功'
	END
ELSE
	BEGIN
		PRINT '条件失敗'
	END


-- 動的変数の整理
-- 動的変数等の確認
-- エラーが出る
DECLARE @test varchar(20)
SELECT @test = '社員'
SELECT * FROM @test

DECLARE @test varchar(100)
SELECT @test = '氏名'
SELECT @test FROM 社員

-- 動的SQL
DECLARE @TEST varchar(20)
SELECT @TEST = '社員'
EXECUTE ('SELECT * FROM 社員')

DECLARE @TEST varchar(100), @TEST2 varchar(100)
SELECT @TEST = '氏名'
SELECT @TEST2 = '社員'
EXECUTE ('SELECT ' + @TEST +' FROM ' + @TEST2);

DECLARE @SQL nvarchar(100), @TABNAME varchar(20)
SELECT @TABNAME = '社員'
SELECT @SQL = N'SELECT * FROM ' + @TABNAME
EXEC sp_executesql @SQL;
EXEC (@SQL);

DECLARE @TEST nvarchar(100), @TEST2 nvarchar(100), @TEST3 nvarchar(100)
SELECT @TEST = '氏名'
SELECT @TEST2 = '社員'
SELECT @TEST3 = N'SELECT 氏名 FROM ' + @TEST2
EXECUTE (@TEST3)
EXEC sp_executesql @TEST3; -- nvarcharにしないとエラーとなる.


-- ランク付け
SELECT ROW_NUMBER() OVER (PARTITION BY 部門番号 ORDER BY 入社日 DESC),
RANK() OVER (PARTITION BY 部門番号 ORDER BY 入社日 DESC),
DENSE_RANK() OVER (PARTITION BY 部門番号 ORDER BY 入社日 DESC),
NTILE(5) OVER (PARTITION BY 部門番号 ORDER BY 入社日 DESC),
* FROM 社員;

SELECT * 
FROM (SELECT ROW_NUMBER() OVER (ORDER BY 入社日 DESC) AS A, * FROM 社員) AS T
WHERE A BETWEEN 1 AND 3;