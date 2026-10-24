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



chapitre 1 — partie 5 : AS

1. à quoi sert AS ?

en sql, AS permet de donner un nom à une colonne dans le résultat d'une requête.

reprenons notre table produits comme exemple : 

nom	        prix	stock
ordinateur	800	    5
souris	    25	    20
clavier	    60	    12
écran	    200	    8
casque	    90	    15

imagine qu'on veut afficher la valeur totale du stock de chaque produit : 

on sait déjà écrire : 

SELECT nom, prix * stock
FROM produits;

le problème, c'est que le résultat possède un nom de colonne pas très clair : 

nom	        prix * stock
ordinateur	4000
souris	    500
clavier	    720
écran	    1600
casque	    1350

avec AS, je peux donner un nom plus clair à cette colonne : 

SELECT nom, prix * stock as valeur_stock
FROM produits;

résultat :

nom	        valeur_stock
ordinateur	4000
souris	    500
clavier	    720
écran	    1600
casque	    1350

la différence est qu'au lieu d'afficher prix * stock comme titre de colonne, sql affiche valeur_stock.

il est important de savoir que AS ne modifie pas la table d'origine. il change seulement le nom affiché dans le résultat.

2. as fonctionne aussi avec les fonctions d'agrégation

par exemple : 

SELECT AVG(prix) as prix_moyen
FROM produits;

résultat :

prix_moyen
235

on a tout simplement donné le nom prix_moyen au résultat de AVG(prix).



chapitre 1 — partie 6 : WHERE

1. à quoi sert WHERE ?

jusqu'ici, on sait comment afficher des colonnes avec SELECT. mais, imaginons qu'on veut afficher seulement certains produits , par exemple, ceux qui coûtent plus de 100 €.

c'est ici que WHERE intervient.

WHERE permet de récupérer seulement les lignes qui respectent une ou plusieurs conditions.

reprenons notre table produits comme exemple : 

nom	        prix	stock
ordinateur	800	    5
souris	    25	    20
clavier	    60	    12
écran	    200	    8
casque	    90	    15

on souhaite récupérer uniquement les produits dont le prix dépasse 100 € : 

SELECT nom, prix
FROM produits
WHERE prix > 100;

SELECT nom, prix : récupére les colonnes nom et prix.
FROM produits : cherche dans la table produits.
WHERE prix > 100 : garde uniquement les produits dont le prix est supérieur à 100 €.

résultat : 

nom	        prix
ordinateur	800
écran	    200

la souris, le clavier et le casque ne sont pas affichés car ils ne respectent pas la condition.

2. les opérateurs de comparaison

avec WHERE, tu peux utiliser différents opérateurs : 

opérateur	signification	        exemple
=	        égal à	                prix = 200
>	        supérieur à	            prix > 100
<	        inférieur à	            prix < 100
>=	        supérieur ou égal à	    prix >= 100
<=	        inférieur ou égal à	    prix <= 100
!=	        différent de	        prix != 100

attention, car en sql, on utilise = pour comparer deux valeurs et non == comme en python.

exemple 1 - produits à moins de 100 € : 

SELECT nom, prix
FROM produits
WHERE prix < 100;

résultat :

nom	    prix
souris	25
clavier	60
casque	90

exemple 2 - produits dont le stock est inférieur ou égal à 8 : 

SELECT nom, stock
FROM produits
WHERE stock <= 8;

résultat : 

nom	        stock
ordinateur	5
écran	    8

3. comment comparer du texte ?

jusqu'ici, nos conditions concernaient uniquement les nombres. mais, on peut également comparer du texte.

par exemple, pour retrouver le produit appelé souris : 

SELECT *
FROM produits
WHERE nom = 'souris';

résultat : 

nom	    prix	stock
souris	25	    20

attention, car les valeurs textuelles sont placées entre apostrophes '...' ou "...".

à retenir : 

WHERE sert à filtrer les lignes d'une table selon une condition. il se place après FROM.
prix = 25 : comparaison avec un nombre.
nom = 'souris' : comparaison avec un texte.

chapitre 1 — partie 7 : AND et OR

1. à quoi servent AND et OR ?

jusqu'ici, on a utilisé WHERE avec une seule condition.

