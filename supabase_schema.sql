-- BrunchPlaner v0.4 – Supabase Schema
-- 1) Im Supabase SQL Editor ausführen.
-- 2) Danach unter Authentication > Users einen Planer-Benutzer mit deiner E-Mail anlegen.
-- 3) Unten DEINE-PLANER-EMAIL ersetzen und die INSERT-Zeile ausführen.

create table if not exists public.brunch_app_config (
  id integer primary key default 1 check (id = 1),
  owner_email text not null
);

create table if not exists public.brunch_app_state (
  id integer primary key default 1 check (id = 1),
  data jsonb not null default '{"people":[],"rounds":[],"activeRoundId":null}'::jsonb,
  updated_at timestamptz not null default now()
);

create table if not exists public.brunch_availability (
  round_id text not null,
  person_id text not null,
  date date not null,
  status text not null check (status in ('yes','maybe','no')),
  updated_at timestamptz not null default now(),
  primary key (round_id, person_id, date)
);

alter table public.brunch_app_config enable row level security;
alter table public.brunch_app_state enable row level security;
alter table public.brunch_availability enable row level security;

revoke all on public.brunch_app_config from anon, authenticated;
revoke all on public.brunch_app_state from anon, authenticated;
revoke all on public.brunch_availability from anon, authenticated;

insert into public.brunch_app_state(id,data) values (1,'{"people":[],"rounds":[],"activeRoundId":null}'::jsonb)
on conflict (id) do nothing;

-- HIER deine Planer-E-Mail eintragen:
insert into public.brunch_app_config(id,owner_email) values (1,'DEINE-PLANER-EMAIL')
on conflict (id) do update set owner_email=excluded.owner_email;

create or replace function public.brunch_is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce(lower(auth.jwt()->>'email') = lower((select owner_email from public.brunch_app_config where id=1)), false);
$$;

create or replace function public.brunch_admin_get_state()
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.brunch_is_admin() then raise exception 'Nicht autorisiert'; end if;
  return (select data from public.brunch_app_state where id=1);
end; $$;

create or replace function public.brunch_admin_get_availability()
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.brunch_is_admin() then raise exception 'Nicht autorisiert'; end if;
  return coalesce((select jsonb_agg(jsonb_build_object('round_id',round_id,'person_id',person_id,'date',to_char(date,'YYYY-MM-DD'),'status',status)) from public.brunch_availability),'[]'::jsonb);
end; $$;

create or replace function public.brunch_admin_save_state(p_data jsonb)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.brunch_is_admin() then raise exception 'Nicht autorisiert'; end if;
  update public.brunch_app_state set data=p_data,updated_at=now() where id=1;
end; $$;

create or replace function public.brunch_admin_save_availability(p_round_id text,p_person_id text,p_answers jsonb)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare d text; s text; app jsonb; round_obj jsonb; dates jsonb;
begin
  if not public.brunch_is_admin() then raise exception 'Nicht autorisiert'; end if;
  app=(select data from public.brunch_app_state where id=1);
  select r into round_obj from jsonb_array_elements(app->'rounds') r where r->>'id'=p_round_id limit 1;
  if round_obj is null then raise exception 'Planungsrunde nicht gefunden'; end if;
  dates=round_obj->'dates';
  if jsonb_array_length(dates) <> (select count(*) from jsonb_each_text(p_answers)) then raise exception 'Nicht alle Sonntage beantwortet'; end if;
  for d in select jsonb_array_elements_text(dates) loop
    s=p_answers->>d;
    if s not in ('yes','maybe','no') then raise exception 'Ungültige Antwort für %',d; end if;
  end loop;
  delete from public.brunch_availability where round_id=p_round_id and person_id=p_person_id;
  for d,s in select key,value from jsonb_each_text(p_answers) loop
    insert into public.brunch_availability(round_id,person_id,date,status) values(p_round_id,p_person_id,d::date,s);
  end loop;
end; $$;

