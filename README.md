# SmartphoneDB

Projeto de banco de dados relacional desenvolvido para modelagem e consulta de dados de marcas, smartphones e proprietários, com foco em integridade, consistência e uso de SQL orientado a cenários reais.

[![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat\&logo=mysql\&logoColor=white)]()
[![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=flat\&logo=mariadb\&logoColor=white)]()
[![SQL](https://img.shields.io/badge/SQL-336791?style=flat\&logo=postgresql\&logoColor=white)]()

---

## 🎯 Proposta de Valor

Estruturar um banco de dados relacional consistente, aplicando boas práticas de modelagem, integridade referencial e consultas SQL com valor de negócio.

**Benefícios principais:**

* Modelagem relacional bem definida (incluindo relação N:N)
* Garantia de integridade e consistência dos dados
* Tipagem orientada ao domínio
* Consultas SQL aplicadas a cenários reais

---

## ⚙️ Funcionalidades

* Modelagem de entidades: marca, smartphone e proprietário
* Implementação de relacionamento N:N via tabela associativa
* Definição de constraints (PRIMARY KEY, FOREIGN KEY, UNIQUE)
* Inserção de dados iniciais para testes
* Consultas SQL com JOIN, agregações e subqueries
* Validação de regras de integridade e comportamento

---

## 🏗️ Arquitetura / Estrutura

Modelo relacional composto por quatro entidades principais:

* **marca** → fabricantes de dispositivos
* **smartphone** → dispositivos cadastrados
* **proprietario** → usuários dos dispositivos
* **proprietario_smartphone** → relação N:N entre usuários e dispositivos

Estrutura do projeto:

```bash
SmartphoneDB/
├── SmartphoneDB.sql
├── README.md
├── evidencias_execucao_01_consulta_agrupada.jpg
├── evidencias_execucao_02_listagem_tabelas.jpg
```

---

## 🔐 Segurança

* Integridade referencial com uso de FOREIGN KEY
* Restrição de exclusão com `ON DELETE RESTRICT`
* Remoção controlada em tabelas associativas com `ON DELETE CASCADE`
* Constraint `UNIQUE` para evitar duplicidade de dados
* Tipagem adequada para evitar inconsistências

---

## 🧰 Stack Tecnológica

* MySQL / MariaDB
* SQL (DDL e DML)

---

## 🚀 Instalação

### Pré-requisitos

* MySQL ou MariaDB em execução (ex.: XAMPP)

### Passos

1. Clonar o repositório
2. Acessar a pasta do projeto
3. Executar o script SQL

```bash
git clone https://github.com/seu-usuario/SmartphoneDB.git
cd SmartphoneDB
```

Execução do script:

```bash
mysql -u root -e "source SmartphoneDB.sql"
```

---

## 🧪 Testes Rápidos

**Checklist funcional:**

1. Validar criação das tabelas
2. Confirmar inserção dos dados iniciais
3. Executar consultas com JOIN
4. Validar agregações (COUNT, AVG)
5. Testar restrições de integridade (RESTRICT e CASCADE)

Consulta de validação:

```sql
SELECT p.nome, COUNT(ps.smartphone_id) AS total_smartphones
FROM proprietario p
LEFT JOIN proprietario_smartphone ps ON ps.proprietario_id = p.id
GROUP BY p.id, p.nome
ORDER BY total_smartphones DESC;
```

---

## 📸 Screenshots

![Diagrama ER](https://i.imgur.com/rl2wzTo.jpeg)

![Consulta agrupada por proprietário](evidencias_execucao_01_consulta_agrupada.jpg)

![Listagem de tabelas](evidencias_execucao_02_listagem_tabelas.jpg)

---

## 👤 Autor

**Natan Da Luz**
Desenvolvedor de Software
