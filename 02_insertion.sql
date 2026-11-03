-- =====================================================
-- Projet  : Tifosi - Base de données du restaurant
-- Fichier : 02_insertion.sql
-- Rôle    : Insertion des données de test
-- Source  : marque.xlsx, boisson.xlsx,
--           ingredient.xlsx, focaccia.xlsx
-- =====================================================

USE tifosi;

-- Garantit la bonne lecture des caractères accentués
SET NAMES utf8mb4;


-- =====================================================
-- MARQUE
-- =====================================================

INSERT INTO marque (id_marque, nom) VALUES
    (1, 'Coca-cola'),
    (2, 'Cristalline'),
    (3, 'Monster'),
    (4, 'Pepsico');


-- =====================================================
-- BOISSON
-- =====================================================

INSERT INTO boisson (id_boisson, nom, id_marque) VALUES
    (1,  'Coca-cola zéro',            1),
    (2,  'Coca-cola original',        1),
    (3,  'Fanta citron',              1),
    (4,  'Fanta orange',              1),
    (5,  'Capri-sun',                 1),
    (6,  'Pepsi',                     4),
    (7,  'Pepsi Max Zéro',            4),
    (8,  'Lipton zéro citron',        4),
    (9,  'Lipton Peach',              4),
    (10, 'Monster energy ultra gold', 3),
    (11, 'Monster energy ultra blue', 3),
    (12, 'Eau de source',             2);


-- =====================================================
-- INGREDIENT
-- =====================================================

INSERT INTO ingredient (id_ingredient, nom) VALUES
    (1,  'Ail'),
    (2,  'Ananas'),
    (3,  'Artichaut'),
    (4,  'Bacon'),
    (5,  'Base Tomate'),
    (6,  'Base crème'),
    (7,  'Champignon'),
    (8,  'Chevre'),
    (9,  'Cresson'),
    (10, 'Emmental'),
    (11, 'Gorgonzola'),
    (12, 'Jambon cuit'),
    (13, 'Jambon fumé'),
    (14, 'Oeuf'),
    (15, 'Oignon'),
    (16, 'Olive noire'),
    (17, 'Olive verte'),
    (18, 'Parmesan'),
    (19, 'Piment'),
    (20, 'Poivre'),
    (21, 'Pomme de terre'),
    (22, 'Raclette'),
    (23, 'Salami'),
    (24, 'Tomate cerise'),
    (25, 'Mozarella');


-- =====================================================
-- FOCACCIA
-- =====================================================

INSERT INTO focaccia (id_focaccia, nom, prix) VALUES
    (1, 'Mozaccia',        9.80),
    (2, 'Gorgonzollaccia', 10.80),
    (3, 'Raclaccia',       8.90),
    (4, 'Emmentalaccia',   9.80),
    (5, 'Tradizione',      8.90),
    (6, 'Hawaienne',       11.20),
    (7, 'Américaine',      10.80),
    (8, 'Paysanne',        12.80);

    -- =====================================================
-- COMPREND (composition des focaccias)
-- Format : (id_focaccia, id_ingredient, quantité en g)
-- Quantités par défaut issues de focaccia.xlsx,
-- sauf exceptions indiquées dans la recette
-- =====================================================

INSERT INTO comprend (id_focaccia, id_ingredient, quantite) VALUES
    -- 1. Mozaccia
    (1, 5, 200),   -- Base Tomate
    (1, 25, 50),   -- Mozarella
    (1, 9, 20),    -- Cresson
    (1, 13, 80),   -- Jambon fumé
    (1, 1, 2),     -- Ail
    (1, 3, 20),    -- Artichaut
    (1, 7, 40),    -- Champignon
    (1, 18, 50),   -- Parmesan
    (1, 20, 1),    -- Poivre
    (1, 16, 20),   -- Olive noire

    -- 2. Gorgonzollaccia
    (2, 5, 200),   -- Base Tomate
    (2, 11, 50),   -- Gorgonzola
    (2, 9, 20),    -- Cresson
    (2, 1, 2),     -- Ail
    (2, 7, 40),    -- Champignon
    (2, 18, 50),   -- Parmesan
    (2, 20, 1),    -- Poivre
    (2, 16, 20),   -- Olive noire

    -- 3. Raclaccia
    (3, 5, 200),   -- Base Tomate
    (3, 22, 50),   -- Raclette
    (3, 9, 20),    -- Cresson
    (3, 1, 2),     -- Ail
    (3, 7, 40),    -- Champignon
    (3, 18, 50),   -- Parmesan
    (3, 20, 1),    -- Poivre

    -- 4. Emmentalaccia
    (4, 6, 200),   -- Base crème
    (4, 10, 50),   -- Emmental
    (4, 9, 20),    -- Cresson
    (4, 7, 40),    -- Champignon
    (4, 18, 50),   -- Parmesan
    (4, 20, 1),    -- Poivre
    (4, 15, 20),   -- Oignon

    -- 5. Tradizione (quantités spécifiques : champignon, olives)
    (5, 5, 200),   -- Base Tomate
    (5, 25, 50),   -- Mozarella
    (5, 9, 20),    -- Cresson
    (5, 12, 80),   -- Jambon cuit
    (5, 7, 80),    -- Champignon (80 g)
    (5, 18, 50),   -- Parmesan
    (5, 20, 1),    -- Poivre
    (5, 16, 10),   -- Olive noire (10 g)
    (5, 17, 10),   -- Olive verte (10 g)

    -- 6. Hawaienne
    (6, 5, 200),   -- Base Tomate
    (6, 25, 50),   -- Mozarella
    (6, 9, 20),    -- Cresson
    (6, 4, 80),    -- Bacon
    (6, 2, 40),    -- Ananas
    (6, 19, 2),    -- Piment
    (6, 18, 50),   -- Parmesan
    (6, 20, 1),    -- Poivre
    (6, 16, 20),   -- Olive noire

    -- 7. Américaine (quantité spécifique : pomme de terre)
    (7, 5, 200),   -- Base Tomate
    (7, 25, 50),   -- Mozarella
    (7, 9, 20),    -- Cresson
    (7, 4, 80),    -- Bacon
    (7, 21, 40),   -- Pomme de terre (40 g)
    (7, 18, 50),   -- Parmesan
    (7, 20, 1),    -- Poivre
    (7, 16, 20),   -- Olive noire

    -- 8. Paysanne
    (8, 6, 200),   -- Base crème
    (8, 8, 50),    -- Chevre
    (8, 9, 20),    -- Cresson
    (8, 21, 80),   -- Pomme de terre
    (8, 13, 80),   -- Jambon fumé
    (8, 1, 2),     -- Ail
    (8, 3, 20),    -- Artichaut
    (8, 7, 40),    -- Champignon
    (8, 18, 50),   -- Parmesan
    (8, 20, 1),    -- Poivre
    (8, 16, 20),   -- Olive noire
    (8, 14, 50);   -- Oeuf