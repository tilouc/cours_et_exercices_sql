SELECT a.libelle, t.libelle
FROM types t
JOIN attaques a
ON t.id = a.type_id;