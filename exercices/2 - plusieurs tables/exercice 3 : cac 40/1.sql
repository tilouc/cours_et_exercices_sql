SELECT e.nom, f.chiffre_affaires
FROM entreprises e
JOIN finances f
ON e.id = f.entreprise_id
WHERE f.annee = "2024";