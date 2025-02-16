/**
 * Temporary solution till https://github.com/denoland/vscode_deno/issues/1255 or https://github.com/QwikDev/qwik/issues/7347 fixed.
 */
import type { QwikIntrinsicElements } from '@builder.io/qwik';

declare global {
    namespace JSX {
        interface IntrinsicElements extends QwikIntrinsicElements {}
    }
    const React: any;
}