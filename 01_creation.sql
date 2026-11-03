-- =====================================================
-- Projet  : Tifosi - Base de données du restaurant
-- Fichier : 01_creation.sql
-- Rôle    : Création de la base, de l'utilisateur
--           et du schéma (tables + contraintes)
-- SGBD    : MySQL
-- =====================================================


-- =====================================================
-- BASE DE DONNÉES
-- =====================================================

-- Réinitialisation : permet de relancer le script sans erreur
DROP DATABASE IF EXISTS tifosi;

-- Encodage utf8mb4 pour la prise en charge des accents
CREATE DATABASE tifosi
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE tifosi;


-- =====================================================
-- UTILISATEUR
-- =====================================================

DROP USER IF EXISTS 'tifosi'@'localhost';

-- Mot de passe de démonstration (environnement local uniquement)
CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'Tifosi2026!';

-- Droits d'administration limités à la base tifosi
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';

-- =====================================================
-- TABLES PRINCIPALES
-- =====================================================

-- ---------- MARQUE ----------
CREATE TABLE marque (
    id_marque INT AUTO_INCREMENT PRIMARY KEY,
    nom       VARCHAR(50) NOT NULL UNIQUE
);

-- ---------- BOISSON ----------
-- Relation "appartient" (1,1) : une boisson appartient à une seule marque
CREATE TABLE boisson (
    id_boisson INT AUTO_INCREMENT PRIMARY KEY,
    nom        VARCHAR(50) NOT NULL UNIQUE,
    id_marque  INT NOT NULL,
    CONSTRAINT fk_boisson_marque
        FOREIGN KEY (id_marque) REFERENCES marque(id_marque)
);

-- ---------- INGREDIENT ----------
CREATE TABLE ingredient (
    id_ingredient INT AUTO_INCREMENT PRIMARY KEY,
    nom           VARCHAR(50) NOT NULL UNIQUE
);

-- ---------- FOCACCIA ----------
CREATE TABLE focaccia (
    id_focaccia INT AUTO_INCREMENT PRIMARY KEY,
    nom         VARCHAR(50)  NOT NULL UNIQUE,
    prix        DECIMAL(5,2) NOT NULL,
    CONSTRAINT chk_focaccia_prix CHECK (prix > 0)
);

-- ---------- CLIENT ----------
CREATE TABLE client (
    id_client   INT AUTO_INCREMENT PRIMARY KEY,
    nom         VARCHAR(50)  NOT NULL,
    email       VARCHAR(150) NOT NULL UNIQUE,
    code_postal INT
);

-- =====================================================
-- TABLES DE LIAISON ET MENU
-- =====================================================

-- ---------- MENU ----------
-- Relation "est constitué" (1,1) : un menu repose sur une seule focaccia
CREATE TABLE menu (
    id_menu     INT AUTO_INCREMENT PRIMARY KEY,
    nom         VARCHAR(50)  NOT NULL UNIQUE,
    prix        DECIMAL(5,2) NOT NULL,
    id_focaccia INT NOT NULL,
    CONSTRAINT chk_menu_prix CHECK (prix > 0),
    CONSTRAINT fk_menu_focaccia
        FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
);

-- ---------- COMPREND ----------
-- Relation n,n entre focaccia et ingredient, avec la quantité en grammes
CREATE TABLE comprend (
    id_focaccia   INT NOT NULL,
    id_ingredient INT NOT NULL,
    quantite      INT NOT NULL,
    PRIMARY KEY (id_focaccia, id_ingredient),
    CONSTRAINT chk_comprend_quantite CHECK (quantite > 0),
    CONSTRAINT fk_comprend_focaccia
        FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
        ON DELETE CASCADE,
    CONSTRAINT fk_comprend_ingredient
        FOREIGN KEY (id_ingredient) REFERENCES ingredient(id_ingredient)
);

-- ---------- CONTIENT ----------
-- Relation n,n entre menu et boisson
CREATE TABLE contient (
    id_menu    INT NOT NULL,
    id_boisson INT NOT NULL,
    PRIMARY KEY (id_menu, id_boisson),
    CONSTRAINT fk_contient_menu
        FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
        ON DELETE CASCADE,
    CONSTRAINT fk_contient_boisson
        FOREIGN KEY (id_boisson) REFERENCES boisson(id_boisson)
);

-- ---------- ACHETE ----------
-- Relation n,n entre client et menu, historisée par date d'achat
CREATE TABLE achete (
    id_client  INT  NOT NULL,
    id_menu    INT  NOT NULL,
    date_achat DATE NOT NULL,
    PRIMARY KEY (id_client, id_menu, date_achat),
    CONSTRAINT fk_achete_client
        FOREIGN KEY (id_client) REFERENCES client(id_client),
    CONSTRAINT fk_achete_menu
        FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
);