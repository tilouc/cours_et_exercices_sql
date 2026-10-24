sql — chapitre 1 : les fondamentaux

1. c'est quoi le sql ?

sql signifie structured query language.

c'est un langage qui permet de demander à une base de données de nous fournir des informations.


imagine une boutique qui vend des produits. elle conserve ses informations dans un tableau nommé produits.

id	nom	        prix	stock
1	ordinateur	800	    5
2	souris	    25	    20
3	clavier	    60	    12
4	écran	    200	    8
5	casque	    90	    15

dans ce tableau :
- produits est le nom de la table.
- id, nom, prix, stock sont les colonnes, également appelées attributs.
- chaque ligne représente un enregistrement, ici un produit.

mais imagine que le magasin possède 1 million de produits. là, tu as besoin du sql pour retrouver les informations facilement.


2. les deux premières instructions : SELECT et FROM

prenons cette requête :

select nom
from produits;

select nom : je veux récupérer la colonne nom
from produits : depuis la table produits
; : marque la fin de la requête

résultat :

nom
ordinateur
souris
clavier
écran
casque

à retenir :
SELECT : ce que tu veux récupérer
FROM : dans quelle table tu veux chercher


3. sélectionner plusieurs colonnes

on veut connaître le nom et le prix de chaque produit : 

SELECT nom, prix
FROM produits;

tu dois juste séparer les noms des colonnes par des virgules

résultat :

nom	        prix
ordinateur	800
souris	    25
clavier	    60
écran	    200
casque	    90


et si on veut récupérer toutes les colonnes ? : 

SELECT *
FROM produits;

* veut dire toutes les colonnes


choses à savoir : 

- les requêtes sql peuvent s'écrire en majuscule comme en minuscule (en majuscule de préférence)
- l'indentation n'est pas obligatoire mais conseillée
- les requêtes se terminent toujours par ;



chapitre 1 — partie 2 : les calculs avec SELECT

1. peut-on faire des calculs en sql ?

jusqu'ici, on utilisait SELECT pour récupérer des informations. mais SELECT permet aussi de faire des calculs.

reprenons la table produits comme exemple : 

id	nom	        prix	stock
1	ordinateur	800	    5
2	souris	    25	    20
3	clavier	    60	    12
4	écran	    200	    8
5	casque	    90	    15

on veut connaître la valeur totale du stock de chaque produit, calculée à partir de son prix de vente. au lieu de calculer manuellement chaque ligne, on fait : 

SELECT nom, prix * stock
FROM produits;

résultat :

nom	        prix * stock
ordinateur	4000
souris	    500
clavier	    720
écran	    1600
casque	    1350

il est important de savoir que cette requête ne modifie aucune donnée dans la table. elle produit juste le calcul.

2. les opérateurs mathématiques

voici les principaux opérateurs que nous allons utiliser : 

opérateur	rôle
+	        addition
-	        soustraction
*	        multiplication
/	        division
pow(a, b)	puissance


exemple : une réduction de 20 %

tous les produits bénéficient d'une réduction de 20 %. leur nouveau prix est : 

prix_nouveau = prix * 0.8

on va écrire : 

SELECT nom, prix * 0.8

résultat :

nom	        prix * 0.8
ordinateur	640
souris	    20
clavier	    48
écran	    160
casque	    72



chapitre 1 — partie 3 : distinct

1. à quoi sert distinct ?

DISTINCT permet de supprimer les doublons dans les résultats d'une requête.

prenons l'exemple d'une table appelée clients : 

id	nom	    ville
1	alice	lille
2	bob	    paris
3	charles	lille
4	david	lyon
5	emma	paris
6	fatou	lille

pour afficher les villes dans lesquelles mes clients habitent, j'écris : 

SELECT ville
FROM clients

résultat :

ville
lille
paris
lille
lyon
paris
lille

on remarque que lille apparaît trois fois tandis que paris deux fois.

si on veut afficher de telle sorte qu'on veuille afficher chaque ville une seule fois, on écrit : 

SELECT DISTINCT ville
FROM clients;

résultat :

ville
lille
paris
lyon


DISTINCT se place toujours juste après SELECT et avant le nom de la colonne.



chapitre 1 — partie 4 : les fonctions d'agrégation

1. c'est quoi une fonction d'agrégation ?

imaginons qu'on veut connaître :
- le prix moyen des produits
- le produit le plus cher
- combien de produits sont dans la table
- combien d'articles il y a en tout dans le magasin

les fonctions d'agrégation permettent de faire des calculs en utilisant plusieurs lignes d'un tableau. le cours présente 5 qui sont essentielles : 

fonction	rôle
SUM()	    calculer une somme
MIN()	    trouver le minimum
MAX()	    trouver le maximum
COUNT()	    compter
AVG()	    calculer une moyenne

reprenons notre table produits comme exemple : 

nom	        prix	stock
ordinateur	800	    5
souris	    25	    20
clavier	    60	    12
écran	    200	    8
casque	    90	    15

a. SUM() — la somme

on veut connaître le nombre total d'unités en stock : 

SELECT SUM(stock)
FROM produits;

sql fait : 5+ 20+ 12 + 8 + 15 = 60

résultat : 60

b. MIN() — le minimum

on veut connaître le prix le plus bas : 

SELECT MIN(prix)
FROM produits;

résultat : 25

c. MAX() — le maximum

on veut connaître le prix le plus élevé : 

SELECT MAX(prix)
FROM produits;

résultat : 800

d. COUNT() — compter

on veut connaître le nombre de lignes dans la table : 

SELECT COUNT(*)
FROM produits;

résultat : 5

attention, car COUNT(*) compte toutes les lignes de la table tandis que COUNT(prix) compte seulement les lignes de la colonne prix qui ne sont pas nulles.

e. AVG() — la moyenne

on veut connaître le prix moyen des produits : 

SELECT AVG(prix)
FROM produits;

sql fait : (800 + 25 + 60 + 200 + 90) / 5 = 235

résultat : 235