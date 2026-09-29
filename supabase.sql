-- IT Asset Tracker: Supabase database setup
-- Run this entire script in Supabase Dashboard > SQL Editor.

create table if not exists public.app_state (
  id integer primary key check (id = 1),
  state_json jsonb not null default '{"assets":[],"history":[],"users":[],"customTypes":{}}'::jsonb,
  updated_at timestamptz not null default now()
);

insert into public.app_state (id, state_json)
values (1, '{"assets":[],"history":[],"users":[],"customTypes":{}}'::jsonb)
on conflict (id) do nothing;

alter table public.app_state enable row level security;

revoke all on table public.app_state from anon;
grant select, insert, update, delete on table public.app_state to authenticated;

drop policy if exists "IT Asset Tracker authenticated read" on public.app_state;
drop policy if exists "IT Asset Tracker authenticated insert" on public.app_state;
drop policy if exists "IT Asset Tracker authenticated update" on public.app_state;
drop policy if exists "IT Asset Tracker authenticated delete" on public.app_state;

create policy "IT Asset Tracker authenticated read"
on public.app_state for select
to authenticated
using (true);

create policy "IT Asset Tracker authenticated insert"
on public.app_state for insert
to authenticated
with check (id = 1);

create policy "IT Asset Tracker authenticated update"
on public.app_state for update
to authenticated
using (id = 1)
with check (id = 1);

create policy "IT Asset Tracker authenticated delete"
on public.app_state for delete
to authenticated
using (id = 1);
