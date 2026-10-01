# BrunchPlaner v1.4.0

Produktivversion auf Basis von v1.3.6.

## Neu in v1.4.0
- Planungsrunden speichern ihre Teilnehmer-Zugehörigkeit dauerhaft.
- Wird eine Person später auf **inaktiv** gesetzt, bleibt sie in älteren Planungsrunden erhalten.
- Alte Runden zeigen diese Person weiterhin in Verfügbarkeit, Einsatzplanung, persönlichem Einsatz und Teilnehmer-Link.
- Neue Planungsrunden übernehmen nur Personen, die beim Erstellen der Runde aktiv sind.
- Zusätzlich wird pro Runde ein kleiner Personen-Snapshot gespeichert. Dadurch kann der veröffentlichte Teilnehmer-Link historische Personen weiterhin darstellen, auch wenn der öffentliche Supabase-Aufruf nur aktive Personen liefert.
- Bestehende Planungsrunden werden beim ersten Admin-Login automatisch auf die neue Rundenlogik ergänzt und gespeichert.

## Wichtig
Keine SQL-/Supabase-Migration erforderlich. Bestehende Personen, Verfügbarkeiten, Einteilungen, Kommentare und Layouts werden nicht verändert.

Personen, die nicht mehr mitmachen, künftig **inaktiv setzen statt löschen**.
