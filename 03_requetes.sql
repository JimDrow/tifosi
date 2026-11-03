-- =====================================================
-- Projet  : Tifosi - Base de données du restaurant
-- Fichier : 03_requetes.sql
-- Rôle    : Requêtes de vérification de la base
-- =====================================================

USE tifosi;
SET NAMES utf8mb4;


-- =====================================================
-- REQUÊTE 1
-- But : Afficher la liste des noms des focaccias
--       par ordre alphabétique croissant
-- =====================================================

SELECT nom
FROM focaccia
ORDER BY nom ASC;

-- Résultat attendu (8 lignes) :
--   Américaine, Emmentalaccia, Gorgonzollaccia, Hawaienne,
--   Mozaccia, Paysanne, Raclaccia, Tradizione
-- Résultat obtenu (8 lignes) :
--   Américaine, Emmentalaccia, Gorgonzollaccia, Hawaienne,
--   Mozaccia, Paysanne, Raclaccia, Tradizione
-- Écart : aucun. Note : la console Windows affiche
--   "Am├®ricaine", il s'agit d'un problème d'affichage
--   du terminal, la donnée est correctement encodée en UTF-8


-- =====================================================
-- REQUÊTE 2
-- But : Afficher le nombre total d'ingrédients
-- =====================================================

SELECT COUNT(*) AS nombre_ingredients
FROM ingredient;

-- Résultat attendu : 25
-- Résultat obtenu : 25
-- Écart : aucun


-- =====================================================
-- REQUÊTE 3
-- But : Afficher le prix moyen des focaccias
-- =====================================================

SELECT ROUND(AVG(prix), 2) AS prix_moyen
FROM focaccia;

-- Résultat attendu : 10.38
--   (somme des 8 prix = 83.00 / 8 = 10.375, arrondi à 10.38)
-- Résultat obtenu : 10.38
-- Écart : aucun


-- =====================================================
-- REQUÊTE 4
-- But : Afficher la liste des boissons avec leur marque,
--       triée par nom de boisson
-- =====================================================

SELECT b.nom AS boisson, m.nom AS marque
FROM boisson b
INNER JOIN marque m ON m.id_marque = b.id_marque
ORDER BY b.nom ASC;

-- Résultat attendu (12 lignes) :
--   Capri-sun (Coca-cola), Coca-cola original (Coca-cola),
--   Coca-cola zéro (Coca-cola), Eau de source (Cristalline),
--   Fanta citron (Coca-cola), Fanta orange (Coca-cola),
--   Lipton Peach (Pepsico), Lipton zéro citron (Pepsico),
--   Monster energy ultra blue (Monster),
--   Monster energy ultra gold (Monster),
--   Pepsi (Pepsico), Pepsi Max Zéro (Pepsico)
-- Résultat obtenu (12 lignes) : identique au résultat attendu
-- Écart : aucun (même remarque d'affichage des accents
--   dans la console Windows que pour la requête 1)


-- =====================================================
-- REQUÊTE 5
-- But : Afficher la liste des ingrédients pour une Raclaccia
-- =====================================================

SELECT i.nom AS ingredient, c.quantite
FROM comprend c
INNER JOIN focaccia f   ON f.id_focaccia   = c.id_focaccia
INNER JOIN ingredient i ON i.id_ingredient = c.id_ingredient
WHERE f.nom = 'Raclaccia';

-- Résultat attendu (7 lignes) :
--   Ail, Base Tomate, Champignon, Cresson,
--   Parmesan, Poivre, Raclette
-- Résultat obtenu (7 lignes) :
--   Ail (2), Base Tomate (200), Champignon (40), Cresson (20),
--   Parmesan (50), Poivre (1), Raclette (50)
-- Écart : aucun, résultat conforme à la recette de focaccia.xlsx


-- =====================================================
-- REQUÊTE 6
-- But : Afficher le nom et le nombre d'ingrédients
--       pour chaque focaccia
-- LEFT JOIN : une focaccia sans ingrédient serait
-- tout de même affichée, avec un total de 0
-- =====================================================

