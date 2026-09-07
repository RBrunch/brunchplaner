# BrunchPlaner v1.2.2 – Produktivversion

Basis: funktionierende Produktivversion v1.2.1.

## Änderungen
- Teilnehmer-Einsatzplan auf Smartphones kompakter dargestellt.
- Personennamen in der kompakten Tabelle werden nach Möglichkeit einzeilig angezeigt.
- Kommentarzeile kleiner/feiner und weiterhin linksbündig; Zeilenumbrüche bleiben erhalten.
- Teilnehmer können den kompletten Einsatzplan über „Tabelle vergrössern“ bzw. Antippen in einer bildschirmfüllenden Ansicht öffnen.
- In der vergrösserten Ansicht kann horizontal/vertikal gescrollt werden; Querformat nutzt die zusätzliche Breite.
- Im Admin-Tab „Kompletter Plan“ werden Namen etwas kompakter dargestellt.

## Datenbank
Keine Supabase-Migration erforderlich. Bestehende Personen, Planungsrunden, Verfügbarkeiten, Kommentare und Zuteilungen bleiben unverändert.

## Deployment
Vor dem Update Datensicherung herunterladen. Danach `index.html`, `config.js` und `README.md` im GitHub-Repository ersetzen. Vercel deployt automatisch.
