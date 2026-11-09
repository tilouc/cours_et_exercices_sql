SELECT b.ville, COUNT(b.nom) AS "nb"
FROM boulangeries b
GROUP BY b.ville
HAVING COUNT(b.nom) >= 2;