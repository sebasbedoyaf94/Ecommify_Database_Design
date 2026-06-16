------ CONSULTAS PARA ANALIZAR ------

-- Consulta 1: Búsqueda de categorías

EXPLAIN ANALYZE
SELECT category_name, category_translations
FROM public.categories
WHERE category_name like '%musi%'
  OR category_name like '%audio%';

-- Consulta 2: Búsqueda de ciudades

EXPLAIN ANALYZE
SELECT zip_code_prefix, city, state
FROM public.zip_codes
WHERE city like '%sao%'
  OR city like '%rio%';

-- Consulta 3: Historial de compras de un cliente

EXPLAIN ANALYZE
SELECT
   o.order_id,
   o.order_status,
   o.order_purchase_timestamp,
   i.product_id,
   i.price,
   p.payment_type,
   p.payment_value
FROM orders o
INNER JOIN order_items i ON o.order_id = i.order_id
INNER JOIN order_payments p ON o.order_id = p.order_id
INNER JOIN customers c ON c.customer_id = o.customer_id
WHERE c.customer_unique_id = '8d50f5ea-df50-201c-cdce-dfb9e2ac8455';

-- Consulta 4: Reporte de ventas totales por estado 'delivered'

EXPLAIN ANALYZE
SELECT
   o.order_status,
   COUNT(DISTINCT o.order_id) as total_orders,
   SUM(p.payment_value) as total_revenue
FROM public.orders o
INNER JOIN public.order_payments p ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY o.order_status;

-- Consulta 5: Reporte de ventas totales por estado 'canceled'

EXPLAIN ANALYZE
SELECT
   o.order_status,
   COUNT(DISTINCT o.order_id) as total_orders,
   SUM(p.payment_value) as total_revenue
FROM public.orders o
INNER JOIN public.order_payments p ON o.order_id = p.order_id
WHERE o.order_status = 'canceled'
GROUP BY o.order_status;
