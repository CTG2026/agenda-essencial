-- AGENDA ESSENCIAL · esquema Supabase (ya aplicado en el proyecto agenda-essencial).
-- Sirve para recrear la base si se migra a otro proyecto: pegar en SQL Editor y ejecutar.
create table public.perfiles(id uuid primary key references auth.users on delete cascade, nombre text);
create function public.es_staff() returns boolean language sql security definer stable set search_path=public as $$ select exists(select 1 from public.perfiles where id=auth.uid()) $$;
revoke execute on function public.es_staff() from public, anon;
grant execute on function public.es_staff() to authenticated;
create table public.citas    (id text primary key, data jsonb not null default '{}', updated_at timestamptz default now());
create table public.clientes (id text primary key, data jsonb not null default '{}', updated_at timestamptz default now());
create table public.dias     (id text primary key, data jsonb not null default '{}', updated_at timestamptz default now());
create table public.config   (id text primary key, data jsonb not null default '{}', updated_at timestamptz default now());
create table public.fotos    (id text primary key, data jsonb not null default '{}', updated_at timestamptz default now());
create table public.bitacora (id text primary key, user_id uuid not null default auth.uid(), data jsonb not null, created_at timestamptz default now());
create index on public.citas((data->>'fecha'));
create index on public.fotos((data->>'clienteId'));
create index on public.fotos((data->>'citaId'));
alter table public.perfiles enable row level security;
create policy "ver propio" on public.perfiles for select to authenticated using (id=auth.uid());
do $$ declare t text; begin
 foreach t in array array['citas','clientes','dias','config','fotos'] loop
  execute format('alter table public.%I enable row level security',t);
  execute format('create policy "ver" on public.%I for select to authenticated using (public.es_staff())',t);
  execute format('create policy "crear" on public.%I for insert to authenticated with check (public.es_staff())',t);
  execute format('create policy "editar" on public.%I for update to authenticated using (public.es_staff()) with check (public.es_staff())',t);
 end loop; end $$;
create policy "borrar" on public.citas for delete to authenticated using (public.es_staff());
create policy "borrar" on public.dias  for delete to authenticated using (public.es_staff());
create policy "borrar" on public.fotos for delete to authenticated using (public.es_staff());
alter table public.bitacora enable row level security;
create policy "ver" on public.bitacora for select to authenticated using (public.es_staff());
create policy "agregar" on public.bitacora for insert to authenticated with check (public.es_staff() and user_id=auth.uid());
alter publication supabase_realtime add table public.citas, public.clientes, public.dias, public.config, public.fotos;
-- Después de crear el usuario compartido en Authentication > Users:
-- insert into public.perfiles(id,nombre) select id,'Essencial' from auth.users where email='CORREO_COMPARTIDO';
