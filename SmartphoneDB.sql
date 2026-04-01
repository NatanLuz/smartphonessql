
-- Projeto SQL com modelagem relacional enxuta e boas praticas.

CREATE DATABASE IF NOT EXISTS smartphone_db;
USE smartphone_db;

-- Permite reexecucao do script sem erro de dependencia.
DROP TABLE IF EXISTS proprietario_smartphone;
DROP TABLE IF EXISTS smartphone;
DROP TABLE IF EXISTS proprietario;
DROP TABLE IF EXISTS marca;


-- 1) Schema


CREATE TABLE marca (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT uq_marca_nome UNIQUE (nome)
) ENGINE=InnoDB;

CREATE TABLE proprietario (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(80) NOT NULL,
  idade TINYINT UNSIGNED NOT NULL,
  localizacao VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

CREATE TABLE smartphone (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  marca_id INT UNSIGNED NOT NULL,
  sistema_operacional ENUM('Android', 'iOS') NOT NULL,
  tela_polegadas DECIMAL(3,1) NOT NULL,
  memoria_ram_gb SMALLINT UNSIGNED NOT NULL,
  armazenamento_gb SMALLINT UNSIGNED NOT NULL,
  camera_mp SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (id),
  INDEX idx_smartphone_marca_id (marca_id),
  CONSTRAINT fk_smartphone_marca
    FOREIGN KEY (marca_id)
    REFERENCES marca (id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE proprietario_smartphone (
  proprietario_id INT UNSIGNED NOT NULL,
  smartphone_id INT UNSIGNED NOT NULL,
  data_associacao DATE NOT NULL DEFAULT (CURRENT_DATE),
  PRIMARY KEY (proprietario_id, smartphone_id),
  INDEX idx_ps_smartphone_id (smartphone_id),
  CONSTRAINT fk_ps_proprietario
    FOREIGN KEY (proprietario_id)
    REFERENCES proprietario (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_ps_smartphone
    FOREIGN KEY (smartphone_id)
    REFERENCES smartphone (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 2) Dados de exemplo ficticios


INSERT INTO marca (nome) VALUES
  ('Motorola'),
  ('Samsung'),
  ('Apple'),
  ('Google'),
  ('Xiaomi'),
  ('Huawei');

INSERT INTO proprietario (nome, idade, localizacao) VALUES
  ('Natan', 22, 'Jardim Figueiras'),
  ('Joao', 25, 'Sao Paulo'),
  ('Maria', 30, 'Rio de Janeiro'),
  ('Pedro', 28, 'Belo Horizonte'),
  ('Ana', 24, 'Brasilia'),
  ('Carla', 27, 'Curitiba');

INSERT INTO smartphone (
  marca_id,
  sistema_operacional,
  tela_polegadas,
  memoria_ram_gb,
  armazenamento_gb,
  camera_mp
) VALUES
  (1, 'Android', 6.5, 4, 128, 48),
  (2, 'Android', 6.2, 6, 64, 12),
  (3, 'iOS', 6.1, 6, 128, 12),
  (4, 'Android', 6.7, 8, 256, 108),
  (5, 'Android', 6.5, 8, 128, 108),
  (6, 'Android', 6.4, 6, 128, 50),
  (2, 'Android', 6.8, 12, 256, 200);

INSERT INTO proprietario_smartphone (proprietario_id, smartphone_id, data_associacao) VALUES
  (1, 1, '2025-01-10'),
  (1, 3, '2025-07-05'),
  (2, 2, '2024-11-20'),
  (3, 4, '2025-03-02'),
  (4, 5, '2025-05-18'),
  (5, 6, '2025-08-30');

-- 3) Consultas de negocio


-- Caso de uso: listar todos os smartphones e suas respectivas marcas.
SELECT
  s.id AS smartphone_id,
  m.nome AS marca,
  s.sistema_operacional,
  s.tela_polegadas,
  s.memoria_ram_gb,
  s.armazenamento_gb,
  s.camera_mp
FROM smartphone s
INNER JOIN marca m ON m.id = s.marca_id
ORDER BY m.nome, s.id;

-- Caso de uso: listar proprietarios com os smartphones que possuem.
SELECT
  p.nome AS proprietario,
  m.nome AS marca,
  s.id AS smartphone_id,
  s.sistema_operacional,
  s.memoria_ram_gb,
  ps.data_associacao
FROM proprietario p
INNER JOIN proprietario_smartphone ps ON ps.proprietario_id = p.id
INNER JOIN smartphone s ON s.id = ps.smartphone_id
INNER JOIN marca m ON m.id = s.marca_id
ORDER BY p.nome, ps.data_associacao;

-- Caso de uso: contar quantos smartphones cada proprietario possui.
SELECT
  p.id,
  p.nome,
  COUNT(ps.smartphone_id) AS total_smartphones
FROM proprietario p
LEFT JOIN proprietario_smartphone ps ON ps.proprietario_id = p.id
GROUP BY p.id, p.nome
ORDER BY total_smartphones DESC, p.nome;

-- Caso de uso: analisar media de RAM por marca (somente marcas com dispositivos).
SELECT
  m.nome AS marca,
  ROUND(AVG(s.memoria_ram_gb), 2) AS media_ram_gb,
  COUNT(s.id) AS total_modelos
FROM marca m
INNER JOIN smartphone s ON s.marca_id = m.id
GROUP BY m.id, m.nome
ORDER BY media_ram_gb DESC;

-- Caso de uso: identificar clientes sem dispositivos cadastrados.
SELECT
  p.id,
  p.nome,
  p.localizacao
FROM proprietario p
LEFT JOIN proprietario_smartphone ps ON ps.proprietario_id = p.id
WHERE ps.smartphone_id IS NULL
ORDER BY p.nome;

-- Caso de uso: listar smartphones Android com camera >= 50 MP e RAM >= 8 GB.
SELECT
  s.id,
  m.nome AS marca,
  s.sistema_operacional,
  s.memoria_ram_gb,
  s.camera_mp
FROM smartphone s
INNER JOIN marca m ON m.id = s.marca_id
WHERE s.sistema_operacional = 'Android'
  AND s.camera_mp >= 50
  AND s.memoria_ram_gb >= 8
ORDER BY s.camera_mp DESC;

-- Caso de uso: encontrar proprietarios que possuem smartphone acima da media geral de armazenamento (subquery).
SELECT DISTINCT
  p.id,
  p.nome
FROM proprietario p
INNER JOIN proprietario_smartphone ps ON ps.proprietario_id = p.id
INNER JOIN smartphone s ON s.id = ps.smartphone_id
WHERE s.armazenamento_gb > (
  SELECT AVG(s2.armazenamento_gb)
  FROM smartphone s2
)
ORDER BY p.nome;