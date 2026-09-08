# BrunchPlaner v1.3.5

Produktiver Layout-Fix auf Basis von v1.3.4.

Änderungen:
- Teilnehmeransicht im Smartphone-Hochformat: Dienstspalte wieder kompakter (145 px statt 180 px), horizontales Wischen bleibt erhalten.
- Dasselbe kompaktere Verhalten gilt für die vergrösserte Hochformat-Ansicht.
- Querformat bleibt unverändert übersichtlich.
- Kommentartexte umbrechen nicht mehr automatisch innerhalb einer einzelnen Kommentarzeile; bewusst eingegebene Zeilenumbrüche bleiben erhalten.
- Im Tab Einsatzplanung sind die Kommentarfelder auf `wrap=off` gestellt, damit kurze Kommentare wie „- kein Birchermüesli“ nicht nur wegen der Feldbreite optisch umbrechen.
- Im Tab Kompletter Plan ist die Kommentarschrift minimal kleiner und automatische Zeilenumbrüche sind deaktiviert.
- Teilnehmeransicht und Vollbildansicht übernehmen ebenfalls nur bewusst eingegebene Zeilenumbrüche.
- Versionsanzeige auf 1.3.5 aktualisiert.

Keine Supabase-Migration erforderlich. Bestehende Daten, Personen und Einteilungen werden nicht verändert.
