SELECT DISTINCT cl.nom, cl.prenom
FROM clients cl
JOIN commandes cm
ON cl.id = cm.client_id
JOIN boulangeries b
ON cm.boulangerie_id = b.id;