# BrunchPlaner v1.2.1

Reiner Bugfix auf Basis von v1.2.

Änderungen:
- Einsatzplanung wird wieder vollständig angezeigt. Ursache war eine fehlende interne HTML-Escaping-Funktion beim Rendern der neuen Kommentarfelder.
- Erste Spalte im Tab „Kompletter Plan“ verbreitert, damit längere Dienstnamen wie „Brunch #3 – Helfer“ einzeilig bleiben.
- Keine Änderung an Supabase-Schema oder bestehenden Daten.
- Alle Funktionen aus v1.2 bleiben erhalten, inklusive Sonntags-Kommentaren, Brunch #3, Drag-and-drop-Reihenfolge und Datensicherung.

Installation: index.html, config.js und README.md im GitHub-Repository ersetzen. Keine SQL-Migration erforderlich.
