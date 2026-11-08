SELECT e.nom, f.capitalisation
FROM entreprises e
JOIN finances f
ON e.id = f.entreprise_id
WHERE e.employes > 100000 AND f.annee = 2024;