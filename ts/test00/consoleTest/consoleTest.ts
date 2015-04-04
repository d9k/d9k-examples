/** source: {@link http://blog.ctaggart.com/2013/11/nodejs-tools-with-typescript-console-app.html} */

/// <reference path="node.d.ts"  />

import readline = require('readline');
import stream = require('stream');

class ReadLineOptions implements readline.ReadLineOptions {
    constructor(public input: stream.ReadableStream, public output: stream.WritableStream) { }
}

var options = new ReadLineOptions(process.stdin, process.stdout);

var rl = readline.createInterface(options);
rl.question('What is your name? ', name => {
    console.log('Hi ' + name + '!');
    rl.question('press enter to exit', () => rl.close());
});
