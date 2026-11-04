DATABASE NORMALISATION – CAMPUSCART
Introduction

Database normalisation is the process of organising data into related tables to minimise duplication, improve consistency and maintain data integrity.

First Normal Form (1NF)

The CampusCart database satisfies First Normal Form because each table contains atomic values, each record has a unique identifier, and repeating groups are avoided.

For example, individual products purchased in an order are stored separately in the Order_Items table rather than being stored as multiple product values in one Orders column.

Second Normal Form (2NF)

The database satisfies Second Normal Form because it satisfies 1NF and non-key attributes depend on the whole candidate key.

Product descriptions and product names are stored in the Products table rather than being unnecessarily repeated in Order_Items.

The combination of order_id and product_id is also unique in Order_Items.

Third Normal Form (3NF)

The database satisfies Third Normal Form because it satisfies 2NF and avoids unnecessary transitive dependencies.

For example, category information is stored in the Categories table, while Products references the category through category_id.

This prevents category names and descriptions from being repeatedly stored against individual products.

Conclusion

The CampusCart database design follows the principles of 1NF, 2NF and 3NF. This improves data consistency, reduces redundancy and supports efficient database management.
