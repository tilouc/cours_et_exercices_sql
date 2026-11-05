SELECT nom, population / surface
FROM pays
WHERE population > 5000000
ORDER BY (population / surface) DESC
LIMIT 10;