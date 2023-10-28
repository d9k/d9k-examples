
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE EXTENSION IF NOT EXISTS "pgsodium" WITH SCHEMA "pgsodium";

CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";

CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";

CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";

SET default_tablespace = '';

SET default_table_access_method = "heap";

CREATE TABLE IF NOT EXISTS "public"."countries" (
    "id" integer NOT NULL,
    "name" character varying(255) NOT NULL
);

ALTER TABLE "public"."countries" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."countries_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."countries_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."countries_id_seq" OWNED BY "public"."countries"."id";

CREATE TABLE IF NOT EXISTS "public"."members" (
    "sportman_id" integer NOT NULL,
    "team_id" integer NOT NULL
);

ALTER TABLE "public"."members" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."movies" (
    "id" bigint NOT NULL,
    "name" "text" NOT NULL,
    "data" "jsonb"
);

ALTER TABLE "public"."movies" OWNER TO "postgres";

ALTER TABLE "public"."movies" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."movies_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "public"."sportmans" (
    "id" integer NOT NULL,
    "name" "text"
);

ALTER TABLE "public"."sportmans" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."sportmans_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."sportmans_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."sportmans_id_seq" OWNED BY "public"."sportmans"."id";

CREATE TABLE IF NOT EXISTS "public"."teams" (
    "id" integer NOT NULL,
    "team_name" "text"
);

ALTER TABLE "public"."teams" OWNER TO "postgres";

CREATE SEQUENCE IF NOT EXISTS "public"."teams_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE "public"."teams_id_seq" OWNER TO "postgres";

ALTER SEQUENCE "public"."teams_id_seq" OWNED BY "public"."teams"."id";

ALTER TABLE ONLY "public"."countries" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."countries_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."sportmans" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."sportmans_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."teams" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."teams_id_seq"'::"regclass");

ALTER TABLE ONLY "public"."countries"
    ADD CONSTRAINT "countries_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."members"
    ADD CONSTRAINT "members_pkey" PRIMARY KEY ("sportman_id", "team_id");

ALTER TABLE ONLY "public"."movies"
    ADD CONSTRAINT "movies_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."sportmans"
    ADD CONSTRAINT "sportmans_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."teams"
    ADD CONSTRAINT "teams_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."members"
    ADD CONSTRAINT "members_sportman_id_fkey" FOREIGN KEY ("sportman_id") REFERENCES "public"."sportmans"("id");

ALTER TABLE ONLY "public"."members"
    ADD CONSTRAINT "members_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "public"."teams"("id");

GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

GRANT ALL ON TABLE "public"."countries" TO "anon";
GRANT ALL ON TABLE "public"."countries" TO "authenticated";
GRANT ALL ON TABLE "public"."countries" TO "service_role";

GRANT ALL ON SEQUENCE "public"."countries_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."countries_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."countries_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."members" TO "anon";
GRANT ALL ON TABLE "public"."members" TO "authenticated";
GRANT ALL ON TABLE "public"."members" TO "service_role";

GRANT ALL ON TABLE "public"."movies" TO "anon";
GRANT ALL ON TABLE "public"."movies" TO "authenticated";
GRANT ALL ON TABLE "public"."movies" TO "service_role";

GRANT ALL ON SEQUENCE "public"."movies_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."movies_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."movies_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."sportmans" TO "anon";
GRANT ALL ON TABLE "public"."sportmans" TO "authenticated";
GRANT ALL ON TABLE "public"."sportmans" TO "service_role";

GRANT ALL ON SEQUENCE "public"."sportmans_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."sportmans_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."sportmans_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."teams" TO "anon";
GRANT ALL ON TABLE "public"."teams" TO "authenticated";
GRANT ALL ON TABLE "public"."teams" TO "service_role";

GRANT ALL ON SEQUENCE "public"."teams_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."teams_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."teams_id_seq" TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";

RESET ALL;
