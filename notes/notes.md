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

maintenant, attaquons le deuxième chapitre de sql qui porte sur les requêtes sur plusieurs tables.



chapitre 2 — les jointures (JOIN)

1. pourquoi avons-nous besoin de JOIN ?

jusqu'ici, toutes nos requêtes sql utilisaient une seule table. mais, dans une véritable application, les informations sont souvent réparties dans plusieurs tables.

imagine qu'on développe un site de commerce en ligne. on dispose de deux tables : 

table clients

id	nom
1	amina
2	louis
3	sara

table commandes

id	    client_id	montant
101	    1	        30
102	    1	        50
103	    3	        20

remarque que dans la table commandes, nous n'avons pas directement le nom du client. nous avons seulement client_id.

pourtant, nous on veut répondre à cette question : 

quel client a passé quelle commande ?

c'est exactement le rôle de JOIN.

2. comment sql relie-t-il les deux tables ?

regardons les colonnes suivantes : 

![schéma relationnel clients et commandes](data:image/svg+xml;charset=utf-8,%3Csvg%20font-family%3D%22-apple-system-body%2C%20ui-sans-serif%2C%20-apple-system%2C%20system-ui%2C%20%26quot%3BSegoe%20UI%26quot%3B%2C%20Helvetica%2C%20%26quot%3BApple%20Color%20Emoji%26quot%3B%2C%20Arial%2C%20sans-serif%2C%20%26quot%3BSegoe%20UI%20Emoji%26quot%3B%2C%20%26quot%3BSegoe%20UI%20Symbol%26quot%3B%22%20font-weight%3D%22400%22%20data-d-component%3D%22svg%22%20fill%3D%22currentColor%22%20style%3D%22color%3Argb(13%2C%2013%2C%2013)%22%20viewBox%3D%220%200%20340%20155%22%20width%3D%22100%25%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%3E%3Crect%20x%3D%228%22%20y%3D%228%22%20width%3D%22137%22%20height%3D%22138%22%20rx%3D%229%22%20fill%3D%22%2364748b%22%20fill-opacity%3D%22.08%22%20stroke%3D%22%2394a3b8%22%20stroke-opacity%3D%22.6%22%2F%3E%3Crect%20x%3D%22195%22%20y%3D%228%22%20width%3D%22137%22%20height%3D%22138%22%20rx%3D%229%22%20fill%3D%22%2364748b%22%20fill-opacity%3D%22.08%22%20stroke%3D%22%2394a3b8%22%20stroke-opacity%3D%22.6%22%2F%3E%3Cg%20font-size%3D%2213%22%20fill%3D%22currentColor%22%20text-anchor%3D%22middle%22%20font-weight%3D%22600%22%3E%3Ctext%20x%3D%2276%22%20y%3D%2229%22%3Eclients%3C%2Ftext%3E%3Ctext%20x%3D%22263%22%20y%3D%2229%22%3Ecommandes%3C%2Ftext%3E%3C%2Fg%3E%3Cg%20font-size%3D%2211%22%20fill%3D%22currentColor%22%3E%3Ctext%20x%3D%2220%22%20y%3D%2255%22%3Eid%3C%2Ftext%3E%3Ctext%20x%3D%2268%22%20y%3D%2255%22%3Enom%3C%2Ftext%3E%3Ctext%20x%3D%22205%22%20y%3D%2255%22%3Eclient_id%3C%2Ftext%3E%3Ctext%20x%3D%22283%22%20y%3D%2255%22%3Emontant%3C%2Ftext%3E%3Ctext%20x%3D%2223%22%20y%3D%2279%22%3E1%3C%2Ftext%3E%3Ctext%20x%3D%2268%22%20y%3D%2279%22%3Eamina%3C%2Ftext%3E%3Ctext%20x%3D%2223%22%20y%3D%22104%22%3E2%3C%2Ftext%3E%3Ctext%20x%3D%2268%22%20y%3D%22104%22%3Elouis%3C%2Ftext%3E%3Ctext%20x%3D%2223%22%20y%3D%22129%22%3E3%3C%2Ftext%3E%3Ctext%20x%3D%2268%22%20y%3D%22129%22%3Esara%3C%2Ftext%3E%3Ctext%20x%3D%22218%22%20y%3D%2279%22%3E1%3C%2Ftext%3E%3Ctext%20x%3D%22289%22%20y%3D%2279%22%3E30%3C%2Ftext%3E%3Ctext%20x%3D%22218%22%20y%3D%22104%22%3E1%3C%2Ftext%3E%3Ctext%20x%3D%22289%22%20y%3D%22104%22%3E50%3C%2Ftext%3E%3Ctext%20x%3D%22218%22%20y%3D%22129%22%3E3%3C%2Ftext%3E%3Ctext%20x%3D%22289%22%20y%3D%22129%22%3E20%3C%2Ftext%3E%3C%2Fg%3E%3Cpath%20d%3D%22M32%2074%20C166%2053%2C%20164%2062%2C%20214%2074%22%20fill%3D%22none%22%20stroke%3D%22%230D9488%22%20stroke-width%3D%222.2%22%20stroke-dasharray%3D%225%204%22%2F%3E%3Cpath%20d%3D%22M32%2074%20C165%2080%2C%20171%2091%2C%20214%20100%22%20fill%3D%22none%22%20stroke%3D%22%230D9488%22%20stroke-width%3D%222.2%22%20stroke-dasharray%3D%225%204%22%2F%3E%3Cpath%20d%3D%22M32%20125%20C162%20145%2C%20171%20143%2C%20214%20125%22%20fill%3D%22none%22%20stroke%3D%22%230D9488%22%20stroke-width%3D%222.2%22%20stroke-dasharray%3D%225%204%22%2F%3E%3C%2Fsvg%3E)

