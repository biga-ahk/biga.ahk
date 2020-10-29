Creates an object composed of keys generated from the results of running each element of collection thru iteratee. The order of grouped values is determined by the order they occur in collection. The corresponding value of each key is an array of elements responsible for generating the key. The iteratee is invoked with one argument: (value).


<!-- Aliases
_.each -->


## Arguments
collection (Array|Object): The collection to iterate over.

[iteratee:=.identity] (Function): The iteratee to transform keys.


## Returns
(Object): Returns the composed aggregate object.
