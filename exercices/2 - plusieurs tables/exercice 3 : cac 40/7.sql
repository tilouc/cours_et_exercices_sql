SELECT e.nom
FROM entreprises e
JOIN finances f1
ON e.id = f1.entreprise_id AND f1.annee = 2023
JOIN finances f2
ON e.id = f2.entreprise_id AND f2.annee = 2024
WHERE f1.dette > f2.dette;