par exemple, la commande 101 possède client_id = 1. dans la table clients, l'identifiant 1 correspond à amina. nous pouvons donc associer cette commande à amina.

et puisque la commande 102 possède également client_id = 1, elle appartient aussi à amina.

3. notre première jointure

voici comment on écrit cette association en sql : 

SELECT clients.nom, commandes.montant
FROM clients
JOIN commandes
ON clients.id = commandes.client_id;

décomposons chaque instruction : 

- SELECT clients.nom, commandes.montant : affiche le nom du client et le montant de la commande.
- FROM clients : partir de la table clients.
- JOIN commandes : relier la table commandes.
- ON clients.id = commandes.client_id : précise comment les deux tables sont reliées.

il est important d'écrire clients.nom plutôt que simplement nom car, lorsque nous utilisons plusieurs tables, nous devons préciser à sql de quelle table provient chaque colonne.

résultat : 

nom	    montant
amina	30
amina	50
sara	20

remarques deux choses : 

1. amina apparaît deux fois. c'est normal, car elle a passé deux commandes.
2. louis n'apparaît pas. tout simplement parce qu'il n'a aucune commande dans notre table commandes.

le JOIN qu'on vient d'utiliser est une jointure interne. aussi appelée inner join. elle conserve les associations qui existent dans les deux tables.

à retenir : 

- JOIN permet de combiner des informations de plusieurs tables. ON indique la condition qui relie leurs lignes.



chapitre 2 — partie 2 : écrire une jointure

jusqu'ici, on a compris pourquoi et comment on utilise JOIN. maintenant, on va apprendre à en écrire une sans modèle.

1. la structure d'une jointure

SELECT table1.colonne, table2.colonne
FROM table1
JOIN table2
ON table1.id = table2.table1_id;

- SELECT : quelles informations veux-tu afficher ?
- FROM : quelle est ta première table ?
- JOIN : quelle autre table veux-tu relier ?
- ON : quelles colonnes permettent d'associer les lignes ?

les noms table1, table2 et table1_id sont seulement des exemples. dans une vraie requête, tu utilises les noms de tes tables et de leurs colonnes.

prenons un nouvel exemple : 

table etudiants

id	nom
1	paul
2	amina
3	lucas

table notes

