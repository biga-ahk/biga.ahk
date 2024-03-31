Creates a function that memoizes the result of func. If resolver is provided, it determines the cache key for storing the result based on the arguments provided to the memoized function.


## Arguments
func (Function): The function to have its output memoized.

[resolver] (Function): The function to resolve the cache key.


## Returns
(Function): Returns the new memoized function.
