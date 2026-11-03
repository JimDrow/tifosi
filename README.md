# Tifosi - Base de données MySQL

Base de données du restaurant de street-food italien **Tifosi** :
focaccias, ingrédients, boissons, marques, menus et clients.

## Contenu du dépôt

| Fichier | Rôle |
|---|---|
| `01_creation.sql` | Création de la base `tifosi`, de l'utilisateur `tifosi` et du schéma (tables, clés, contraintes) |
| `02_insertion.sql` | Insertion des données de test (marques, boissons, ingrédients, focaccias, compositions) |
| `03_requetes.sql` | 10 requêtes de vérification, avec résultats attendus et obtenus |

## Installation

Prérequis : MySQL 8 ou supérieur.

Depuis le client MySQL, connecté en `root`, exécuter les scripts dans l'ordre :

```sql
SOURCE chemin/vers/01_creation.sql;
SOURCE chemin/vers/02_insertion.sql;
SOURCE chemin/vers/03_requetes.sql;
```

Le script `01_creation.sql` supprime puis recrée la base : il peut être relancé sans erreur.

## Schéma

- **Tables principales** : `marque`, `boisson`, `ingredient`, `focaccia`, `client`, `menu`
- **Tables de liaison** : `comprend` (focaccia ↔ ingrédient, avec quantité en grammes), `contient` (menu ↔ boisson), `achete` (client ↔ menu, avec date d'achat)

Sécurité des données : champs obligatoires (`NOT NULL`), valeurs uniques (`UNIQUE`), contraintes d'intégrité (`FOREIGN KEY`) et contrôles de valeurs (`CHECK` sur les prix et les quantités).