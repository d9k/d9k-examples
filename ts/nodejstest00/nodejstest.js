/** http://holtcode.blogspot.ru/2012/12/typescript-nodejs-development-part-1.html */
/// <reference path="./node-definitions/node.d.ts" />
//import http = module('http');
http.createServer(function (req, res) {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Hello World\n');
}).listen(1337, '127.0.0.1');
console.log('Server running at http://127.0.0.1:1337/');
//# sourceMappingURL=nodejstest.js.map