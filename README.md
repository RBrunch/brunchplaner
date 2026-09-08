# BrunchPlaner v1.3 – Produktivversion

Basis: funktionierende Produktivversion v1.2.2.

## Neu in v1.3
- Neuer Dienst **☕ Kaffee #3 – Schnuppern**
- Der Dienst ist analog zu den bestehenden Diensten vollständig in Einsatzplanung, komplettem Plan und Teilnehmeransicht integriert.
- Einsatzzeit für **Kaffee #3 – Schnuppern: 08:15–12:00 Uhr**, identisch mit Kaffee #1 – Chef, damit Schnuppernde auch die Vorbereitung miterleben.
- Kalenderübernahme (ICS) verwendet ebenfalls 08:15–12:00 Uhr.
- CSV-Export nimmt alle aktuell vorhandenen Dienste vollständig mit auf.

## Daten / Supabase
- Keine neue Supabase-Migration erforderlich.
- Bestehende Personen, Verfügbarkeiten, Kommentare, Zuteilungen und Planungsrunden bleiben erhalten.
- Der neue Dienst ist in bestehenden Planungsrunden zunächst leer und kann danach normal zugeteilt werden.

Vor dem Deployment wird wie gewohnt eine aktuelle Datensicherung empfohlen.
