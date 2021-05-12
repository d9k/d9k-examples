// https://learn.javascript.ru/native-prototypes

// Добавьте всем функциям в прототип метод defer(ms), который вызывает функции через ms миллисекунд.

function f() {
  console.log("Hello!");
}

Function.prototype.defer = function(ms) {
  return setTimeout(this, ms);
}

f.defer(1000);

// Добавьте всем функциям в прототип метод defer(ms), который возвращает обёртку, откладывающую вызов функции на ms миллисекунд.

function f2(a, b) {
  console.log(a + b);
}

Function.prototype.defer2 = function(ms) {
  let _this = this;

  return function() {
    let args = Array.prototype.slice.call(arguments)
    let fnBinded = _this.bind.apply(_this, [_this].concat(args))

    return setTimeout(
      fnBinded,
      ms
    );
  }
}

f2.defer2(1000)(1,2);

