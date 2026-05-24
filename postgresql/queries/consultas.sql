-- Consulta 1
-- Cantidad de órdenes por estado
SELECT 
    order_status, 
    COUNT(*) AS cantidad_ordenes
FROM orders
GROUP BY order_status
ORDER BY cantidad_ordenes DESC;

-- Consulta 2
-- Los 5 productos más caros vendidos
SELECT 
    product_id, 
    price, 
    freight_value AS costo_envio
FROM order_items
ORDER BY price DESC
LIMIT 5;

-- Consulta 3
-- Total de ingresos agrupados por tipo de pago
SELECT 
    payment_type, 
    SUM(payment_value) AS dinero_recaudado
FROM order_payments
GROUP BY payment_type;

-- Consulta 4
-- Cantidad de clientes por estado
SELECT 
    zc.state AS estado, 
    COUNT(c.customer_id) AS total_clientes
FROM customers c
JOIN zip_codes zc ON c.customer_zip_code = zc.zip_code_prefix
GROUP BY zc.state
ORDER BY total_clientes DESC;