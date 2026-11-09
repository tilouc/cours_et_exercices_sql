SELECT b.ville, COUNT(b.nom)
FROM boulangeries b
GROUP BY b.ville;