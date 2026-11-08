SELECT e.nom, (f.dette * 1.0 / f.capitaux_propres) AS ratio
FROM entreprises e
JOIN finances f
ON e.id = f.entreprise_id
WHERE f.annee = 2024
ORDER BY ratio DESC;