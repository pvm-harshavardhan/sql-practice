# SQL Practice Database

This is a **work-in-progress** open-source SQL practice project.  

## What This Project Will Include

- **Database schema:** Tables for departments, employees, products, customers, orders, and more.
- **Sample data:** Realistic data for all tables.
- **Practice queries:** A variety of SQL exercises, from basic SELECTs to more advanced queries.
- **Learning resource:** A place to experiment, learn, and share SQL knowledge.

## Set Up the Database
- Open your MySQL client (such as MySQL Workbench, DBeaver, or the MySQL command line).
- Run the commands in `000.sql` to create the `sql_practice` database, tables, and populate them with sample data.

## Database Schema

The database models an e-commerce system with the following tables:

1. **departments** - Company departments with locations and budgets
2. **suppliers** - Product suppliers with contact information
3. **categories** - Product categories with descriptions
4. **customers** - Customer information including contact details and location
5. **employees** - Employee information with job titles, salaries, and department relationships
6. **products** - Product catalog with pricing, inventory, and category information
7. **orders** - Customer orders with status and shipping information
8. **order_details** - Line items for each order with quantity and pricing

## Entity Relationship Diagram (Draft)

```
+-------------+     +------------+     +------------+
| departments |     | suppliers  |     | categories |
+-------------+     +------------+     +------------+
       ↑                  ↑                  ↑
       |                  |                  |
+-------------+     +------------+     +------------+
| employees   |     | products   |<----| order_det. |
+-------------+     +------------+     +------------+
                           ↑                  ↑
                           |                  |
                    +------------+     +------------+
                    | customers  |---->| orders    |
                    +------------+     +------------+
```

---

***Contributions, suggestions, and feedback are welcome—feel free to open an issue or submit a pull request!***

---