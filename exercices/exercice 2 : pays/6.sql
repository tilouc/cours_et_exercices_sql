SELECT nom, taux_migration
FROM pays
WHERE population > 5000000
ORDER BY taux_migration DESC
LIMIT 10