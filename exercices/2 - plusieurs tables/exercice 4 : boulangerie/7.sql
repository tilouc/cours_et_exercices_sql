SELECT cl.nom
FROM clients cl
JOIN commandes cm
ON cl.id = cm.client_id
JOIN boulangeries b
ON cm.boulangerie_id = b.id
JOIN patisseries p
ON p.id = cm.patisserie_id
WHERE p.calories > 400;