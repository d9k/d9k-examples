import { Person } from './Person';

export type Engineer = Person & {
    specialization: string;
}

