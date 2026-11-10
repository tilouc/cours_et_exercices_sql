SELECT em.matiere,
       SUM(e.coefficient) * 100.0 / (
           SELECT SUM(e2.coefficient)
           FROM epreuve_matiere em2
           JOIN epreuve e2 ON em2.epreuve_id = e2.id
           JOIN concours c2 ON e2.concours_id = c2.id
           WHERE c2.nom = 'ccinp' AND c2.filiere = 'mp'
       ) AS "poids en pourcentage"
FROM epreuve_matiere em
JOIN epreuve e ON em.epreuve_id = e.id
JOIN concours c ON e.concours_id = c.id
WHERE c.nom = 'ccinp' AND c.filiere = 'mp'
GROUP BY em.matiere;
