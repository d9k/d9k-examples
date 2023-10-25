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
pnpm exec supabase gen types typescript --linked > supabase/supabase-types.ts
```

## Development commands

```bash
pnpm install --save-dev supabase
```

Then "Login to Supabase", then

```bash
pnpm exec supabase init
```

Then "Link to Supabase project"