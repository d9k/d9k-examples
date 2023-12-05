/** https://github.com/babel/babel/discussions/14578#discussioncomment-2810253 */
// TODO
import * as fs from 'fs';
import { TSPropertySignature } from '@babel/types';
import { parse } from '@babel/parser';
import traverse, { Node, NodePath, Visitor } from '@babel/traverse';
import set from 'lodash/set';
import { BabelTraverseHelper } from './src/lib/babel/traverse-helper';

import jsonLoose from 'json-loose'

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

// const getCode = <P extends Node,>(path: NodePath<P>) => {
//     const { node } = path;
//     const { start, end } = node;

//     if (start && end) {
//         return source.slice(start, end);
//     }
// }

type SupabaseRelationInfo = {
    columns: string[];
    foreignKeyName: string;
    isOneToOne: boolean;
    referencedColumns: string[];
    referencedRelation: string;
}

type DbFieldFkInfo = {
    fkName: string;
    foreignSchema?: string;
    foreignTable: string;
    foreignField: string;
    isOneToOne: boolean;
}

type DbFieldInfo = {
    description?: string;
    name: string;
    type: string;
    nullable: boolean;
    fkInfo?: DbFieldFkInfo;
}

type DbTable = {
    properties: DbFieldInfo[];
}

type DbSchema = {[tableName: string]: DbTable};
type DbStructure = {[schemaName: string]: DbSchema};

const result: DbStructure = {};

const traverseHelperDbSchemas = new BabelTraverseHelper({maxLevel: 1});
const traverseHelperDbSchemaSections = new BabelTraverseHelper({maxLevel: 1});
const traverseHelperDbTables = new BabelTraverseHelper({maxLevel: 1});
const traverseHelperDbTablesSections = new BabelTraverseHelper({maxLevel: 1});
const traverseHelperDbTablesFields = new BabelTraverseHelper({maxLevel: 1});

let currentSchemaName = '';
let currentTableName = '';
let currentTableRelationsInfo: SupabaseRelationInfo[] = [];

const visitDbTablesFields: Visitor = {
    // TSPropertySignature(path) {
    TSPropertySignature(path) {
        const { node, parentPath } = path;

        const fieldName = (node.key as any).name;

        const resultPath = [currentSchemaName, currentTableName, fieldName];

        const typeString = `${path.get('typeAnnotation.typeAnnotation')}`

        const typeParts = typeString.split(/[ ]*\|[ ]*/g);

        traverseHelperDbTablesFields.process(path);

        const fieldInfo: DbFieldInfo = {
            name: fieldName,
            nullable: false,
            type: '',
        }

        typeParts.forEach((typePart) => {
            if (typePart === 'null') {
                fieldInfo.nullable = true;
            } else {
                fieldInfo.type = typePart;
            }
        })

        set(result, resultPath, fieldInfo);
    }
}

const visitDbTablesSections: Visitor = {
    TSPropertySignature(path) {
        const { node } = path;

        const sectionName = (node.key as any).name;
        traverseHelperDbTablesSections.process(path);

        switch (sectionName) {
            case 'Row':
                traverseHelperDbTablesFields.reset();
                path.traverse(visitDbTablesFields);
                break;
            case 'Relationships':
                const relationsString = `${path.get('typeAnnotation.typeAnnotation')}`;
                const jsonEncodedRelationsBroken = relationsString.replace(/;$/gm, ',');
                const jsonEncodedRelations = jsonLoose(jsonEncodedRelationsBroken);
                currentTableRelationsInfo = JSON.parse(jsonEncodedRelations);
                break;
        }
    }
}

const visitDatabaseSchemasTables: Visitor = {
    TSPropertySignature(path) {
        const { node } = path;

        currentTableName = (node.key as any).name;

        traverseHelperDbTables.process(path);

        const resultPath = [currentSchemaName, currentTableName]
        set(result, resultPath, {})

        currentTableRelationsInfo = [];
        traverseHelperDbTablesSections.reset();
        path.traverse(visitDbTablesSections);
        currentTableRelationsInfo.forEach((relationInfo) => {
            const {columns, foreignKeyName, isOneToOne, referencedColumns, referencedRelation} = relationInfo;

            for (let i = 0; i < columns.length; i ++) {
                const column = columns[i];
                const referencedColumn = referencedColumns[i];

                const fkResultPath = [currentSchemaName, currentTableName, column, 'fkInfo']

                const fkInfo: DbFieldFkInfo = {
                    foreignField: referencedColumn,
                    fkName: foreignKeyName,
                    isOneToOne,
                    foreignTable: referencedRelation,
                }

                set(result, fkResultPath, fkInfo);
            }
        })
    }
}

const visitDatabaseSchemasSection: Visitor = {
    TSPropertySignature(path) {
        const { node } = path;

        const name = (node.key as any).name;

        traverseHelperDbSchemaSections.process(path);

        if (name === 'Tables') {
            traverseHelperDbTables.reset();
            path.traverse(visitDatabaseSchemasTables);
        }
    }
}

const visitDatabaseSchemas: Visitor = {
    TSPropertySignature(path) {
        const { node, parentPath } = path;
        currentSchemaName = (node.key as any).name;

        traverseHelperDbSchemas.process(path);

        if (currentSchemaName === 'graphql_public') {
            return;
        }

        result[currentSchemaName] = {};

        traverseHelperDbSchemaSections.reset();
        path.traverse(visitDatabaseSchemasSection);
    }
}

traverse(parsed, {
    TSInterfaceDeclaration(path) {
        const {node } = path;
        const {id: {name}} = node;
        if (name === 'Database') {
            traverseHelperDbSchemas.reset();
            path.traverse(visitDatabaseSchemas);
        }
    },
});

console.log(`Writing parsed raw types to "${supabaseRawParsedTypesPath}"`);
fs.writeFileSync(supabaseRawParsedTypesPath, JSON.stringify(parsed, null, '  '));

console.log(`Writing schema to "${supabaseSchemaJsonPath}"`);
fs.writeFileSync(supabaseSchemaJsonPath, JSON.stringify(result, null, '  '));