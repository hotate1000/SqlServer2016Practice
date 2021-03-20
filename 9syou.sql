-- 照合順序
SELECT * FROM 商品
WHERE 商品名 = 'こーひーマイルド' COLLATE JAPANESE_BIN;

SELECT * FROM 商品
WHERE 商品名 = 'こーひーマイルド' COLLATE JAPANESE_CI_AS;



