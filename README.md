## SmartphoneDB - Smartphone and Owner Database (Academic Project)

Database project to manage smartphone brands, owners, and their relationships.
(Created and practiced as a college assignment)

This project consists of a database to store information about smartphone brands, owners, and the relationship between them.

How to Use
Clone or download this repository to your computer.

Import the SQL file into your database management system (e.g., MySQL, MariaDB).

Run the SQL scripts to create the database, tables, and insert sample data.

You can perform queries to explore information about brands, owners, and smartphones.

Customization
To add more brands or smartphones, edit the insertion scripts in the SQL code.

To add new owners, add them in the Proprietario table and associate them with smartphones in the SmartphonesDoProprietario table.

Database Structure
The database consists of four main tables:

Marca: Stores smartphone brands.

Proprietario: Stores smartphone owners’ data.

Smartphone: Stores technical specifications of smartphones.

SmartphonesDoProprietario: Relates which owners own which smartphones (many-to-many relationship).

SQL Scripts
The project includes SQL scripts for:

Creating the database and tables.
Inserting sample data for brands, owners, and smartphones.
Associating smartphones with owners.

SQL Code Example:

CREATE DATABASE IF NOT EXISTS SmartphoneDB;
USE SmartphoneDB;

CREATE TABLE IF NOT EXISTS Marca (
  Codigo INT PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Proprietario (
  Codigo INT PRIMARY KEY AUTO_INCREMENT,
  Nome VARCHAR(50) NOT NULL,
  Idade TINYINT NOT NULL,
  Localizacao VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Smartphone (
  Codigo INT PRIMARY KEY AUTO_INCREMENT,
  Marca INT NOT NULL,
  SistemaOperacional VARCHAR(50) NOT NULL,
  Tela VARCHAR(50) NOT NULL,
  MemoriaRAM INT NOT NULL,
  ArmazenamentoInterno INT NOT NULL,
  Camera VARCHAR(50) NOT NULL,
  FOREIGN KEY (Marca) REFERENCES Marca(Codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS SmartphonesDoProprietario(
  CodigoDoProprietario INT NOT NULL,
  CodigoDoSmartphone INT NOT NULL,
  PRIMARY KEY (CodigoDoProprietario, CodigoDoSmartphone),
  FOREIGN KEY (CodigoDoProprietario) REFERENCES Proprietario(Codigo) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (CodigoDoSmartphone) REFERENCES Smartphone(Codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Marca (Nome) VALUES 
  ('Motorola'), 
  ('Samsung'), 
  ('Apple'), 
  ('Google'), 
  ('Xiaomi'), 
  ('Huawei');

INSERT INTO Proprietario (Nome, Idade, Localizacao) VALUES 
  ('Natan', 22, 'Jardim Figueiras'),
  ('João', 25, 'São Paulo'),
  ('Maria', 30, 'Rio de Janeiro'),
  ('Pedro', 28, 'Belo Horizonte'),
  ('Ana', 24, 'Brasília');

INSERT INTO Smartphone (Marca, SistemaOperacional, Tela, MemoriaRAM, ArmazenamentoInterno, Camera) VALUES 
  (1, 'Android', '6.5"', 4, 128, '48MP'),
  (2, 'Android', '6.2"', 6, 64, '12MP'),
  (3, 'iOS', '6.1"', 4, 64, '12MP'),
  (4, 'Android', '6.7"', 8, 256, '108MP'),
  (5, 'Android', '6.5"', 8, 128, '108MP'),
  (6, 'Android', '6.4"', 6, 128, '50MP');

-- Example of associating smartphones to owners
INSERT INTO SmartphonesDoProprietario (CodigoDoProprietario, CodigoDoSmartphone) VALUES 
    (1, 1),  -- Natan owns smartphone 1
    (2, 2),  -- João owns smartphone 2
    (3, 3),  -- Maria owns smartphone 3
    (4, 4),  -- Pedro owns smartphone 4
    (5, 5);  -- Ana owns smartphone 5
