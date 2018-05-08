# Assignment:
number   = 42
opposite = true

# Conditions:
number = -42 if opposite

# Functions:
square = (x) -> x * x

# Arrays:
list = [1, 2, 3, 4, 5]

# Objects:
math =
  root:   Math.sqrt
  square: square
  cube:   (x) -> x * square x

# Splats:
race = (winner, runners...) ->
  print winner, runners

# Existence:
alert "I knew it!" if elvis?

# Array comprehensions:
cubes = (math.cube num for num in list)

#========================================
# fat arrows
# http://coffeescript.org/#fat-arrow

Account = (customer, cart) ->
  @customer = customer
  @cart = cart

  $('.shopping_cart').on 'click', (event) =>
    @customer.purchase @cart

#========================================
# Generator Functions
# see http://coffeescript.org/#generators

perfectSquares = ->
  num = 0
  loop
    num += 1
    yield num * num
  return

window.ps or= perfectSquares()

#========================================
# String interpolation
# http://coffeescript.org/#strings

author = "Wittgenstein"
quote  = "A picture is a fact. -- #{ author }"

sentence = "#{ 22 / 7 } is a decent approximation of π"

# in and of operators
# https://makandracards.com/makandra/31073-beware-coffeescript-in-is-not-the-javascript-in

in_array = 'name' in {name: 'Horst'} # => false
of_array = 'name' of {name: 'Horst'} # => true
in_array2 = 'name' in {'surnsame', 'name', 'nickname'}
