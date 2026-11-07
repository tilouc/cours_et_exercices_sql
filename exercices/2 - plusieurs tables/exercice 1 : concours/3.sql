SELECT SUM(e.coefficient) AS "coefficient des mathématiques"
FROM epreuve e
JOIN concours c
ON c.id = e.concours_id
JOIN epreuve_matiere em
ON e.id = em.epreuve_id
WHERE c.nom = "ccinp" and matiere = "mathématiques";