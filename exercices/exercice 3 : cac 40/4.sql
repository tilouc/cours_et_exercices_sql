SELECT annee, SUM(benefice)
FROM finances
GROUP BY annee
ORDER BY annee ASC;