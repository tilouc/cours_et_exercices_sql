SELECT e.nom, e.secteur, f.dividende
FROM entreprises e
JOIN finances f
ON e.id = f.entreprise_id
WHERE annee = 2024
ORDER BY f.dividende DESC
LIMIT 5;