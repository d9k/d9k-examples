import { TypescriptParser } from 'typescript-parser';
import { ScriptKind } from 'typescript';
// import { parseStruct } from 'ts-file-parser';
import * as fs from 'fs';
import upperFirst from 'lodash/upperFirst';

const supabaseGeneratedTypesPath = 'src/db/types.generated.ts';

const supabaseParsedRawTypesPath = 'src/db/deprecated-typescript-parser/types-parsed-raw.generated.json';
const supabaseParsedTypesPath = 'src/db/deprecated-typescript-parser/types-parsed.generated.json';

async function main() {
    const timerToPreventFreeze = setTimeout(() => {}, 999999);
    // const source = fs.readFileSync(supabaseGeneratedTypesPath).toString();
    const parser = new TypescriptParser();
    const parsed = await parser.parseFile(supabaseGeneratedTypesPath, 'workspace root');
    // console.log(parsed);

    // const parsed = parseStruct(source, {}, supabaseGeneratedTypesPath);
    // console.log(parsed);
    console.log(`Writing raw types to "${supabaseParsedRawTypesPath}"`);
    fs.writeFileSync(supabaseParsedRawTypesPath, JSON.stringify(parsed, null, '  '));

    parsed.declarations = await Promise.all(parsed.declarations.map(async (declaration) => {
        const {name, properties} = declaration as any;
        console.log(`# Declaration ${name}`);
        if (properties) {
            (declaration as any).properties = await Promise.all(properties.map(async(property: any) => {
                const {name, type} = property;
                console.log('## property:', name);

                let _typeParsed;

                if (type[0] == '{') {
                    const manualParseTypeName = `ManualParse{upperFirst(name)}`;
                    // const manualParseDeclarationPrefix = `type ${manualParseTypeName} = `;
                    const manualParseDeclarationPrefix = `interface ${manualParseTypeName} `;
                    const manualParseDeclarationSuffix = `;`;

                    const manualParseDeclaration = `${manualParseDeclarationPrefix}${type}${manualParseDeclarationSuffix}`;

                    console.log('manualParseDeclaration:', manualParseDeclaration);

                    _typeParsed = await parser.parseSource(manualParseDeclaration, ScriptKind.TS);
                }

                return {...property, _typeParsed};
            }))
        }

        return declaration;
    }))

    fs.writeFileSync(supabaseParsedTypesPath, JSON.stringify(parsed, null, '  '));
}

main().then(() => {
    process.exit();
});
