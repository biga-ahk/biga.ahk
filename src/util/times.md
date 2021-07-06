Invokes the iteratee `n` times, returning an array of the results of each invocation. The iteratee is invoked with one argument; (index).


## Arguments
n (number): The number of times to invoke iteratee.

[iteratee:=.identity] (Function): The function invoked per iteration.


## Returns
(Array): Returns the array of results.

## Example
```autohotkey
A.times(4, A.constant(0))
; => [0, 0, 0, 0]

; make an array with random numbers
boundFunc := A.random.bind(A, 1, 1000, 0)
array := A.times(5, boundFunc)
; => [395, 364, 809, 904, 449]
```