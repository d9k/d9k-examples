/** https://github.com/GoodRequest/joi-type-extract/issues/3 */

/** Case 1 */

export type A = {
    name: string;
    size: string;
};

export type B = A & {
    size: number;
};

const b: B = {
    name: 'ogre',

    // TS2322 error: Type 'number' is not assignable to type 'never'.
    size: 3.5,
};

/** Case 2 */

export type A2 = {
  name: string;
  size: string;
};

export type B2 = Omit<A2, 'size'> & {
  size: number;
};

const b2: B2 = {
  name: 'ogre',

  // Works
  size: 3.5,
};