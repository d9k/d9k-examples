import { Book } from './Book';
import { Person } from './Person';

export type Engineer = Person & {
    specialization: string;
    favTechBooks: Book[];
}