id	    etudiant_id	    matiere	    note
101	    1	            maths	    15
102	    2	            physique	17
103	    1	            physique	12
104	    3	            maths	    14

dans la table notes, la colonne etudiant_id indique à quel étudiant appartient chaque note.

par exemple : 

- etudiant_id = 1 correspond à paul.
- etudiant_id = 2 correspond à amina.
- etudiant_id = 3 correspond à lucas.


on veut afficher pour chaque note, le nom de l'etudiant, la matiere et la note obtenue : 

SELECT etudiants.nom, notes.matiere, notes.note
FROM etudiants
JOIN notes
ON etudiants.id = notes.etudiant_id;

résultat : 

nom	    matiere	    note
paul	maths	    15
amina	physique	17
paul	physique	12
lucas	maths	    14

chapitre 2 — partie 3 : les alias de tables

AS ne sert pas seulement à renommer une colonne dans le résultat. il existe une autre utilisation très pratique dans notre cas.

c'est donner un nom plus court à une table pendant une requête.

1. pourquoi utiliser des alias ?

regardons ensemble cette requête : 

SELECT etudiants.nom, notes.matiere, notes.note
FROM etudiants
JOIN notes
ON etudiants.id = notes.etudiant_id;

cette requête est correcte mais nous devons écrire etudiants et notes plusieurs fois.

on peut raccourcir en faisant : 

SELECT e.nom, n.matiere, n.note
FROM etudiants as e
JOIN notes as n
ON e.id = n.etudiant_id;

ici : 

- etudiants AS e : dans cette requête, e désigne la table etudiants.
- notes AS n : dans cette requête, n désigne la table notes.
- e.nom : la colonne nom de la table etudiants.
- n.matiere : la colonne matiere de la table notes.

2. attention à cette différence

on connait deux types d'alias maintenant : 

type d'alias	    exemple	                        rôle
alias de colonne	prix * stock AS valeur_stock	donne un nom au résultat d'un calcul
alias de table	    etudiants AS e	                donne un nom court à une table dans la requête

on peut même utiliser les deux dans une même requête.

il est important de savoir que AS est facultatif pour les alias de table dans sql. FROM etudiants e est aussi valide.

à retenir : 

un alias de table raccourcit son nom dans une requête. il ne modifie pas la table dans la base de données.



chapitre 2 — partie 4 : LEFT JOIN

1. le problème avec JOIN

revenons sur notre exemple avec les étudiants et leurs notes. reprenons les deux tables mais ajoutons une nouvelle étudiante qui se nomme ines.

table etudiants

id	nom
1	paul
2	amina
3	lucas
4	ines

table notes

id	    etudiant_id	    matiere	    note
101	    1	            maths	    15
102	    2	            physique	17
103	    1	            physique	12
104	    3	            maths	    14

remarque que ines n'a pas de note enregistrée.

exécutons cette requête qu'on connait déjà : 

SELECT e.nom, n.matiere, n.note
FROM etudiants e
JOIN notes n
ON e.id = n.etudiant_id;

résultat :

nom	    matiere	    note
paul	maths	    15
amina	physique	17
paul	physique	12
lucas	maths	    14

ines n'apparaît pas ici car aucune ligne de notes ne possède etudiant_id = 4.

c'est normal car JOIN qui signifie INNER JOIN conserve seulement les associations trouvées dans les deux tables.

mais imagine qu'on veut afficher tous les étudiants et même ceux qui n'ont pas de note.

comment faire alors ?

2. la solution : LEFT JOIN

regardons cette requête :

SELECT e.nom, n.matiere, n.note
FROM etudiants e
LEFT JOIN notes n
ON e.id = n.etudiant_id;

remarque qu'on a simplement remplacé JOIN par LEFT JOIN.

résultat :

nom	    matiere	    note
paul	maths	    15
paul	physique	12
amina	physique	17
lucas	maths	    14
ines	NULL	    NULL

cette fois ines apparaît. tout simplement parce que LEFT JOIN conserve toutes les lignes de la table située à gauche de la jointure, ici etudiants, même lorsqu'il n'existe aucune correspondance dans notes.

