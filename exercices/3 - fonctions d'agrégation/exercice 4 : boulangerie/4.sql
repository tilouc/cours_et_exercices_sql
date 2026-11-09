SELECT p.nom, SUM(c.quantite) AS "total"
FROM boulangeries b
JOIN commandes c
ON b.id = c.boulangerie_id
JOIN patisseries p
ON p.id = c.patisserie_id
GROUP BY p.id, p.nom
HAVING MAX(c.quantite)
LIMIT 1;