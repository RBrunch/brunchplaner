# BrunchPlaner v1.2 – Produktivversion

Diese Version basiert auf der funktionierenden Produktivversion v1.1 und ergänzt ausschliesslich die getestete Kommentarfunktion pro Sonntag.

Neu in v1.2:
- Pro Sonntag ein kompaktes Kommentarfeld im Tab **Einsatzplanung** (max. 120 Zeichen).
- Zeilenumbrüche werden gespeichert und angezeigt.
- Kommentare erscheinen im Tab **Kompletter Plan** in einer eigenen untersten Zeile.
- Kommentare erscheinen im veröffentlichten Teilnehmer-Dienstplan ebenfalls in einer eigenen untersten Zeile und dort linksbündig.
- Die Personen-/Dienstzeilen im Teilnehmerplan bleiben unverändert zentriert.
- Mobile Darstellung bleibt kompakt.
- Bestehende Personen, Planungsrunden, Verfügbarkeiten und Einteilungen bleiben erhalten.
- Keine Supabase-Migration erforderlich; Kommentare werden im bestehenden Planungsrunden-JSON gespeichert.

Zusätzlich wurde die Kalenderzeit für den bereits in v1.1 eingeführten Dienst **Brunch #3 – Helfer** auf 08:15–12:00 vervollständigt.

## Update
Vor dem Update eine aktuelle Datensicherung herunterladen. Danach `index.html`, `config.js` und `README.md` im GitHub-Repository ersetzen. Vercel deployt anschliessend automatisch.
