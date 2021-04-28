-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 27 avr. 2021 à 10:22
-- Version du serveur :  5.7.31
-- Version de PHP : 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `express_food`
--

-- --------------------------------------------------------

--
-- Structure de la table `administrator`
--

DROP TABLE IF EXISTS `administrator`;
CREATE TABLE IF NOT EXISTS `administrator` (
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `administrator`
--

INSERT INTO `administrator` (`user_id`) VALUES
(1);

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

DROP TABLE IF EXISTS `client`;
CREATE TABLE IF NOT EXISTS `client` (
  `address` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`address`, `user_id`) VALUES
('8 rue du Pinson, 8ème étage, Saint Geneviève des bois, 91700', 3);

-- --------------------------------------------------------

--
-- Structure de la table `deliverer`
--

DROP TABLE IF EXISTS `deliverer`;
CREATE TABLE IF NOT EXISTS `deliverer` (
  `longitude` decimal(9,6) DEFAULT NULL,
  `latitude` decimal(8,6) DEFAULT NULL,
  `status` varchar(45) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `deliverer`
--

INSERT INTO `deliverer` (`longitude`, `latitude`, `status`, `user_id`) VALUES
('0.000000', '0.000000', 'available', 2);

-- --------------------------------------------------------

--
-- Structure de la table `order`
--

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creation_date` datetime NOT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `deliverer_user_id` int(11) NOT NULL,
  `client_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_deliverer_user` (`deliverer_user_id`),
  KEY `fk_order_client_user` (`client_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `order`
--

INSERT INTO `order` (`id`, `creation_date`, `delivery_date`, `deliverer_user_id`, `client_user_id`) VALUES
(1, '2021-04-27 12:08:41', NULL, 2, 3);

-- --------------------------------------------------------

--
-- Structure de la table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text,
  `price_pretax` decimal(10,0) NOT NULL,
  `tva_in_percent` decimal(10,0) NOT NULL,
  `type` varchar(45) NOT NULL,
  `creation_date` datetime NOT NULL,
  `is_daily_product` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `product`
--

INSERT INTO `product` (`id`, `title`, `content`, `price_pretax`, `tva_in_percent`, `type`, `creation_date`, `is_daily_product`) VALUES
(1, 'Délice boursin', 'Burger au boursin et à l’escalope', '6', '20', 'plat', '2021-04-27 11:33:36', 1),
(2, 'Tiramisu Bueno', 'Tiramisu au kinder bueno', '3', '20', 'dessert', '2021-04-27 11:33:36', 1),
(3, 'Big One', 'Burger avec un steak', '5', '20', 'plat', '2021-04-27 11:33:36', 0),
(4, 'Tiramisu Daim', 'Tiramisu au daim', '3', '20', 'dessert', '2021-04-27 11:38:11', 1),
(5, 'Supreme', 'Sandwich au poulet', '6', '20', 'plat', '2021-04-27 11:39:58', 1);

-- --------------------------------------------------------

--
-- Structure de la table `product_order`
--

DROP TABLE IF EXISTS `product_order`;
CREATE TABLE IF NOT EXISTS `product_order` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `title` varchar(45) NOT NULL,
  `content` text,
  `price_pretax` decimal(10,0) NOT NULL,
  `tva_in_percent` decimal(10,0) NOT NULL,
  `type` varchar(45) NOT NULL,
  `ordering_delivery_date` datetime NOT NULL,
  `quantity_same_product` int(11) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `fk_product_order_product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `product_order`
--

INSERT INTO `product_order` (`order_id`, `product_id`, `title`, `content`, `price_pretax`, `tva_in_percent`, `type`, `ordering_delivery_date`, `quantity_same_product`) VALUES
(1, 1, 'Délice boursin', 'Burger au boursin et à l’escalope', '6', '20', 'plat', '2021-04-27 12:20:43', 2);

-- --------------------------------------------------------

--
-- Structure de la table `stock`
--

DROP TABLE IF EXISTS `stock`;
CREATE TABLE IF NOT EXISTS `stock` (
  `product_id` int(11) NOT NULL,
  `number_in_stock` int(11) NOT NULL,
  `deliverer_user_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`deliverer_user_id`),
  KEY `fk_stock_deliverer_user` (`deliverer_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `stock`
--

INSERT INTO `stock` (`product_id`, `number_in_stock`, `deliverer_user_id`) VALUES
(1, 8, 2),
(2, 4, 2);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `mail` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `creation_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `mail`, `password`, `creation_date`) VALUES
(1, 'Jean', 'Dujardin', 'jeandujardin@gmail.com', 'fHFdFKJdkf%85', '2021-04-27 11:03:08'),
(2, 'Gaspard', 'Proust', 'gaspardproust@gmail.com', 'fHTfgJdkf!49', '2021-04-27 11:14:09'),
(3, 'Blanche', 'Gardin', 'blanchegardin@gmail.com', 'hgnvoBINo9$', '2021-04-27 11:19:26');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `administrator`
--
ALTER TABLE `administrator`
  ADD CONSTRAINT `fk_administrator_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `fk_client_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `deliverer`
--
ALTER TABLE `deliverer`
  ADD CONSTRAINT `fk_deliverer_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `fk_order_client_user` FOREIGN KEY (`client_user_id`) REFERENCES `client` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_order_deliverer_user` FOREIGN KEY (`deliverer_user_id`) REFERENCES `deliverer` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `product_order`
--
ALTER TABLE `product_order`
  ADD CONSTRAINT `fk_product_order_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_product_order_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `fk_stock_deliverer_user` FOREIGN KEY (`deliverer_user_id`) REFERENCES `deliverer` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_stock_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
