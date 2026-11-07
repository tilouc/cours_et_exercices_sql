SELECT d.nom, p.nom
FROM dresseurs d
JOIN detient_pokemons dp
ON d.id = dp.dresseur_id
JOIN pokemons p
ON p.id = dp.pokemon_id;