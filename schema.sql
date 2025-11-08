create extension if not exists "pgcrypto";

create table if not exists public.todos (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  is_complete boolean not null default false,
  created_at timestamp with time zone default now()
);

alter table public.todos enable row level security;

drop policy if exists "Allow read for anon" on public.todos;
create policy "Allow read for anon"
  on public.todos for select
  using (true);

drop policy if exists "Allow insert for authenticated" on public.todos;
create policy "Allow insert for authenticated"
  on public.todos for insert
  with check (auth.role() = 'authenticated');


drop policy if exists "Allow update for authenticated" on public.todos;
create policy "Allow update for authenticated"
  on public.todos for update
  using (auth.role() = 'authenticated')
  with check (auth.role() = 'authenticated');

drop policy if exists "Allow delete for authenticated" on public.todos;
create policy "Allow delete for authenticated"
  on public.todos for delete
  using (auth.role() = 'authenticated');

notify pgrst, 'reload schema';

DO $$
BEGIN
  CREATE OR REPLACE FUNCTION pgrst_watch() RETURNS event_trigger LANGUAGE plpgsql AS $$
  BEGIN
    PERFORM pg_notify('pgrst', 'reload schema');
  END;$$;

  DROP EVENT TRIGGER IF EXISTS pgrst_ddl_watch;
  CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end EXECUTE PROCEDURE pgrst_watch();
EXCEPTION WHEN OTHERS THEN
  NULL;
END$$;