mais imaginons qu'on veut chercher des produits qui respectent plusieurs conditions en même temps.

c'est exactement le rôle de AND et OR.

AND signifie et : toutes les conditions doivent être vraies.
OR signifie ou : au moins une des conditions doit être vraie.

reprenons notre table produits comme exemple : 

nom	        prix	stock
ordinateur	800	    5
souris	    25	    20
clavier	    60	    12
écran	    200	    8
casque	    90	    15

2. AND — plusieurs conditions obligatoires

imagine qu'on veut afficher les produits qui coûtent plus de 50 € et dont le stock est supérieur ou égal à 10 : 

SELECT nom, prix, stock
FROM produits
WHERE prix > 50 AND stock >= 10;

pour chaque produit, sql vérifie deux conditions : 

produit	    prix > 50	stock ≥ 10	retenu ?
ordinateur	oui	        non	        non
souris	    non	        oui	        non
clavier	    oui	        oui	        oui
écran	    oui	        non	        non
casque	    oui	        oui	        oui

résultat :

nom	    prix	stock
clavier	60	    12
casque	90	    15

avec AND, une seule condition qui est fausse suffit pour exclure un produit.

3. OR — au moins une condition vraie

cette fois, on veut afficher les produits qui coûtent plus de 500 € ou dont le stock est supérieur ou égal à 15 : 

SELECT nom, prix, stock
FROM produits
WHERE prix > 500 OR stock >= 15;

produit	    prix > 500	stock ≥ 15	retenu ?
ordinateur	oui	        non	        oui
souris	    non	        oui	        oui
clavier	    non	        non	        non
écran	    non	        non	        non
casque	    non	        oui	        oui

résultat : 

nom	        prix	stock
ordinateur	800	    5
souris	    25	    20
casque	    90	    15

avec OR, une seule condition vraie suffit pour inclure le produit.

attention, car OR inclut aussi les lignes où les deux conditions sont vraies.

4. combiner AND et OR avec des parenthèses

il est possible de combiner les deux (AND et OR).

imagine qu'on souhaite afficher les produits : 
- dont le prix dépasse 100 € OU dont le stock atteint au moins 15;
- ET dont le prix reste inférieur à 500 €.

on écrit : 

SELECT nom, prix, stock
FROM produits
WHERE (prix > 100 or stock >= 15)
AND prix < 500;

ici, les parenthèses servent à regrouper les conditions. sql examine d'abord la condition entre parenthèses, puis vérifie que le prix est inférieur à 500.

résultat : 

nom	    prix	stock
souris	25	    20
écran	200	    8
casque	90	    15

il est important de savoir que sans parenthèses, AND est prioritaire sur OR.

à retenir : 

AND exige toutes les conditions, OR exige au moins une et les parenthèses permettent de regrouper les conditions.



chapitre 1 — partie 8 : LIKE

1. à quoi sert LIKE ?

jusqu'ici, on sait qu'utiliser WHERE sert à chercher des valeurs précises.

par exemple : 

SELECT nom
FROM produits
WHERE nom = 'clavier';

cette requête recherche le produit dont le nom exact est clavier. mais, imaginons maintenant qu'on veut trouver tous les produits dont le nom commence par la lettre c. on ne connait pas forcément leurs noms complets. c'est ici qu'intervient LIKE.

LIKE permet de rechercher du texte selon un motif sans forcément connaître le texte en entier.

2. comprendre le symbole %

en sql, % représente zéro, un ou plusieurs caractères.

reprenons notre table produits comme exemple : 

nom	        prix	stock
ordinateur	800	    5
souris	    25	    20
clavier	    60	    12
écran	    200	    8
casque	    90	    15

exemple 1 - les noms qui commencent par c : 

SELECT nom
FROM produits
WHERE nom LIKE 'c%';

ici : 
- c signifie que le nom doit commencer par cette lettre.
- % signifie que n'importe quels caractères peuvent suivre.

résultat : 

nom
clavier
casque

exemple 2 - les noms qui se terminent par e : 

SELECT nom
FROM produits
WHERE nom LIKE '%e';

ici, on accepte n'importe quels caractères avant la lettre e.

résultat :

nom
casque

exemple 3 - les noms qui contiennent la lettre a : 

SELECT nom
FROM produits
WHERE nom LIKE '%a%';

