# Ecommify Database Design

Guía de Despliegue y Ejecución de Base de Datos (PostgreSQL)

Para levantar el modelo relacional en PostgreSQL correctamente, los scripts SQL deben ejecutarse en un orden estricto para evitar errores de dependencias y llaves foráneas.

Se debe seguir la siguiente secuencia:

1. Creación del esquema base --> Se debe ejecutar el script principal de DDL para crear las tablas y estructura

        Archivo --> /postgresql/schema/ecommify.sql
   
3. Carga de semillas --> Se debe ejecutar en el siguiente orden:
     1. Categorías
          Archivo --> /postgresql/seed_data/categories.sql
     2. Códigos postales
          Archivo --> /postgresql/seed_data/zip_codes.sql
     3. Clientes
          Archivo --> /postgresql/seed_data/customers.sql
     4. Vendedores
          Archivo --> /postgresql/seed_data/sellers.sql
     5. Pedidos
          Archivo --> /postgresql/seed_data/orders.sql
     6. Productos pedido
          Archivo --> /postgresql/seed_data/order_items.sql
     7. Pago pedido
          Archivo --> /postgresql/seed_data/order_payments.sql

4. Creación de informes --> Una vez se tenga toda la información en la base de datos, se deben crear los siguientes scripts
     Archivo 1 --> /postgresql/queries/mv_resumen_vendedores.sql
     Archivo 2 --> /postgresql/queries/mv_ventas_por_ciudad.sql

5. Validación --> Ejecutar las consultas para validar que la carga de información fue exitosa
     Archivo --> /postgresql/queries/consultas.sql
