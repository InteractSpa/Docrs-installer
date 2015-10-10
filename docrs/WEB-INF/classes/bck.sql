-- MySQL dump 10.13  Distrib 5.5.38, for debian-linux-gnu (x86_64)
--
-- Host: 10.1.1.106    Database: taskmanager
-- ------------------------------------------------------
-- Server version	5.5.38-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `convocation_documents`
--

DROP TABLE IF EXISTS `convocation_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `convocation_documents` (
  `convocation_id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  KEY `FK_cux2y9lw3jrowtdnr71wajvxp` (`document_id`),
  KEY `FK_6jno2b0l4gbtblgu1ne51rrdh` (`convocation_id`),
  CONSTRAINT `FK_6jno2b0l4gbtblgu1ne51rrdh` FOREIGN KEY (`convocation_id`) REFERENCES `convocations` (`id`),
  CONSTRAINT `FK_cux2y9lw3jrowtdnr71wajvxp` FOREIGN KEY (`document_id`) REFERENCES `day_orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `convocation_documents`
--

LOCK TABLES `convocation_documents` WRITE;
/*!40000 ALTER TABLE `convocation_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `convocation_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `convocations`
--

DROP TABLE IF EXISTS `convocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `convocations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` bit(1) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `modified` date DEFAULT NULL,
  `description` longtext,
  `end_date` datetime DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `owner_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_20amgufc7km8kqng7n7lbbduc` (`owner_id`),
  CONSTRAINT `FK_20amgufc7km8kqng7n7lbbduc` FOREIGN KEY (`owner_id`) REFERENCES `ldapuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `convocations`
--

LOCK TABLES `convocations` WRITE;
/*!40000 ALTER TABLE `convocations` DISABLE KEYS */;
INSERT INTO `convocations` VALUES (1,'\0','2014-10-15','2014-10-15','Seduta ordinaria','2014-10-16 20:30:49','2014-10-16 16:00:49','Convocazione di Giovedì 16 Ottobre 2014',1),(2,'\0','2014-10-17','2014-10-17','seduta ordinaria','2014-10-20 20:30:27','2014-10-20 16:00:27','seduta del Consiglio comunale del 20 ottobre 2014',1),(3,'\0','2014-10-22','2014-10-22','Seduta ordinaria','2014-10-23 20:30:43','2014-10-23 16:00:43','Seduta del Consiglio Comunale del 23 ottobre 2014',1),(4,'\0','2014-10-22','2014-10-27','Seduta ordinaria','2014-10-27 20:30:10','2014-10-27 16:00:10','Consiglio Comunale del 27 ottobre 2014',1),(5,'\0','2014-11-03','2014-11-03','Seduta ordinaria','2014-11-03 20:30:04','2014-11-03 16:00:04','Consiglio comunale del 3 novembre 2014',1);
/*!40000 ALTER TABLE `convocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `day_order_documents`
--

DROP TABLE IF EXISTS `day_order_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `day_order_documents` (
  `day_order_id` int(11) NOT NULL,
  `document_id` int(11) NOT NULL,
  KEY `FK_qf2uliqiou8x70g160h774l9q` (`document_id`),
  KEY `FK_4her77by694vxr7s5pcyujghv` (`day_order_id`),
  CONSTRAINT `FK_4her77by694vxr7s5pcyujghv` FOREIGN KEY (`day_order_id`) REFERENCES `day_orders` (`id`),
  CONSTRAINT `FK_qf2uliqiou8x70g160h774l9q` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `day_order_documents`
--

LOCK TABLES `day_order_documents` WRITE;
/*!40000 ALTER TABLE `day_order_documents` DISABLE KEYS */;
INSERT INTO `day_order_documents` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(15,2),(14,8),(14,10),(18,11),(18,13),(18,12),(18,14),(19,1),(21,11),(21,13),(21,12),(21,14),(22,15),(23,18),(27,18),(27,21),(28,23),(28,22);
/*!40000 ALTER TABLE `day_order_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `day_orders`
--

DROP TABLE IF EXISTS `day_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `day_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` bit(1) DEFAULT NULL,
  `description` longtext,
  `title` varchar(255) NOT NULL,
  `convocation_id` int(11) DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_1jcg2gk1agywhipwug40o1nf3` (`convocation_id`),
  KEY `FK_jqfkepqafdv8iyi9o0f69dugc` (`owner_id`),
  CONSTRAINT `FK_jqfkepqafdv8iyi9o0f69dugc` FOREIGN KEY (`owner_id`) REFERENCES `ldapuser` (`id`),
  CONSTRAINT `FK_1jcg2gk1agywhipwug40o1nf3` FOREIGN KEY (`convocation_id`) REFERENCES `convocations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `day_orders`
--

LOCK TABLES `day_orders` WRITE;
/*!40000 ALTER TABLE `day_orders` DISABLE KEYS */;
INSERT INTO `day_orders` VALUES (1,'\0','Commissione d\'inchiesta Galleria Vittorio Emanuele','Delibera N. 165',1,NULL),(2,'\0','Mozione del Consigliere Mascaretti: Fiume Seveso','Mozione 356',1,NULL),(3,'\0','Mozione dei Consiglieri De Corato ed Osnato: Revoca partecipazione Expo dell\'India','Mozione 304',1,NULL),(4,'\0','Mozione del Consigliere Sonego ed altri: Acquisto di 135 cacciabombardieri F35','Mozione 242',1,NULL),(5,'\0','Promozione per una regolamentazione territoriale ad hoc per i rapporti di collaborazione coordinata e continuativa anche a progetto.','O. d. G. del Consigliere Forte ed altri',1,NULL),(6,'\0','Adozione in comune di un sistema di gestione dell\'energia','Mozione del Consigliere Strada ed altri',1,NULL),(7,'\0','Mozione del Consigliere Biscardini ed altri, intitolazione di una piazza a Salvador Allende','Mozione 258',1,NULL),(14,'\0','Associazione Milano Smart City','delibera n. 181',2,NULL),(15,'\0','Fiume Seveso','Mozione IM/356 del Cons. Mascaretti',2,NULL),(18,'\0','Feste di quartiere','Delibera N. 140',2,NULL),(19,'\0','Commissione di Inchiesta sulla Galleria','Delibera N. 165',3,NULL),(21,'\0','Regolamento Feste di Quartiere','Delibera n. 140',3,NULL),(22,'\0','Interventi di demolizione e ricostruzione all\'interno dei Nuclei di Antica Formazione','Delibera n. 182',4,NULL),(23,'\0','Regolamento per riprese audiovisive','Delibera n. 185',4,NULL),(26,'\0','Interventi ai sensi dell\'art. 21 del Regolamento di Organizzazione e Funzionamento del Consiglio comunale','Articolo 21',5,NULL),(27,'\0','Regolamento per la disciplina delle riprese audiovisive delle sedute degli Organi collegiali del Comune di Milano','Delibera N/185',5,NULL),(28,'\0','Referendum popolari - Modifica degli articoli 11, 12, 13, 14 e 15 dello Statuto del Comune di Milano','Delibera N/155',5,NULL);
/*!40000 ALTER TABLE `day_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_tags`
--

DROP TABLE IF EXISTS `document_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_tags` (
  `document_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  UNIQUE KEY `UK_o99q5aq1f50g6ganja5nq4im` (`tag_id`,`document_id`),
  KEY `FK_riobwo6o2iijec0mdayxlrto4` (`document_id`),
  CONSTRAINT `FK_riobwo6o2iijec0mdayxlrto4` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`),
  CONSTRAINT `FK_gbnfd50vvir8ikhk3tg55o2sx` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_tags`