3. que signifie NULL ?

observe la dernière ligne : 

nom	    matiere	note
ines	NULL	NULL

NULL signifie que la valeur est absente ou inconnue dans le résultat.

ici, ines n'a aucune ligne correspondante dans notes. sql remplit donc ces colonnes avec NULL.

attention, car NULL n'est pas égal à 0. une note de 0 serait une vraie note enregistrée. NULL signifie qu'aucune note n'est disponible.

4. pourquoi appelle-t-on cela LEFT JOIN ?

regardons : 

FROM etudiants e
LEFT JOIN notes n

- etudiants --> table de gauche --> toutes les lignes sont conservées

- notes --> table de droite --> lignes associées si elles existent

la table etudiants est celle qui est située à gauche de LEFT JOIN. c'est donc elle qui garde toutes les lignes.

5. JOIN contre LEFT JOIN

JOIN (INNER JOIN) : 

- conserve uniquement les lignes qui ont une correspondance;
- ines n'est pas incluse;
- 4 lignes dans notre exemple

LEFT JOIN : 

- conserve toutes les lignes de la table de gauche;
- ines est incluse;
- 5 lignes dans notre exemple

à retenir : 

LEFT JOIN conserve toutes les lignes de la table de gauche même si il y a aucune correspondance dans la table de droite. les colonnes sans correspondance prennent alors la valeur NULL.



chapitre 2 — partie 5 : UNION

1. pourquoi utilise-t-on UNION ?

imaginons qu'on veut développer une application de vente de jeux vidéo.

on possède deux magasins, chacun avec sa propre table.

table magasin_lille
jeu
minecraft
fifa
gta

table magasin_paris
jeu
fortnite
gta
valorant

on connait déjà cette requête :

SELECT jeu
FROM magasin_lille;

elle affiche les trois jeux du magasin de lille.

mais imagine qu'on veut obtenir la liste de tous les jeux proposés par les deux magasins.

on pourrait exécuter deux requêtes séparément, mais ce n'est pas très pratique.

la solution est UNION

2. comment fonctionne UNION ?

SELECT jeu
FROM magasin_lille;

UNION

SELECT jeu
FROM magasin_paris;

observons la structure :
- première requête SELECT : les jeux de lille;
- UNION : réunir les deux résultats;
- deuxième requête SELECT : les jeux de paris.

voici ce qui se passe :

magasin_lille   magasin_paris

minecraft       fortnite

fifa            gta

gta             valorant

union
  |
  |
  v

résultat : 

minecraft

fifa

gta

fortnite

valorant

remarque importante : où est passé le deuxième gta ?

les deux magasins proposent gta, mais celui-ci apparaît une seule fois dans le résultat.

pourquoi ?

tout simplement parce que UNION élimine automatiquement les doublons.

tu te souviens de DISTINCT ? c'est le même principe d'élimination des doublons, mais cette fois sur le résultat combiné des deux requêtes.

3. les conditions pour utiliser UNION

les deux tables doivent avoir le même schéma relationnel. pour nos requêtes, retiens notamment que les résultats doivent avoir des colonnes compatibles.

par exemple : 

SELECT jeu, prix
FROM magasin_lille

UNION

SELECT jeu, prix
FROM magasin_paris;

cela fonctionne si les deux tables possèdent jeu et prix avec des types compatibles.

en revanche :

SELECT jeu, prix
FROM magasin_lille

UNION

SELECT jeu
FROM magasin_paris;

est incorrect la première requête retourne deux colonnes, tandis que la deuxième n'en retourne qu'une.

les deux résultats doivent avoir le même nombre de colonnes, dans un ordre compatible, avec des types de données compatibles.

autre précision : quand il y a plusieurs colonnes, UNION supprime les doublons sur la ligne entière, pas simplement sur une colonne.

4. différence entre JOIN et UNION

c'est le point le plus important de cette leçon.

