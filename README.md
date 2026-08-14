# AVG — Coming-Soon-Seite

Landing-Page für die **AVG Ambulante Versorgungsgemeinschaft GmbH i. Gr.**
Zieldomain: `www.ambulante-versorgungsgemeinschaft.de`

Countdown läuft auf den **47. Hausärztinnen- und Hausärztetag, 10.09.2026, 09:00 Uhr** (Berlin).

## Was drin ist

| Datei | Zweck |
|---|---|
| `index.html` | Die komplette Seite. Kein Build, kein Framework, keine Abhängigkeiten. |
| `favicon.svg` | Kompass-Signet als Browser-Icon. |
| `og.png` | Vorschaubild fürs Teilen (LinkedIn, WhatsApp, Slack). |
| `build-og.ps1` | Erzeugt `og.png` neu. Nur nötig, wenn sich Logo oder Datum ändern. |
| `serve.js` | Lokale Vorschau. Nicht Teil des Deployments. |
| `vercel.json` | Wird von GitHub Pages ignoriert. Liegt bereit, falls die Seite später auf Vercel umzieht. |

Impressum und Datenschutzhinweis stecken als Overlay direkt in `index.html`. Es gibt
bewusst keine Unterseiten: die Seite ist ein One-Pager.

## Lokal ansehen

```
node serve.js
```

Dann `http://localhost:4321` im Browser öffnen.

## Deployment

Läuft über GitHub Pages. Jeder Push auf `main` geht automatisch live.

Aktuell erreichbar unter <https://floyet89.github.io/avg-landing/>.

## Offen

1. E-Mail-Adresse im Impressum-Overlay eintragen (aktuell Platzhalter).
2. Domain `www.ambulante-versorgungsgemeinschaft.de` per DNS auf GitHub Pages zeigen
   lassen, dann in den Repo-Settings als Custom Domain eintragen.
3. Danach `og:url` und `og:image` in `index.html` auf die echte Domain umstellen.

## Datenschutz

Die Seite lädt **nichts** von externen Servern: keine Google Fonts, keine Analytics,
keine Cookies, keine Formulare. Nur Systemschriften und Inline-Assets. Die
Content-Security-Policy in `vercel.json` erzwingt das technisch.

## Easter Eggs

Zwei Stück, beide greifen Motive aus dem Storyboard auf:

1. **Klick auf die Kompassnadel** — sie dreht durch, danach erscheint die geschwärzte
   Akte. Die einzelnen Schwärzungen lassen sich anklicken und geben nacheinander den
   Text frei.
2. **„47." in der Fußzeile antippen** oder einfach **`47` tippen** — es kommt eine
   Wartemarke mit dem laufenden Countdown als Aufrufzeit.

Dazu eine Nachricht in der Browser-Konsole für alle, die dort nachsehen.