ici, le nom peut contenir des caractères avant et après la lettre a.

résultat : 

nom
clavier
écran
casque

il est important de comprendre que la position de % change le type de recherche.

3. comprendre l'utilité du symbole _

contrairement à %, le symbole _ remplace exactement un caractère.

exemple : 

SELECT nom
FROM produits
WHERE nom LIKE 'c_sque';

sql recherche un nom qui : 
- commence par c;
- possède exactement un caractère après c;
- se termine par sque.

casque correspond, parce que le _ remplace la lettre a.

résultat :

nom
casque

comparaison : 

symbole	signification
%	    zéro, un ou plusieurs caractères
_	    un caractère

4. comparer = et like

il faut faire attention à cette différence : 

WHERE nom = 'c%'

car, ici sql recherche littéralement le texte c%

en revanche : 

WHERE nom LIKE 'c%'

ici, sql recherche tous les noms commençant par c.

% et _ sont des caractères spéciaux lorsqu'ils sont utilisés dans LIKE.

à retenir : 

LIKE sert à rechercher du texte selon un motif. % remplace un nombre quelconque de caractères, tandis que _ en remplace exactement un.



chapitre 1 — partie 9 : ORDER BY

1. à quoi sert ORDER BY ?

jusqu'ici, on sait comment récupérer des données avec SELECT et les filtrer avec WHERE. mais imagine qu'on veut afficher les produits du moins cher au plus cher.

c'est ici qu'intervient ORDER BY.

ORDER BY permet de trier les résultats d'une requête sql.

reprenons notre table produits comme exemple : 

nom	        prix	stock
ordinateur	800	    5
souris	    25	    20
clavier	    60	    12
écran	    200	    8
casque	    90	    15

2. ASC : trier dans l'ordre croissant

on veut afficher les produits du moins cher au plus cher : 

SELECT nom, prix
FROM produits
ORDER BY prix ASC;

ASC signifie ascending, c'est-à-dire croissant.

résultat : 

nom	        prix
souris	    25
clavier	    60
casque	    90
écran	    200
ordinateur	800

il est important de savoir que ASC est facultatif. si on écrit simplement : 

SELECT nom, prix
FROM produits
ORDER BY prix;

on obtient le même résultat car l'ordre croissant est utilisé par défaut.

3. DESC: trier dans l'ordre décroissant

ici, on peut afficher les produits du plus cher au moins cher : 

SELECT nom, prix
FROM produits
ORDER BY prix desc;

DESC signifie descending, c'est-à-dire décroissant.

résultat :

nom	        prix
ordinateur	800
écran	    200
casque	    90
clavier	    60
souris	    25

instruction	        résultat
order by prix asc	du moins cher au plus cher
order by prix desc	du plus cher au moins cher
order by prix	    identique à asc

4. peut-on trier du texte ?

oui. ORDER BY ne fonctionne pas seulement avec des nombres.

par exemple : 

SELECT nom
FROM produits
ORDER BY nom ASC;

résultat :

nom
casque
clavier
écran
ordinateur
souris

les noms sont classés par ordre alphabétique. et avec DESC, on obtient l'ordre alphabétique inverse.

5. combiner WHERE et ORDER BY

imagine qu'on veut afficher les produits coûtant plus de 50 €, classés du plus cher au moins cher : 

SELECT nom, prix
FROM produits
WHERE prix > 50
ORDER BY prix DESC;

sql va : 

1. récupérer les données de produits;
2. conserver uniquement les produits dont le prix dépasse 50 €;
3. trier ces produits du plus cher au moins cher.

résultat : 

nom	        prix
ordinateur	800
écran	    200
casque	    90
clavier	    60

attention à l'ordre d'écriture car WHERE vient avant ORDER BY.

à retenir : 

ORDER BY trie les résultats. ASC signifie croissant (par défaut), DESC signifie décroissant. ORDER BY se place après WHERE seulement si y en a un.



chapitre 1 — partie 10 : LIMIT

1. à quoi sert LIMIT ?

imagine que notre magasin possède 10 000 produits.

on exécute : 

SELECT *
FROM produits;

sql va te renvoyer les 10 000 lignes. mais imagine qu'on veut afficher seulement 3 produits.

