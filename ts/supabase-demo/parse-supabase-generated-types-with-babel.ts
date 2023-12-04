/** https://github.com/babel/babel/discussions/14578#discussioncomment-2810253 */
// TODO
import * as fs from 'fs';
import { parse } from "@babel/parser";
import traverse, { Node, NodePath, Visitor } from "@babel/traverse";
import { StringNullableChain } from 'lodash';

const supabaseGeneratedTypesPath = 'src/db/types.generated.ts';

const supabaseRawParsedTypesPath = 'src/db/babel-parser/types-raw-parsed.generated.json';

const source = fs.readFileSync(supabaseGeneratedTypesPath).toString();

const parsed = parse(source, {
    sourceType: 'module',
    plugins: [
        [
            "typescript",
            {}
            // { dts: true }
        ]
    ]
});

const getCode = <P extends Node,>(path: NodePath<P>) => {
    const { node } = path;
    const { start, end } = node;

    if (start && end) {
        return source.slice(start, end);
    }
}

let pathDatabaseBody: NodePath;
// let pathDatabasePublic: NodePath;

type DatabaseTableProperty = {
    description: string;
    name: string;
    type: string;
    nullable: boolean;
    foreignSchema?: string;
    foreignTable?: string;
}

type DatabaseTable = {
    properties: DatabaseTableProperty[];
}

type DatabaseSchema = {[tableName: string]: DatabaseTable};
type DatabaseStructure = {[schemaName: string]: DatabaseSchema};

const databaseSchema: DatabaseStructure = {};

const visitDatabaseChild: Visitor = {
    TSPropertySignature(path) {
        const { node, parentPath } = path;
        const name = (node.key as any).name;

        if (parentPath !== pathDatabaseBody || name === 'graphql_public') {
            path.skip();
            return;
        }

        databaseSchema[name] = {};
        path.skip();
    }
}

traverse(parsed, {
    TSInterfaceDeclaration(path) {
        const {node } = path;
        const {id: {name}} = node;
        // const childrenNodes = node.body.body.forEach((node) => {
        //     const name = node.id.name;
        // });
        if (name === 'Database') {
            // console.log('interface:', getCode(path));
            pathDatabaseBody = path.get('body') as NodePath;
            path.traverse(visitDatabaseChild);

            // path.traverse()
        }
    },
    // enter(path, state) {
    //     const { node } = path;
    //     const { start, end } = node;
    //     // const { code } = state.file
    //     // if (path.isIdentifier({ name: "n" })) {
    //     //     path.node.name = "x";
    //     // }
    //     // console.log(code.slice(node.start, node.end))
    //     // console.log(path.toString());

    //     if (start && end) {
    //         const code = source.slice(start, end);
    //         console.log(code)
    //     }

    //     path.traverse

    //     console.log();
    // },
    // enter(path) {
    //     if (path.isIdentifier({ name: "n" })) {
    //       path.node.name = "x";
    //     }
    //   },
    // FunctionDeclaration: function(path) {
    //   path.node.id.name = "x";
    // },
});

console.log(`Writing parsed types to "${supabaseRawParsedTypesPath}"`);
fs.writeFileSync(supabaseRawParsedTypesPath, JSON.stringify(parsed, null, '  '));