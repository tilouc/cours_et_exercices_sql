SELECT e.nom, f.benefice
FROM entreprises e
JOIN finances f
ON e.id = f.entreprise_id
WHERE e.secteur = "Luxe" AND f.annee = 2024;