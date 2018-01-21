CREATE TABLE "datasets" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "base_url" varchar, "site_number" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "rows_and_cols" json);
CREATE TABLE "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
INSERT INTO "schema_migrations" (version) VALUES
('20180116011927'),
('20180121220705');


