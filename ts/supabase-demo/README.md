# Supabase demo

## Init schema

At first go to your project page at Supabase, choose "SQL editor" on left menu and init schema with schema you want to test, for example `demo.sql`.

## Installation

```bash
pnpm install
```

## Connecting to Supabase

### Login to Supabase

Generate access token at https://supabase.com/dashboard/account/tokens, then

```bash
pnpm exec supabase login
```

Then enter access token. Local system keyring password may be asked then.

### Link to Supabase project


Then go to your project subase settings -> Project settings -> general -> copy "<Reference_ID>"

and run


```bash
pnpm exec supabase link --project-ref=<Reference_ID>
```

### Generate typescript types

```bash
pnpm run gen-typescript-types
```

which executes

```bash
pnpm exec supabase gen types typescript --linked > src/db/supabase-types-generated.ts
```

See

## Generate JSON schema

```bash
pnpm run parse-supabase-generated-types-with-babel
```

## Generate JSON schema: deprecated

Deprecated because `pg-structure` which is used `pg-tables-to-jsonschema` stopped to work with PostgreSQL connection to Supabase for unknown reason with error

```
TypeError: Cannot read properties of undefined (reading 'table')
    at ForeignKey.get referencedTable (node_modules/pg-structure/src/pg-structure/constraint/foreign-key.ts:80:23)
```

Copy `.env.template` to `.env`. Fill envirorment variables values.

Execute `pnpm run gen-json-schema`.

- ~~[without relations :(](https://github.com/SpringTree/pg-tables-to-jsonschema/issues/27)~~
    - implemented foreign keys save to `src/foreign-keys.json` with [postgres.js library](https://github.com/porsager/postgres#connection-details).

## Generate doc & schema with tbls

- [k1LoW/tbls: CI-Friendly tool for document a database, written in Go.](https://github.com/k1LoW/tbls)

```bash
pnpm run tbls
```

## Get OpenAPI JSON

Get Project `<API_Key>` from `Settings -> API -> Project API keys -> service_role [Reveal], [Copy]`

`https://<Reference_ID>.supabase.co/rest/v1/?apikey=<API_Key>`

See result at `src/db/rest_v1.json`.
With relations 🙂 (see `definitions.members.properties` section).

## Development commands

```bash
pnpm install --save-dev supabase
```

Then "Login to Supabase", then

```bash
pnpm exec supabase init
```

Then "Link to Supabase project"