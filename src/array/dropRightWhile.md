Creates a slice of array excluding elements dropped from the end. Elements are dropped until predicate returns falsey. The predicate is invoked with three arguments: (value, index, array).


## Arguments
array (Array): The array to query.

[predicate:=.identity] (Function): The function invoked per iteration.


## Returns

(Array): Returns the slice of array.
