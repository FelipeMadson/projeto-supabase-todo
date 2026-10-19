# Serverless Todo Web Application with Supabase

A responsive, single-page task management application built with vanilla modern JavaScript and backed by Supabase (PostgreSQL with Row Level Security).

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

*Leia isto em [Português](README.pt-BR.md).*

---

## Architectural Highlights

- **Pure Client-Side Modern JS**: Zero bundler requirements; runs directly in modern evergreen browsers.
- **Supabase Realtime & Persistence**: Direct integration with PostgreSQL through Supabase Client SDK.
- **Adaptive Theming**: Native CSS color-scheme support (`prefers-color-scheme: dark`) with accessible high-contrast palettes.
- **Row-Level Security**: Hardened SQL schema ready for multi-tenant authenticated scopes.

---

## Database Initialization

Execute the included `schema.sql` within your Supabase project's SQL Editor:

```sql
-- Creates todos table with proper constraints and indexes
create table if not exists todos (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  is_complete boolean default false,
  inserted_at timestamp with time zone default timezone('utc'::text, now()) not null
);

alter table todos enable row level security;
```

---

## Running Locally

1. Open `index.html` in your browser or serve using any static web server:
   ```bash
   npx serve .
   ```
2. Configure your Supabase project URL and Anonymous Key in `index.html`.

## License

MIT © [Felipe Madison](https://github.com/FelipeMadson)
