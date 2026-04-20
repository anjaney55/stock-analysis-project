DROP TABLE news;

CREATE TABLE news (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title TEXT,
    clean_title TEXT,
    sentiment FLOAT,
    sentiment_label VARCHAR(20),
    time DATETIME
);

CREATE TABLE stock (
    id INT AUTO_INCREMENT PRIMARY KEY,
    time DATETIME,
    open_price FLOAT,
    close_price FLOAT
);

SELECT * FROM news;

-- Adding the sentiment and sentiment_label column 
ALTER TABLE news
ADD sentiment FLOAT,
ADD sentiment_label VARCHAR(20);

ALTER Table news
DROP COLUMN title;

-- To count of positive, negative and neutral
SELECT sentiment_label, COUNT(*) 
FROM news
GROUP BY sentiment_label;     

SELECT AVG(sentiment) FROM news;

-- CREATE AGGREGATED NEWS TABLE
CREATE TABLE news_hourly AS
SELECT 
	DATE_FORMAT(time, '%Y-%m-%d %H:00:00') AS hour,
    AVG(sentiment) AS avg_sentiment
FROM news
GROUP BY hour;

SELECT * FROM news_hourly;

CREATE TABLE stock_hourly AS
SELECT
	date_format(time,'%Y-%m-%d %H:00:00') AS hour,
    AVG(close_price) AS avg_price
FROM stock
GROUP BY hour;

SELECT * FROM stock_hourly;

SELECT
n.hour,
n.avg_sentiment,
s.avg_price
FROM news_hourly as n
INNER JOIN stock_hourly as s
ON n.hour = s.hour;

SELECT 
	n.hour,
	n. avg_sentiment,
	s.avg_price,
	(s.avg_price - LAG(s.avg_price) OVER (ORDER BY n.hour)) AS price_change
FROM news_hourly AS n
JOIN stock_hourly AS s
ON n.hour = s.hour;

SELECT
	CASE
		WHEN avg_sentiment > 0 THEN 'Positive'
		ELSE 'Negative'
    END AS sentiment_type,
    AVG(avg_price) AS avg_stock_price
FROM news_hourly AS n
JOIN stock_hourly AS s
ON n.hour = s.hour
GROUP BY sentiment_type;