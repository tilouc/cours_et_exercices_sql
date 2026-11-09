SELECT b.nom, SUM(c.quantite * p.prix) AS "total"
FROM boulangeries b
JOIN commandes c
ON b.id = c.boulangerie_id
JOIN patisseries p
ON p.id = c.patisserie_id
GROUP BY b.id, b.nom;