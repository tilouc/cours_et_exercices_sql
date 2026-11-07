SELECT p.nom, ee.niveau
FROM pokemons p
JOIN evolue_en ee
ON p.id = ee.pokemon_base_id;