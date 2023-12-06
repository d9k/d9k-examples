
import { TypescriptParser } from 'typescript-parser';

const json = (data: any): string => JSON.stringify(data, null, '  ');

/**
 * No fields for type! Also no nested type declarations supported
 * https://github.com/buehler/node-typescript-parser/issues/123
 */
async function main() {
    const timerToPreventFreeze = setTimeout(() => {}, 999999);
    const parser = new TypescriptParser();
    console.log('# interface');
    console.log();
    console.log(json(await parser.parseSource(`
        interface A {
            n: number;
            s: string;
        }
    `)));
    console.log();
    console.log('# type');
    console.log();
    console.log(json(await parser.parseSource(`
        type A = {
            n: number;
            s: string;
        }
    `)));
    clearTimeout(timerToPreventFreeze);
  }

  main().then(() => {
    process.exit()
  });