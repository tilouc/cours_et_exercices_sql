SELECT c.nom, c.filiere, COUNT(e.nom) AS "nombre épreuves", SUM(duree) AS "durée totale"
FROM concours c
JOIN epreuve e
ON c.id = e.concours_id
WHERE e.oral = 0
GROUP BY c.nom, c.filiere
ORDER BY c.nom, CASE WHEN c.filiere = "mp" THEN 1 WHEN c.filiere = "pc" THEN 2 WHEN c.filiere = "mpi" THEN 3 END;