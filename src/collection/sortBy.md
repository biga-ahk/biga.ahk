Creates an array of elements, sorted in ascending order by the results of running each element in a collection thru each iteratee. This method performs a stable sort, that is, it preserves the original sort order of equal elements. The iteratees are invoked with one argument: (value).


## Arguments
collection (Array|Object): The collection to iterate over.

[iteratees:=.identity] (Function): The iteratees to sort by.


## Returns
(Array): Returns the new sorted array.
