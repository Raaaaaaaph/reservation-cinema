-- Création de la base de données
CREATE DATABASE IF NOT EXISTS reservation_cinema;

-- Utilisation de la BDD
USE reservation_cinema;

-- Création des tables
CREATE TABLE utilisateur (
    id_utilisateur INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(20) NOT NULL,
    prenom VARCHAR(20) NOT NULL,
    email VARCHAR(30) UNIQUE NOT NULL ,
    mot_de_passe VARCHAR(60) NOT NULL
);

CREATE TABLE tarif (
    id_tarif INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    libelle VARCHAR(15) UNIQUE NOT NULL,
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
    libelle VARCHAR(30) UNIQUE NOT NULL,
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
    libelle VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE projection (
    id_projection INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    horaire DATETIME NOT NULL
);

CREATE TABLE version (
    id_version INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    libelle VARCHAR(10) UNIQUE NOT NULL
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

-- Remplissage des tables
INSERT INTO utilisateur (nom, prenom, email, mot_de_passe) VALUES
	('Demouy', 'Vanessa', 'vanessa.demouy@gmail.com', '$2y$10$jdY4NuBm1.y9fT3MSMJ7TuUzd1bUl/EHzSq1f0rQMnEWAePBUzBrW'),
	('Lunghini', 'Elsa', 'elsalunghini@yahoo.com', '$2y$10$7ZLqcGi02oSXGAukB4xH0eUv4Ym7HtupWWGIlb/dTVnJ5zwI8qEAm'),
	('Marchal', 'Catherine', 'marchal.catherine@outlook.fr', '$2y$10$oDz9CaG5IRggK8uq.Ia0XeHILJCFmHVEpuCiu9zmdB88uD/34hp9u'),
	('Wolfrom', 'Fabian', 'fab-wolf@gmail.com', '$2y$10$8sVc1jkJWNDMIJiQBzj9tu9FMg0dGrWC/gwKNybbQa2/NR5t45zJm'),
	('Baroche', 'Benjamin', 'benbaroche@gmail.com', '$2y$10$NRBPS2H1Rj9ajA3LNBk69uIgkpnA2Xigfu48lsiyzLShrvJaUPVbm'),
	('Benhamour', 'Rebecca', 'rebecca.benhamour@outlook.fr', '$2y$10$KjZ5O3a2rJnunavIE5egx.3G3EBMliziXpIi1t0f8PtqcmuxRyCMO'),
	('Pons', 'Aurélie', 'pons-aurelie@gmail.com', '$2y$10$TuoS7IarkPwI3dXOv2LCZuQGqWEBkEoqbYNxJN4P/l2Wv7/0qpnw6'),
	('Rémiens', 'Clément', 'clement.remiens@gmail.com', '$2y$10$W98wEry6bONlUUosXUynbODLYFM6VrZsXhzKSr1Nkw5AIp6bRhXqe'),
	('Anselmo', 'Nicolas', 'nico.enselmo@gmail.com', '$2y$10$KdzVj49TfbvEcfYsEMlLaeo98Unrf5pErSTuFk6E0SMLnKpL.2/0a'),
	('Davydzenka', 'Catherine', 'catherineda@gmail.com', '$2y$10$WXcMwRcFFJL0fX83rM8zouRW9LGxRkMR.tuUn/gJCcRtDbauh/QS6'),
	('Mittelstadt', 'Mikael', 'mittelstadt-mikael@outlook.fr', '$2y$10$/QMCJNzaPOBzNpaHPz1HsOoj/pEra3.djIlc3JNgK8m.PXXLMwXAS'),
    ('Diefenthal', 'Frédéric', 'frederic.diefenthal@outlook.fr', '$2y$10$NpGhOjyx07dw8mQoknQkVO/GRnRHD/sXB49SfhCVbR602jynuqUBu'),
	('Galiana', 'Agustin', 'agustin-galiana@gmail.com', '$2y$10$4rAKCRpU0KnVneCT4tgBMuxwlZ2fbBpxq1j33KQojGEYnx70w1t.S'),
	('Passaniti', 'Lucia', 'lucia.passaniti@matret.fr', '$2y$10$YGFA/AMHQUZAqrcAFiR7V.WVoPvXVQBPGDyemVyjiFE7BbxqI5Nmy'),
	('Telle', 'Terence', 'terence.telle@gmail.com', '$2y$10$2ClCSGmlAgNBnSnQdIqVje7.GdUDcsszfVRArYjPMQM4l4BNAxR1m');

INSERT INTO administrateur (telephone, utilisateur) VALUES
	('0746869027', 1),
	('0635125688', 2),
	('0611438736', 3);

INSERT INTO proprietaire (nb_cinema, utilisateur) VALUES
	(2, 12),
	(1, 13),
	(5, 14),
	(3, 15);

INSERT INTO tarif (libelle, prix) VALUES
	('Plein tarif', 9.20),
	('Étudiant', 7.60),
	('Moins de 14 ans', 5.90);

INSERT INTO client (date_naissance, etudiant, carte_etudiante, utilisateur, tarif) VALUES
	('1991-06-01', false, '', 4, 1),
	('1971-05-22', false, '', 5, 1),
	('1997-06-25', true, '', 6, 2),
	('1996-04-03', true, '', 7, 2),
	('1997-10-15', true, '', 8, 2),
	('1998-06-21', true, '', 9, 2),
	('2008-05-02', false, '', 10, 3),
	('1997-01-02', true, '', 11, 2);

INSERT INTO ville (nom, code_postal) VALUES
	('Paris', 75000),
	('Marseille', 13000),
	('Lyon', 69000),
	('Toulouse', 31000),
	('Nice', 06000),
	('Nantes', 44000);

INSERT INTO cinema (nom, nb_salles, adresse, ville, proprietaire) VALUES
	('Gaumé CE', 13, '23 Av. des Champs-Élysées', 1, 4),
	('Gaumé MF', 8, '36 Av. du Maréchal Foch', 2, 4),
	('Gaumé Vaise', 9, '43 Rue de Docks', 3, 4),
	('Matret Bellecour', 10, '79 Rue de la République', 3, 3),
	('Matret Concorde', 7, '79 Bd de l\'Égalité', 6, 3),
	('Matret Rialto', 7, '4 Rue de Rivoli', 5, 3),
	('Matret Palais', 12, '170 Bd de Magenta', 1, 3),
	('Matret Galande', 5, '42 Rue Galande', 1, 3),
	('Le Wilson', 3, '3 PI. du Président Thomas Wilson', 4, 1),
	('Le Borderouge', 1, '59 Av. Maurice Bourgès-Maunoury', 4, 1),
	('L\'Équinox', 1, '13 Av. Berthelot', 3, 2);
