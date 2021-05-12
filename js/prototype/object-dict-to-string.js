// https://learn.javascript.ru/prototype-methods

// ваш код, который добавляет метод dictionary.toString

// НЕ РАБОТАЕТ!!
//let dictionary = Object.create(null, {
  //toString: function() {
    //let result = [];
    //for(let key in this) {
      //result.push(key); // "apple", затем "__proto__"
    //}
    //return result.join(',');
  //}
//});


let dictionary = Object.create(null, {
  toString: { // определяем свойство toString
    value() { // значение -- это функция
      return Object.keys(this).join();
    }
  }
});



// добавляем немного данных
dictionary.apple = "Apple";
dictionary.__proto__ = "test"; // здесь __proto__ -- это обычный ключ

// только apple и __proto__ выведены в цикле
for(let key in dictionary) {
  console.log(key); // "apple", затем "__proto__"
}

// ваш метод toString в действии
console.log(dictionary + ''); // "apple,__proto__"