create or replace function public.brunch_participant_get_round(p_token text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare app jsonb; r jsonb; public_people jsonb;
begin
  app=(select data from public.brunch_app_state where id=1);
  select x into r from jsonb_array_elements(app->'rounds') x where x->>'linkToken'=p_token limit 1;
  if r is null then return null; end if;
  select coalesce(jsonb_agg(jsonb_build_object('id',p->>'id','name',p->>'name','active',coalesce((p->>'active')::boolean,true)) order by p->>'name'),'[]'::jsonb)
    into public_people
    from jsonb_array_elements(app->'people') p
    where coalesce((p->>'active')::boolean,true)=true;
  -- E-Mail und Mobilnummer werden bewusst nicht an Teilnehmer ausgeliefert.
  return jsonb_build_object('people',public_people,'round',r - 'avail' - 'availabilityCompleted' - 'people');
end; $$;

create or replace function public.brunch_participant_get_availability(p_token text,p_person_id text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare app jsonb; r jsonb; rid text; person_ok boolean;
begin
  app=(select data from public.brunch_app_state where id=1);
  select x into r from jsonb_array_elements(app->'rounds') x where x->>'linkToken'=p_token limit 1;
  if r is null then raise exception 'Planungsrunde nicht gefunden'; end if;
  rid=r->>'id';
  select exists(select 1 from jsonb_array_elements(app->'people') p where p->>'id'=p_person_id and coalesce((p->>'active')::boolean,true)) into person_ok;
  if not person_ok then raise exception 'Person nicht gefunden'; end if;
  return coalesce((select jsonb_object_agg(to_char(date,'YYYY-MM-DD'),status) from public.brunch_availability where round_id=rid and person_id=p_person_id),'{}'::jsonb);
end; $$;

create or replace function public.brunch_participant_save_availability(p_token text,p_person_id text,p_answers jsonb)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare app jsonb; r jsonb; rid text; dates jsonb; d text; s text; person_ok boolean;
begin
  app=(select data from public.brunch_app_state where id=1);
  select x into r from jsonb_array_elements(app->'rounds') x where x->>'linkToken'=p_token limit 1;
  if r is null then raise exception 'Planungsrunde nicht gefunden'; end if;
  if coalesce((r->>'published')::boolean,false) then raise exception 'Diese Umfrage ist bereits abgeschlossen'; end if;
  rid=r->>'id'; dates=r->'dates';
  select exists(select 1 from jsonb_array_elements(app->'people') p where p->>'id'=p_person_id and coalesce((p->>'active')::boolean,true)) into person_ok;
  if not person_ok then raise exception 'Person nicht gefunden'; end if;
  if jsonb_array_length(dates) <> (select count(*) from jsonb_each_text(p_answers)) then raise exception 'Bitte alle Sonntage beantworten'; end if;
  for d in select jsonb_array_elements_text(dates) loop
    s=p_answers->>d;
    if s not in ('yes','maybe','no') then raise exception 'Ungültige oder fehlende Antwort für %',d; end if;
  end loop;
  delete from public.brunch_availability where round_id=rid and person_id=p_person_id;
  for d,s in select key,value from jsonb_each_text(p_answers) loop
    insert into public.brunch_availability(round_id,person_id,date,status) values(rid,p_person_id,d::date,s);
  end loop;
end; $$;

revoke all on function public.brunch_is_admin() from public;
revoke all on function public.brunch_admin_get_state() from public;
revoke all on function public.brunch_admin_get_availability() from public;
revoke all on function public.brunch_admin_save_state(jsonb) from public;
revoke all on function public.brunch_admin_save_availability(text,text,jsonb) from public;
revoke all on function public.brunch_participant_get_round(text) from public;
revoke all on function public.brunch_participant_get_availability(text,text) from public;
revoke all on function public.brunch_participant_save_availability(text,text,jsonb) from public;

grant execute on function public.brunch_admin_get_state() to authenticated;
grant execute on function public.brunch_admin_get_availability() to authenticated;
grant execute on function public.brunch_admin_save_state(jsonb) to authenticated;
grant execute on function public.brunch_admin_save_availability(text,text,jsonb) to authenticated;
grant execute on function public.brunch_participant_get_round(text) to anon, authenticated;
grant execute on function public.brunch_participant_get_availability(text,text) to anon, authenticated;
grant execute on function public.brunch_participant_save_availability(text,text,jsonb) to anon, authenticated;
