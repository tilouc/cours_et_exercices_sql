SELECT e.nom, f.benefice
FROM entreprises e
JOIN finances f
ON e.id = f.entreprise_id
WHERE benefice < 0 and annee = 2024;