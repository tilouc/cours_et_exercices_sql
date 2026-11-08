SELECT cl.prenom, p.nom
FROM clients cl
JOIN commandes cm
ON cl.id = cm.client_id
JOIN patisseries p
ON p.id = cm.patisserie_id;