# Baltimore Metal Crafters Database Management System

Java Swing application for managing restoration projects, customers, employees, purchasing, and billing.

## Technology Stack

- Java 21+ | Postgres (Supabase) | Maven 3.9+ | Swing GUI

## Quick Start (Supabase / Postgres)

1) Create a Supabase project (free) and get DB credentials (host, db, user, password). Create a public Storage bucket named `photos`.

2) Configure the app:
	- Copy `app/src/main/resources/application-supabase.properties.example` to `app/src/main/resources/application.properties`.
	- Fill `db.url`, `db.user`, `db.password`. Keep `db.driver=org.postgresql.Driver`.
	- Optional (for Storage uploads): set `supabase.url`, `supabase.service.key`, `supabase.bucket=photos`.

3) Create schema and seed data in Supabase (SQL Editor):
```bash
-- In Supabase SQL Editor, paste the contents of these files in order:
-- 1) db/schema.pg.sql
-- 2) db/seed.pg.sql
```

4) Build and run:
```bash
cd app
mvn -q -DskipTests package
mvn -q exec:java
```

Notes:
- Photos: if `supabase.*` settings are present and `photos` bucket is public, new images are uploaded to Supabase; otherwise they are saved locally under `photos/job_<id>/`.
- Legacy MySQL files (`db/schema.sql`, `db/data.sql`, `db/queries.sql`) are retained for reference. Use the `*.pg.sql` files with Postgres.

## Reference Queries (Postgres)

See `db/queries.pg.sql` for sample reports adapted to Postgres.