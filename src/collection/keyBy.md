Creates an object composed of keys generated from the results of running each element of collection thru iteratee. The corresponding value of each key is the last element responsible for generating the key. The iteratee is invoked with one argument: (value).


## Arguments
collection (Array|Object): The collection to iterate over.

[iteratee:=A.identity] (Function): The iteratee to transform keys.


## Returns
(Object): Returns the composed aggregate object.
