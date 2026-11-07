SELECT p.nom
FROM pokemons p
JOIN detient_pokemons dp
ON p.id = dp.pokemon_id
JOIN dresseurs d
ON d.id = dp.dresseur_id
WHERE d.nom = "Pierre";