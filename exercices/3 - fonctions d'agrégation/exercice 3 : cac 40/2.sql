SELECT e.secteur, SUM(f.benefice) AS benefice_total
FROM entreprises e
JOIN finances f
ON e.id = f.entreprise_id
WHERE f.annee > 2018 AND f.annee < 2025
GROUP BY e.secteur
ORDER BY benefice_total DESC
LIMIT 1;