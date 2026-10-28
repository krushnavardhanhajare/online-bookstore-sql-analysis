
-- =====================================================
-- Project: Online Bookstore SQL Analysis
-- Database: online_bookstore
-- Tool: MySQL
-- =====================================================

USE online_bookstore;


-- 1. Display all books
SELECT *
FROM book;


-- 2. Display all customers
SELECT *
FROM customers;


-- 3. Display all orders
SELECT *
FROM orders;


-- 4. Find books in the Fiction genre
SELECT *
FROM book
WHERE genre = 'Fiction';


-- 5. Find books published after 1950
SELECT *
FROM book
WHERE published_year > 1950;


-- 6. Find customers from Canada
SELECT *
FROM customers
WHERE country = 'Canada';


-- 7. Find orders placed in November 2023
-- Assumes order_date uses a compatible date format
SELECT *
FROM orders
WHERE STR_TO_DATE(order_date, '%d-%m-%Y')
      >= '2023-11-01'
  AND STR_TO_DATE(order_date, '%d-%m-%Y')
      < '2023-12-01';


-- 8. Calculate total book stock
SELECT SUM(stock) AS total_stock
FROM book;


-- 9. Find orders with quantity greater than one
SELECT
    o.order_id,
    c.name AS customer_name,
    o.book_id,
    o.quantity
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.quantity > 1;


-- 10. Find orders with total amount greater than 20
SELECT *
FROM orders
WHERE total_amount > 20;


-- 11. Total quantity sold by genre
SELECT
    b.genre,
    SUM(o.quantity) AS total_books_sold
FROM orders o
JOIN book b
    ON o.book_id = b.book_id
GROUP BY b.genre
ORDER BY total_books_sold DESC;


-- 12. Average price of Fantasy books
SELECT AVG(price) AS average_price
FROM book
WHERE genre = 'Fantasy';


-- 13. Customers who placed at least two orders
SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) >= 2;


-- 14. Most frequently ordered book by order count
SELECT
    b.book_id,
    b.title,
    COUNT(o.order_id) AS order_count
FROM orders o
JOIN book b
    ON o.book_id = b.book_id
GROUP BY b.book_id, b.title
ORDER BY order_count DESC
LIMIT 1;


-- 15. Top three most expensive Fantasy books
SELECT
    title,
    author,
    price
FROM book
WHERE genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;


-- 16. Total quantity sold by author
SELECT
    b.author,
    SUM(o.quantity) AS total_books_sold
FROM orders o
JOIN book b
    ON o.book_id = b.book_id
GROUP BY b.author
ORDER BY total_books_sold DESC;


-- 17. Customers who spent more than 30 in total
SELECT
    c.customer_id,
    c.name,
    c.city,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.city
HAVING SUM(o.total_amount) > 30
ORDER BY total_spent DESC;


-- 18. Highest-spending customer
SELECT
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 1;
