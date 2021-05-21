This method is like [A.invert](/?id=invert) except that the inverted object is generated from the results of running each element of object thru iteratee. The corresponding inverted value of each inverted key is an array of keys responsible for generating the inverted value. The iteratee is invoked with one argument: (value).

> [!Note]
> AutoHotkey object keys are always converted to lowercase.

## Arguments
object (Object): The object to invert.

[iteratee=A.identity] (Function): The iteratee invoked per element.

## Returns
(Array): Returns the new inverted object.
