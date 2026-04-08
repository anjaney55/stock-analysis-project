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

CREATE TABLE stock_hourly AS
SELECT
	date_format(time,'%Y-%m-%d %H:00:00') AS hour,
    AVG(close_price) AS avg_price
FROM stock
GROUP BY hour;