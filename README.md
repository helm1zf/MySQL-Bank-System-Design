# 🏦 Fadhali Bank: Full Relational Database Implementation
This project started as a university assignment, but I ended up putting a lot of work into the details to make it feel like a real banking system. I didn't want just a couple of tables; I wanted a fully functional environment where you could actually track money moving around.
**Presentation Grade: 1.7**| **Academic Bachelor Project** at Trier University of Applied Science

## 📖 Project Overview
This project is complete SQL implementation of a retail banking system called **Fadhali Bank**. [cite_start] It covers everything from customer management and branch organization to complex financial transactions and loan tracking.

## 🫆 The Blueprint (ER-Modell)
Before I touched any code, I mapped everything out in an ER-Modell.

* **The Logic**: It's not just a list of names; it's a web of how people, accounts, and staff actually interact.
* **Relationship**: I used specific linking tables like *haben* to connect customers to accounts and *erstellt_in* to track which branch opened which account.
* **Staffing** : I even added an *arbeiten_in* table to show which employees are assigned to which physical branch.

I designed this ER-Modell to ensure the database follow **Third Normal Form (3NF)** standards, preventing data redundancy while maintaining high performance for a banking environment.
* **Many-to-Many-Relationships**: I implemented the *haben* table to handle the complex of relationship where a customer can own multiple account, and an account can potentially have multiple owners (Joint Accounts).
* **Service Tracking**: The *bedienen* table is a "Weak Entity" relationship that logs the intersection of Employees and Customer
* **Separation of Concerns**:

## </> Breaking Down the Code
The script (fadhali_bank_schema ) does all the heavy thing lifting— from setting up the structure to filling it withmassive amount of test data.

### Structure and Constraint
I didnt just use standard settings. I added specific rules to keep the data clean:
* **Professional IDs**: I used AUTO_INCREMENT but set them to start at realistic numbers. For example, Customer start at 1001, Branches at 9002001 and Employees at 1000001
* **Safety Checks**: The ((bankkonto)) table has built-in checks to make sure you only enter valid account types like "Saving" or "Giro" and valid statuses like "Active" or "Suspended".
* **Cleanup**: I used ((on delete cascade)) in tables like *aufnehmen* and *arbeiten_in*, so if a record is deleted, the database cleans itself up automatically.

### The Transaction Ledger (*überweisen*)
This is my favorite part of the code. It's full log of every transaction. I filled it with real-world scenarios.
* **Regular stuff**: You'll see transfers for rent (Wohnmiete) and salaries (Gehalt)
* **The *Doner* Test**: I added small transaction for a "Döner Box" and set the status to abgelehnt (rejected) just to show how the system handles a failed payment.

### The Dataset
To make sure the queries actually return interesting results, I manually added:
* **19 Unique Customers** with different jobs, from Informatikers to teachers.
* **50 Employees** spread across 9 branches in cities like Trier, Wittlich, Bitburg, and Bonn


## 📊 Business Intelligence & Analytics
I wrote a set of complex SQL queries to simulate the kind of reports a real bank manager would need. You can find these in the (Anfrage_fadhali_bank.sql) file.
* **Spending & Income Analysis**: I built reports that join multiple tables to calculate the total money flowing in and out of every account, sorted to show the highest-spending customers.
* **Service Quality Tracking**: I created a query to filter for "ungenügend" (insufficient) ratings in the *bedienen* table to identify which staff members might need more training.
* **Logistics & Gaps**: I used **NOT EXISTS** logic to find customer who have an account but live in a city where we don't actually have a physical branch yet.
* **Staffing Overview**: A report that counts exactly how many employees are assigned to each specific branch location using **GROUP BY** logic.

## 🔍 How to Use it
1. **Build a Bank**: Run the .... .sql script in MySQL. It drops any old versions, creates the tables and seeds the data.
2. **Run Analytics**: Execute the queries in .....:SQL to see the business reports in actions.

### 📂 Repository Contents
* final_fadhali_bank.sql: Main script for database structure and data.
* Anfragen_Fadhali_bank.sql: Analytical business queries.
* mein Projekt.pdf: The original ER-Modell blueprint.


