# Ecommify - Arquitectura de Base de Datos Políglota Híbrida

## Universidad de La Sabana

### Maestría en Arquitectura de Software

**Equipo 27**

* Edgar Andrés Romero Otálora
* Jhon Alexander Tenjo Romero
* Julián David Miranda Leguizamón
* Sebastián Bedoya Flórez

---

# Resumen Ejecutivo

Ecommify es una plataforma de comercio electrónico diseñada para conectar compradores y vendedores dentro de un marketplace centralizado. El proyecto aborda el desafío de soportar simultáneamente operaciones transaccionales críticas y consultas analíticas de alta concurrencia mediante una arquitectura de persistencia políglota híbrida.

La solución implementa:

* **PostgreSQL** como motor transaccional (Write Model) para garantizar integridad referencial y propiedades ACID.
* **MongoDB** como motor analítico (Read Model) optimizado para consultas masivas y estructuras documentales flexibles.
* **Apache Kafka** como mecanismo de sincronización asíncrona entre ambos modelos mediante eventos.
* **Patrón Transactional Outbox** para garantizar consistencia eventual entre los motores.

El proyecto fue desarrollado utilizando el dataset público **Olist Brazilian E-Commerce**, compuesto por aproximadamente:

* 99.441 órdenes
* 103.886 pagos
* 112.650 productos vendidos
* Más de 1.000.000 registros geográficos

---

# Objetivo General

Diseñar, implementar y evaluar críticamente una arquitectura de base de datos híbrida (PostgreSQL + MongoDB) para una plataforma de comercio electrónico, garantizando:

* Consistencia transaccional para operaciones críticas.
* Disponibilidad para cargas analíticas.
* Escalabilidad horizontal.
* Optimización basada en evidencia mediante pruebas de rendimiento.

---

# Arquitectura de la Solución

La arquitectura implementa una separación de responsabilidades basada en patrones CQRS y persistencia políglota.

## Write Model - PostgreSQL

Responsable de:

* Clientes
* Órdenes
* Pagos
* Vendedores
* Categorías
* Items de pedidos

Características:

* Integridad referencial
* Propiedades ACID
* Índices B-Tree
* Índices GIN
* Extensiones PostgreSQL

## Read Model - MongoDB

Responsable de:

* Catálogo de productos
* Reseñas
* Geolocalización
* Consultas analíticas

Características:

* Esquemas flexibles
* Indexación geoespacial
* Aggregation Pipelines
* Diseño preparado para Sharding

## Sincronización

La sincronización entre PostgreSQL y MongoDB fue diseñada mediante:

* Apache Kafka
* Event Driven Architecture
* Transactional Outbox Pattern
* Dead Letter Queues (DLQ)
* Consumidores idempotentes

---

# Tecnologías Utilizadas

## PostgreSQL

* PostgreSQL 16+
* UUID
* JSONB
* PG_TRGM
* B-Tree Indexes
* GIN Indexes

## MongoDB

* MongoDB Atlas
* Aggregation Framework
* GeoJSON
* 2dsphere Indexes
* Replica Sets
* Sharding Design

## Herramientas

* Python
* SQLAlchemy
* Google Colab
* Supabase
* MongoDB Atlas
* Apache Kafka

---

# Estructura del Repositorio

```text
Ecommify_Database_Design
│
├── docs/
│   ├── Informe Técnico Integral
│   └── Presentación Ejecutiva
│
├── mongodb/
│
├── notebooks/
│   ├── PostgreSQL
│   └── MongoDB
│
├── postgresql/
│   ├── schema/
│   ├── seed_data/
│   └── scripts/
│
└── README.md
```

---

# Modelo de Datos

## PostgreSQL (Modelo Relacional)

Entidades principales:

* customers
* orders
* order_items
* order_payments
* sellers
* categories
* zip_codes

Características:

* Normalización
* Integridad referencial
* Llaves primarias UUID
* Restricciones FK
* Optimización mediante índices

---

## MongoDB (Modelo Documental)

Colecciones principales:

### products

Permite modelado polimórfico para diferentes categorías de productos.

### order_reviews

Permite almacenar reseñas y comentarios con estructura flexible.

### geolocation

Implementa almacenamiento geoespacial utilizando GeoJSON.

---

# Decisiones Arquitectónicas Destacadas

## PostgreSQL como Write Model

Se seleccionó PostgreSQL para garantizar:

* Consistencia
* Integridad
* Transacciones ACID

Particularmente importante para:

* Órdenes
* Pagos
* Clientes

---

