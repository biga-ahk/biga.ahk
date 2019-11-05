This method recursively merges own and inherited enumerable string keyed properties of source objects into the destination object. Array and plain object properties are merged recursively. Other objects and value types are overridden by assignment. Source objects are applied from left to right. Subsequent sources overwrite property assignments of previous sources.


## Arguments
object (Object): The destination object.

[sources] (...Object): The source objects.


## Returns
(Object): Returns object.
