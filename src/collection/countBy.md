Creates an object composed of keys generated from the results of running each element of collection thru iteratee. The corresponding value of each key is the number of times the key was returned by iteratee. The iteratee is invoked with one argument: (value).


## Arguments
object (Array|Object): The collection to iterate over.

[predicate:=.identity] (Function): The iteratee to transform keys.


## Returns
(Object): Returns the composed aggregate object.
