SELECT c.filiere, em.matiere, e.duree, e.coefficient
FROM epreuve e
JOIN epreuve_matiere em
ON e.id = em.epreuve_id
JOIN concours c
ON c.id = e.concours_id
WHERE c.nom = "cmp";