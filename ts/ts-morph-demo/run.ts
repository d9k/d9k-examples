import { Project } from "ts-morph";

/**
 * @see https://ts-morph.com/navigation/example
 * @see https://stackoverflow.com/a/70079643/1760643
 */
const project = new Project();
project.addSourceFilesAtPaths("src/**/*.ts");

const sourceFile = project.getSourceFileOrThrow("src/Engineer.ts");

const hasClasses = sourceFile.getClasses().length > 0;
const interfaces = sourceFile.getInterfaces();

// person interface
// const personInterface = sourceFile.getInterface("Engineer")!;
// const personInterface = sourceFile.getInterface("Engineer")!;
console.log(
    sourceFile.getClasses()
    // personInterface.isDefaultExport(), // returns true
    // personInterface.getName(), // returns "Person"
    // personInterface.getProperties(), // returns the properties
);

// const declarations = variableDeclaration.getType().getSymbolOrThrow().getDeclarations();
// const declarations = personInterface.getType().getSymbolOrThrow().getDeclarations();

// console.log(declarations[0].getText());

for (const [name, declarations] of sourceFile.getExportedDeclarations()) {
  console.log(`${name}: ${declarations.map(d => d.getText()).join(", ")}`);

  declarations.map((d) => {
    const properties = d.getType().getProperties();
    properties.map((p) => {
      const propertyName = p.getName();
      const propertyType = p.getDeclarations()[0].getType().getText();
      console.log(`${propertyName}: ${propertyType}`);
    });
  });
}