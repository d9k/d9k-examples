/**
 * @NOTE Turn on "Run on save for files:" under Settings > Languages & Frameworks > JavaScript > Prettier. Make sure that .ts files are included.
 */
module.exports = {
  printWidth: 120,
  tabWidth: 2,
  useTabs: false,
  semi: true,
  singleQuote: true,
  quoteProps: 'as-needed',
  trailingComma: 'all',
  bracketSpacing: true,
  arrowParens: 'always',
  endOfLine: 'lf',
  importOrder: ['^@/', '^[./]'],
  importOrderParserPlugins: ['typescript', 'decorators-legacy'],
  importOrderSeparation: true,
  // plugins: ['@trivago/prettier-plugin-sort-imports'],
};
