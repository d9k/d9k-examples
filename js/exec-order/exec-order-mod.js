// что выведется и почему?
// google микротаски, макротаски

let i;
for (i = 0; i < 3; i++) {
    const log = () => {
        console.log(i);
    }
    setTimeout(log);
}

console.log('test');

Promise.reject()
    .then(() => console.log(3))
    .catch(() => console.log(4))
    .catch(() => console.log(5))
    .then(() => console.log(6));

function foo() {
    console.log(bar);
    var bar = 8;
    function bar() { return 9; }
    function bar() { return 10; }
}

foo()
