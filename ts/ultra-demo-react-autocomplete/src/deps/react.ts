/**
 * Ugly hack to fix "Go to definition" command in VS Code
 *
 * Mapped to `"react-fixed"` module in `importMap.json`
 *
 * TODO https://github.com/exhibitionist-digital/ultra/issues/287
*/

// TODO `export *` doesn't work! Error: Module '"https://esm.sh/v128/@types/react@18.2.38/index"' uses 'export =' and cannot be used with 'export *'.deno-ts(2498)
// @deno-types="@types/react"
// export * from "react";

// @deno-types="@types/react"
export {
  useState,
  useEffect,
  // TODO rest members
} from "https://esm.sh/react@18.2.0?dev"

// @deno-types="@types/react"
import react from "https://esm.sh/react@18.2.0?dev"
export default react;