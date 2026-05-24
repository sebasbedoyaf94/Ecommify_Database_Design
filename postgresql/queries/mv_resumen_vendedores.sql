-- public.mv_resumen_vendedores source

CREATE MATERIALIZED VIEW public.mv_resumen_vendedores
TABLESPACE pg_default
AS SELECT seller_id,
    count(*) AS productos_vendidos,
    sum(price) AS total_facturado
   FROM order_items
  GROUP BY seller_id
WITH DATA;