SELECT f.nom AS focaccia, COUNT(c.id_ingredient) AS nombre_ingredients
FROM focaccia f
LEFT JOIN comprend c ON c.id_focaccia = f.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY f.nom ASC;

-- Résultat attendu (8 lignes) :
--   Américaine (8), Emmentalaccia (7), Gorgonzollaccia (8),
--   Hawaienne (9), Mozaccia (10), Paysanne (12),
--   Raclaccia (7), Tradizione (9)
-- Résultat obtenu (8 lignes) :
--   Américaine (8), Emmentalaccia (7), Gorgonzollaccia (8),
--   Hawaienne (9), Mozaccia (10), Paysanne (12),
--   Raclaccia (7), Tradizione (9)
-- Écart : aucun


-- =====================================================
-- REQUÊTE 7
-- But : Afficher le nom de la focaccia
--       qui a le plus d'ingrédients
-- Gère le cas d'égalité : toutes les focaccias ayant
-- le nombre maximal d'ingrédients sont affichées
-- =====================================================

SELECT f.nom AS focaccia, COUNT(*) AS nombre_ingredients
FROM focaccia f
INNER JOIN comprend c ON c.id_focaccia = f.id_focaccia
GROUP BY f.id_focaccia, f.nom
HAVING COUNT(*) = (
    SELECT MAX(nb)
    FROM (
        SELECT COUNT(*) AS nb
        FROM comprend
        GROUP BY id_focaccia
    ) AS totaux
);

-- Résultat attendu : Paysanne (12)
-- Résultat obtenu : Paysanne (12)
-- Écart : aucun


-- =====================================================
-- REQUÊTE 8
-- But : Afficher la liste des focaccias
--       qui contiennent de l'ail
-- =====================================================

SELECT f.nom AS focaccia
FROM focaccia f
INNER JOIN comprend c   ON c.id_focaccia   = f.id_focaccia
INNER JOIN ingredient i ON i.id_ingredient = c.id_ingredient
WHERE i.nom = 'Ail'
ORDER BY f.nom ASC;

-- Résultat attendu (4 lignes) :
--   Gorgonzollaccia, Mozaccia, Paysanne, Raclaccia
-- Résultat obtenu (4 lignes) :
--   Gorgonzollaccia, Mozaccia, Paysanne, Raclaccia
-- Écart : aucun


-- =====================================================
-- REQUÊTE 9
-- But : Afficher la liste des ingrédients inutilisés
-- LEFT JOIN + IS NULL : on garde les ingrédients
-- sans aucune correspondance dans la table comprend
-- =====================================================

SELECT i.nom AS ingredient
FROM ingredient i
LEFT JOIN comprend c ON c.id_ingredient = i.id_ingredient
WHERE c.id_ingredient IS NULL
ORDER BY i.nom ASC;

-- Résultat attendu (2 lignes) : Salami, Tomate cerise
-- Résultat obtenu (2 lignes) : Salami, Tomate cerise
-- Écart : aucun


-- =====================================================
-- REQUÊTE 10
-- But : Afficher la liste des focaccias
--       qui n'ont pas de champignons
-- La sous-requête liste les focaccias contenant du
-- champignon, NOT IN les exclut du résultat final
-- =====================================================

SELECT f.nom AS focaccia
FROM focaccia f
WHERE f.id_focaccia NOT IN (
    SELECT c.id_focaccia
    FROM comprend c
    INNER JOIN ingredient i ON i.id_ingredient = c.id_ingredient
    WHERE i.nom = 'Champignon'
)
ORDER BY f.nom ASC;

-- Résultat attendu (2 lignes) : Américaine, Hawaienne
-- Résultat obtenu (2 lignes) : Américaine, Hawaienne
-- Écart : aucun (même remarque d'affichage des accents
--   dans la console Windows que pour la requête 1)
