Checks if predicate returns truthy for **any** element of collection. Iteration is stopped once predicate returns truthy. The predicate is invoked with three arguments: (value, index|key, collection).


## Arguments
collection (Array|Object): The collection to iterate over.

[iteratees:=.identity] (Function): The function invoked per iteration.


## Returns
(Array): Returns true if any element passes the predicate check, else false.
