CREATE DATABASE IF NOT EXISTS reservation_cinema;
USE reservation_cinema;

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
    utilisateur INT NOT NULL,
    date_naissance DATE NOT NULL,
    etudiant BOOL NOT NULL,
    carte_etudiante BLOB,
    tarif INT NOT NULL,
    FOREIGN KEY (utilisateur) REFERENCES utilisateur(id_utilisateur),
    FOREIGN KEY (tarif) REFERENCES tarif(id_tarif)
);

CREATE TABLE ticket (
    id_ticket INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    client INT,
    FOREIGN KEY (client) REFERENCES client(id_client)
);

CREATE TABLE panier (
    id_panier INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    client INT NOT NULL,
    ticket INT NOT NULL,
    FOREIGN KEY (client) REFERENCES client(id_client),
    FOREIGN KEY (ticket) REFERENCES ticket(id_ticket)
);

CREATE TABLE paiement (
    id_paiement INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    somme FLOAT NOT NULL,
    ticket INT,
    panier INT,
    FOREIGN KEY (ticket) REFERENCES ticket(id_ticket),
    FOREIGN KEY (panier) REFERENCES panier(id_panier)
);

CREATE TABLE film (
    id_film INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    titre VARCHAR(50) NOT NULL,
    sortie DATE NOT NULL,
    synopsis TEXT NOT NULL,
    classification INT NOT NULL,
    realisateur INT NOT NULL,
    genre INT NOT NULL
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

ALTER TABLE film
ADD FOREIGN KEY (classification) REFERENCES classification(id_classification),
ADD FOREIGN KEY (realisateur) REFERENCES realisateur(id_realisateur),
ADD FOREIGN KEY (genre) REFERENCES genre(id_genre);

CREATE TABLE projection (
    id_projection INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    horaire DATETIME NOT NULL ,
    film INT NOT NULL,
    version INT NOT NULL,
    FOREIGN KEY (film) REFERENCES film(id_film)
);

CREATE TABLE version (
    id_version INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    libelle VARCHAR(10) NOT NULL
);

ALTER TABLE projection
ADD FOREIGN KEY (version) REFERENCES version(id_version);

CREATE TABLE ville (
    id_ville INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(20) NOT NULL,
    code_postal INT NOT NULL
);

CREATE TABLE cinema (
    id_cinema INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(30) NOT NULL,
    nb_salles INT NOT NULL,
    adresse TEXT NOT NULL,
    ville INT NOT NULL,
    FOREIGN KEY (ville) REFERENCES ville(id_ville)
);

CREATE TABLE salle (
    id_salle INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    numero INT NOT NULL,
    nb_places INT NOT NULL,
    cinema INT NOT NULL,
    FOREIGN KEY (cinema) REFERENCES cinema(id_cinema)
);

ALTER TABLE projection
ADD salle INT NOT NULL,
ADD FOREIGN KEY (salle) REFERENCES salle(id_salle);

CREATE TABLE place (
    id_place INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    colonne VARCHAR(1) NOT NULL,
    ligne INT NOT NULL,
    salle INT NOT NULL,
    FOREIGN KEY (salle) REFERENCES salle(id_salle)
);

ALTER TABLE ticket
ADD place INT NOT NULL,
ADD FOREIGN KEY (place) REFERENCES place(id_place);

CREATE TABLE proprietaire (
    id_proprietaire INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    utilisateur INT NOT NULL,
    nb_cinema INT NOT NULL,
    FOREIGN KEY (utilisateur) REFERENCES utilisateur(id_utilisateur)
);

ALTER TABLE cinema
ADD proprietaire INT NOT NULL,
ADD FOREIGN KEY (proprietaire) REFERENCES proprietaire(id_proprietaire);

CREATE TABLE administrateur (
    id_administrateur INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    utilisateur INT NOT NULL,
    telephone VARCHAR(10) NOT NULL,
    FOREIGN KEY (utilisateur) REFERENCES utilisateur(id_utilisateur)
);