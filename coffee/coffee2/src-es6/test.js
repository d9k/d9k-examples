  // Assignment:
var Account, author, cubes, in_array, in_array2, list, math, num, number, of_array, opposite, perfectSquares, quote, race, sentence, square,
  indexOf = [].indexOf;

number = 42;

opposite = true;

if (opposite) {
  // Conditions:
  number = -42;
}

// Functions:
square = function(x) {
  return x * x;
};

// Arrays:
list = [1, 2, 3, 4, 5];

// Objects:
math = {
  root: Math.sqrt,
  square: square,
  cube: function(x) {
    return x * square(x);
  }
};

// Splats:
race = function(winner, ...runners) {
  return print(winner, runners);
};

if (typeof elvis !== "undefined" && elvis !== null) {
  // Existence:
  alert("I knew it!");
}

// Array comprehensions:
cubes = (function() {
  var i, len, results;
  results = [];
  for (i = 0, len = list.length; i < len; i++) {
    num = list[i];
    results.push(math.cube(num));
  }
  return results;
})();

//========================================
// fat arrows
// http://coffeescript.org/#fat-arrow
Account = function(customer, cart) {
  this.customer = customer;
  this.cart = cart;
  return $('.shopping_cart').on('click', (event) => {
    return this.customer.purchase(this.cart);
  });
};

//========================================
// Generator Functions
// see http://coffeescript.org/#generators
perfectSquares = function*() {
  num = 0;
  while (true) {
    num += 1;
    yield num * num;
  }
};

window.ps || (window.ps = perfectSquares());

//========================================
// String interpolation
// http://coffeescript.org/#strings
author = "Wittgenstein";

quote = `A picture is a fact. -- ${author}`;

sentence = `${22 / 7} is a decent approximation of π`;

// in and of operators
// https://makandracards.com/makandra/31073-beware-coffeescript-in-is-not-the-javascript-in
in_array = indexOf.call({
  name: 'Horst' // => false
}, 'name') >= 0;

of_array = 'name' in {
  name: 'Horst' // => true
};

in_array2 = indexOf.call({'surnsame': 'surnsame', 'name': 'name', 'nickname': 'nickname'}, 'name') >= 0;