JOIN	                                                            UNION
associe les informations de plusieurs tables selon une condition	réunit les lignes de plusieurs résultats
permet d'ajouter des colonnes provenant d'autres tables	            conserve le même nombre de colonnes
utilise généralement ON	                                            s'écrit entre deux requêtes SELECT

une image mentale simple :
- JOIN sert à mettre les informations côte à côte en reliant des lignes correspondantes;
- UNION sert à empiler deux ensembles de résultats et retirer les doublons.

à retenir : 

UNION réunit les résultats de deux requêtes SELECT, supprime les doublons et exige des colonnes compatibles.



chapitre 2 — partie 6 : INTERSECT

1. à quoi sert INTERSECT ?

on vient d'apprendre que UNION permet de réunir les membres de deux clubs.

mais imaginons maintenant qu'on veut retrouver uniquement les personnes qui appartiennent aux deux clubs en même temps.

reprenons les tables.

table club_a

membre
amina
paul
sara

table club_b

membre
paul
lucas
ines

regarde bien : paul est le seul membre présent dans les deux tables.

c'est exactement ce que permet INTERSECT.

2. comment fonctionne INTERSECT ?

SELECT membre
FROM club_a

INTERSECT

SELECT membre
FROM club_b;

SQL récupère les membres du premier résultat, puis ceux du deuxième, et conserve uniquement ceux qui sont présents dans les deux résultats.

résultat :

membre
paul

INTERSECT retourne uniquement les lignes communes aux deux résultats.

3. quelle différence entre UNION et INTERSECT ?

avec exactement les mêmes tables :

opération	résultat
UNION	    amina, paul, sara, lucas, ines
INTERSECT	paul

c'est donc très différent.

UNION signifie présent dans le premier ou le deuxième résultat, éventuellement les deux.

INTERSECT signifie présent dans le premier et le deuxième résultat.

les deux opérations suppriment les doublons par défaut.

comme pour UNION, les deux requêtes doivent retourner le même nombre de colonnes, avec des types compatibles.

à retenir : 

- INTERSECT conserve uniquement les lignes présentes dans les deux résultats.



chapitre 2 — partie 7 : EXCEPT

nous avons étudié deux opérations :
- union : les éléments présents dans au moins une des deux tables;
- intersect : les éléments présents dans les deux tables.

il reste une troisième opération importante qui est la différence entre deux ensembles.

1. comprendre EXCEPT

imagine qu'on organise deux activités dans ton école.

table basket

nom
paul
amina
lucas
ines

table football

nom
lucas
sara
paul
adam

on veut répondre à cette question :

quelles personnes pratiquent le basket, mais pas le football ?

observons les données : 
- paul pratique les deux sports --> on l'exclut.
- amina pratique seulement le basket --> on la conserve.
- lucas pratique les deux sports --> on l'exclut.
- ines pratique seulement le basket --> on la conserve.

résultat attendu :

nom
amina
ines

pour obtenir cela, on utilise EXCEPT.

2. la requête SQL

SELECT nom
FROM basket

EXCEPT

SELECT nom
FROM football;

comment SQL raisonne-t-il ?

il prend les noms présents dans le premier résultat, puis retire ceux qui apparaissent également dans le deuxième.

3. attention car l'ordre change le résultat !

c'est la principale difficulté avec EXCEPT.

comparons ces deux requêtes : 

requête a

SELECT nom 
FROM basket

EXCEPT

SELECT nom 
FROM football;

résultat : amina, ines.


requête b

SELECT nom 
FROM football

EXCEPT

SELECT nom 
FROM basket;

résultat : sara, adam.

pourquoi les résultats sont-ils différents ?

parce que EXCEPT signifie "prendre les éléments du premier résultat qui n'existent pas dans le deuxième".

si tu inverses les deux requêtes, tu inverses le sens de la différence.

contrairement à UNION et INTERSECT, l'ordre des deux résultats est donc essentiel.

comme les deux opérations précédentes, EXCEPT supprime les doublons par défaut et nécessite des colonnes compatibles.

à retenir : 

EXCEPT récupère les lignes présentes dans le premier résultat, mais absentes du deuxième.