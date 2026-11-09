SELECT em.matiere, SUM(e.coefficient) AS "coefficient total"
FROM epreuve e
JOIN epreuve_matiere em
ON e.id = em.epreuve_id
JOIN concours c
ON c.id = e.concours_id
WHERE c.nom = "ccinp" and c.filiere = "mpi"
GROUP BY matiere;