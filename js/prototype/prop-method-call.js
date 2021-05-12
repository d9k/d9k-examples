function Rabbit(name) {
  this.name = name;
}
Rabbit.prototype.sayHi = function() {
  console.log(this.name);
};

let rabbit = new Rabbit("Rabbit");

rabbit.sayHi();
// Rabbit

Rabbit.prototype.sayHi();
// undefined

Rabbit.prototype.sayHi.call(rabbit);
// Rabbit

Object.getPrototypeOf(rabbit).sayHi();
// undefined

Object.getPrototypeOf(rabbit).sayHi.apply(rabbit)
// Rabbit

rabbit.__proto__.sayHi();
// undefined

rabbit.__proto__.sayHi.apply(rabbit)
// Rabbit
