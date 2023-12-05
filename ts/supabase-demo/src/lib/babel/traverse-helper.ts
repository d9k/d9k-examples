import { NodePath } from "@babel/traverse";

export type BabelParserTraverseHelperConstructorArgs = {
    maxLevel?: number;
}

export class BabelTraverseHelper {
    _pathToLevel: WeakMap<NodePath, number>;
    maxLevel = 0;

    constructor(constructorArgs: BabelParserTraverseHelperConstructorArgs = {}) {
        this.reset();
        Object.assign(this, constructorArgs)
    }

    reset() {
        this._pathToLevel = new WeakMap();
    }

    process(newPath: NodePath) {
        const {maxLevel, _pathToLevel} = this;

        const newLevel = (_pathToLevel.get(newPath) || 0) + 1;
        _pathToLevel.set(newPath, newLevel);

        if (maxLevel && newLevel >= maxLevel) {
            newPath.skip();
        }
    }
}