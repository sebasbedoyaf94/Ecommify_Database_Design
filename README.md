# Ecommify - Grupo E27

Integrantes: Edgar Andrés Romero, Jhon Alexander Tenjo, Julian David Miranda, Sebastián Bedoya Flórez

---

## Demostración del Proyecto

https://github.com/sebasbedoyaf94/Ecommify_Database_Design/blob/main/media/demo.mp4

---

## Componente Relacional (PostgreSQL)

Para levantar el modelo relacional en PostgreSQL correctamente, poblar el dataset de prueba y replicar el benchmark de rendimiento, los scripts SQL deben ejecutarse en el siguiente orden estricto para evitar errores de dependencias y llaves foráneas:

### Paso 1: Creación del Esquema Base
Cree una base de datos limpia en su gestor y ejecute el script de definición de datos. Este bloque inicial estructura las tablas y las restricciones básicas de llaves primarias y foráneas.

* **Archivo:** `/postgresql/schema/ecommify.sql`

### Paso 2: Carga de Semillas
Proceda a poblar las tablas con el dataset base de Ecommify. Este volumen simula un entorno real de producción para evaluar el comportamiento del motor.
 **Debe respetarse rigurosamente este orden de inserción:**
1. **Categorías:** `/postgresql/seed_data/categories.sql`
2. **Códigos Postales:** `/postgresql/seed_data/zip_codes.sql`
3. **Clientes:** `/postgresql/seed_data/customers.sql`
4. **Vendedores:** `/postgresql/seed_data/sellers.sql`
5. **Pedidos:** `/postgresql/seed_data/orders.sql`
6. **Productos Pedido:** `/postgresql/seed_data/order_items.sql`
7. **Pago Pedido:** `/postgresql/seed_data/order_payments.sql`

### Paso 3: Auditoría de Rendimiento Inicial (Línea Base)
Antes de aplicar optimizaciones o índices avanzados, ejecute el script de validación. Esto obligará a PostgreSQL a medir el costo computacional real y exponer los planes de ejecución por fuerza bruta (`Seq Scan`) sobre el esquema original.
* **Archivo:** `/postgresql/scripts/explain_analyze_queries.sql`

### Paso 4: Estrategia de Indexación
Aplique el script de optimización. Este archivo habilita la extensión nativa de trigramas y construye las estructuras indexadas (`B-Tree` y `GIN`) sobre las llaves foráneas y campos de control analizados para corregir cuellos de botella.
* **Archivo:** `/postgresql/scripts/create_indexeses.sql` 

### Paso 5: Verificación de Resultados
Vuelva a lanzar las consultas críticas del **Paso 3** (`/postgresql/scripts/explain_analyze_queries.sql`). Audite cómo el planificador conmuta de manera autónoma sus estrategias hacia nodos `Index Scan` y `Bitmap Heap Scan`, reduciendo drásticamente los tiempos de respuesta.

---
*Nota: Los detalles analíticos de las decisiones del optimizador y los scripts de automatización en Python se encuentran completamente documentados en los Notebooks de Google Colab adjuntos a esta entrega.*

