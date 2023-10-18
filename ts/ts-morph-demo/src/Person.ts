export enum Gender {
    male = 'male',
    female = 'female',
}

export type Person = {
    name: string;
    age: number;
    gender?: Gender;
    skin?: 'white' | 'black' | 'yellow' | 'red';
}

