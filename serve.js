// Winziger statischer Server nur für die lokale Vorschau. Nicht Teil des Deployments.
const http = require("http");
const fs = require("fs");
const path = require("path");

const ROOT = __dirname;
const TYPES = {
  ".html": "text/html; charset=utf-8",
  ".css": "text/css; charset=utf-8",
  ".svg": "image/svg+xml",
  ".png": "image/png",
  ".txt": "text/plain; charset=utf-8",
  ".xml": "application/xml; charset=utf-8",
};

http
  .createServer((req, res) => {
    let rel = decodeURIComponent(req.url.split("?")[0]);
    if (rel === "/") rel = "/index.html";
    const file = path.join(ROOT, path.normalize(rel).replace(/^(\.\.[/\\])+/, ""));
    fs.readFile(file, (err, buf) => {
      if (err) {
        res.writeHead(404, { "Content-Type": "text/plain" });
        return res.end("404");
      }
      res.writeHead(200, { "Content-Type": TYPES[path.extname(file)] || "application/octet-stream" });
      res.end(buf);
    });
  })
  .listen(4321, () => console.log("preview on http://localhost:4321"));
