SELECT p1.nom, p2.nom, ee.niveau
FROM pokemons p1
JOIN evolue_en ee
ON p1.id = ee.pokemon_base_id
JOIN pokemons p2
ON p2.id = ee.pokemon_evol_id;