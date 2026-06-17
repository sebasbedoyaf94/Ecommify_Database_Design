------ CREACIÓN DE ÍNDICES ------

-- Habilitación de extensión para optimización de texto
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- 1. Índices GIN para búsquedas difusas
CREATE INDEX categories_name_trgm_idx ON public.categories USING gin (category_name gin_trgm_ops);
CREATE INDEX zip_codes_city_trgm_idx ON public.zip_codes USING gin (city gin_trgm_ops);

-- 2. Índices b-tree en llaves foráneas
CREATE INDEX customers_customer_zip_code_idx ON public.customers USING btree (customer_zip_code);
CREATE INDEX orders_customer_id_idx ON public.orders USING btree (customer_id);
CREATE INDEX sellers_seller_zip_code_idx ON public.sellers USING btree (seller_zip_code);
CREATE INDEX order_items_order_id_idx ON public.order_items USING btree (order_id);
CREATE INDEX order_items_product_id_idx ON public.order_items USING btree (product_id);
CREATE INDEX order_items_seller_id_idx ON public.order_items USING btree (seller_id);
CREATE INDEX order_payments_order_id_idx ON public.order_payments USING btree (order_id);

-- 3. índices b-tree para control operativo
CREATE INDEX orders_order_status_idx ON public.orders USING btree (order_status);
CREATE INDEX order_payments_payment_type_idx ON public.order_payments USING btree (payment_type);