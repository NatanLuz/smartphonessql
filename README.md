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
