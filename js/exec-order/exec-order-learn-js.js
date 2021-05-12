// https://learn.javascript.ru/event-loop#makrozadachi-i-mikrozadachi

setTimeout(() => console.log("timeout"));

queueMicrotask(() => console.log("microtask"))

Promise.resolve()
  .then(() => console.log("promise"));

console.log("code");

// code появляется первым, т.к. это обычный синхронный вызов.
// microtask и promise появляются вторыми, потому что .then проходит через очередь микрозадач и выполняется после текущего синхронного кода.
// timeout появляется последним, потому что это макрозадача.