c'est exactement le rôle de LIMIT.

LIMIT permet de limiter le nombre de lignes affichées dans le résultat d'une requête.

reprenons notre table produits comme exemple : 

nom	        prix	stock
ordinateur	800	    5
souris	    25	    20
clavier	    60	    12
écran	    200	    8
casque	    90	    15

on écrit : 

SELECT *
FROM produits
LIMIT 3;

le résultat va avoir au maximum 3 lignes.

attention, car sans ORDER BY, sql ne garantit pas quelles seront ces trois lignes. si tu veux choisir les trois premières selon un ordre précis, on doit le préciser.

2. combiner ORDER BY et LIMIT

c'est dans cette situation que LIMIT devient particulièrement intéressant.

imagine qu'on veut retrouver les deux produits les plus chers. comment procéder ?

on va utiliser deux instructions : 

1. ORDER BY prix DESC pour classer les produits du plus cher au moins cher.
2. LIMIT 2 pour ne conserver que les deux premiers résultats.

SELECT nom, prix
FROM produits
ORDER BY prix DESC
LIMIT 2;

voici ce que sql va faire : 

étape 1 : classer les produits du plus cher au moins cher

nom	        prix
ordinateur	800
écran	    200
casque	    90
clavier	    60
souris	    25

étape 2 : conserver seulement les deux premiers produits

nom	        prix
ordinateur	800
écran	    200

ici, LIMIT 2 ne suffit pas à lui seul pour afficher les deux plus chers. c'est ORDER BY prix DESC qui classe les produits, puis LIMIT 2 qui limite le résultat à deux lignes.

3. combiner WHERE, ORDER BY et LIMIT

maintenant, imagine que tu veux afficher les deux produits les moins chers parmi ceux qui coûtent plus de 50 € : 

SELECT nom, prix
FROM produits
WHERE prix > 50
ORDER BY prix ASC
LIMIT 2;

sql va : 

1. sélectionner les produits dont le prix dépasse 50 €;
2. les classer du moins cher au plus cher;
3. garder seulement les deux premiers.

résultat : 

nom	    prix
clavier	60
casque	90

4. l'ordre des instructions sql

quand tu écris une requête contenant toutes ces instructions, tu dois respecter cet ordre : 

SELECT colonne
FROM table
WHERE condition
ORDER BY colonne ASC
LIMIT nombre;

elles ne sont pas toutes obligatoires. on peut écrire une requête sans WHERE, sans ORDER BY ou sans LIMIT.

à retenir : 

LIMIT n affiche au maximum n lignes. avec ORDER BY, il permet de récupérer les premières lignes d'un classement précis.



exercice bilan — chapitre 1 sql

imaginons une librairie possédant les données suivantes dans une table livres : 

id	titre	    genre	        prix	stock
1	atlas	    science	        30	    8
2	algebra	    science	        45	    3
3	brume	    roman	        18	    12
4	code	    informatique	50	    6
5	cosmos	    science	        25	    14
6	demain	    roman	        35	    5
7	circuits	informatique	40	    9

consigne : écris une requête sql pour chaque question sans regarder les exemples précédents.

question 1 : affiche tous les genres de livres sans répétition.

SELECT DISTINCT genre
FROM livres;

question 2 : affiche le titre et le prix des livres dont le titre commence par « c » et dont le prix est inférieur à 50 €, du plus cher au moins cher.

SELECT titre, prix
FROM livres
WHERE titre LIKE 'c%' AND prix < 50
ORDER BY prix DESC;

question 3 : affiche le nombre de livres différents ayant au moins 8 unités en stock. appelle le résultat `nombre_livres`.

SELECT COUNT(titre) as nombre_livres
FROM livres
WHERE stock >= 8;

question 4 : affiche les titres et la valeur totale du stock des 2 livres ayant la plus grande valeur de stock. appelle la colonne calculée `valeur_stock` (valeur = prix × stock).

SELECT titre, prix * stock AS valeur_stock
FROM livres
ORDER BY valeur_stock DESC
LIMIT 2;

question 5 : affiche le prix moyen des livres du genre `roman`. appelle le résultat `prix_moyen`.

SELECT AVG(prix) AS prix_moyen
FROM livres
WHERE genre = 'roman';

