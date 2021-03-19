Creates an array of elements split into two groups, the first of which contains elements predicate returns truthy for, the second of which contains elements predicate returns falsey for. The predicate is invoked with one argument: (value).


## Arguments
collection (Array|Object): The collection to iterate over.

[predicate:=.identity] (Function): The function invoked per iteration.


## Returns
(Array): Returns the array of grouped elements.
