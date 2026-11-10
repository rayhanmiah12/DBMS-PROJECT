# 🎓 University Student Management System (Oracle SQL)

A comprehensive relational database project built using **Oracle SQL**. This system models a university's core operations, managing departments, teachers, students, course offerings, enrollments, and academic results.

---

## 🚀 Features & Modules

1. **DDL (Data Definition Language)**: 
   * Complete schema design with 6 core tables (`Department`, `Teacher`, `Student`, `Course`, `Enrollment`, `Result`).
   * Implements primary keys, foreign key constraints (`REFERENCES`), check constraints (`CHECK`), unique constraints, and schema modifications (`ALTER TABLE`).
2. **DML (Data Manipulation Language)**:
   * Sample data seeding for departments, faculty members, students, course allocations, semester enrollments, and exam results.
   * Demonstrates `UPDATE` and `DELETE` operations with transaction control (`COMMIT`).
3. **Filtering & Retrieval (`SELECT`)**:
   * Utilizes projections, column aliases, `DISTINCT`, calculated fields, and multi-condition filtering (`AND`, `OR`, `BETWEEN`, `IN`, `LIKE`, `IS NULL`).
4. **Sorting & Aggregations**:
   * Data ordering via `ORDER BY` (ascending/descending, multi-column).
   * Aggregate functions (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`) and null handling with `NVL`.
5. **Advanced SQL Queries**:
   * Grouping and filtering summaries using `GROUP BY` and `HAVING`.
   * Subqueries and correlated subqueries for complex analytical retrieval.
   * Multi-table relational joins connecting students, courses, results, and departments.

---

## 📂 Database Schema Overview

* **`Department`**: Stores faculty/department details (ID, name, head of department, established year).
* **`Teacher`**: Stores faculty member information, designations (Professor, Lecturer, etc.), salaries, and department links.
* **`Student`**: Manages student demographics, contact numbers, admission year, and department associations.
* **`Course`**: Tracks academic courses, credit hours, department ownership, and assigned teachers.
* **`Enrollment`**: Mapping table tracking student course registrations per semester.
* **`Result`**: Stores examination marks, calculated letter grades, and exam dates for enrolled students.

---

## 🛠️ Getting Started & Execution

To run this project locally on your Oracle database environment (such as Oracle SQL Developer or SQL*Plus):

1. Clone or download the repository:
   ```bash
   git clone [https://github.com/rayhanmiah12/DBMS-PROJECT.git](https://github.com/rayhanmiah12/DBMS-PROJECT.git)
