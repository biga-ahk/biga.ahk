This method is like [A.mean](/?id=mean) except that it accepts iteratee which is invoked for each element in array to generate the value to be averaged. The iteratee is invoked with one argument: (value).

## Arguments
array (Array): The array to iterate over.

[iteratee:=.identity] (Function): The iteratee invoked per element.


## Returns
(number): Returns the mean.