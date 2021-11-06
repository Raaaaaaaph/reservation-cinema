-- Création de la base de données
CREATE DATABASE IF NOT EXISTS reservation_cinema;

-- Utilisation de la BDD
USE reservation_cinema;

-- Création des tables
CREATE TABLE utilisateur (
    id_utilisateur INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(20) NOT NULL,
    prenom VARCHAR(20) NOT NULL,
    email VARCHAR(30) NOT NULL,
    mot_de_passe VARCHAR(60) NOT NULL
);

CREATE TABLE tarif (
    id_tarif INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    libelle VARCHAR(10) NOT NULL,
    prix FLOAT NOT NULL
);

CREATE TABLE client (
    id_client INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    date_naissance DATE NOT NULL,
    etudiant BOOL NOT NULL,
    carte_etudiante BLOB
);

CREATE TABLE ticket (
    id_ticket INT PRIMARY KEY AUTO_INCREMENT NOT NULL
);

CREATE TABLE panier (
    id_panier INT PRIMARY KEY AUTO_INCREMENT NOT NULL
);

CREATE TABLE paiement (
    id_paiement INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    somme FLOAT NOT NULL
);

CREATE TABLE film (
    id_film INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    titre VARCHAR(50) NOT NULL,
    sortie DATE NOT NULL,
    synopsis TEXT NOT NULL
);

CREATE TABLE classification (
    id_classification INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    libelle VARCHAR(30) NOT NULL,
    icone BLOB
);

CREATE TABLE realisateur (
    id_realisateur INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(20) NOT NULL,
    prenom VARCHAR(20) NOT NULL,
    nationalite VARCHAR(20) NOT NULL
);

CREATE TABLE genre (
    id_genre INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    libelle VARCHAR(20) NOT NULL
);

CREATE TABLE projection (
    id_projection INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    horaire DATETIME NOT NULL
);

CREATE TABLE version (
    id_version INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    libelle VARCHAR(10) NOT NULL
);

CREATE TABLE ville (
    id_ville INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(20) NOT NULL,
    code_postal INT NOT NULL
);

CREATE TABLE cinema (
    id_cinema INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(30) NOT NULL,
    nb_salles INT NOT NULL,
    adresse TEXT NOT NULL
);

CREATE TABLE salle (
    id_salle INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    numero INT NOT NULL,
    nb_places INT NOT NULL
);

CREATE TABLE place (
    id_place INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    colonne VARCHAR(1) NOT NULL,
    ligne INT NOT NULL
);

CREATE TABLE proprietaire (
    id_proprietaire INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nb_cinema INT NOT NULL
);

CREATE TABLE administrateur (
    id_administrateur INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    telephone VARCHAR(10) NOT NULL
);

-- Ajout des relations entre les tables
ALTER TABLE client
ADD utilisateur INT NOT NULL,
ADD tarif INT NOT NULL,
ADD FOREIGN KEY (utilisateur) REFERENCES utilisateur(id_utilisateur),
ADD FOREIGN KEY (tarif) REFERENCES tarif(id_tarif);

ALTER TABLE ticket
ADD client INT,
ADD place INT NOT NULL,
ADD FOREIGN KEY (client) REFERENCES client(id_client),
ADD FOREIGN KEY (place) REFERENCES place(id_place);

ALTER TABLE panier
ADD client INT NOT NULL,
ADD ticket INT NOT NULL,
ADD FOREIGN KEY (client) REFERENCES client(id_client),
ADD FOREIGN KEY (ticket) REFERENCES ticket(id_ticket);

ALTER TABLE paiement
ADD ticket INT,
ADD panier INT,
ADD FOREIGN KEY (ticket) REFERENCES ticket(id_ticket),
ADD FOREIGN KEY (panier) REFERENCES panier(id_panier);

ALTER TABLE film
ADD classification INT NOT NULL,
ADD realisateur INT NOT NULL,
ADD genre INT NOT NULL,
ADD FOREIGN KEY (classification) REFERENCES classification(id_classification),
ADD FOREIGN KEY (realisateur) REFERENCES realisateur(id_realisateur),
ADD FOREIGN KEY (genre) REFERENCES genre(id_genre);

ALTER TABLE projection
ADD film INT NOT NULL,
ADD version INT NOT NULL,
ADD salle INT NOT NULL,
ADD FOREIGN KEY (film) REFERENCES film(id_film),
ADD FOREIGN KEY (version) REFERENCES version(id_version),
ADD FOREIGN KEY (salle) REFERENCES salle(id_salle);

ALTER TABLE cinema
ADD ville INT NOT NULL,
ADD proprietaire INT NOT NULL,
ADD FOREIGN KEY (ville) REFERENCES ville(id_ville),
ADD FOREIGN KEY (proprietaire) REFERENCES proprietaire(id_proprietaire);

ALTER TABLE salle
ADD cinema INT NOT NULL,
ADD FOREIGN KEY (cinema) REFERENCES cinema(id_cinema);

ALTER TABLE place
ADD salle INT NOT NULL,
ADD FOREIGN KEY (salle) REFERENCES salle(id_salle);

ALTER TABLE proprietaire
ADD utilisateur INT NOT NULL,
ADD FOREIGN KEY (utilisateur) REFERENCES utilisateur(id_utilisateur);

ALTER TABLE administrateur
ADD utilisateur INT NOT NULL,
ADD FOREIGN KEY (utilisateur) REFERENCES utilisateur(id_utilisateur);
