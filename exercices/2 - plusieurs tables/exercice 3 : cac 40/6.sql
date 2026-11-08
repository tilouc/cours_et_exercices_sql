SELECT e.nom, f1.chiffre_affaires AS ca_2023, f2.chiffre_affaires AS ca_2024
FROM entreprises e
JOIN finances f1
ON e.id = f1.entreprise_id AND f1.annee = 2023
JOIN finances f2
ON e.id = f2.entreprise_id AND f2.annee = 2024
WHERE secteur = "Banque";