This method is like [A.find](/?id=find) except that it returns the index of the first element predicate returns truthy for instead of the element itself.


## Arguments
array (Array): The array to inspect.

[predicate:=.identity] (Function): The function invoked per iteration.

[fromIndex:=1] (number): The index to search from.


## Returns
(number): Returns the index of the found element, else -1.
