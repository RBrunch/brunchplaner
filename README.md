# BrunchPlaner v1.0 – Produktion

Dies ist die erste produktive Version des BrunchPlaners. Sie verwendet ausschliesslich die bereits eingerichtete Supabase-Datenbank. Ein Vercel-/GitHub-Update dieser Dateien verändert oder löscht keine Personen, Verfügbarkeiten, Planungsrunden oder Einsätze in Supabase.

## Für Updates wichtig

- Für normale Oberflächen-/JavaScript-Updates nur `index.html` (und falls nötig `config.js`) in GitHub ersetzen.
- Keine Demo-/Seed-SQL-Datei gehört zur Produktionsversion.
- Datenbank-SQL nur ausführen, wenn eine Änderung ausdrücklich als **Migration** für die bestehende Produktivdatenbank vorgesehen ist.
- Vor einer späteren Datenbank-Migration im BrunchPlaner über **Kompletter Einsatzplan → Datensicherung** einen JSON-Export erstellen.
- Niemals einen `service_role`- oder Secret-Key in `config.js` eintragen. Dort gehört nur der Supabase Publishable Key hinein.

## Datensicherung

Der Button **Datensicherung** exportiert in v1.0 den gesamten aktuell geladenen BrunchPlaner-Datenbestand (alle Personen und Planungsrunden inkl. Verfügbarkeiten und Zuteilungen) als datierte JSON-Datei.

## Deployment

Das GitHub-Repository ist mit dem bestehenden Vercel-Projekt verbunden. Ein Commit auf den produktiven Branch löst automatisch ein neues Vercel-Deployment aus; die bestehende Domain und die Daten in Supabase bleiben erhalten.


## Backup & Wiederherstellung

In der Übersicht stehen jetzt **Datensicherung herunterladen** und **Datensicherung wiederherstellen** zur Verfügung. Der Export liest den Datenbestand frisch aus Supabase. Die Wiederherstellung ersetzt den aktuellen Datenbestand vollständig, verlangt eine Bestätigung und läuft serverseitig in einer Transaktion.

Vor der ersten Verwendung der Wiederherstellung muss `supabase_migration_backup_restore.sql` **einmalig** im Supabase SQL Editor ausgeführt werden. Diese Migration legt nur die Wiederherstellungsfunktion an und verändert beim Einrichten keine bestehenden BrunchPlaner-Daten.
