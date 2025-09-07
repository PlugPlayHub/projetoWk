-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: base_wk
-- ------------------------------------------------------
-- Server version	9.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `cliente` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(60) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `uf` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`cliente`),
  UNIQUE KEY `clientes_unique_1` (`nome`),
  KEY `idx_clientes_nome` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'JEAN CARLOS','RIBEIRÃO PRETO','SP'),(4,'MARIO JOSÉ','SÃO PAULO ','SP'),(5,'ANA CLARA','SANTOS','SP'),(6,'CECILIA BARBOSA','RIO DE JANEIRO','RJ'),(7,'ISABELA FERREIRA','AMAZONAS','AM'),(8,'LARISSA','FRANCA','SP'),(9,'CAROL','CENTRAL DE MINAS','MG'),(10,'KAUANNY','UBATUBA','SP'),(11,'ELISA','RIBERAO VERDE','SP'),(12,'SOPHIA','BELO HORIZONTE','MG'),(13,'MARCELO HENRIQUE MORAES','BELO HORIZONTE','MG');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido_venda`
--

DROP TABLE IF EXISTS `pedido_venda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido_venda` (
  `pedidov` int NOT NULL AUTO_INCREMENT,
  `cliente` int DEFAULT NULL,
  `data_emissao` date DEFAULT NULL,
  `Valor_total` decimal(15,2) DEFAULT NULL,
  `Total_qtde` int DEFAULT NULL,
  PRIMARY KEY (`pedidov`),
  KEY `fkcliente_idx` (`cliente`),
  CONSTRAINT `fkcliente` FOREIGN KEY (`cliente`) REFERENCES `clientes` (`cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido_venda`
--

LOCK TABLES `pedido_venda` WRITE;
/*!40000 ALTER TABLE `pedido_venda` DISABLE KEYS */;
INSERT INTO `pedido_venda` VALUES (9,5,'2025-09-06',343.39,6),(10,6,'2025-09-07',183.50,3);
/*!40000 ALTER TABLE `pedido_venda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto_pedidov`
--

DROP TABLE IF EXISTS `produto_pedidov`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto_pedidov` (
  `produto_pedidov` int NOT NULL AUTO_INCREMENT,
  `pedidov` int DEFAULT NULL,
  `produto` int DEFAULT NULL,
  `qtde` int DEFAULT NULL,
  `valor_unit` decimal(15,2) DEFAULT NULL,
  `valor_total` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`produto_pedidov`),
  KEY `fkproduto_idx` (`produto`),
  KEY `fmpedidov_idx` (`pedidov`),
  CONSTRAINT `fkproduto` FOREIGN KEY (`produto`) REFERENCES `produtos` (`produto`),
  CONSTRAINT `fmpedidov` FOREIGN KEY (`pedidov`) REFERENCES `pedido_venda` (`pedidov`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto_pedidov`
--

LOCK TABLES `produto_pedidov` WRITE;
/*!40000 ALTER TABLE `produto_pedidov` DISABLE KEYS */;
INSERT INTO `produto_pedidov` VALUES (47,10,11,2,56.80,113.60),(48,10,22,1,69.90,69.90),(64,9,11,1,10.00,10.00),(65,9,19,1,69.90,69.90),(66,9,22,1,69.90,69.90),(67,9,11,1,56.80,56.80),(68,9,25,1,79.99,79.99);
/*!40000 ALTER TABLE `produto_pedidov` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `produto` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(10) DEFAULT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  `preco_venda` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`produto`),
  UNIQUE KEY `produtos_unique` (`codigo`),
  KEY `idx_produtos_codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (3,'01','BUZINA DE BOI','32.9'),(11,'02','ANEL DE DEDINHO','56.8'),(12,'03','TINTA BRANCA FOSCO ','89.5'),(18,'04','SAPATO MASCULINO PRETO E BRANCO','11'),(19,'05','CHAPÉU','69.9'),(22,'06','BRACELETE','69.9'),(23,'07','CROPPED','56.73'),(24,'08','CALÇA','110.9'),(25,'09','SHORT-SAIA','79.99'),(26,'10','GLOSSILIOUS','80');
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'base_wk'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-07 11:16:23
