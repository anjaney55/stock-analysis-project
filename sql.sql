CREATE TABLE news (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title TEXT,
    clean_title TEXT
);

SELECT * FROM news;

ALTER TABLE news
ADD sentiment FLOAT,
ADD sentiment_label VARCHAR(20);

ALTER Table news
DROP COLUMN title;