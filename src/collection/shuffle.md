Creates an array of shuffled values, using a version of the [Fisher-Yates shuffle](https://en.wikipedia.org/wiki/Fisher-Yates_shuffle).

## Arguments
collection (Array|Object): The collection to shuffle.


## Returns
(Array): Returns the new shuffled array.


## Example
```autohotkey
A.shuffle([1, 2, 3, 4])
; => [4, 1, 3, 2]

A.shuffle(["barney", "fred", "pebbles"])
; => ["pebbles", "barney", "fred"]
```
