# BrunchPlaner v0.4.2 – Online-Basis

Diese Version basiert auf der getesteten Oberfläche v0.3.11. Neu ist die Anbindung an Supabase für zentrale Daten und ein Planer-Login. Ohne ausgefüllte `config.js` läuft die App weiterhin lokal als Demo.

## Online einrichten

1. Bei Supabase ein neues Projekt anlegen.
2. Im **SQL Editor** die Datei `supabase_schema.sql` vollständig ausführen. Vorher in der INSERT-Zeile `DEINE-PLANER-EMAIL` durch deine echte Login-E-Mail ersetzen.
3. In Supabase unter **Authentication → Users** einen Benutzer mit genau dieser E-Mail und einem Passwort anlegen.
4. In Supabase unter **Project Settings / API** die Projekt-URL und den **Publishable Key** kopieren. Niemals den `service_role`-Schlüssel in die App eintragen.
5. `config.js` öffnen und `supabaseUrl` sowie `supabasePublishableKey` einsetzen.
6. Optional zum Testen `supabase_demo_seed.sql` im SQL Editor ausführen. Damit startet die Online-Datenbank mit der Oktober/November-2026-Demo.
7. Den Ordner mit `index.html` und `config.js` als statische Website deployen (z. B. Vercel).

## Verhalten

- Planer: Anmeldung mit Supabase Auth; Planungsdaten werden zentral gespeichert.
- Teilnehmer: kein Login. Der allgemeine Link `?teilnahme=...` lädt nur die betreffende Planungsrunde und aktive Namen. E-Mail/Mobilnummern werden nicht ausgeliefert.
- Teilnehmer-Verfügbarkeiten werden separat gespeichert und erst nach vollständigem Abschluss der Umfrage übernommen.
- Nach Veröffentlichung zeigt derselbe Link persönliche Einsätze plus den kompakten Gesamtplan.
- Mehrere Browser/Geräte greifen auf dieselben zentralen Daten zu.

## Sicherheit

Die Tabellen sind per RLS gesperrt und nicht direkt für Browserrollen freigegeben. Zugriff erfolgt nur über definierte RPC-Funktionen. Admin-Funktionen prüfen zusätzlich die konfigurierte Planer-E-Mail. Der Publishable Key ist für Browser-Nutzung gedacht; ein Service-Role-Key darf niemals in `config.js` stehen.

## Hinweis v0.4

Die Oberfläche ist bewusst weitgehend identisch zu v0.3.11. v0.4 ist der erste Online-Schritt; vor echtem Produktivbetrieb sollte ein kurzer Test mit 2–3 echten Geräten durchgeführt werden.


## v0.4.2
- Teilnehmeransicht für Smartphones optimiert.
- Verfügbarkeits-Tabelle passt ohne horizontales Scrollen auf schmale Displays.
- Datum kompakter, Antwortbuttons vollständig sichtbar und fingerfreundlich.
- Planer-/Desktopansicht funktional unverändert.
