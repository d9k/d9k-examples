# supabase-refine

See [/ts/supabase-demo/demo.sql](../supabase-demo/demo.sql) for schema.

- From tutorial
  [Use Supabase with refine | Supabase Docs](https://supabase.com/docs/guides/getting-started/quickstarts/refine)

```bash
pnpm install
```

```bash
cp .env.template .env
```

Fill from Supabase admin panel, project settings:

- `VITE_SUPABASE_URL`: `API -> Project URL`
- `VITE_SUPABASE_ANON_KEY`: `API -> Project API keys: anon, public`

```bash
pnpm run dev
```

See http://localhost:5173/countries

## Limitation

- Inferencer requires table to have at least one record.
  - See also [How the fields are inferred | Inferencer | refine doc](https://refine.dev/docs/packages/documentation/inferencer/#how-the-fields-are-inferred)
- TODO Error on table with foreign keys, http://localhost:5173/members: "Objects are not valid as a React child (found: object with keys {id, team_name}). If you meant to render a collection of children, use an array instead."

## Development

### Generate CRUD page

```
pnpm run refine create-resource countries
```

### How mantine packages was installed:

```
pnp @mantine/core@^5.10.4 @mantine/hooks@^5.10.4 @mantine/form@^5.10.4 @mantine/notifications@^5.10.4 @emotion/react @tabler/icons
```

See also [issue about Mantine v7 support](https://github.com/refinedev/refine/issues/5178).

# Auto-generated README:

<div align="center" style="margin: 30px;">
    <a href="https://refine.dev">
    <img src="https://refine.ams3.cdn.digitaloceanspaces.com/refine_logo.png"  align="center" />
    </a>
</div>
<br/>

This [refine](https://github.com/refinedev/refine) project was generated with
[superplate](https://github.com/pankod/superplate).

## Getting Started

**refine** is a React-based framework for building data-intensive applications
in no time ✨

Refine offers lots of out-of-the box functionality for rapid development,
without compromising extreme customizability. Use-cases include, but are not
limited to admin panels, B2B applications and dashboards.

## Available Scripts

### Running the development server.

```bash
npm run dev
```

### Building for production.

```bash
npm run build
```

### Running the production server.

```bash
npm run start
```

## Learn More

To learn more about **refine**, please check out the
[Documentation](https://refine.dev/docs)

- **React Router**
  [Docs](https://refine.dev/docs/core/providers/router-provider/)
- **Supabase Data Provider**
  [Docs](https://refine.dev/docs/core/providers/data-provider/#overview)

## License

MIT
