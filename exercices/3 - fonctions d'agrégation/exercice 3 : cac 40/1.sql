SELECT e.secteur, COUNT(e.nom)
FROM entreprises e
GROUP BY e.secteur;