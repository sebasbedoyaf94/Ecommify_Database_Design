-- public.mv_ventas_por_ciudad source

CREATE MATERIALIZED VIEW public.mv_ventas_por_ciudad
TABLESPACE pg_default
AS SELECT z.city AS ciudad,
    count(o.order_id) AS total_compras,
    sum(oi.price) AS total_dinero
   FROM orders o
     JOIN customers c ON o.customer_id = c.customer_id
     JOIN zip_codes z ON c.customer_zip_code = z.zip_code_prefix
     JOIN order_items oi ON o.order_id = oi.order_id
  GROUP BY z.city
WITH DATA;