import { config } from 'dotenv';

import { execFileSync, CommonExecOptions } from 'child_process';

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
    DB_USER
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

const connectionString = `postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}`

console.log(connectionString);

const execOptions: CommonExecOptions = {stdio: 'inherit'};

console.log('Updating JSON schema');

execFileSync(
    'tbls',
    [
        'out',
        '-t',
        'json',
        '-o',
        'tbls-out/schema.json',
        connectionString
    ],
    execOptions
);

console.log('Updating doc');

execFileSync(
    'tbls',
    [
        'doc',
        // '-o',
        // 'tbls-out/doc',
        '--rm-dist',
        connectionString
    ],
    execOptions
);