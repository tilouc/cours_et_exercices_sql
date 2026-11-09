SELECT e.secteur, AVG(f.dette * 1.0 / f.capitaux_propres) AS "ratio_dette"
FROM entreprises e
JOIN finances f
ON e.id = f.entreprise_id
WHERE f.annee = 2023
GROUP BY e.secteur
ORDER BY ratio_dette DESC;