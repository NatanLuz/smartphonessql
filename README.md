# SmartphoneDB - Banco de Dados de Smartphones e Proprietários

Este projeto consiste em um banco de dados para armazenar informações sobre marcas de smartphones, proprietários e a relação entre eles.

## Estrutura do Banco de Dados

O banco de dados é composto por quatro tabelas principais:

1. **Marca**: Armazena as marcas dos smartphones.
2. **Proprietario**: Armazena os dados dos proprietários dos smartphones.
3. **Smartphone**: Armazena as especificações técnicas dos smartphones.
4. **SmartphonesDoProprietario**: Relaciona quais proprietários possuem quais smartphones (relação muitos-para-muitos).

## Scripts SQL

O projeto inclui os scripts SQL para:

- Criação do banco de dados e das tabelas.
- Inserção de dados de exemplo para marcas, proprietários e smartphones.
- Associação de smartphones a proprietários.

### Código SQL

```sql
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

-- Exemplo de como associar smartphones a proprietários
INSERT INTO SmartphonesDoProprietario (CodigoDoProprietario, CodigoDoSmartphone) VALUES 
    (1, 1),  -- Natan possui o smartphone 1
    (2, 2),  -- João possui o smartphone 2
    (3, 3),  -- Maria possui o smartphone 3
    (4, 4),  -- Pedro possui o smartphone 4
    (5, 5);  -- Ana possui o smartphone 5
