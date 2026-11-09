SELECT DISTINCT d.nom, COUNT(p.nom) AS "count(*)"
FROM dresseurs d
JOIN detient_pokemons dp
ON d.id = dp.dresseur_id
JOIN pokemons p
ON p.id = dp.pokemon_id
WHERE dp.niveau > 50
GROUP BY d.nom
HAVING COUNT(p.nom) >= 4;