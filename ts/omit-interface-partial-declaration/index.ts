import { PartialDeclarationExample } from "MyModule";

export const p: PartialDeclarationExample = {
  a: 1,
  b: 2,
  c: 'c',
  d: 'd',
}

export interface OmitPartialDeclarationExample extends Omit<PartialDeclarationExample, 'a' | 'c'> {
  a: string;
  e: string;
}

// Works OK
export const o: OmitPartialDeclarationExample = {
  a: '1',
  b: 2,
  d: 'd',
  e: 'e',
}

console.log('o:', o);
