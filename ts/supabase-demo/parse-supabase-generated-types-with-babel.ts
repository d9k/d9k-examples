/** https://github.com/babel/babel/discussions/14578#discussioncomment-2810253 */
// TODO
import * as fs from 'fs';
import { parse } from "@babel/parser";
import traverse, { Node, NodePath, Visitor } from "@babel/traverse";
import { set } from 'lodash';
import { BabelTraverseHelper } from './src/lib/babel/traverse-helper';

const supabaseGeneratedTypesPath = 'src/db/types.generated.ts';

const supabaseRawParsedTypesPath = 'src/db/babel-parser/types-raw-parsed.generated.json';
const supabaseSchemaJsonPath = 'src/db/babel-parser/types-parsed.generated.json';

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

// let pathDatabaseBody: NodePath;
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

const result: DatabaseStructure = {};

const traverseHelperDatabaseSchemas = new BabelTraverseHelper({maxLevel: 1});
const traverseHelperDatabaseSchemaSections = new BabelTraverseHelper({maxLevel: 1});
const traverseHelperDatabaseSchemaTables = new BabelTraverseHelper({maxLevel: 1});
const traverseHelperDatabaseSchemaTablesSections = new BabelTraverseHelper({maxLevel: 1});

let currentSchemaName = '';
let currentTableName = '';


const visitDatabaseSchemasTablesSections: Visitor = {
    TSPropertySignature(path) {
        const { node, parentPath } = path;

        currentTableName = (node.key as any).name;

        traverseHelperDatabaseSchemaTables.process(path);

        const resultPath = [currentSchemaName, currentTableName]

        set(result, resultPath, {})
    }
}

const visitDatabaseSchemasTables: Visitor = {
    TSPropertySignature(path) {
        const { node, parentPath } = path;

        currentTableName = (node.key as any).name;

        traverseHelperDatabaseSchemaTables.process(path);

        const resultPath = [currentSchemaName, currentTableName]

        set(result, resultPath, {})
    }
}

const visitDatabaseSchemasSection: Visitor = {
    TSPropertySignature(path) {
    // enter(path) {
        const { node, parentPath } = path;

        const name = (node.key as any).name;

        traverseHelperDatabaseSchemaSections.process(path);

        if (name === 'Tables') {
            traverseHelperDatabaseSchemaTables.reset();
            path.traverse(visitDatabaseSchemasTables);
        }
    }
}

const visitDatabaseSchemas: Visitor = {
    TSPropertySignature(path) {
        const { node, parentPath } = path;
        currentSchemaName = (node.key as any).name;

        traverseHelperDatabaseSchemas.process(path);

        // parentPath !== pathDatabaseBody ||
        if (currentSchemaName === 'graphql_public') {
            return;
        }

        result[currentSchemaName] = {};

        traverseHelperDatabaseSchemaSections.reset();
        path.traverse(visitDatabaseSchemasSection);
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
            // pathDatabaseBody = path.get('body') as NodePath;
            traverseHelperDatabaseSchemas.reset();
            path.traverse(visitDatabaseSchemas);
        }
    },
});

console.log(`Writing parsed raw types to "${supabaseRawParsedTypesPath}"`);
fs.writeFileSync(supabaseRawParsedTypesPath, JSON.stringify(parsed, null, '  '));

console.log(`Writing schema to "${supabaseSchemaJsonPath}"`);
fs.writeFileSync(supabaseSchemaJsonPath, JSON.stringify(result, null, '  '));