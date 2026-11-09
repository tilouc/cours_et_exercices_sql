SELECT DISTINCT d.nom, COUNT(p.nom) AS "nombre_pokemons", AVG(dp.niveau) AS "niveau_moyen"
FROM dresseurs d
JOIN detient_pokemons dp
ON d.id = dp.dresseur_id
JOIN pokemons p
ON p.id = dp.pokemon_id
GROUP BY d.nom;