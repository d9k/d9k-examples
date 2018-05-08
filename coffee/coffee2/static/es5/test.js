"use strict";

// Assignment:
var Account,
    author,
    cubes,
    in_array,
    in_array2,
    list,
    math,
    num,
    number,
    of_array,
    opposite,
    perfectSquares,
    quote,
    race,
    sentence,
    square,
    indexOf = [].indexOf;

number = 42;

opposite = true;

if (opposite) {
  // Conditions:
  number = -42;
}

// Functions:
square = function square(x) {
  return x * x;
};

// Arrays:
list = [1, 2, 3, 4, 5];

// Objects:
math = {
  root: Math.sqrt,
  square: square,
  cube: function cube(x) {
    return x * square(x);
  }
};

// Splats:
race = function race(winner) {
  for (var _len = arguments.length, runners = Array(_len > 1 ? _len - 1 : 0), _key = 1; _key < _len; _key++) {
    runners[_key - 1] = arguments[_key];
  }

  return print(winner, runners);
};

if (typeof elvis !== "undefined" && elvis !== null) {
  // Existence:
  alert("I knew it!");
}

// Array comprehensions:
cubes = function () {
  var i, len, results;
  results = [];
  for (i = 0, len = list.length; i < len; i++) {
    num = list[i];
    results.push(math.cube(num));
  }
  return results;
}();

//========================================
// fat arrows
// http://coffeescript.org/#fat-arrow
Account = function Account(customer, cart) {
  var _this = this;

  this.customer = customer;
  this.cart = cart;
  return $('.shopping_cart').on('click', function (event) {
    return _this.customer.purchase(_this.cart);
  });
};

//========================================
// Generator Functions
// see http://coffeescript.org/#generators
perfectSquares = /*#__PURE__*/regeneratorRuntime.mark(function perfectSquares() {
  return regeneratorRuntime.wrap(function perfectSquares$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          num = 0;

        case 1:
          if (!true) {
            _context.next = 7;
            break;
          }

          num += 1;
          _context.next = 5;
          return num * num;

        case 5:
          _context.next = 1;
          break;

        case 7:
        case "end":
          return _context.stop();
      }
    }
  }, perfectSquares, this);
});

window.ps || (window.ps = perfectSquares());

//========================================
// String interpolation
// http://coffeescript.org/#strings
author = "Wittgenstein";

quote = "A picture is a fact. -- " + author;

sentence = 22 / 7 + " is a decent approximation of \u03C0";

// in and of operators
// https://makandracards.com/makandra/31073-beware-coffeescript-in-is-not-the-javascript-in
in_array = indexOf.call({
  name: 'Horst' // => false
}, 'name') >= 0;

of_array = 'name' in {
  name: 'Horst' // => true
};

in_array2 = indexOf.call({ 'surnsame': 'surnsame', 'name': 'name', 'nickname': 'nickname' }, 'name') >= 0;