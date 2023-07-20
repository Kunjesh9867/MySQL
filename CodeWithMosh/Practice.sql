USE sql_store;

SELECT o.order_id, o.product_id, name, quantity, o.unit_price
FROM order_items o
JOIN products p
ON o.product_id = p.product_id;

USE sql_store;
SELECT *
FROM order_items
JOIN sql_inventory.products
ON sql_store.order_items.product_id = sql_inventory.products.product_id;


USE sql_invoicing;
SELECT payment_id, clients.client_id,clients.name,address,city,state,date,amount,payment_methods.   name
FROM payments
JOIN clients ON payments.payment_id = clients.client_id
JOIN payment_methods ON payments.payment_id = payment_methods.payment_method_id;

USE sql_store;

SELECT p.product_id,
       p.name,
       order_items.quantity
FROM order_items
LEFT JOIN products p
    on order_items.product_id = p.product_id
ORDER BY product_id;


SELECT  order_date,
        order_id,
        first_name,
        s.name,
        os.name
FROM orders o
LEFT JOIN customers c on o.customer_id = c.customer_id
LEFT JOIN  shippers s on o.shipper_id = s.shipper_id
LEFT JOIN  order_statuses os on o.status = os.order_status_id
order by status;

USE sql_invoicing;
SELECT p.date,
       clients.name,
       amount,
       payment_methods.name
FROM payments p
LEFT JOIN  clients
    ON p.client_id = clients.client_id
LEFT JOIN payment_methods
    ON p.payment_method = payment_methods.payment_method_id;

-- UNION
USE sql_store;
SELECT customer_id,
       first_name,
       points,
       'Bronze' AS 'Type'
FROM customers
WHERE points<2000

UNION

SELECT customer_id,
       first_name,
       points,
       'Silver' AS 'Type'
FROM customers
WHERE points BETWEEN 2000 AND 3000

UNION

SELECT customer_id,
       first_name,
       points,
       'Gold' AS 'Type'
FROM customers
WHERE points>3000
ORDER BY first_name;