This method is like [A.max](/?id=max) except that it accepts iteratee which is invoked for each element in array to generate the criterion by which the value is ranked. The iteratee is invoked with one argument: (value).

## Arguments
array (Array): The array to iterate over.

[iteratee:=.identity] (Function): The iteratee invoked per element.


## Returns
(*): Returns the maximum value.