--

LOCK TABLES `document_tags` WRITE;
/*!40000 ALTER TABLE `document_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` bit(1) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `modified` date DEFAULT NULL,
  `content_type` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `permission` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `uiid` int(11) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `convocation_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_miifo0rx9fnctcrjj1bceevwk` (`convocation_id`),
  KEY `FK_cqhq2rrt2xlo7tx5lbwqugr23` (`user_id`),
  CONSTRAINT `FK_cqhq2rrt2xlo7tx5lbwqugr23` FOREIGN KEY (`user_id`) REFERENCES `ldapuser` (`id`),
  CONSTRAINT `FK_miifo0rx9fnctcrjj1bceevwk` FOREIGN KEY (`convocation_id`) REFERENCES `convocations` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` VALUES (1,'','2014-10-15','2014-11-03','application/pdf','165-2014.PDF','/home/ubuntu/WepPlatform/uploads1413373588882.PDF',NULL,1,0,NULL,NULL,NULL),(2,'','2014-10-15','2014-11-03','application/pdf','IM 356.pdf','/home/ubuntu/WepPlatform/uploads1413373735471.pdf',NULL,1,0,NULL,NULL,NULL),(3,'','2014-10-15','2014-11-03','application/pdf','IM 304.pdf','/home/ubuntu/WepPlatform/uploads1413373844427.pdf',NULL,1,0,NULL,NULL,NULL),(4,'','2014-10-15','2014-11-03','application/pdf','IM 242.pdf','/home/ubuntu/WepPlatform/uploads1413373930441.pdf',NULL,1,0,NULL,NULL,NULL),(5,'','2014-10-15','2014-11-03','application/pdf','IM 311.pdf','/home/ubuntu/WepPlatform/uploads1413374073210.pdf',NULL,1,0,NULL,NULL,NULL),(6,'','2014-10-15','2014-11-03','application/pdf','IM 341.pdf','/home/ubuntu/WepPlatform/uploads1413374147039.pdf',NULL,1,0,NULL,NULL,NULL),(7,'','2014-10-15','2014-11-03','application/pdf','IM 258.pdf','/home/ubuntu/WepPlatform/uploads1413374243147.pdf',NULL,1,0,NULL,NULL,NULL),(8,'','2014-10-17','2014-11-03','application/pdf','181-2014.PDF','/home/ubuntu/WepPlatform/uploads1413538722569.PDF',NULL,1,0,NULL,NULL,NULL),(9,'','2014-10-17','2014-10-17','application/pdf','emendamenti collegati alla n181.pdf','/home/ubuntu/WepPlatform/uploads1413540062231.pdf',NULL,1,0,NULL,NULL,NULL),(10,'','2014-10-17','2014-11-03','application/pdf','emendamenti collegati alla n181.pdf','/home/ubuntu/WepPlatform/uploads1413546314980.pdf',NULL,1,0,NULL,NULL,NULL),(11,'','2014-10-17','2014-11-03','application/pdf','140.PDF','/home/ubuntu/WepPlatform/uploads1413548628935.PDF',NULL,1,0,NULL,NULL,NULL),(12,'','2014-10-17','2014-11-03','application/pdf','da  87 al 112 (Emendamenti N-140 FESTE DI QUARTIERE).PDF','/home/ubuntu/WepPlatform/uploads1413548909836.PDF',NULL,1,0,NULL,NULL,NULL),(13,'','2014-10-17','2014-11-03','application/pdf','DA 1 A 86 (emendamenti N-140 FESTE DI QUARTIERE).PDF','/home/ubuntu/WepPlatform/uploads1413548910320.PDF',NULL,1,0,NULL,NULL,NULL),(14,'','2014-10-17','2014-11-03','application/pdf','da 113 a 114 (emendamenti N140 Feste Quartiere).PDF','/home/ubuntu/WepPlatform/uploads1413548910377.PDF',NULL,1,0,NULL,NULL,NULL),(15,'','2014-10-22','2014-11-03','application/pdf','182-2014.PDF','/home/ubuntu/WepPlatform/uploads1413983529555.PDF',NULL,1,0,NULL,NULL,NULL),(18,'','2014-10-22','2014-11-03','application/pdf','185-2014.pdf','/home/ubuntu/WepPlatform/uploads1413983668445.pdf',NULL,0,0,NULL,NULL,NULL),(19,'\0','2014-10-22','2014-10-22','application/pdf','185-2014.pdf','/home/ubuntu/WepPlatform/uploads1413983712029.pdf',NULL,0,0,NULL,NULL,NULL),(20,'','2014-11-03','2014-11-03','application/pdf','da 1 a 11.pdf','/home/ubuntu/WepPlatform/uploads1415010224619.pdf',NULL,1,0,NULL,NULL,NULL),(21,'\0','2014-11-03','2014-11-03','application/pdf','Emendamenti presentati alla N-185 da 1 a 11.pdf','/home/ubuntu/WepPlatform/uploads1415010340784.pdf',NULL,1,0,NULL,NULL,NULL),(22,'\0','2014-11-03','2014-11-03','application/pdf','EMENDAMENTI ALLA N-155.pdf','/home/ubuntu/WepPlatform/uploads1415010414968.pdf',NULL,1,0,NULL,NULL,NULL),(23,'','2014-11-03','2014-11-03','application/pdf','155.PDF','/home/ubuntu/WepPlatform/uploads1415010485841.PDF',NULL,1,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inserted_cards`
--

DROP TABLE IF EXISTS `inserted_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inserted_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inserted_cards`
--

LOCK TABLES `inserted_cards` WRITE;
/*!40000 ALTER TABLE `inserted_cards` DISABLE KEYS */;
/*!40000 ALTER TABLE `inserted_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ldap_users`
--

DROP TABLE IF EXISTS `ldap_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ldap_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` bit(1) DEFAULT NULL,
  `card_inserted` bit(1) DEFAULT NULL,
  `card` int(11) DEFAULT NULL,
  `domain_group` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `role_description` varchar(255) DEFAULT NULL,
  `seat` int(11) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `system_role` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_aus1qs9uxig4n4dqojwfxxwtu` (`card`),
  UNIQUE KEY `UK_jqv1t9gmita186mwpjukw0aj4` (`seat`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ldap_users`
--

LOCK TABLES `ldap_users` WRITE;
/*!40000 ALTER TABLE `ldap_users` DISABLE KEYS */;
INSERT INTO `ldap_users` VALUES (1,'\0','\0',1,'','Giuliano.Pisapia@comune.milano.it','Giuliano','welcome2014','Sindaco','',NULL,'Pisapia','USER','COMUNE-MILANO\\giuliano.pisapia'),(2,'\0','\0',53,'','Ada Lucia.De Cesaris@comune.milano.it','Ada Lucia','welcome2014','Vicesindaco, Assessore','Urbanistica, Edilizia Privata, Agricoltura',NULL,'De Cesaris','USER','COMUNE-MILANO\\adalucia.decesaris'),(3,'\0','\0',5,'','Daniela.Benelli@comune.milano.it','Daniela','welcome2014','Assessore','Area Metropolitana, Casa, Demanio',NULL,'Benelli','USER','COMUNE-MILANO\\Daniela.Benelli'),(4,'\0','\0',65,'','Francesco.Cappelli@comune.milano.it','Francesco','welcome2014','Assessore','Educazione e Istruzione',NULL,'Cappelli','USER','COMUNE-MILANO\\Francesco.Cappelli'),(5,'\0','\0',67,'','Filippo.Del Corno@comune.milano.it','Filippo','welcome2014','Assessore','Cultura',NULL,'Del Corno','USER','COMUNE-MILANO\\Filippo.DelCorno'),(6,'\0','\0',27,'','Pierfrancesco.Majorino@comune.milano.it','Pierfrancesco','welcome2014','Assessore','Politiche Sociali e Cultura della salute',NULL,'Majorino','USER','COMUNE-MILANO\\Pierfrancesco.Majori'),(7,'\0','\0',44,'','Maria Carmela.Rozza@comune.milano.it','Maria Carmela','welcome2014','Assessore','Lavori Pubblici e Arredo Urbano',NULL,'Rozza','USER','COMUNE-MILANO\\Maria.Rozza'),(8,'\0','\0',66,'','Francesca.Balzani@comune.milano.it','Francesca','welcome2014','Assessore','Bilancio, Patrimonio e Tributi',NULL,'Balzani','USER','COMUNE-MILANO\\Francesca.Balzani'),(9,'\0','\0',51,'','Chiara.Bisconti@comune.milano.it','Chiara','welcome2014','Assessore','Benessere, Qualità della vita, Sport e tempo libero, Risorse umane, Tutela degli animali, Verde, Servizi Generali',NULL,'Bisconti','USER','COMUNE-MILANO\\Chiara.Bisconti'),(10,'\0','\0',61,'','Franco.D\'Alfonso@comune.milano.it','Franco','welcome2014','Assessore','Commercio, Attivitˆ produttive, Turismo, Marketing territoriale, Servizi Civici',NULL,'D\'Alfonso','USER','COMUNE-MILANO\\Franco.DAlfonso'),(11,'\0','\0',22,'','Marco.Granelli@comune.milano.it','Marco','welcome2014','Assessore','Sicurezza e coesione sociale, Polizia locale, Protezione civile, Volontariato',NULL,'Granelli','USER','COMUNE-MILANO\\Marco.Granelli'),(12,'\0','\0',30,'','Pierfrancesco.Maran@comune.milano.it','Pierfrancesco','welcome2014','Assessore','Mobilitˆ. Ambiente, Metropolitane, Acqua pubblica, Energia',NULL,'Maran','USER','COMUNE-MILANO\\Pierfrancesco.Maran'),(13,'\0','\0',50,'','Cristina.Tajani@comune.milano.it','Cristina','welcome2014','Assessore','Politiche per il lavoro, Sviluppo economico, Universitˆ e ricerca',NULL,'Tajani','USER','COMUNE-MILANO\\Cristina.Tajani'),(14,'\0','\0',3,'Partito Democratico Pisapia Sindaco','Filippo.Barberis@comune.milano.it','Filippo','welcome2014','Consigliere','',NULL,'Barberis','USER','COMUNE-MILANO\\Filippo.Barberis'),(15,'\0','\0',7,'Partito Democratico Pisapia Sindaco','Lamberto.Bertole\'@comune.milano.it','Lamberto','welcome2014','Consigliere','Presidente gruppo',NULL,'Bertole\'','USER','COMUNE-MILANO\\Lamberto.Bertole'),(16,'\0','\0',9,'Partito Democratico Pisapia Sindaco','Paola.Bocci@comune.milano.it','Paola','welcome2014','Consigliere','',NULL,'Bocci','USER','COMUNE-MILANO\\Paola.Bocci'),(17,'\0','\0',58,'Partito Democratico Pisapia Sindaco','Elena .Buscemi@comune.milano.it','Elena ','welcome2014','Consigliere','',NULL,'Buscemi','USER','COMUNE-MILANO\\Elena.Buscemi'),(18,'\0','\0',13,'Partito Democratico Pisapia Sindaco','Natale Francesco.Comotti@comune.milano.it','Natale Francesco','welcome2014','Consigliere','',NULL,'Comotti','USER','COMUNE-MILANO\\Natale.Comotti'),(19,'\0','\0',14,'Partito Democratico Pisapia Sindaco','Marco .Cormio@comune.milano.it','Marco ','welcome2014','Consigliere','',NULL,'Cormio','USER','COMUNE-MILANO\\CormioM'),(20,'\0','\0',16,'Partito Democratico Pisapia Sindaco','Maria Anna.De Censi@comune.milano.it','Maria Anna','welcome2014','Consigliere','',NULL,'De Censi','USER','COMUNE-MILANO\\Maria.DeCensi'),(21,'\0','\0',57,'Partito Democratico Pisapia Sindaco','Francesco Maria.De Lisi@comune.milano.it','Francesco Maria','welcome2014','Consigliere','',NULL,'De Lisi','USER','COMUNE-MILANO\\Francesco.DeLisi'),(22,'\0','\0',18,'Partito Democratico Pisapia Sindaco','Andrea.Fanzago@comune.milano.it','Andrea','welcome2014','Consigliere','',NULL,'Fanzago','USER','COMUNE-MILANO\\FanzagoA'),(23,'\0','\0',55,'Partito Democratico Pisapia Sindaco','Ruggero Alberto.Gabbai@comune.milano.it','Ruggero Alberto','welcome2014','Consigliere','',NULL,'Gabbai','USER','COMUNE-MILANO\\Ruggero.Gabbai'),(24,'\0','\0',21,'Partito Democratico Pisapia Sindaco','David.Gentili@comune.milano.it','David','welcome2014','Consigliere','',NULL,'Gentili','USER','COMUNE-MILANO\\David.Gentili'),(25,'\0','',56,'Partito Democratico Pisapia Sindaco','Gabriele.Ghezzi@comune.milano.it','Gabriele','welcome2014','Consigliere','',NULL,'Ghezzi','USER','COMUNE-MILANO\\Gabriele.Ghezzi'),(26,'\0','',69,'Partito Democratico Pisapia Sindaco','Alessandro.Giungi@comune.milano.it','Alessandro','welcome2014','Consigliere','',NULL,'Giungi','USER','COMUNE-MILANO\\Alessandro.Giungi'),(27,'\0','',15,'Partito Democratico Pisapia Sindaco','Rosaria.Iardino@comune.milano.it','Rosaria','welcome2014','Consigliere','',NULL,'Iardino','USER','COMUNE-MILANO\\mariaRosaria.Iardino'),(28,'\0','',25,'Partito Democratico Pisapia Sindaco','Emanuele.Lazzarini@comune.milano.it','Emanuele','welcome2014','Consigliere','',NULL,'Lazzarini','USER','COMUNE-MILANO\\Emanuele.Lazzarini'),(29,'\0','\0',28,'Partito Democratico Pisapia Sindaco','Francesco.Mancuso@comune.milano.it','Francesco','welcome2014','Consigliere','',NULL,'Mancuso','USER','COMUNE-MILANO\\Francesco.Mancuso'),(30,'\0','\0',36,'Partito Democratico Pisapia Sindaco','Carlo.Monguzzi@comune.milano.it','Carlo','welcome2014','Consigliere','',NULL,'Monguzzi','USER','COMUNE-MILANO\\Carlo.Monguzzi'),(31,'\0','\0',40,'Partito Democratico Pisapia Sindaco','Rosario Leonardo.Pantaleo@comune.milano.it','Rosario Leonardo','welcome2014','Consigliere','',NULL,'Pantaleo','USER','COMUNE-MILANO\\Rosario.Pantaleo'),(32,'\0','\0',46,'Partito Democratico Pisapia Sindaco','Anna.Scavuzzo@comune.milano.it','Anna','welcome2014','Consigliere','',NULL,'Scavuzzo','USER','COMUNE-MILANO\\Anna.Scavuzzo'),(33,'\0','\0',59,'Partito Democratico Pisapia Sindaco','Mattia Mirko.Stanzani@comune.milano.it','Mattia Mirko','welcome2014','Consigliere','',NULL,'Stanzani','USER','COMUNE-MILANO\\Mattia.Stanzani'),(34,'\0','\0',60,'Sinistra Ecologia Libertˆ','Luca.Gibillini@comune.milano.it','Luca','welcome2014','Consigliere','',NULL,'Gibillini','USER','COMUNE-MILANO\\Luca.Gibillini'),(35,'\0','\0',34,'Sinistra Ecologia Libertˆ','Mirko.Mazzali@comune.milano.it','Mirko','welcome2014','Consigliere','',NULL,'Mazzali','USER','COMUNE-MILANO\\Mirko.Mazzali'),(36,'\0','\0',41,'Sinistra Ecologia Libertˆ','Ines.Quartieri@comune.milano.it','Ines','welcome2014','Consigliere','Presidente gruppo',NULL,'Quartieri','USER','COMUNE-MILANO\\Ines.Quartieri'),(37,'\0','\0',48,'Milano Civica per Pisapia Sindaco','Elisabetta Luisa.Strada@comune.milano.it','Elisabetta Luisa','welcome2014','Consigliere','Presidente gruppo',NULL,'Strada','USER','COMUNE-MILANO\\Elisabetta.Strada'),(38,'\0','',43,'Sinistra per Pisapia - Federazione della Sinistra','Basilio.Rizzo@comune.milano.it','Basilio','welcome2014','Consigliere, Presidente del Consiglio','',NULL,'Rizzo','USER','COMUNE-MILANO\\Basilio.Rizzo'),(39,'\0','\0',47,'Sinistra per Pisapia - Federazione della Sinistra','Anita.Sonego@comune.milano.it','Anita','welcome2014','Consigliere','Presidente gruppo',NULL,'Sonego','USER','COMUNE-MILANO\\Anita.Sonego'),(40,'\0','\0',23,'Valori per Milano','Raffaele.Grassi@comune.milano.it','Raffaele','welcome2014','Consigliere','Presidente gruppo',NULL,'Grassi','USER','COMUNE-MILANO\\Raffaele.Grassi'),(41,'\0','\0',12,'Gruppo Radicale - Federalista Europeo','Marco .Cappato@comune.milano.it','Marco ','welcome2014','Consigliere','Presidente gruppo',NULL,'Cappato','USER','COMUNE-MILANO\\Marco.Cappato'),(42,'\0','\0',64,'Forza Italia','Fabrizio.De Pasquale@comune.milano.it','Fabrizio','welcome2014','Consigliere','Presidente gruppo',NULL,'De Pasquale','USER','COMUNE-MILANO\\Fabrizio.DePasquale'),(43,'\0','\0',70,'Forza Italia','Gianluca.Comazzi@comune.milano.it','Gianluca','welcome2014','Consigliere','',NULL,'Comazzi','USER','COMUNE-MILANO\\Gianluca.Comazzi'),(44,'\0','\0',20,'Forza Italia','Giulio.Gallera@comune.milano.it','Giulio','welcome2014','Consigliere','',NULL,'Gallera','USER','COMUNE-MILANO\\GalleraG'),(45,'\0','',31,'Forza Italia','Andrea.Mascaretti@comune.milano.it','Andrea','welcome2014','Consigliere','',NULL,'Mascaretti','USER','COMUNE-MILANO\\MascarettiA'),(46,'\0','\0',39,'Forza Italia','Luigi.Pagliuca@comune.milano.it','Luigi','welcome2014','Consigliere','',NULL,'Pagliuca','USER','COMUNE-MILANO\\Luigi.Pagliuca'),(47,'\0','\0',42,'Forza Italia','Alan Christian.Rizzi@comune.milano.it','Alan Christian','welcome2014','Consigliere','',NULL,'Rizzi','USER','COMUNE-MILANO\\RizziA'),(48,'\0','\0',49,'Forza Italia','Pietro.Tatarella@comune.milano.it','Pietro','welcome2014','Consigliere','',NULL,'Tatarella','USER','COMUNE-MILANO\\Pietro.Tatarella'),(49,'\0','\0',6,'Forza Italia','Armando.Vagliati@comune.milano.it','Armando','welcome2014','Consigliere','',NULL,'Vagliati','USER','COMUNE-MILANO\\Armando.Vagliati'),(50,'\0','\0',4,'Lega Nord per l\'indipendenza della Padania','Massimiliano.Bastoni@comune.milano.it','Massimiliano','welcome2014','Consigliere','',NULL,'Bastoni','USER','COMUNE-MILANO\\Massimiliano.Bastoni'),(51,'\0','\0',45,'Lega Nord per l\'indipendenza della Padania','Igor.Iezzi@comune.milano.it','Igor','welcome2014','Consigliere','',NULL,'Iezzi','USER','COMUNE-MILANO\\Igor.Iezzi'),(52,'\0','\0',26,'Lega Nord per l\'indipendenza della Padania','Luca.Lepore@comune.milano.it','Luca','welcome2014','Consigliere','',NULL,'Lepore','USER','COMUNE-MILANO\\LeporeL'),(53,'\0','\0',37,'Lega Nord per l\'indipendenza della Padania','Alessandro.Morelli@comune.milano.it','Alessandro','welcome2014','Consigliere','Presidente gruppo',NULL,'Morelli','USER','COMUNE-MILANO\\Alessandro.Morelli'),(54,'\0','\0',33,'Movimento 5 stelle','Mattia.Calise@comune.milano.it','Mattia','welcome2014','Consigliere','Presidente gruppo',NULL,'Calise','USER','COMUNE-MILANO\\Mattia.Calise'),(55,'\0','\0',29,'Manfredi Palmeri','Manfredi.Palmeri@comune.milano.it','Manfredi','welcome2014','Consigliere','Presidente gruppo',NULL,'Palmeri','USER','COMUNE-MILANO\\Manfredi.Palmeri'),(56,'\0','\0',8,'Gruppo Misto','Roberto.Biscardini@comune.milano.it','Roberto','welcome2014','Consigliere','',NULL,'Biscardini','USER','COMUNE-MILANO\\Roberto.Biscardini'),(57,'\0','',17,'Gruppo Misto','Riccardo.De Corato@comune.milano.it','Riccardo','welcome2014','Consigliere','',NULL,'De Corato','USER','COMUNE-MILANO\\DeCoratoR'),(58,'\0','\0',38,'Gruppo Misto','Marco.Osnato@comune.milano.it','Marco','welcome2014','Consigliere','Presidente gruppo',NULL,'Osnato','USER','COMUNE-MILANO\\Marco.Osnato'),(59,'\0','\0',2,'Nuovo Centrodestra','Carmine.Abagnale@comune.milano.it','Carmine','welcome2014','Consigliere','',NULL,'Abagnale','USER','COMUNE-MILANO\\Carmine.Abagnale'),(60,'\0','\0',68,'Nuovo Centrodestra','Marcovalerio.Bove@comune.milano.it','Marcovalerio','welcome2014','Consigliere','Presidente gruppo',NULL,'Bove','USER','COMUNE-MILANO\\Marcovalerio.Bove'),(61,'\0','\0',19,'Nuovo Centrodestra','Matteo.Forte@comune.milano.it','Matteo','welcome2014','Consigliere','',NULL,'Forte','USER','COMUNE-MILANO\\Matteo.Forte'),(62,'\0','\0',0,'','Pierangelo.Cortesini@comune.milano.it','Pierangelo','welcome2014','Direttore Settore Presidenza del CC','',NULL,'Cortesini','USER','COMUNE-MILANO\\CortesiniP'),(64,'\0','',62,'','Sabrina.Zarini@comune.milano.it','Sabrina','welcome2014','Segreteria del CC','',NULL,'Zarini','SEGRETARY','COMUNE-MILANO\\Sabrina.Zarini'),(65,'\0','\0',1000,'','','Adalgisa','welcome2014','Segreteria del CC','',NULL,'Albanese','SEGRETARY','COMUNE-MILANO\\Adalgisa.Albanese'),(66,'\0','\0',1001,'','','Daniela','welcome2014','Segreteria del CC','',NULL,'Bonafin','SEGRETARY','COMUNE-MILANO\\Daniela.Bonafin'),(67,'\0','\0',1002,'','','Nadia','welcome2014','Segreteria del CC','',NULL,'Sacchi','SEGRETARY','COMUNE-MILANO\\Nadia.Sacchi'),(68,'\0','\0',1003,'','','Enza','welcome2014','Segreteria del CC','',NULL,'Cellamare','SEGRETARY','COMUNE-MILANO\\Enza.Cellamare'),(69,'\0','\0',1004,'','','Teresa','welcome2014','Segreteria del CC','',NULL,'Floriello','SEGRETARY','COMUNE-MILANO\\Teresa.Floriello'),(70,'\0','\0',1005,'','','Laura','welcome2014','Segretario Generale','',NULL,'Peroncini','SEGRETARY','COMUNE-MILANO\\Laura.Peroncini');
/*!40000 ALTER TABLE `ldap_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ldapuser`
--

DROP TABLE IF EXISTS `ldapuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ldapuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` bit(1) DEFAULT NULL,
  `domain_group` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `role_description` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `system_role` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ldapuser`
--

LOCK TABLES `ldapuser` WRITE;
/*!40000 ALTER TABLE `ldapuser` DISABLE KEYS */;
INSERT INTO `ldapuser` VALUES (1,'\0','','Giuliano.Pisapia@comune.milano.it','Giuliano','Sindaco','','Pisapia','USER','COMUNE-MILANO\\giuliano.pisapia',NULL),(2,'\0','','Ada Lucia.De Cesaris@comune.milano.it','Ada Lucia','Vicesindaco, Assessore','Urbanistica, Edilizia Privata, Agricoltura','De Cesaris','USER','COMUNE-MILANO\\adalucia.decesaris',NULL),(3,'\0','','Daniela.Benelli@comune.milano.it','Daniela','Assessore','Area Metropolitana, Casa, Demanio','Benelli','USER','COMUNE-MILANO\\Daniela.Benelli',NULL),(4,'\0','','Francesco.Cappelli@comune.milano.it','Francesco','Assessore','Educazione e Istruzione','Cappelli','USER','COMUNE-MILANO\\Francesco.Cappelli',NULL),(5,'\0','','Filippo.Del Corno@comune.milano.it','Filippo','Assessore','Cultura','Del Corno','USER','COMUNE-MILANO\\Filippo.DelCorno',NULL),(6,'\0','','Pierfrancesco.Majorino@comune.milano.it','Pierfrancesco','Assessore','Politiche Sociali e Cultura della salute','Majorino','USER','COMUNE-MILANO\\Pierfrancesco.Majori',NULL),(7,'\0','','Maria Carmela.Rozza@comune.milano.it','Maria Carmela','Assessore','Lavori Pubblici e Arredo Urbano','Rozza','USER','COMUNE-MILANO\\Maria.Rozza',NULL),(8,'\0','','Francesca.Balzani@comune.milano.it','Francesca','Assessore','Bilancio, Patrimonio e Tributi','Balzani','USER','COMUNE-MILANO\\Francesca.Balzani',NULL),(9,'\0','','Chiara.Bisconti@comune.milano.it','Chiara','Assessore','Benessere, Qualità della vita, Sport e tempo libero, Risorse umane, Tutela degli animali, Verde, Servizi Generali','Bisconti','USER','COMUNE-MILANO\\Chiara.Bisconti',NULL),(10,'\0','','Franco.D\'Alfonso@comune.milano.it','Franco','Assessore','Commercio, Attivitˆ produttive, Turismo, Marketing territoriale, Servizi Civici','D\'Alfonso','USER','COMUNE-MILANO\\Franco.DAlfonso',NULL),(11,'\0','','Marco.Granelli@comune.milano.it','Marco','Assessore','Sicurezza e coesione sociale, Polizia locale, Protezione civile, Volontariato','Granelli','USER','COMUNE-MILANO\\Marco.Granelli',NULL),(12,'\0','','Pierfrancesco.Maran@comune.milano.it','Pierfrancesco','Assessore','Mobilitˆ. Ambiente, Metropolitane, Acqua pubblica, Energia','Maran','USER','COMUNE-MILANO\\Pierfrancesco.Maran',NULL),(13,'\0','','Cristina.Tajani@comune.milano.it','Cristina','Assessore','Politiche per il lavoro, Sviluppo economico, Universitˆ e ricerca','Tajani','USER','COMUNE-MILANO\\Cristina.Tajani',NULL),(14,'\0','Partito Democratico Pisapia Sindaco','Filippo.Barberis@comune.milano.it','Filippo','Consigliere','','Barberis','USER','COMUNE-MILANO\\Filippo.Barberis',NULL),(15,'\0','Partito Democratico Pisapia Sindaco','Lamberto.Bertole\'@comune.milano.it','Lamberto','Consigliere','Presidente gruppo','Bertole\'','USER','COMUNE-MILANO\\Lamberto.Bertole',NULL),(16,'\0','Partito Democratico Pisapia Sindaco','Paola.Bocci@comune.milano.it','Paola','Consigliere','','Bocci','USER','COMUNE-MILANO\\Paola.Bocci',NULL),(17,'\0','Partito Democratico Pisapia Sindaco','Elena .Buscemi@comune.milano.it','Elena ','Consigliere','','Buscemi','USER','COMUNE-MILANO\\Elena.Buscemi',NULL),(18,'\0','Partito Democratico Pisapia Sindaco','Natale Francesco.Comotti@comune.milano.it','Natale Francesco','Consigliere','','Comotti','USER','COMUNE-MILANO\\Natale.Comotti',NULL),(19,'\0','Partito Democratico Pisapia Sindaco','Marco .Cormio@comune.milano.it','Marco ','Consigliere','','Cormio','USER','COMUNE-MILANO\\CormioM',NULL),(20,'\0','Partito Democratico Pisapia Sindaco','Maria Anna.De Censi@comune.milano.it','Maria Anna','Consigliere','','De Censi','USER','COMUNE-MILANO\\Maria.DeCensi',NULL),(21,'\0','Partito Democratico Pisapia Sindaco','Francesco Maria.De Lisi@comune.milano.it','Francesco Maria','Consigliere','','De Lisi','USER','COMUNE-MILANO\\Francesco.DeLisi',NULL),(22,'\0','Partito Democratico Pisapia Sindaco','Andrea.Fanzago@comune.milano.it','Andrea','Consigliere','','Fanzago','USER','COMUNE-MILANO\\FanzagoA',NULL),(23,'\0','Partito Democratico Pisapia Sindaco','Ruggero Alberto.Gabbai@comune.milano.it','Ruggero Alberto','Consigliere','','Gabbai','USER','COMUNE-MILANO\\Ruggero.Gabbai',NULL),(24,'\0','Partito Democratico Pisapia Sindaco','David.Gentili@comune.milano.it','David','Consigliere','','Gentili','USER','COMUNE-MILANO\\David.Gentili',NULL),(25,'\0','Partito Democratico Pisapia Sindaco','Gabriele.Ghezzi@comune.milano.it','Gabriele','Consigliere','','Ghezzi','USER','COMUNE-MILANO\\Gabriele.Ghezzi',NULL),(26,'\0','Partito Democratico Pisapia Sindaco','Alessandro.Giungi@comune.milano.it','Alessandro','Consigliere','','Giungi','USER','COMUNE-MILANO\\Alessandro.Giungi',NULL),(27,'\0','Partito Democratico Pisapia Sindaco','Rosaria.Iardino@comune.milano.it','Rosaria','Consigliere','','Iardino','USER','COMUNE-MILANO\\mariaRosaria.Iardino',NULL),(28,'\0','Partito Democratico Pisapia Sindaco','Emanuele.Lazzarini@comune.milano.it','Emanuele','Consigliere','','Lazzarini','USER','COMUNE-MILANO\\Emanuele.Lazzarini',NULL),(29,'\0','Partito Democratico Pisapia Sindaco','Francesco.Mancuso@comune.milano.it','Francesco','Consigliere','','Mancuso','USER','COMUNE-MILANO\\Francesco.Mancuso',NULL),(30,'\0','Partito Democratico Pisapia Sindaco','Carlo.Monguzzi@comune.milano.it','Carlo','Consigliere','','Monguzzi','USER','COMUNE-MILANO\\Carlo.Monguzzi',NULL),(31,'\0','Partito Democratico Pisapia Sindaco','Rosario Leonardo.Pantaleo@comune.milano.it','Rosario Leonardo','Consigliere','','Pantaleo','USER','COMUNE-MILANO\\Rosario.Pantaleo',NULL),(32,'\0','Partito Democratico Pisapia Sindaco','Anna.Scavuzzo@comune.milano.it','Anna','Consigliere','','Scavuzzo','USER','COMUNE-MILANO\\Anna.Scavuzzo',NULL),(33,'\0','Partito Democratico Pisapia Sindaco','Mattia Mirko.Stanzani@comune.milano.it','Mattia Mirko','Consigliere','','Stanzani','USER','COMUNE-MILANO\\Mattia.Stanzani',NULL),(34,'\0','Sinistra Ecologia Libertˆ','Luca.Gibillini@comune.milano.it','Luca','Consigliere','','Gibillini','USER','COMUNE-MILANO\\Luca.Gibillini',NULL),(35,'\0','Sinistra Ecologia Libertˆ','Mirko.Mazzali@comune.milano.it','Mirko','Consigliere','','Mazzali','USER','COMUNE-MILANO\\Mirko.Mazzali',NULL),(36,'\0','Sinistra Ecologia Libertˆ','Ines.Quartieri@comune.milano.it','Ines','Consigliere','Presidente gruppo','Quartieri','USER','COMUNE-MILANO\\Ines.Quartieri',NULL),(37,'\0','Milano Civica per Pisapia Sindaco','Elisabetta Luisa.Strada@comune.milano.it','Elisabetta Luisa','Consigliere','Presidente gruppo','Strada','USER','COMUNE-MILANO\\Elisabetta.Strada',NULL),(38,'\0','Sinistra per Pisapia - Federazione della Sinistra','Basilio.Rizzo@comune.milano.it','Basilio','Consigliere, Presidente del Consiglio','','Rizzo','USER','COMUNE-MILANO\\Basilio.Rizzo',NULL),(39,'\0','Sinistra per Pisapia - Federazione della Sinistra','Anita.Sonego@comune.milano.it','Anita','Consigliere','Presidente gruppo','Sonego','USER','COMUNE-MILANO\\Anita.Sonego',NULL),(40,'\0','Valori per Milano','Raffaele.Grassi@comune.milano.it','Raffaele','Consigliere','Presidente gruppo','Grassi','USER','COMUNE-MILANO\\Raffaele.Grassi',NULL),(41,'\0','Gruppo Radicale - Federalista Europeo','Marco .Cappato@comune.milano.it','Marco ','Consigliere','Presidente gruppo','Cappato','USER','COMUNE-MILANO\\Marco.Cappato',NULL),(42,'\0','Forza Italia','Fabrizio.De Pasquale@comune.milano.it','Fabrizio','Consigliere','Presidente gruppo','De Pasquale','USER','COMUNE-MILANO\\Fabrizio.DePasquale',NULL),(43,'\0','Forza Italia','Gianluca.Comazzi@comune.milano.it','Gianluca','Consigliere','','Comazzi','USER','COMUNE-MILANO\\Gianluca.Comazzi',NULL),(44,'\0','Forza Italia','Giulio.Gallera@comune.milano.it','Giulio','Consigliere','','Gallera','USER','COMUNE-MILANO\\GalleraG',NULL),(45,'\0','Forza Italia','Andrea.Mascaretti@comune.milano.it','Andrea','Consigliere','','Mascaretti','USER','COMUNE-MILANO\\MascarettiA',NULL),(46,'\0','Forza Italia','Luigi.Pagliuca@comune.milano.it','Luigi','Consigliere','','Pagliuca','USER','COMUNE-MILANO\\Luigi.Pagliuca',NULL),(47,'\0','Forza Italia','Alan Christian.Rizzi@comune.milano.it','Alan Christian','Consigliere','','Rizzi','USER','COMUNE-MILANO\\RizziA',NULL),(48,'\0','Forza Italia','Pietro.Tatarella@comune.milano.it','Pietro','Consigliere','','Tatarella','USER','COMUNE-MILANO\\Pietro.Tatarella',NULL),(49,'\0','Forza Italia','Armando.Vagliati@comune.milano.it','Armando','Consigliere','','Vagliati','USER','COMUNE-MILANO\\Armando.Vagliati',NULL),(50,'\0','Lega Nord per l\'indipendenza della Padania','Massimiliano.Bastoni@comune.milano.it','Massimiliano','Consigliere','','Bastoni','USER','COMUNE-MILANO\\Massimiliano.Bastoni',NULL),(51,'\0','Lega Nord per l\'indipendenza della Padania','Igor.Iezzi@comune.milano.it','Igor','Consigliere','','Iezzi','USER','COMUNE-MILANO\\Igor.Iezzi',NULL),(52,'\0','Lega Nord per l\'indipendenza della Padania','Luca.Lepore@comune.milano.it','Luca','Consigliere','','Lepore','USER','COMUNE-MILANO\\LeporeL',NULL),(53,'\0','Lega Nord per l\'indipendenza della Padania','Alessandro.Morelli@comune.milano.it','Alessandro','Consigliere','Presidente gruppo','Morelli','USER','COMUNE-MILANO\\Alessandro.Morelli',NULL),(54,'\0','Movimento 5 stelle','Mattia.Calise@comune.milano.it','Mattia','Consigliere','Presidente gruppo','Calise','USER','COMUNE-MILANO\\Mattia.Calise',NULL),(55,'\0','Manfredi Palmeri','Manfredi.Palmeri@comune.milano.it','Manfredi','Consigliere','Presidente gruppo','Palmeri','USER','COMUNE-MILANO\\Manfredi.Palmeri',NULL),(56,'\0','Gruppo Misto','Roberto.Biscardini@comune.milano.it','Roberto','Consigliere','','Biscardini','USER','COMUNE-MILANO\\Roberto.Biscardini',NULL),(57,'\0','Gruppo Misto','Riccardo.De Corato@comune.milano.it','Riccardo','Consigliere','','De Corato','USER','COMUNE-MILANO\\DeCoratoR',NULL),(58,'\0','Gruppo Misto','Marco.Osnato@comune.milano.it','Marco','Consigliere','Presidente gruppo','Osnato','USER','COMUNE-MILANO\\Marco.Osnato',NULL),(59,'\0','Nuovo Centrodestra','Carmine.Abagnale@comune.milano.it','Carmine','Consigliere','','Abagnale','USER','COMUNE-MILANO\\Carmine.Abagnale',NULL),(60,'\0','Nuovo Centrodestra','Marcovalerio.Bove@comune.milano.it','Marcovalerio','Consigliere','Presidente gruppo','Bove','USER','COMUNE-MILANO\\Marcovalerio.Bove',NULL),(61,'\0','Nuovo Centrodestra','Matteo.Forte@comune.milano.it','Matteo','Consigliere','','Forte','USER','COMUNE-MILANO\\Matteo.Forte',NULL),(62,'\0','','Pierangelo.Cortesini@comune.milano.it','Pierangelo','Direttore Settore Presidenza del CC','','Cortesini','USER','COMUNE-MILANO\\CortesiniP',NULL),(63,'\0','','Ileana.Music˜@comune.milano.it','Ileana','Segretario Generale','','Music˜','USER','COMUNE-MILANO\\Ileana.Musico',NULL),(64,'\0','','Sabrina.Zarini@comune.milano.it','Sabrina','Segreteria del CC','','Zarini','SEGRETARY','COMUNE-MILANO\\Sabrina.Zarini',NULL);
/*!40000 ALTER TABLE `ldapuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prefered_documents`
--

DROP TABLE IF EXISTS `prefered_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prefered_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` bit(1) DEFAULT NULL,
  `created` date DEFAULT NULL,
  `modified` date DEFAULT NULL,
  `document_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_94vt1twba0syubh7q0q4d0kfc` (`user_id`,`document_id`),
  KEY `FK_gohbr24pnguqaqvrdrccdmap3` (`document_id`),
  CONSTRAINT `FK_59fyw7bcprlte7nkxaggs0gu6` FOREIGN KEY (`user_id`) REFERENCES `ldapuser` (`id`),
  CONSTRAINT `FK_gohbr24pnguqaqvrdrccdmap3` FOREIGN KEY (`document_id`) REFERENCES `documents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prefered_documents`
--

LOCK TABLES `prefered_documents` WRITE;
/*!40000 ALTER TABLE `prefered_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `prefered_documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` bit(1) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `audio_path` varchar(255) DEFAULT NULL,
  `data` text NOT NULL,
  `subtitle_path` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `stream_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,'\0','2014-11-06 12:18:39',NULL,'ooo','uuu','yy','fsd','2');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deleted` bit(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-11-06 12:25:18

UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413373588882.PDF' WHERE `id`='1';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413373735471.pdf' WHERE `id`='2';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413373844427.pdf' WHERE `id`='3';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413373930441.pdf' WHERE `id`='4';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413374073210.pdf' WHERE `id`='5';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413374147039.pdf' WHERE `id`='6';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413374243147.pdf' WHERE `id`='7';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413538722569.PDF' WHERE `id`='8';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413540062231.pdf' WHERE `id`='9';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413546314980.pdf' WHERE `id`='10';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413548628935.PDF' WHERE `id`='11';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413548909836.PDF' WHERE `id`='12';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413548910320.PDF' WHERE `id`='13';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413548910377.PDF' WHERE `id`='14';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413983529555.PDF' WHERE `id`='15';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413983668445.pdf' WHERE `id`='18';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1413983712029.pdf' WHERE `id`='19';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1415010224619.pdf' WHERE `id`='20';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1415010340784.pdf' WHERE `id`='21';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/uploads1415010485841.PDF' WHERE `id`='23';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/1415299204909.jpg' WHERE `id`='28';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/1415299638857.jpg' WHERE `id`='29';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/1415368217549.pdf' WHERE `id`='30';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/1415368487767.pdf' WHERE `id`='31';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/1415368588764.pdf' WHERE `id`='32';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/1415368800110.pdf' WHERE `id`='33';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/1415368921960.pdf' WHERE `id`='34';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/1415369049273.pdf' WHERE `id`='35';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/1415369142518.pdf' WHERE `id`='36';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/1415369226394.pdf' WHERE `id`='37';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/1415369493149.pdf' WHERE `id`='38';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/1415369591651.pdf' WHERE `id`='39';
UPDATE `taskmanager`.`documents` SET `path`='/mnt/nas-master/cdm_management_uploads/1415369668165.pdf' WHERE `id`='40';
