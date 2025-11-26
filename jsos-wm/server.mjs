import http from 'http';
import { readFile } from 'fs/promises';
import path from 'path';

const root = "/usr/local/share/jsos-shell";

http.createServer(async (req, res) => {
  let filePath = path.join(root, req.url === "/" ? "index.html" : req.url);
  try {
    let data = await readFile(filePath);
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.end(data);
  } catch (e) {
    res.statusCode = 404;
    res.end("Not Found");
  }
}).listen(7777, () => {
  console.log("JSOS local server running at http://127.0.0.1:7777");
});
