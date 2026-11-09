SELECT cl.nom, COUNT(cm.id) AS "nb_commandes"
FROM clients cl
JOIN commandes cm
ON cl.id = cm.client_id
GROUP BY cl.id;