## MongoDB como Read Model

Se seleccionó MongoDB para:

* Catálogo de productos
* Consultas masivas
* Analítica geográfica

Beneficios:

* Alta disponibilidad
* Escalabilidad horizontal
* Flexibilidad documental

---

## Patrón Transactional Outbox

Implementado para evitar:

* Pérdida de eventos
* Inconsistencia entre motores
* Problemas de doble escritura

---

## Estrategia de Indexación

### PostgreSQL

* Índices B-Tree
* Índices GIN

### MongoDB

* Índices compuestos
* Índices geoespaciales
* Índices sobre subdocumentos

---

# Teorema CAP

## PostgreSQL

Prioriza:

**Consistency + Availability**

Aplicado a:

* customers
* orders
* payments
* sellers

---

## MongoDB

Prioriza:

**Partition Tolerance + Availability**

Aplicado a:

* products
* order_reviews
* geolocation

---

# Resultados de Optimización

## PostgreSQL

### Mejoras obtenidas

* Búsquedas textuales: hasta 98%
* Historial de compras: hasta 72.5%
* Consultas agregadas: hasta 60%

### Técnicas utilizadas

* EXPLAIN ANALYZE
* Índices B-Tree
* Índices GIN

---

## MongoDB

| Colección     | Mejora |
| ------------- | ------ |
| Products      | 14.8%  |
| Order Reviews | 69.6%  |
| Geolocation   | 99.4%  |

### Caso Destacado

La colección geolocation fue optimizada mediante:

* Deduplicación de datos
* Índices compuestos
* Diseño geoespacial

Resultado:

* 2.000.326 documentos → 6.349 documentos
* Aceleración de 162x

---

# Escalabilidad

La arquitectura contempla crecimiento futuro mediante:

## PostgreSQL

* Particionamiento futuro
* Réplicas de lectura
* Escalamiento vertical

## MongoDB

* Replica Sets
* Sharding geográfico
* Escalamiento horizontal

## Tecnologías Recomendadas

* Redis
* Elasticsearch / OpenSearch
* Prometheus
* Grafana

---

# Instalación y Ejecución

## PostgreSQL

### Paso 1: Crear Esquema

Archivo:

```text
/postgresql/schema/ecommify.sql
```

---

### Paso 2: Cargar Datos

Ejecutar en orden:

```text
/postgresql/seed_data/categories.sql
/postgresql/seed_data/zip_codes.sql
/postgresql/seed_data/customers.sql
/postgresql/seed_data/sellers.sql
/postgresql/seed_data/orders.sql
/postgresql/seed_data/order_items.sql
/postgresql/seed_data/order_payments.sql
```

---

### Paso 3: Línea Base

```text
/postgresql/scripts/explain_analyze_queries.sql
```

---

### Paso 4: Crear Índices

```text
/postgresql/scripts/create_indexes.sql
```

---

### Paso 5: Validar Mejoras

Ejecutar nuevamente:

```text
/postgresql/scripts/explain_analyze_queries.sql
```

---

# MongoDB

Ejecutar los scripts correspondientes a:

* Creación de colecciones

ubicados en:

```text
/mongodb/
```

---

# Benchmark y Pruebas

Las pruebas fueron desarrolladas utilizando:

* SQLAlchemy
* ThreadPoolExecutor
* Google Colab
* Explain Analyze
* MongoDB Explain Plans

Se evaluaron:

* Rendimiento
* Concurrencia
* Throughput
* Latencia
* Escalabilidad

---

# Demostración

Video del proyecto:

https://drive.google.com/file/d/1gLuvvcFAIjP6vYv9EPix4bRiQnUB7fh7/view?usp=sharing

Repositorio:

https://github.com/sebasbedoyaf94/Ecommify_Database_Design

---

# Documentación

La documentación completa se encuentra en:

```text
docs/
```

Incluye:

* Informe técnico integral
* Arquitectura
* Modelado relacional
* Modelado documental
* Teorema CAP
* Estrategia de indexación
* Pruebas de rendimiento
* Escalabilidad
* Recomendaciones para producción

---

# Conclusiones

La implementación de Ecommify permitió validar que una arquitectura híbrida basada en PostgreSQL y MongoDB ofrece una separación efectiva entre cargas transaccionales y analíticas.

Las optimizaciones implementadas demostraron mejoras medibles de rendimiento, mientras que las decisiones de diseño adoptadas preparan la plataforma para escenarios de crecimiento futuro mediante estrategias de escalamiento horizontal, replicación y procesamiento orientado a eventos.
