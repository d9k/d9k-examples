import { config } from 'dotenv';

import { SchemaConverter } from 'pg-tables-to-jsonschema';

config();

const {
    DB_HOST,
    DB_NAME,
    DB_PORT,
    DB_USER,
    DB_PASSWORD
} = process.env;

console.log({
    DB_HOST,
    DB_NAME,
    DB_PORT,
    DB_USER,
    DB_PASSWORD
});

if (!DB_HOST) {
    throw Error('DB_HOST not set');
}

if (!DB_PORT) {
    throw Error('DB_PORT not set');
}

if (!DB_USER) {
    throw Error('DB_USER not set');
}

if (!DB_NAME) {
    throw Error('DB_NAME not set');
}

const converter = new SchemaConverter( {
    pg: {
      host: DB_HOST,
      port: parseInt(DB_PORT, 10),
      user: DB_USER,
      password: DB_PASSWORD,
      database: DB_NAME,
    },
    input: {
      schemas: ['public'],
      exclude: ['not_this_table'],
      include: []
    },
    output: {
      additionalProperties: false,
      baseUrl: 'http://api.localhost.com/schema/',
      defaultDescription: 'Missing description',
      indentSpaces: 2,
      outDir: 'dist/schema',
      unwrap: false
    }
  } );

console.log(converter.convert());