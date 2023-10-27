-- From Supabase + React Tutorial:
-- https://supabase.com/docs/guides/getting-started/quickstarts/reactjs

-- Create the table
CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
-- Insert some sample data into the table
INSERT INTO countries (name) VALUES ('United States');
INSERT INTO countries (name) VALUES ('Canada');
INSERT INTO countries (name) VALUES ('Mexico');

-- From Supabase Javascript Client Doc - Typescript Support:
-- https://supabase.com/docs/reference/javascript/typescript-support

create table public.movies (
  id bigint generated always as identity primary key,
  name text not null,
  data jsonb null
);

-- From Many-to-many joins | Querying Joins and Nested tables
-- https://supabase.com/docs/guides/api/joins-and-nesting#many-to-many-joins

create table sportmans (
  "id" serial primary key,
  "name" text
);

INSERT INTO sportmans ("name") VALUES
	 ('Zabuza');

create table teams (
  "id" serial primary key,
  "team_name" text
);

INSERT INTO teams (team_name) VALUES
	 ('Village of the Hidden Mist');

create table members (
  "sportman_id" int references sportmans,
  "team_id" int references teams,
  primary key (sportman_id, team_id)
);

INSERT INTO members (sportman_id,team_id) VALUES
	 (1,1);
