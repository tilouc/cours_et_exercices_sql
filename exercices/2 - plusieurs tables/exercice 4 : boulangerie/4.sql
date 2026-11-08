SELECT DISTINCT p.nom
FROM clients cl
JOIN commandes cm
ON cl.id = cm.client_id
JOIN patisseries p
ON p.id = cm.patisserie_id
JOIN boulangeries b
ON b.id = cm.boulangerie_id
WHERE b.nom = "Au Pain Doré";