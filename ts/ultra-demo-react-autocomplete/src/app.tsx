import useAsset from "ultra/hooks/use-asset.js";
import { useEffect, useState } from "react";

export default function App() {
  const [testVar, setTestVar] = useState(100);

  console.log(testVar);

  useEffect(() => {
    setTestVar((x: number) => x + 100)
  }, [])

  return (
    <html lang="en">
      <head>
        <meta charSet="utf-8" />
        <title>Ultra</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="shortcut icon" href={useAsset("/favicon.ico")} />
        <link rel="stylesheet" href={useAsset("/style.css")} />
      </head>
      <body>
        <main>
          <h1>
            <span></span>__<span></span>
          </h1>
          <p>
            Welcome to{" "}
            <strong>Ultra</strong>. This is a barebones starter for your web
            app.
          </p>
          <p>
            Take{" "}
            <a
              href="https://ultrajs.dev/docs"
              target="_blank"
            >
              this
            </a>, you may need it where you are going. It will show you how to
            customize your routing, data fetching, and styling with popular
            libraries.
          </p>
        </main>
      </body>
    </html>
  );
}
