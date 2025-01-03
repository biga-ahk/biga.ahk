# Quick Start

See [Getting Started](https://biga-ahk.github.io/biga.ahk/#/getting-started) for installation, inclusion, and initializiation.

### Attributes

By default the following attributes are as follows:

`A.throwExceptions := true`
Wherever typeif errors can be detected, biga.ahk will throw an exception pointing out the location the error occurred. Set this to `false` if you would like your script to continue without being stopped by exceptions.

`A.limit := -1`
Determines the number of times strings will be replaced when using [.replace](#replace) with a string argument. Set this to `1` to get closer to a javascript experience.

<br><br>

# **Array methods**
## .chunk

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/chunk.ahk' class='text-muted'>source</a>

Creates an array of elements split into groups the length of `size`. If array can't be split evenly, the final chunk will be the remaining elements.


#### Arguments
array (Array): The array to process.

[size:=1] (number): The length of each chunk


#### Returns
(Array): Returns the new array of chunks.


#### Example

```autohotkey
A.chunk(["a", "b", "c", "d"], 2)
; => [["a", "b"], ["c", "d"]]

A.chunk(["a", "b", "c", "d"], 3)
; => [["a", "b", "c"], ["d"]]

```



## .compact

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/compact.ahk' class='text-muted'>source</a>

Creates an array with all falsey values removed. The values `false`, `0`, and `""` are falsey.


#### Arguments
array (Array): The array to compact.


#### Returns
(Array): Returns the new array of filtered values.


#### Example

```autohotkey
A.compact([0, 1, false, 2, "", 3])
; => [1, 2, 3]

```



## .concat

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/concat.ahk' class='text-muted'>source</a>

Creates a new array concatenating `array` with any additional arrays and/or values.

#### Arguments
array (Array): The array to concatenate.

[values] (...*): The values to concatenate.


#### Returns
(Array): Returns the new concatenated array.


#### Example

```autohotkey
array := [1]
A.concat(array, 2, [3], [[4]])
; => [1, 2, 3, [4]]

A.concat(array)
; => [1]

```



## .depthOf

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/depthOf.ahk' class='text-muted'>source</a>

This method is explores `array` and returns the maximum depth.


#### Arguments
array (Array): The array to inspect.


#### Returns
(number): Returns the maximum depth.


#### Example

```autohotkey
A.depthOf([1])
; => 1

A.depthOf([1, [2]])
; => 2

A.depthOf([1, [[2]]])
; => 3

A.depthOf([1, [2, [3, [4]], 5]])
; => 4

```



## .difference

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/difference.ahk' class='text-muted'>source</a>

Creates an array of `array` values not included in the other given arrays. The order of result values are determined by the first array.

#### Arguments
array (Array): The array to inspect.

values (...Array): The values to exclude.


#### Returns
(Array): Returns the new array of filtered values.


#### Example

```autohotkey
A.difference([2, 1], [2, 3])
; => [1]

```



## .drop

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/drop.ahk' class='text-muted'>source</a>

Creates a slice of `array` with `n` elements dropped from the beginning.


#### Arguments
array (Array): The array to query.

[n:=1] (number): The number of elements to drop.


#### Returns
(Array): Returns the slice of array.


#### Example

```autohotkey
A.drop([1, 2, 3])
; => [2, 3]

A.drop([1, 2, 3], 2)
; => [3]

A.drop([1, 2, 3], 5)
; => []

A.drop([1, 2, 3], 0)
; => [1, 2, 3]

A.drop("fred")
; => ["r", "e", "d"]

A.drop(100)
; => ["0", "0"]

```



## .dropRight

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/dropRight.ahk' class='text-muted'>source</a>

Creates a slice of `array` with `n` elements dropped from the end.


#### Arguments
array (Array): The array to query.

[n:=1] (number): The number of elements to drop.


#### Returns
(Array): Returns the slice of array.


#### Example

```autohotkey
A.dropRight([1, 2, 3])
; => [1, 2]

A.dropRight([1, 2, 3], 2)
; => [1]

A.dropRight([1, 2, 3], 5)
; => []

A.dropRight([1, 2, 3], 0)
; => [1, 2, 3]

A.dropRight("fred")
; => ["f", "r", "e"]

A.dropRight(100)
; => ["1", "0"]

```



## .dropRightWhile

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/dropRightWhile.ahk' class='text-muted'>source</a>

Creates a slice of `array` excluding elements dropped from the end. Elements are dropped until `predicate` returns falsey. The predicate is invoked with three arguments: (value, index, array).


#### Arguments
array (Array): The array to query.

[predicate:=.identity] (Function): The function invoked per iteration.


#### Returns

(Array): Returns the slice of array.


#### Example

```autohotkey
users := [ {"user": "barney", 	"active": true}
		, {"user": "fred",		"active": false}
		, {"user": "pebbles", 	"active": false} ]
A.dropRightWhile(users, func("fn_dropRightWhile"))
; => [{"user": "barney", "active": true }]

fn_dropRightWhile(o)
{
	return !o.active
}
; The A.matches iteratee shorthand.
A.dropRightWhile(users, {"user": "pebbles", "active": false})
; => [ {"user": "barney", "active": true }, {"user": "fred", "active": false} ]

; The A.matchesProperty iteratee shorthand.
A.dropRightWhile(users, ["active", false])
; => [ {"user": "barney", "active": true } ]

; The A.property iteratee shorthand.
A.dropRightWhile(users, "active")
; => [ {"user": "barney", "active": true }, {"user": "fred", "active": false }, {"user": "pebbles", "active": false} ]

```



## .dropWhile

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/dropWhile.ahk' class='text-muted'>source</a>

Creates a slice of `array` excluding elements dropped from the beginning. Elements are dropped until `predicate` returns falsey. The predicate is invoked with three arguments: (value, index, array).


#### Arguments
array (Array): The array to query.

[predicate:=.identity] (Function): The function invoked per iteration.


#### Returns
(Array): Returns the slice of array.


#### Example

```autohotkey
users := [ {"user": "barney", 	"active": false }
		, { "user": "fred", 	"active": false }
		, { "user": "pebbles", 	"active": true } ]
A.dropWhile(users, func("fn_dropWhile"))
; => [{ "user": "pebbles", "active": true }]

fn_dropWhile(o)
{
	return !o.active
}
; The A.matches iteratee shorthand.
A.dropWhile(users, {"user": "barney", "active": false})
; => [ { "user": "fred", "active": false }, { "user": "pebbles", "active": true } ]

; The A.matchesProperty iteratee shorthand.
A.dropWhile(users, ["active", false])
; => [ {"user": "pebbles", "active": true } ]

; The A.property iteratee shorthand.
A.dropWhile(users, "active")
; => [ {"user": "barney", "active": false }, { "user": "fred", "active": false }, { "user": "pebbles", "active": true } ]

```



## .fill

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/fill.ahk' class='text-muted'>source</a>

Fills elements of `array` with value from `start` up to, but not including, `end`.

> [!Note]
> Unlike it's Lodash counterpart, this method does NOT mutate the array.


#### Arguments
array (Array): The array to fill.

value (*): The value to fill array with.

[start:=1] (number): The start position.

[end:=array.length] (number): The end position.


#### Returns
(Array): Returns array.


#### Example

```autohotkey
array := [1, 2, 3]
A.fill(array, "a")
; => ["a", "a", "a"]

A.fill([4, 6, 8, 10], "*", 2, 3)
; => [4, "*", "*", 10]

```



## .findIndex

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/findIndex.ahk' class='text-muted'>source</a>

This method is like [A.find](/?id=find) except that it returns the index of the first element `predicate` returns truthy for instead of the element itself.


#### Arguments
array (Array): The array to inspect.

[predicate:=.identity] (Function): The function invoked per iteration.

[fromIndex:=1] (number): The index to search from.


#### Returns
(number): Returns the index of the found element, else -1.


#### Example

```autohotkey
users := [ { "user": "barney", "age": 36, "active": true }
	, { "user": "fred", "age": 40, "active": false }
	, { "user": "pebbles", "age": 1, "active": true } ]
; The A.matches iteratee shorthand.
A.findIndex(users, { "age": 1, "active": true })
; => 3

; The A.matchesProperty iteratee shorthand.
A.findIndex(users, ["active", false])
; => 2

; The A.property iteratee shorthand.
A.findIndex(users, "active")
; => 1

```



## .findLastIndex

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/findLastIndex.ahk' class='text-muted'>source</a>

This method is like [A.findIndex](/?id=findindex) except that it iterates over elements of collection from right to left.

#### Arguments
array (Array): The array to inspect.

[predicate:=.identity] (Function): The function invoked per iteration.

[fromIndex:=array.count()] (number): The index to search from.


#### Returns
(key): Returns the key of the found element, else -1.


#### Example

```autohotkey
users := [{"user": "barney", "active": true}
		, {"user": "fred", "active": false}
		, {"user": "pebbles", "active": false}]
A.findLastIndex(users, {"user": "barney", "active": true})
; => 1

A.findLastIndex(users, ["active", true])
; => 1

A.findLastIndex(users, "active")
; => 1

```



## .flatten

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/flatten.ahk' class='text-muted'>source</a>

Flattens `array` a single level deep.


#### Arguments
array (Array): The array to flatten.


#### Returns
(Array): Returns the new flattened array.


#### Example

```autohotkey
A.flatten([1, [2, [3, [4]], 5]])
; => [1, 2, [3, [4]], 5]

A.flatten([[1, 2, 3], [4, 5, 6]])
; => [1, 2, 3, 4, 5, 6]

```



## .flattenDeep

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/flattenDeep.ahk' class='text-muted'>source</a>

Recursively flattens `array`.


#### Arguments
array (Array): The array to flatten.


#### Returns
(Array): Returns the new flattened array.


#### Example

```autohotkey
A.flattenDeep([1])
; => [1]

A.flattenDeep([1, [2]])
; => [1, 2]

A.flattenDeep([1, [2, [3, [4]], 5]])
; => [1, 2, 3, 4, 5]

```



## .flattenDepth

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/flattenDepth.ahk' class='text-muted'>source</a>

Recursively flatten `array` up to depth times.


#### Arguments
array (Array): The array to flatten.

[depth:=1] (number): The maximum recursion depth.


#### Returns
(Array): Returns the new flattened array.


#### Example

```autohotkey
A.flattenDepth([1, [2, [3, [4]], 5]], 1)
; => [1, 2, [3, [4]], 5]

A.flattenDepth([1, [2, [3, [4]], 5]], 2)
; => [1, 2, 3, [4], 5]

```



## .fromPairs

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/fromPairs.ahk' class='text-muted'>source</a>

The inverse of A.toPairs; this method returns an object composed from key-value pairs.

#### Arguments
pairs (Array): The key-value pairs.


#### Returns
(Object): Returns the new object.


#### Example

```autohotkey
A.fromPairs([["a", 1], ["b", 2]])
; => {"a": 1, "b": 2}

```



## .head

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/head.ahk' class='text-muted'>source</a>

Gets the first element of `array`.

#### Aliases
`.first`

#### Arguments
array (Array): The array to query.


#### Returns
(*): Returns the first element of array.


#### Example

```autohotkey
A.head([1, 2, 3])
; => 1

A.head([])
; => ""

A.head("fred")
; => "f"

A.head(100)
; => "1"

```



## .indexOf

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/indexOf.ahk' class='text-muted'>source</a>

Gets the index at which the first occurrence of `value` is found in `array`. If `fromIndex` is negative, it's used as the offset from the end of `array`.


#### Arguments
array (Array): The array to inspect.

value (*): The value to search for.

[fromIndex:=1] (number): The index to search from.


#### Returns
(number): Returns the index of the matched value, else -1.


#### Example

```autohotkey
A.indexOf([1, 2, 1, 2], 2)
; => 2

; Search from the `fromIndex`.
A.indexOf([1, 2, 1, 2], 2, 3)
; => 4

A.indexOf(["fred", "barney"], "pebbles")
; => -1

StringCaseSense, On
A.indexOf(["fred", "barney"], "Fred")
; => -1

```



## .initial

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/initial.ahk' class='text-muted'>source</a>

Gets all but the last element of `array`.


#### Arguments
array (Array): The array to query.

#### Returns
(Array): Returns the slice of array.


#### Example

```autohotkey
A.initial([1, 2, 3])
; => [1, 2]

A.initial("fred")
; => ["f", "r", "e"]

A.initial(100)
; => ["1", "0"]

```



## .intersection

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/intersection.ahk' class='text-muted'>source</a>

Creates an array of unique values that are included in all given arrays. The order of result values are determined by the first array.


#### Arguments
[arrays*] (...Array): The arrays to inspect.


#### Returns
(Array): Returns the new array of intersecting values.


#### Example

```autohotkey
A.intersection([2, 1], [2, 3])
; => [2]

```



## .join

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/join.ahk' class='text-muted'>source</a>

Converts all elements in `array` into a string separated by `separator`.


#### Arguments
array (Array): The array to convert.

[separator:=","] (string): The element separator.


#### Returns
(string): Returns the joined string.


#### Example

```autohotkey
A.join(["a", "b", "c"], "~")
; => "a~b~c"

A.join(["a", "b", "c"])
; => "a,b,c"

```



## .last

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/last.ahk' class='text-muted'>source</a>

Gets the last element of `array`.


#### Arguments
array (Array): The array to query.


#### Returns
(*): Returns the last element of array.


#### Example

```autohotkey
A.last([1, 2, 3])
; => 3

A.last([])
; => ""

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/lastIndexOf.ahk' class='text-muted'>source</a>

This method is like [A.indexOf](/?id=indexof) except that it iterates over elements of `array` from right to left.


#### Arguments
array (Array): The array to inspect.

value (*): The value to search for.

[fromIndex:=array.count()] (number): The index to search from.


#### Returns
(number): Returns the index of the matched value, else -1.


#### Example

```autohotkey
A.lastIndexOf([1, 2, 1, 2], 2)
; => 4

; Search from the `fromIndex`.
A.lastIndexOf([1, 2, 1, 2], 1, 2)
; => 1

StringCaseSense, On
A.lastIndexOf(["fred", "barney"], "Fred")
; => -1

```



## .nth

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/nth.ahk' class='text-muted'>source</a>

Gets the element at index `n` of `array`. If `n` is negative, the nth element from the end is returned.


#### Arguments
array (Array): The array to query.

[n:=1] (number): The index of the element to return.


#### Returns
(*): Returns the nth element of array.


#### Example

```autohotkey
A.nth([1, 2, 3])
; => 1

A.nth([1, 2, 3], -3)
; => 1

A.nth([1, 2, 3], 5)
; => ""

A.nth("fred")
; => "f"

A.nth(100)
; => "1"

A.nth([1, 2, 3], 0)
; => 1

```



## .reverse

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/reverse.ahk' class='text-muted'>source</a>

Reverses `array` so that the first element becomes the last, the second element becomes the second to last, and so on.


#### Arguments
array (Array): The array to modify.


#### Returns
(Array): Returns array.


#### Example

```autohotkey
A.reverse(["a", "b", "c"])
; => ["c", "b", "a"]

A.reverse([{"foo": "bar"}, "b", "c"])
; => ["c", "b", {"foo": "bar"}]

A.reverse([[1, 2, 3], "b", "c"])
; => ["c", "b", [1, 2, 3]]

```



## .slice

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/slice.ahk' class='text-muted'>source</a>

Creates a slice of `array` from `start` up to, but not including, `end`.


#### Arguments
array (Array): The array to slice.

[start:=1] (number): The start position.

[end:=array.count()] (number): The end position.


#### Returns
(Array): Returns the slice of array.


#### Example

```autohotkey
A.slice([1, 2, 3], 1, 2)
; => [1, 2]

A.slice([1, 2, 3], 1)
; => [1, 2, 3]

A.slice([1, 2, 3], 5)
; => []

A.slice("fred")
; => ["f", "r", "e", "d"]

A.slice(100)
; => ["1", "0", "0"]

```



## .sortedIndex

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/sortedIndex.ahk' class='text-muted'>source</a>

Uses a binary search to determine the lowest index at which value should be inserted into `array` in order to maintain its sort order.


#### Arguments
array (Array): The sorted array to inspect.

value (*): The value to evaluate.


#### Returns
(number): Returns the index at which value should be inserted into array.


#### Example

```autohotkey
A.sortedIndex([30, 50], 40)
; => 2

```



## .sortedIndexOf

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/sortedIndexOf.ahk' class='text-muted'>source</a>

This method is like [A.indexOf](/?id=indexOf) except that it performs a binary search on a sorted `array`.


#### Arguments
array (Array): The sorted array to inspect.

value (*): The value to search for.


#### Returns
(number): Returns the index of the matched value, else `-1`.


#### Example

```autohotkey
A.sortedIndexOf([4, 5, 5, 6], 5)
; => 2

```



## .sortedUniq

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/sortedUniq.ahk' class='text-muted'>source</a>

This method is like [A.uniq](/?id=uniq) except that it's optimized for sorted arrays.


#### Arguments
array (Array): The sorted array to inspect.


#### Returns
(array): Returns the new duplicate free array.


#### Example

```autohotkey
A.sortedUniq([1, 1, 2])
; => [1, 2]

```



## .tail

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/tail.ahk' class='text-muted'>source</a>

Gets all but the first element of `array`.


#### Arguments
array (Array): The array to query.


#### Returns
(Array): Returns the slice of array.


#### Example

```autohotkey
A.tail([1, 2, 3])
; => [2, 3]

A.tail("fred")
; => ["r", "e", "d"]

A.tail(100)
; => ["0", "0"]

```



## .take

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/take.ahk' class='text-muted'>source</a>

Creates a slice of `array` with `n` elements taken from the beginning.


#### Arguments
array (Array): The array to query.

[n:=1] (number): The number of elements to take.


#### Returns
(Array): Returns the slice of array.


#### Example

```autohotkey
A.take([1, 2, 3])
; => [1]

A.take([1, 2, 3], 2)
; => [1, 2]

A.take([1, 2, 3], 5)
; => [1, 2, 3]

A.take([1, 2, 3], 0)
; => []

A.take("fred")
; => ["f"]

A.take(100)
; => ["1"]

```



## .takeRight

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/takeRight.ahk' class='text-muted'>source</a>

Creates a slice of `array` with `n` elements taken from the end.


#### Arguments
array (Array): The array to query.

[n:=1] (number): The number of elements to take.


#### Returns
(Array): Returns the slice of array.


#### Example

```autohotkey
A.takeRight([1, 2, 3])
; => [3]

A.takeRight([1, 2, 3], 2)
; => [2, 3]

A.takeRight([1, 2, 3], 5)
; => [1, 2, 3]

A.takeRight([1, 2, 3], 0)
; => []

A.takeRight("fred")
; => ["d"]

A.takeRight(100)
; => ["0"]

```



## .union

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/union.ahk' class='text-muted'>source</a>

Creates an array of unique values, in order, from all given arrays.


#### Arguments
[arrays] (...Array): The arrays to inspect.


#### Returns
(Array): Returns the new array of combined values.


#### Example

```autohotkey
A.union([2], [1, 2])
; => [2, 1]

```



## .uniq

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/uniq.ahk' class='text-muted'>source</a>

Creates a duplicate-free version of an `array`, in which only the first occurrence of each element is kept. The order of result values is determined by the order they occur in the array.


#### Arguments
array (Array): The array to inspect.


#### Returns
(Array): Returns the new duplicate free array.

#### Example

```autohotkey
A.uniq([2, 1, 2])
; => [2, 1]

```



## .unzip

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/unzip.ahk' class='text-muted'>source</a>

This method is like [A.zip](/?id=zip) except that it accepts an array of grouped elements and creates an array regrouping the elements to their pre-zip configuration.

#### Arguments
array (Array): The array of grouped elements to process.


#### Returns

(Array): Returns the new array of regrouped elements.

#### Example

```autohotkey
zipped := A.zip(["a", "b"], [1, 2], [true, false])
; => [["a", 1, true], ["b", 2, true]]
A.unzip(zipped)
; => [["a", "b"], [1, 2], [true, false]]

```



## .without

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/without.ahk' class='text-muted'>source</a>

Creates an array excluding all given values.

#### Arguments
array (Array): The array to inspect.

[values] (...*): The values to exclude.


#### Returns
(Array): Returns the new array of filtered values.


#### Example

```autohotkey
A.without([2, 1, 2, 3], 1, 2)
; => [3]

```



## .zip

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/zip.ahk' class='text-muted'>source</a>

Creates an array of grouped elements, the first of which contains the first elements of the given arrays, the second of which contains the second elements of the given arrays, and so on.

#### Arguments
[arrays*] (...Array): The arrays to process.


#### Returns

(Array): Returns the new array of grouped elements.

#### Example

```autohotkey
A.zip(["a", "b"], [1, 2], [true, true])
; => [["a", 1, true], ["b", 2, true]]

```



## .zipObject

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/array/zipObject.ahk' class='text-muted'>source</a>

This method is like [A.fromPairs](/?id=frompairs) except that it accepts two arrays, one of property identifiers and one of corresponding values.


#### Arguments
[props:=[]] (Array): The property identifiers.

[values:=[]] (Array): The property values.


#### Returns

(Object): Returns the new object.


#### Example

```autohotkey
A.zipObject(["a", "b"], [1, 2])
; => {"a": 1, "b": 2}

```




# **Collection methods**
## .count

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/count.ahk' class='text-muted'>source</a>

Gets the number of occurrences of `value` if found in `collection`, else `0`

#### Arguments
collection (Array|Object|string): The collection to inspect.

value (*): The value to count

[fromIndex:=1] (number): The index to search from

#### Returns
(number): Returns the number of occurances.


#### Example

```autohotkey
A.count([1, 2, 3], 2)
; => 1

A.count("pebbles", "b")
; => 2

A.count(["fred", "barney", "pebbles"], "barney")
; => 1

users := [ {"user": "fred", "age": 40, "active": true}
		, {"user": "barney", "age": 36, "active": false}
		, {"user": "pebbles", "age": 1, "active": false} ]
; The A.matches iteratee shorthand.
A.count(users, {"age": 1, "active": false})
; => 1

; The A.matchesProperty iteratee shorthand.
A.count(users, ["active", false])
; => 2

; The A.property iteratee shorthand.
A.count(users, "active")
; => 1

```



## .countBy

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/countBy.ahk' class='text-muted'>source</a>

Creates an object composed of keys generated from the results of running each element of `collection` thru `iteratee`. The corresponding value of each key is the number of times the key was returned by `iteratee`. The iteratee is invoked with one argument: (value).


#### Arguments
object (Array|Object): The collection to iterate over.

[iteratee:=.identity] (Function): The iteratee to transform keys.


#### Returns
(Object): Returns the composed aggregate object.


#### Example

```autohotkey
A.countBy([6.1, 4.2, 6.3], func("floor"))
; => {"4": 1, "6": 2}

; The A.property iteratee shorthand.
A.countBy(["one", "two", "three"], A.size)
; => {"3": 2, "5": 1}

```



## .every

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/every.ahk' class='text-muted'>source</a>

Checks if `predicate` returns truthy for all elements of `collection`. Iteration is stopped once `predicate` returns falsey. The predicate is invoked with three arguments: (value, index|key, collection).

> [!Note]
> This method returns true for empty collections because everything is true of elements of empty collections.


#### Arguments
collection (Array|Object): The collection to iterate over.

[predicate:=.identity] (Function): The function invoked per iteration.


#### Returns
(boolean): Returns true if all elements pass the predicate check, else false.


#### Example

```autohotkey
A.every([true, 1, false, "yes"], A.isBoolean)
; => false

users := [{ "user": "barney", "age": 36, "active": false }
, { "user": "fred", "age": 40, "active": false }]
; The A.matches iteratee shorthand.
A.every(users, {"user": "barney", "age": 36, "active": false})
; => false

; The A.matchesProperty iteratee shorthand.
A.every(users, ["active", false])
; => true

; The A.property iteratee shorthand.
A.every(users, "active")
; => false

```



## .filter

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/filter.ahk' class='text-muted'>source</a>

Iterates over elements of `collection`, returning an array of all elements `predicate` returns truthy for. The predicate is invoked with three arguments: (value, index|key, collection).


#### Arguments
collection (Array|Object): The collection to iterate over.

[predicate:=.identity] (Function): The function invoked per iteration.

#### Returns
(Array): Returns the new filtered array.


#### Example

```autohotkey
users := [{"user":"barney", "age":36, "active":true}, {"user":"fred", "age":40, "active":false}]
A.filter(users, func("fn_filterFunc"))
; => [{"user":"barney", "age":36, "active":true}]

fn_filterFunc(param_iteratee)
{
	if (param_iteratee.active) {
		return true
	}
}
; The A.matches shorthand
A.filter(users, {"age":36, "active":true})
; => [{"user":"barney", "age":36, "active":true}]

; The A.matchesProperty shorthand
A.filter(users, ["active", false])
; => [{"user":"fred", "age":40, "active":false}]

; The A.property shorthand
A.filter(users, "active")
; => [{"user":"barney", "age":36, "active":true}]

```



## .find

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/find.ahk' class='text-muted'>source</a>

Iterates over elements of `collection`, returning the first element `predicate` returns truthy for.


#### Arguments
collection (Array|Object): The collection to inspect.

[predicate:=.identity] (Function): The function invoked per iteration.

[fromIndex:=1] (number): The index to search from.


#### Returns
(*): Returns the matched element, else false.


#### Example

```autohotkey
users := [ {"user": "barney", "age": 36, "active": true}
	, {"user": "fred", "age": 40, "active": false}
	, {"user": "pebbles", "age": 1, "active": true} ]
A.find(users, func("fn_findFunc"))
; => { "user": "barney", "age": 36, "active": true }

fn_findFunc(o)
{
	return o.active
}
; The A.matches iteratee shorthand.
A.find(users, { "age": 1, "active": true })
; => { "user": "pebbles", "age": 1, "active": true }

; The A.matchesProperty iteratee shorthand.
A.find(users, ["active", false])
; => { "user": "fred", "age": 40, "active": false }

; The A.property iteratee shorthand.
A.find(users, "active")
; => { "user": "barney", "age": 36, "active": true }

```



## .findLast

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/findLast.ahk' class='text-muted'>source</a>

This method is like [A.find](/?id=find) except that it iterates over elements of `collection` from right to left.


#### Arguments
collection (Array|Object): The collection to inspect.

function (Function): The function invoked per iteration.


#### Returns
(*): Returns the matched element, else false.


#### Example

```autohotkey
A.findLast([1, 2, 3, 4], func("fn_findLastFunc"))
; => 3

fn_findLastFunc(n)
{
	return mod(n, 2) == 1
}
```



## .forEach

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/forEach.ahk' class='text-muted'>source</a>

Iterates over elements of `collection` and invokes `iteratee` for each element. The iteratee is invoked with three arguments: (value, index|key, collection). Iteratee functions may exit iteration early by explicitly returning false.


#### Aliases
`.each`


#### Arguments
collection (Array|Object): The collection to iterate over.

[iteratee:=.identity] (Function): The function invoked per iteration.


#### Returns
(*): Returns collection.


#### Example

```autohotkey
A.forEach([1, 2], func("fn_forEachFunc1"))
fn_forEachFunc1(value)
{
	msgbox, % value
}
; msgboxes 1 then 2

A.forEach({ "a": 1, "b": 2 }, func("fn_forEachFunc2"))
fn_forEachFunc2(value, key)
{
	msgbox, % key
}
; msgboxes "a" then "b"
```




## .forEachRight

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/forEachRight.ahk' class='text-muted'>source</a>

This method is like [A.forEach](/?id=foreach) except that it iterates over elements of `collection` from right to left.


#### Aliases
`.eachRight`


#### Arguments
collection (Array|Object): The collection to iterate over.

[iteratee:=.identity] (Function): The function invoked per iteration.


#### Returns
(*): Returns collection.


#### Example

```autohotkey
A.forEach([1, 2], func("fn_forEachFunc1"))
fn_forEachFunc1(value)
{
	msgbox, % value
}
; msgboxes 2 then 1

A.forEach({ "a": 1, "b": s2 }, func("fn_forEachFunc2"))
fn_forEachFunc2(value, key)
{
	msgbox, % key
}
; msgboxes "b" then "a"
```




## .groupBy

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/groupBy.ahk' class='text-muted'>source</a>

Creates an object composed of keys generated from the results of running each element of `collection` thru `iteratee`. The order of grouped values is determined by the order they occur in `collection`. The corresponding value of each key is an array of elements responsible for generating the key. The iteratee is invoked with one argument: (value).


<!-- Aliases
_.each -->


#### Arguments
collection (Array|Object): The collection to iterate over.

[iteratee:=.identity] (Function): The iteratee to transform keys.


#### Returns
(Object): Returns the composed aggregate object.


#### Example

```autohotkey
A.groupBy([6.1, 4.2, 6.3], A.floor)
; => {4: [4.2], 6: [6.1, 6.3]}

A.groupBy(["one", "two", "three"], A.size)
; => {3: ["one", "two"], 5: ["three"]}

A.groupBy([6.1, 4.2, 6.3], func("ceil"))
; => {5: [4.2], 7: [6.1, 6.3]}

```



## .includes

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/includes.ahk' class='text-muted'>source</a>

Checks if `value` is in `collection`. If `collection` is a string, it's checked for a substring of value.


#### Arguments
collection (Array|Object|string): The collection to inspect.

value (*): The value to search for.

[fromIndex:=1] (number): The index to search from.


#### Returns
(boolean): Returns true if value is found, else false.


#### Example

```autohotkey
A.includes([1, 2, 3], 1)
; => true

A.includes({ "a": 1, "b": 2 }, 1)
; => true

A.includes("inStr", "Str")
; => true

StringCaseSense, On
A.includes("inStr", "str")
; => false

; RegEx object
A.includes("hello!", "/\D/")
; => true

```



## .keyBy

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/keyBy.ahk' class='text-muted'>source</a>

Creates an object composed of keys generated from the results of running each element of `collection` thru `iteratee`. The corresponding value of each key is the last element responsible for generating the key. The iteratee is invoked with one argument: (value).


#### Arguments
collection (Array|Object): The collection to iterate over.

[iteratee:=.identity] (Function): The iteratee to transform keys.


#### Returns
(Object): Returns the composed aggregate object.


#### Example

```autohotkey
array := [ {"dir": "left", "code": 97}
	, {"dir": "right", "code": 100}]
A.keyBy(array, func("fn_keyByFunc"))
; => {"left": {"dir": "left", "code": 97}, "right": {"dir": "right", "code": 100}}

fn_keyByFunc(value)
{
	return value.dir
}
; The A.property iteratee shorthand.
A.keyBy(array, "dir")
; => {"left": {"dir": "left", "code": 97}, "right": {"dir": "right", "code": 100}}

```



## .map

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/map.ahk' class='text-muted'>source</a>

Creates an array of values by running each element in `collection` thru `iteratee`. The iteratee is invoked with three arguments: (value, index|key, collection).


#### Arguments
collection (Array|Object): The collection to iterate over.

[iteratee:=.identity] (Function): The function invoked per iteration.


#### Returns
(Array): Returns the new mapped array.


#### Example

```autohotkey
fn_square(n)
{
	return n * n
}
A.map([4, 8], func("fn_square"))
; => [16, 64]

A.map({ "a": 4, "b": 8 }, func("fn_square"))
; => [16, 64]

A.map({ "a": 4, "b": 8 })
; => [4, 8]

; The A.property shorthand
users := [{ "user": "barney" }, { "user": "fred" }]
A.map(users, "user")
; => ["barney", "fred"]

```



## .partition

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/partition.ahk' class='text-muted'>source</a>

Creates an array of elements split into two groups, the first of which contains elements `predicate` returns truthy for, the second of which contains elements `predicate` returns falsey for. The predicate is invoked with one argument: (value).


#### Arguments
collection (Array|Object): The collection to iterate over.

[predicate:=.identity] (Function): The function invoked per iteration.


#### Returns
(Array): Returns the array of grouped elements.


#### Example

```autohotkey
users := [ { "user": "barney", "age": 36, "active": false }
	, { "user": "fred", "age": 40, "active": true }
	, { "user": "pebbles", "age": 1, "active": false } ]
A.partition(users, func("fn_partitionFunc"))
; => [[{ "user": "fred", "age": 40, "active": true }], [{ "user": "barney", "age": 36, "active": false }, { "user": "pebbles", "age": 1, "active": false }]]

fn_partitionFunc(o)
{
	return o.active
}
; The A.matches iteratee shorthand.
A.partition(users, {"age": 1, "active": false})
; => [[{ "user": "pebbles", "age": 1, "active": false }], [{ "user": "barney", "age": 36, "active": false }, { "user": "fred", "age": 40, "active": true }]]

; The A.propertyMatches iteratee shorthand.
A.partition(users, ["active", false])
; => [[{ "user": "barney", "age": 36, "active": false }, { "user": "pebbles", "age": 1, "active": false }] ,[{ "user": "fred", "age": 40, "active": true }]]

; The A.property iteratee shorthand.
A.partition(users, "active")
; => [[{ "user": "fred", "age": 40, "active": true }], [{ "user": "barney", "age": 36, "active": false }, { "user": "pebbles", "age": 1, "active": false }]]

```



## .reject

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/reject.ahk' class='text-muted'>source</a>

The opposite of [A.filter](/?id=filter) this method returns the elements of `collection` that `predicate` does **not** return truthy for.

#### Arguments
collection (Array|Object): The collection to iterate over.

[predicate:=.identity] (Function): The function invoked per iteration.


#### Returns
(Array): Returns the new filtered array.


#### Example

```autohotkey
users := [{"user":"barney", "age":36, "active":false}, {"user":"fred", "age":40, "active":true}]
A.reject(users, func("fn_rejectFunc"))
; => [{"user":"fred", "age":40, "active":true}]

fn_rejectFunc(o)
{
	return !o.active
}
; The A.matches shorthand
A.reject(users, {"age":40, "active":true})
; => [{"user":"barney", "age":36, "active":false}]

; The A.matchesProperty shorthand
A.reject(users, ["active", false])
; => [{"user":"fred", "age":40, "active":true}]

; The A.property shorthand
A.reject(users, "active")
; => [{"user":"barney", "age":36, "active":false}]

```



## .sample

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/sample.ahk' class='text-muted'>source</a>

Gets a single random element from `collection`.

#### Arguments
collection (Array|Object|String): The collection to sample.


#### Returns
(*): Returns the random element.


#### Example
```autohotkey
A.sample([1, 2, 3, 4])
; => 2
```




## .sampleSize

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/sampleSize.ahk' class='text-muted'>source</a>

Gets `n` random elements at unique keys from `collection` up to the size of `collection`.


#### Arguments
collection (Array|Object|String): The collection to sample.

[n:=1] (number): The number of elements to sample.


#### Returns
(Array): Returns the random elements.


#### Example
```autohotkey
A.sampleSize([1, 2, 3], 2)
; => [3, 1]

A.sampleSize([1, 2, 3], 4)
; => [2, 3, 1]
```




## .shuffle

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/shuffle.ahk' class='text-muted'>source</a>

Creates an array of shuffled values, using a version of the [Fisher-Yates shuffle](https://en.wikipedia.org/wiki/Fisher-Yates_shuffle).

#### Arguments
collection (Array|Object): The collection to shuffle.


#### Returns
(Array): Returns the new shuffled array.


#### Example
```autohotkey
A.shuffle([1, 2, 3, 4])
; => [4, 1, 3, 2]

A.shuffle(["barney", "fred", "pebbles"])
; => ["pebbles", "barney", "fred"]
```




## .size

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/size.ahk' class='text-muted'>source</a>

Gets the size of `collection` by returning its length for array-like values or the number of own enumerable string keyed properties for objects.


#### Arguments
collection (Array|Object|string): The collection to inspect.


#### Returns
(number): Returns the collection size.


#### Example

```autohotkey
A.size([1, 2, 3])
; => 3

A.size({ "a": 1, "b": 2 })
; => 2

A.size("pebbles")
; => 7

```



## .some

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/some.ahk' class='text-muted'>source</a>

Checks if `predicate` returns truthy for **any** element of `collection`. Iteration is stopped once `predicate` returns truthy. The predicate is invoked with three arguments: (value, index|key, collection).


#### Arguments
collection (Array|Object): The collection to iterate over.

[iteratees:=.identity] (Function): The function invoked per iteration.


#### Returns
(Array): Returns true if any element passes the predicate check, else false.


#### Example

```autohotkey
users := [{ "user": "barney", "active": true }, { "user": "fred", "active": false }]
; The A.matches iteratee shorthand.
A.some(users, { "user": "barney", "active": false })
; => false

; The A.matchesProperty iteratee shorthand.
A.some(users, ["active", false])
; => true

; The A.property iteratee shorthand.
A.some(users, "active")
; => true

```



## .sortBy

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/collection/sortBy.ahk' class='text-muted'>source</a>

Creates an array of elements, sorted in ascending order by the results of running each element in a collection thru each iteratee. This method performs a stable sort, that is, it preserves the original sort order of equal elements. The iteratees are invoked with one argument: (value).


#### Arguments
collection (Array|Object): The collection to iterate over.

[iteratees:=.identity] (Function): The iteratees to sort by.


#### Returns
(Array): Returns the new sorted array.


#### Example

```autohotkey
A.sortBy(["b", "f", "e", "c", "d", "a"])
; => ["a", "b", "c", "d", "e", "f"]

users := [{ "name": "fred", "age": 40 }
 , { "name": "barney", "age": 34 }
 , { "name": "bernard", "age": 36 }
 , { "name": "zoey", "age": 40 }]
A.sortBy(users, "age")
; => [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"zoey"}, {"age":40, "name":"fred"}]

A.sortBy(users, ["age", "name"])
; => [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zoey"}]

A.sortBy(users, func("fn_sortByFunc"))
; => [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zoey"}]

fn_sortByFunc(o)
{
	return o.name
}
; sort using result of another method
A.sortBy(["ab", "a", " abc", "abc"], A.size)
; => ["a", "ab", "abc", " abc"]

```




# **Date methods**
## .now

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/date/now.ahk' class='text-muted'>source</a>

Gets the timestamp of the number of milliseconds that have elapsed since the Unix epoch *(1 January 1970 00:00:00 UTC)*.

> [!Note]
> The returned timestamp is only accurate to the second.

#### Returns
(number): Returns the timestamp.


#### Example
```autohotkey
A.now()
; => 1636159584000
```





# **Function methods**
## .ary

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/function/ary.ahk' class='text-muted'>source</a>

Creates a function that invokes `func`, with up to `n` arguments, ignoring any additional arguments.


#### Arguments
func (Function): The function to cap arguments for.

[n:=func.maxParams] (number): The arity cap.


#### Returns
(Function): Returns the new capped function.


#### Example

```autohotkey
aryFunc := A.ary(Func("fn_aryFunc"), 2)
aryFunc.call("a", "b", "c", "d")
; => ["a", "b"]

fn_aryFunc(arguments*) {
	return arguments
}
```



## .delay

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/function/delay.ahk' class='text-muted'>source</a>

Invokes `func` after `wait` milliseconds. Any additional arguments are provided to func when it's invoked.


#### Arguments
func (Function): The function to delay.

wait (number): The number of milliseconds to delay invocation.

[args] (...*): The arguments to invoke func with.


#### Returns
(boolean): Returns true.


#### Example
```autohotkey
A.delay(Func("fn_delayFunc"), 1000, "later")
fn_delayFunc(text) {
	msgbox, % text
}
; => msgboxes 'later' after one second.
```




## .flip

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/function/flip.ahk' class='text-muted'>source</a>

Creates a function that invokes `func` with arguments reversed.


#### Arguments
func (Function): The function to flip arguments for.


#### Returns
(Function): Returns the new flipped function.


#### Example

```autohotkey
flippedFunc1 := A.flip(Func("inStr"))
flippedFunc1.call("s", "string")
; => 1

flippedFunc2 := A.flip(Func("fn_flipFunc"))
flippedFunc2.call("a", "b", "c", "d")
; => ["d", "c", "b", "a"]

fn_flipFunc(arguments*) {
	return biga.toArray(arguments)
}
```



## .memoize

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/function/memoize.ahk' class='text-muted'>source</a>

Creates a function that memoizes the result of `func`. If `resolver` is provided, it determines the cache key for storing the result based on the arguments provided to the memoized function.


#### Arguments
func (Function): The function to have its output memoized.

[resolver] (Function): The function to resolve the cache key.


#### Returns
(Function): Returns the new memoized function.


#### Example

```autohotkey
memoizedFibonacci := A.memoize(func("fn_fibonacci"))
memoizedFibonacci.call(10)
; => 55

; Subsequent calls with the same argument will use the cached result
memoizedFibonacci.call(10)
; => 55

fn_fibonacci(n) {
	if (n <= 1) {
		return n
	}
	return fn_fibonacci(n - 1) + fn_fibonacci(n - 2)
}
```



## .negate

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/function/negate.ahk' class='text-muted'>source</a>

Creates a function that negates the result of the `predicate` func. The func `predicate` is invoked with the this binding and arguments of the created function.


#### Arguments
predicate (Function): The predicate to negate.


#### Returns
(Function): Returns the new negated function.


#### Example

```autohotkey
fn_isEven(n) {
	return (mod(n, 2) = 0)
}
A.filter[1, 2, 3, 4, 5, 6], A.negate(func("fn_isEven"))
; => [1, 3, 5]

```



## .once

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/function/once.ahk' class='text-muted'>source</a>

Creates a function that is restricted to invoking `func` once. Repeat calls to the function return the value of the first invocation.


#### Arguments
func (Function): The function to restrict.


#### Returns
(Function): Returns the new restricted function.


#### Example
```autohotkey
initialize = A.once(func("fn_createApplication"))
initialize.call()
initialize.call()
; => `fn_createApplication` is invoked once
```



## .throttle

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/function/throttle.ahk' class='text-muted'>source</a>

Creates a throttled function that only invokes `func` at most once per every `wait` milliseconds. The function is invoked with the last arguments provided to the throttled function. Subsequent calls to the throttled function return the result of the last invocation.


#### Arguments
func (Function): The function to throttle.

[wait:=0] (number): The number of milliseconds to throttle invocations to.


#### Returns
(Function): Returns the new throttled function.


#### Example
```autohotkey
refresh := A.throttle(func("fn_updateGUI"), 1000)
refresh.call()
refresh.call()
; => `fn_updateGUI` is invokable once every 1000ms but will return the last value anytime called
```





# **Lang methods**
## .castArray

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/castArray.ahk' class='text-muted'>source</a>

Casts `value` as an array if it's not one.

#### Arguments
value (*): The value to inspect.


#### Returns
(Array): Returns the cast array.


#### Example

```autohotkey
A.castArray(1)
; => [1]

A.castArray({"a": 1})
; => {"a": 1}

A.castArray("abc")
; => ["abc"]

A.castArray("")
; => [""]

```



## .clone

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/clone.ahk' class='text-muted'>source</a>

Creates a shallow clone of `value`. Supports cloning arrays, objects, numbers, strings.

#### Arguments
value (*): The value to clone.


#### Returns
(*): Returns the cloned value.


#### Example
```autohotkey
object := [{ "a": 1 }, { "b": 2 }]
shallowclone := A.clone(object)
object.a := 2
object
; => [{ "a": 2 }, { "b": 2 }]
shallowclone
; => [{ "a": 1 }, { "b": 2 }]
```




## .cloneDeep

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/cloneDeep.ahk' class='text-muted'>source</a>

This method is like [A.clone](/?id=clone) except that it recursively clones `value`.


#### Arguments
value (*): The value to recursively clone.


#### Returns
(*): Returns the deep cloned value.


#### Example

```autohotkey
object := [{ "a": [[1, 2, 3]] }, { "b": 2 }]
deepclone := A.cloneDeep(object)
object[1].a := 2
; object
; => [{ "a": 2 }, { "b": 2 }]
; deepclone
; => [{ "a": [[1, 2, 3]] }, { "b": 2 }]
```



## .conformsTo

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/conformsTo.ahk' class='text-muted'>source</a>

Checks if `object` conforms to source by invoking the predicate properties of `source` with the corresponding property values of `object`.


#### Arguments
object (Object): The object to inspect.

source (Object): The object of property predicates to conform to.


#### Returns
(boolean): Returns true if object conforms, else false.


#### Example

```autohotkey
object := {"a": 1, "b": 2}
A.conformsTo(object, {"b": func("fn_conformsToFunc1")})
; => true

A.conformsTo(object, {"b": func("fn_conformsToFunc2")})
; => false

fn_conformsToFunc1(n)
{
	return n > 1
}
fn_conformsToFunc2(n)
{
	return n > 2
}
```



## .eq

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/eq.ahk' class='text-muted'>source</a>

Performs a shallow comparison between two values to determine if they are equivalent.


#### Arguments
value (*): The value to compare.

other (*): The other value to compare.


#### Returns
(boolean): Returns true if the values are equivalent, else false.


#### Example

```autohotkey
object := {"a": 1}
other := {"a": 1}
A.eq(object, other)
; => true

A.eq("a", "a")
; => true

A.eq("", "")
; => true

```



## .gt

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/gt.ahk' class='text-muted'>source</a>

Checks if `value` is greater than other.


#### Arguments
value (*): The value to compare.

other (*): The other value to compare.


#### Returns
(boolean): Returns true if value is greater than other, else false.


#### Example

```autohotkey
A.gt(3, 1)
; => true

A.gt(3, 3)
; => false

A.gt(1, 3)
; => false

```



## .gte

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/gte.ahk' class='text-muted'>source</a>

Checks if `value` is greater than or equal to other.


#### Arguments
value (*): The value to compare.

other (*): The other value to compare.


#### Returns
(boolean): Returns true if value is greater than or equal to other, else false.


#### Example

```autohotkey
A.gte(3, 1)
; => true

A.gte(3, 3)
; => true

A.gte(1, 3)
; => false

```



## .isAlnum

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/isAlnum.ahk' class='text-muted'>source</a>

Checks if `value` is an alnum.


#### Arguments
value (*): The value to check.


#### Returns
(boolean): Returns true if value is an alnum, else false.


#### Example

```autohotkey
A.isAlnum(1)
; => true

A.isAlnum("hello")
; => true

A.isAlnum([])
; => false

A.isAlnum({})
; => false

```



## .isArray

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/isArray.ahk' class='text-muted'>source</a>

Checks if `value` is an Array object.


#### Arguments
value (*): The value to check.


#### Returns
(boolean): Returns true if value is an array, else false.


#### Example

```autohotkey
A.isArray([1, 2, 3])
; => true

A.isArray("abc")
; => false

A.isArray({"key": "value"})
; => true

```



## .isBoolean

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/isBoolean.ahk' class='text-muted'>source</a>

Checks if `value` is classified as a boolean.


#### Arguments
value (*): The value to check.


#### Returns
(boolean): Returns true if value is a boolean, else false.


#### Example

```autohotkey
A.isBoolean(true)
; => true

A.isBoolean(1)
; => true

A.isBoolean(false)
; => true

A.isBoolean(0)
; => true

```



## .isEmpty

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/isEmpty.ahk' class='text-muted'>source</a>

Checks if `value` is an empty object. Objects are considered empty if they have no own enumerable string keyed properties.


#### Arguments
value (*): The value to check.


#### Returns
(boolean): Returns `true` if value is empty, else `false`.


#### Example

```autohotkey
A.isEmpty("")
; => true

A.isEmpty(true)
; => true

A.isEmpty(1)
; => true

A.isEmpty([1, 2, 3])
; => false

A.isEmpty({"a": 1})
; => false

```



## .isEqual

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/isEqual.ahk' class='text-muted'>source</a>

Performs a deep comparison between two values to determine if they are equivalent.

This method supports comparing numbers, strings, and objects.


#### Arguments
value (*): The value to compare.

other (...*): The other value to compare.


#### Returns
(boolean): Returns true if the values are equivalent, else false.


#### Example

```autohotkey
A.isEqual(1, 1)
; => true

A.isEqual({ "a": 1 }, { "a": 1 })
; => true

A.isEqual(1, 1, 2)
; => false

StringCaseSense, On
A.isEqual({ "a": "a" }, { "a": "A" })
; => false

```



## .isError

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/isError.ahk' class='text-muted'>source</a>

Checks if `value` is an exception error object.


#### Arguments
value (*): The value to check.


#### Returns
(boolean): Returns true if value is an exception object, else false.


#### Example

```autohotkey
A.isError(Exception("something broke"))
; => true

```



## .isFloat

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/isFloat.ahk' class='text-muted'>source</a>

Checks if `value` is a float.


#### Arguments
value (*): The value to check.


#### Returns
(boolean): Returns true if value is a float, else false.


#### Example

```autohotkey
A.isFloat(1.0)
; => true

A.isFloat(1)
; => false

```



## .isFunction

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/isFunction.ahk' class='text-muted'>source</a>

Checks if `value` is callable as a function object, bound function, or object method.


#### Arguments
value (*): The `value` to check.


#### Returns
(boolean): Returns `true` if `value` is callable, else `false`.


#### Example

```autohotkey
boundFunc := func("strLen").bind()
A.isFunction(boundFunc)
; => true

IsFunc(boundFunc)
; => false

A.isFunction(A.isString)
; => true

A.isFunction(A.matchesProperty("a", 1))
; => true

A.isFunction([1, 2, 3])
; => false

```



## .isInteger

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/isInteger.ahk' class='text-muted'>source</a>

Checks if `value` is an integer.


#### Arguments
value (*): The value to check.


#### Returns
(boolean): Returns true if value is an integer, else false.


#### Example

```autohotkey
A.isInteger(1)
; => true

A.isInteger("1")
; => false

```



## .ismatch

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/ismatch.ahk' class='text-muted'>source</a>

Performs a partial deep comparison between `object` and `source` to determine if object contains equivalent property values.

Partial comparisons will match empty array and empty object source values against any array or object value, respectively. See [A.isEqual](/?id=isEqual) for a list of supported value comparisons.


#### Arguments
object (Object): The object to inspect.

source (Object): The object of property values to match.


#### Returns
(boolean): Returns true if object is a match, else false.

#### Example

```autohotkey
object := { "a": 1, "b": 2, "c": 3 }
A.isMatch(object, {"b": 2})
; => true

A.isMatch(object, {"b": 2, "c": 3})
; => true

A.isMatch(object, {"b": 1})
; => false

A.isMatch(object, {"b": 2, "z": 99})
; => false

```



## .isNumber

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/isNumber.ahk' class='text-muted'>source</a>

Checks if `value` is a number.


#### Arguments
value (*): The value to check.


#### Returns
(boolean): Returns true if value is a number, else false.


#### Example

```autohotkey
A.isNumber(1)
; => true

A.isNumber("1")
; => true

A.isNumber("1.001")
; => true

```



## .isObject

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/isObject.ahk' class='text-muted'>source</a>

Checks if `value` is an object.


#### Arguments
value (*): The value to check.


#### Returns
(boolean): Returns true if value is an object, else false.


#### Example

```autohotkey
A.isObject({})
; => true

A.isObject([1, 2, 3])
; => true

A.isObject("")
; => false

```



## .isString

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/isString.ahk' class='text-muted'>source</a>

Checks if `value` is classified as a string.


#### Arguments
value (*): The value to check.


#### Returns
(boolean): Returns true if value is a string, else false.


#### Example

```autohotkey
A.isString("abc")
; => true

A.isString(1)
; => false

```



## .isUndefined

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/isUndefined.ahk' class='text-muted'>source</a>

Checks if `value` is undefined or blank.


#### Arguments
value (*): The value to check.


#### Returns
(boolean): Returns true if value is undefined, else false.


#### Example

```autohotkey
A.isUndefined("")
; => true

A.isUndefined(non_existant_var)
; => true

A.isUndefined({})
; => false

A.isUndefined(" ")
; => false

A.isUndefined(0)
; => false

A.isUndefined(false)
; => false

```



## .lt

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/lt.ahk' class='text-muted'>source</a>

Checks if `value` is less than other.


#### Arguments
value (*): The value to compare.

other (*): The other value to compare.


#### Returns
(boolean): Returns true if value is less than other, else false.


#### Example

```autohotkey
A.lt(1, 3)
; => true

A.lt(3, 3)
; => false

A.lt(3, 1)
; => false

```



## .lte

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/lte.ahk' class='text-muted'>source</a>

Checks if `value` is less than or equal to other.


#### Arguments
value (*): The value to compare.

other (*): The other value to compare.


#### Returns
(boolean): Returns true if value is less than or equal to other, else false.


#### Example

```autohotkey
A.lte(1, 3)
; => true

A.lte(3, 3)
; => true

A.lte(3, 1)
; => false

```



## .toArray

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/toArray.ahk' class='text-muted'>source</a>

Converts `value` to an array.


#### Arguments
value (*): The value to convert.


#### Returns
(Array): Returns the converted array.


#### Example

```autohotkey
A.toArray({"a": 1, "b": 2})
; => [1, 2]

A.toArray("abc")
; => ["a", "b", "c"]

A.toArray(1)
; => []

A.toArray("")
; => []

```



## .toLength

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/toLength.ahk' class='text-muted'>source</a>

Converts `value` to an integer suitable for use as the length of an array-like object.


#### Arguments
value (*): The value to convert.


#### Returns
(number): Returns the converted integer.


#### Example

```autohotkey
A.toLength(3.2)
; => 3

A.toLength("3.2")
; => 3

```



## .toString

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/toString.ahk' class='text-muted'>source</a>

Converts `value` to a string. An empty string is returned for undefined values. The sign of `-0` is preserved.


#### Arguments
value (*): The value to convert.


#### Returns
(boolean): Returns the converted string.


#### Example

```autohotkey
A.toString(non_existant_var)
; => ""

A.toString(-0)
; => "-0"

A.toString([1, 2, 3])
; => "1,2,3"

```



## .typeOf

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/lang/typeOf.ahk' class='text-muted'>source</a>

This method returns a string indicating the type of `value`.


#### Arguments
value (*): the value to check.


#### Returns
(string): Returns value's type.


#### Example

```autohotkey
A.typeOf(42)
; => "integer"

A.typeOf(0.25)
; => "float"

A.typeOf("blubber")
; => "string"

A.typeOf([])
; => "object"

A.typeOf(undeclaredVariable)
; => "undefined"

```




# **Math methods**
## .add

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/math/add.ahk' class='text-muted'>source</a>

Adds two numbers.


#### Arguments
augend (number): The first number in an addition.

addend (number): The second number in an addition.


#### Returns
(number): Returns the total.


#### Example

```autohotkey
A.add(6, 4)
; => 10

```



## .ceil

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/math/ceil.ahk' class='text-muted'>source</a>

Computes `number` rounded up to `precision`.


#### Arguments
number (number): The number to round up.

[precision:=0] (number): The precision to round up to.


#### Returns
(number): Returns the rounded up number.


#### Example

```autohotkey
A.ceil(4.006)
; => 5

A.ceil(6.004, 2)
; => 6.01

A.ceil(6040, -2)
; => 6100

```



## .divide

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/math/divide.ahk' class='text-muted'>source</a>

Divide two numbers.


#### Arguments
dividend (number): The first number in a division.

divisor (number): The second number in a division.


#### Returns
(number): Returns the quotient.


#### Example

```autohotkey
A.divide(6, 4)
; => 1.5

```



## .floor

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/math/floor.ahk' class='text-muted'>source</a>

Computes `number` rounded down to `precision`.


#### Arguments
number (number): The number to round down.

[precision:=0] (number): The precision to round down to.


#### Returns
(number): Returns the rounded down number.

#### Example

```autohotkey
A.floor(4.006)
; => 4

A.floor(0.046, 2)
; => 0.04

A.floor(4060, -2)
; => 4000

```



## .max

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/math/max.ahk' class='text-muted'>source</a>

Computes the maximum value of `array`. If `array` is empty or falsey, `""` is returned.


#### Arguments
array (Array): The array to iterate over.


#### Returns
(*): Returns the maximum value.


#### Example

```autohotkey
A.max([4, 2, 8, 6])
; => 8

A.max([])
; => ""

```



## .maxBy

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/math/maxBy.ahk' class='text-muted'>source</a>

This method is like [A.max](/?id=max) except that it accepts `iteratee` which is invoked for each element in `array` to generate the criterion by which the value is ranked. The iteratee is invoked with one argument: (value).

#### Arguments
array (Array): The array to iterate over.

[iteratee:=.identity] (Function): The iteratee invoked per element.


#### Returns
(*): Returns the maximum value.

#### Example

```autohotkey
objects := [ {"n": 4 }, { "n": 2 }, { "n": 8 }, { "n": 6 } ]
A.maxBy(objects, func("fn_maxByFunc"))
; => { "n": 8 }

fn_maxByFunc(o)
{
	return o.n
}
; The A.property iteratee shorthand
A.maxBy(objects, "n")
; => { "n": 8 }

```



## .mean

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/math/mean.ahk' class='text-muted'>source</a>

Computes the mean of the values in `array`.


#### Arguments
array (Array): The array to iterate over.


#### Returns
(number): Returns the mean.


#### Example

```autohotkey
A.mean([4, 2, 8, 6])
; => 5

```



## .meanBy

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/math/meanBy.ahk' class='text-muted'>source</a>

This method is like [A.mean](/?id=mean) except that it accepts `iteratee` which is invoked for each element in `array` to generate the value to be averaged. The iteratee is invoked with one argument: (value).

#### Arguments
array (Array): The array to iterate over.

[iteratee:=.identity] (Function): The iteratee invoked per element.


#### Returns
(number): Returns the mean.

#### Example

```autohotkey
objects := [{"n": 4}, {"n": 2}, {"n": 8}, {"n": 6}]
A.meanBy(objects, func("fn_meanByFunc"))
; => 5

fn_meanByFunc(o)
{
	return o.n
}
; The A.property iteratee shorthand.
A.meanBy(objects, "n")
; => 5

```



## .min

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/math/min.ahk' class='text-muted'>source</a>

Computes the minimum value of `array`. If array is empty or falsey, `""` is returned.


#### Arguments
array (Array): The array to iterate over.


#### Returns
(*): Returns the minimum value.


#### Example

```autohotkey
A.min([4, 2, 8, 6])
; => 2

A.min([])
; => ""

```



## .minBy

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/math/minBy.ahk' class='text-muted'>source</a>

This method is like [A.min](/?id=min) except that it accepts `iteratee` which is invoked for each element in `array` to generate the criterion by which the value is ranked. The iteratee is invoked with one argument: (value).

#### Arguments
array (Array): The array to iterate over.

[iteratee:=.identity] (Function): The iteratee invoked per element.


#### Returns
(*): Returns the minimum value.

#### Example

```autohotkey
objects := [ {"n": 4 }, { "n": 2 }, { "n": 8 }, { "n": 6 } ]
A.minBy(objects, func("fn_minByFunc"))
; => { "n": 2 }

fn_minByFunc(o)
{
	return o.n
}
; The A.property iteratee shorthand
A.minBy(objects, "n")
; => { "n": 2 }

```



## .multiply

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/math/multiply.ahk' class='text-muted'>source</a>

Multiply two numbers.


#### Arguments
multiplier (number): The first number in a multiplication.

multiplicand (number): The second number in a multiplication.


#### Returns
(number): Returns the product.


#### Example

```autohotkey
A.multiply(6, 4)
; => 24

```



## .round

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/math/round.ahk' class='text-muted'>source</a>

Computes `number` rounded to `precision`.


#### Arguments
number (number): The number to round.

[precision:=0] (number): The precision to round to.


#### Returns
(number): Returns the rounded number.


#### Example

```autohotkey
A.round(4.006)
; => 4

A.round(4.006, 2)
; => 4.01

A.round(4060, -2)
; => 4100

```



## .subtract

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/math/subtract.ahk' class='text-muted'>source</a>

Subtract two numbers.


#### Arguments
minuend (number): The first number in a subtraction.

subtrahend (number): The second number in a subtraction.


#### Returns
(number): Returns the difference.


#### Example

```autohotkey
A.subtract(6, 4)
; => 2

```



## .sum

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/math/sum.ahk' class='text-muted'>source</a>

Computes the sum of the values in `array`.


#### Arguments
array (Array): The array to iterate over.


#### Returns
(number): Returns the sum.


#### Example

```autohotkey
A.sum([4, 2, 8, 6])
; => 20

```



## .sumBy

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/math/sumBy.ahk' class='text-muted'>source</a>

This method is like [A.sum](/?id=sum) except that it accepts `iteratee` which is invoked for each element in `array` to generate the value to be summed. The iteratee is invoked with one argument: (value).


#### Arguments
array (Array): The array to iterate over.
[iteratee:=.identity] (Function): The iteratee invoked per element.


#### Returns
(number): Returns the sum.


#### Example

```autohotkey
objects := [ {"n": 4 }, { "n": 2 }, { "n": 8 }, { "n": 6 } ]
A.sumBy(objects, func("fn_sumByFunc"))
; => 20

fn_sumByFunc(o)
{
	return o.n
}
; The A.property iteratee shorthand
A.sumBy(objects, "n")
; => 20

```




# **Number methods**
## .clamp

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/number/clamp.ahk' class='text-muted'>source</a>

Clamps `number` within the inclusive `lower` and `upper` bounds.


#### Arguments
number (number): The number to clamp.

lower (number): The lower bound.

upper (number): The upper bound.


#### Returns
(number): Returns the clamped number.


#### Example

```autohotkey
A.clamp(-10, -5, 5)
; => -5

A.clamp(10, -5, 5)
; => 5

```



## .inRange

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/number/inRange.ahk' class='text-muted'>source</a>

Checks if `n` is between `start` and up to, but not including, `end`. If end is not specified, it's set to start with start then set to 0. If start is greater than end the params are swapped to support negative ranges.


#### Arguments
number (number): The number to check.

start (number): The start of the range.

end (number): The end of the range.


#### Returns
(boolean): Returns true if number is in the range, else false.


#### Example

```autohotkey
A.inRange(3, 2, 4)
; => true

A.inRange(4, 8)
; => true

A.inRange(4, 2)
; => false

A.inRange(2, 2)
; => false

A.inRange(1.2, 2)
; => true

A.inRange(5.2, 4)
; => false

A.inRange(-3, -2, -6)
; => true

```



## .random

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/number/random.ahk' class='text-muted'>source</a>

Produces a random number between the inclusive `lower` and `upper` bounds. If `floating` is true, or either lower or upper are floats, a floating-point number is returned instead of an integer. Uses AutoHotkey's pseudo-random [Random](https://www.autohotkey.com/docs/commands/Random.htm) command.


#### Arguments
[lower:=0] (number): The lower bound.

[upper:=1] (number): The upper bound.

[floating:=false] (boolean): Specify returning a floating-point number.


#### Returns
(number): Returns the random number.


#### Example
```autohotkey
A.random(0, 5)
; => an integer between 0 and 5

A.random(5)
; => an integer between 0 and 5

A.random(1.2, 5.2)
; => a floating-point number between 1.2 and 5.2
```




# **Object methods**
## .at

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/at.ahk' class='text-muted'>source</a>

Creates an array of values corresponding to `paths` of `object`.

#### Arguments
object (Object): The object to iterate over.

[paths] (...(string|string[])): The property paths to pick.


#### Returns
(Array): Returns the picked values.


#### Example

```autohotkey
object := {"a": [{ "b": {"c": 3} }, 4]}
A.at(object, ["a[1].b.c", "a[2]"])
; => [3, 4]

```



## .defaults

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/defaults.ahk' class='text-muted'>source</a>

Assigns own and inherited enumerable string keyed properties of `source` objects to the destination object for all destination properties. Source objects are applied from left to right. Once a property is set, additional values of the same property are ignored.

> [!Note]
> Unlike it's Lodash counterpart, this method does **NOT** mutate the object.


#### Arguments
object (Object): The destination object.

[sources] (...Object*): The source objects.


#### Returns
(Object): Returns object.


#### Example

```autohotkey
A.defaults({"a": 1}, {"b": 2}, {"a": 3})
; => {"a": 1, "b": 2}

```



## .findKey

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/findKey.ahk' class='text-muted'>source</a>

This method is like [A.find](/?id=find) except that it returns the key of the first element `predicate` returns truthy for instead of the element itself.


#### Arguments
collection (Array|Object): The collection to inspect.

function (Function): The function invoked per iteration.

[fromIndex:=1] (number): The index to search from.


#### Returns
(*): Returns the matched element, else false.


#### Example

```autohotkey
users := { "barney": {"age": 36, "active": true}
, "fred": {"age": 40, "active": false}
, "pebbles": {"age": 1, "active": true} }
A.findKey(users, func("fn_findKeyFunc"))
; => "barney"

fn_findKeyFunc(o)
{
	return o.age < 40
}
; The A.matches iteratee shorthand.
A.findKey(users, {"age": 1, "active": true})
; => "pebbles"

; The A.matchesProperty iteratee shorthand.
A.findKey(users, ["active", false])
; => "fred"

; The A.property iteratee shorthand.
A.findKey(users, "active")
; => "barney"

```



## .forIn

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/forIn.ahk' class='text-muted'>source</a>

Iterates over own enumerable keys of `object` and invokes `iteratee` for each property. The iteratee is invoked with three arguments: (value, key, object). Iteratee functions may exit iteration early by explicitly returning `false`.


#### Arguments
object (Object): The object to iterate over.

[iteratee:=.identity] (Function): The function invoked per iteration.


#### Returns
(*): Returns the resolved value.

#### Example
```autohotkey
object := {"a": 1, "b": 2}

A.forIn(object, func("fn_forInFunc"))

fn_forInFunc(value, key) {
	msgbox, % key
}
; => msgboxes "a" then "b"
```




## .forInRight

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/forInRight.ahk' class='text-muted'>source</a>

This method is like [A.forIn](/?id=forin) except that it iterates over properties of `object` in the opposite order.


#### Arguments
object (Object): The object to iterate over.

[iteratee:=.identity] (Function): The function invoked per iteration.


#### Returns
(*): Returns the resolved value.

#### Example
```autohotkey
object := [1, 2, 3]
A.forInRight(object, func("fn_forInRightFunc")

fn_forInRightFunc(value, key) {
	msgbox, % value
}
; => msgboxes "3", "2", then "1"
```




## .get

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/get.ahk' class='text-muted'>source</a>

Gets the value at path of `object`. If the resolved value is `""`, the `defaultValue` is returned in its place.


#### Arguments
object (Object): The object to query.

path (Array|string): The path of the property to get.

[defaultValue:=""] (*): The value returned for undefined resolved values.


#### Returns
(*): Returns the resolved value.


#### Example

```autohotkey
object := {"a": [{ "b": {"c": 3} }]}
A.get(object, "a[1].b.c")
; => 3

A.get(object, ["a", "1", "b", "c"])
; => 3

A.get(object, "a.b.c", "default")
; => "default"

```



## .has

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/has.ahk' class='text-muted'>source</a>

Checks if `path` is a property of `object`.


#### Arguments
object (Object): The object to query.

path (Array|string): The path to check.


#### Returns
(boolean): Returns true if path exists, else false.


#### Example

```autohotkey
object := {"a": { "b": ""}}
A.has(object, "a")
; => true

A.has(object, "a.b")
; => true

A.has(object, ["a", "b"])
; => true

A.has(object, "a.b.c")
; => false

```



## .invert

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/invert.ahk' class='text-muted'>source</a>

Creates an object composed of the inverted keys and values of object. If object contains duplicate values, subsequent values overwrite property assignments of previous values.


#### Arguments
object (Object): The object to invert.


#### Returns
(Array): Returns the new inverted object.


#### Example

```autohotkey
object := {"a": 1, "b": 2, "c": 1}
A.invert(object)
; => {"1": "c", "2": "b"}

A.invert({1: "a", 2: "A"})
; => {"a": 2}

```



## .invertBy

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/invertBy.ahk' class='text-muted'>source</a>

This method is like [A.invert](/?id=invert) except that the inverted object is generated from the results of running each element of object thru `iteratee`. The corresponding inverted value of each inverted key is an array of keys responsible for generating the inverted value. The iteratee is invoked with one argument: (value).


#### Arguments
object (Object): The object to invert.

[iteratee:=.identity] (Function): The iteratee invoked per element.

#### Returns
(Array): Returns the new inverted object.


#### Example

```autohotkey
object := {"a": 1, "b": 2, "c": 1}
A.invertBy(object)
; => {"1": ["a", "c"], "2":["b"]}

A.invertBy(object, func("invertByFunc"))
; => {"group1": ["a", "c"], "group2": ["b"]}

invertByFunc(value)
{
	return "group" value
}
```



## .keys

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/keys.ahk' class='text-muted'>source</a>

Creates an array of the own enumerable properties of object.


#### Arguments
object (Object): The object to query.


#### Returns
(Array): Returns the array of property names.


#### Example

```autohotkey
object := {"a": 1, "b": 2, "c": 3}
A.keys(object)
; => ["a", "b", "c"]

A.keys("hi")
; => [1, 2]

```



## .mapKeys

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/mapKeys.ahk' class='text-muted'>source</a>

The opposite of [A.mapValues](/?id=mapvalues) this method creates an object with the same values as object and keys generated by running each own enumerable string keyed property of object thru `iteratee`. The iteratee is invoked with three arguments: (value, index|key, object).


#### Arguments
object (Object): The object to iterate over.

[iteratee:=.identity] (Function): The function invoked per iteration.


#### Returns
(Object): Returns the new mapped object.


#### Example

```autohotkey
A.mapKeys({"a": 1, "b": 2}, func("fn_mapKeysFunc"))
; => {"a+1": 1, "b+2": 2}

fn_mapKeysFunc(value, key)
{
	return key "+" value
}
```



## .mapValues

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/mapValues.ahk' class='text-muted'>source</a>

Creates an object with the same keys as object and values generated by running each own enumerable string keyed property of object thru `iteratee`. The iteratee is invoked with three arguments: (value, index|key, object).


#### Arguments
object (Object): The object to iterate over.

[iteratee:=.identity] (Function): The function invoked per iteration.


#### Returns
(Object): Returns the new mapped object.


#### Example

```autohotkey
users := {"fred": {"user": "fred", "age": 40}
		,"pebbles": {"user": "pebbles", "age": 1}}
A.mapValues(users, func("fn_mapValuesFunc"))
; => {"fred": 40, "pebbles": 1}

fn_mapValuesFunc(o)
{
	return o.age
}
; The A.property iteratee shorthand.
A.mapValues(users, "age")
; => {"fred": 40, "pebbles": 1}

```



## .merge

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/merge.ahk' class='text-muted'>source</a>

This method recursively merges own and inherited enumerable string keyed properties of source objects into the destination object. Array and plain object properties are merged recursively. Other objects and value types are overridden by assignment. Source objects are applied from left to right. Subsequent sources overwrite property assignments of previous sources.


#### Arguments
object (Object): The destination object.

[sources] (...Object): The source objects.


#### Returns
(Object): Returns object.


#### Example

```autohotkey
object := {"options": [{"option1": true}]}
other := {"options": [{"option2": false}]}
A.merge(object, other)
; => {"options": [{"option1": true, "option2": false}]}

object := { "a": [{ "b": 2 }, { "d": 4 }] }
other := { "a": [{ "c": 3 }, { "e": 5 }] }
A.merge(object, other)
; => { "a": [{ "b": "2", "c": 3 }, { "d": "4", "e": 5 }] }

```



## .omit

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/omit.ahk' class='text-muted'>source</a>

The opposite of [A.pick](/?id=pick) this method creates an object composed of the own and inherited enumerable property paths of object that are not omitted.


#### Arguments
object (Object): The source object.

[paths] (...(string|string[])): The property paths to omit.

#### Returns
(Object): Returns the new object.


#### Example

```autohotkey
object := {"a": 1, "b": "2", "c": 3}
A.omit(object, ["a", "c"])
; => {"b": "2"}

```



## .pick

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/pick.ahk' class='text-muted'>source</a>

Creates an object composed of the picked object properties.


#### Arguments
object (Object): The source object.

[paths] (...(string|string[])): The property paths to pick.

#### Returns
(Object): Returns the new object.


#### Example

```autohotkey
object := {"a": 1, "b": "2", "c": 3}
A.pick(object, ["a", "c"])
; => {"a": 1, "c": 3}

```



## .pickBy

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/pickBy.ahk' class='text-muted'>source</a>

Creates an object composed of the object properties `predicate` returns truthy for. The predicate is invoked with two arguments: (value, key).


#### Arguments
object (Object): The source object.

[predicate:=.identity] (Function): The function invoked per property.


#### Returns
(Object): Returns the new object.


#### Example

```autohotkey
object := {"a": 1, "b": "two", "c": 3}
A.pickBy(object, A.isNumber)
; => {"a": 1, "c": 3}

```



## .set

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/set.ahk' class='text-muted'>source</a>

Sets the value at `path` of `object`. If a portion of `path` doesn't exist, it's created. Objects are created for all missing properties.


#### Arguments
object (Object): The object to modify.

path (Array|string): The path of the property to set.

value (*): The value to set.

#### Returns
(Object): Returns object.


#### Example

```autohotkey
object := {"a": [{ "b": {"c": 3} }]}
A.set(object, "a[1].b.c", 4)
; => {"a": [{ "b": {"c": 4} }]}

A.get(object, "a[1].b.c")
; => 4

A.set(object, ["x", "1", "y", "z"], 5)
A.get(object, ["x", "1", "y", "z"])
; => 5

```



## .toPairs

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/toPairs.ahk' class='text-muted'>source</a>

Creates an array of own enumerable string keyed-value pairs for object which can be consumed by [A.fromPairs](/?id=frompairs).


#### Aliases
`.entries`


#### Arguments
object (Object): The object to query.


#### Returns
(Array): Returns the key-value pairs.


#### Example

```autohotkey
A.toPairs({"a": 1, "b": 2})
; => [["a", 1], ["b", 2]]

```



## .values

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/object/values.ahk' class='text-muted'>source</a>

Creates an array of the own enumerable string keyed property values of `object`.


#### Arguments
object (Object): The object to query.


#### Returns
(Array): Returns the array of property values.


#### Example

```autohotkey
object := {"a": 1, "b": 2}
object.c := 3
A.values(object)
; => [1, 2, 3]

A.values("hi")
; => ["h", "i"]

```




# **String methods**
## .camelCase

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/camelCase.ahk' class='text-muted'>source</a>

Converts string to camel case.

#### Arguments
[string:=""] (string): The string to convert.

#### Returns
(string): Returns the camel cased string.


#### Example

```autohotkey
A.camelCase("--foo-bar--")
; => "fooBar"

A.camelCase("fooBar")
; => "fooBar"

A.camelCase("__FOO_BAR__")
; => "fooBar"

```



## .endsWith

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/endsWith.ahk' class='text-muted'>source</a>

Checks if `string` ends with the given target string.


#### Arguments
string (string): The string to inspect.

[target] (string): The string to search for.

[position:=strLen()] (number): The position to search up to.


#### Returns
(boolean): Returns true if string ends with target, else false.


#### Example

```autohotkey
A.endsWith("abc", "c")
; => true

A.endsWith("abc", "b")
; => false

A.endsWith("abc", "b", 2)
; => true

```



## .escape

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/escape.ahk' class='text-muted'>source</a>

Converts the characters "&", "<", ">", '"', and "'" in `string` to their corresponding HTML entities.

> [!Note]
> No other characters are escaped. To escape additional characters use a third-party library.

Though the ">" character is escaped for symmetry, characters like ">" and "/" don't need escaping in HTML and have no special meaning unless they're part of a tag or unquoted attribute value. See Mathias [Bynens's article](https://mathiasbynens.be/notes/ambiguous-ampersands) (under "semi-related fun fact") for more details.

When working with HTML you should always quote attribute values to reduce XSS vectors.


#### Arguments
[string:=""] (string): The string to escape.


#### Returns
(string): Returns the escaped string.


#### Example

```autohotkey
string := "fred, barney, & pebbles"
A.escape(string)
; => "fred, barney, &amp; pebbles"

```



## .kebabCase

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/kebabCase.ahk' class='text-muted'>source</a>

Converts `string` to kebab case.


#### Arguments
[string:=""] (string): The string to convert.


#### Returns
(string): Returns the kebab cased string.


#### Example

```autohotkey
A.kebabCase("Foo Bar")
; => "foo-bar"

A.kebabCase("fooBar")
; => "foo-bar"

A.kebabCase("--FOO_BAR--")
; => "foo-bar"

```



## .lowerCase

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/lowerCase.ahk' class='text-muted'>source</a>

Converts `string`, as space separated words, to lower case.


#### Arguments
[string:=""] (string): The string to convert.


#### Returns
(string): Returns the lower cased string.


#### Example

```autohotkey
A.lowerCase("--Foo-Bar--")
; => "foo bar"

A.lowerCase("fooBar")
; => "foo bar"

A.lowerCase("__FOO_BAR__")
; => "foo bar"

```



## .lowerFirst

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/lowerFirst.ahk' class='text-muted'>source</a>

Converts the first character of `string` to lower case.


#### Arguments
[string:=""] (string): The string to convert.


#### Returns
(string): Returns the converted string.


#### Example

```autohotkey
A.lowerFirst("Fred")
; => "fred"

A.lowerFirst("FRED")
; => "fRED"

```



## .pad

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/pad.ahk' class='text-muted'>source</a>

Pads `string` on the left and right sides if it's shorter than `length`. Padding characters are truncated if they can't be evenly divided by length.

#### Arguments
[string:=""] (string): The string to pad.

[length:=0] (number): The padding length.

[chars:=" "] (string): The string used as padding.


#### Returns
(string): Returns the padded string.


#### Example

```autohotkey
A.pad("abc", 8)
; => "  abc   "

A.pad("abc", 8, "_-")
; => "_-abc_-_"

A.pad("abc", 3)
; => "abc"

```



## .padEnd

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/padEnd.ahk' class='text-muted'>source</a>

Pads `string` on the right side if it's shorter than `length`. Padding characters are truncated if they exceed length.

#### Arguments
[string:=""] (string): The string to pad.

[length:=0] (number): The padding length.

[chars:=" "] (string): The string used as padding.


#### Returns
(string): Returns the padded string.


#### Example

```autohotkey
A.padEnd("abc", 6)
; => "abc   "

A.padEnd("abc", 6, "_-")
; => "abc_-_"

A.padEnd("abc", 3)
; => "abc"

```



## .padStart

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/padStart.ahk' class='text-muted'>source</a>

Pads `string` on the left side if it's shorter than `length`. Padding characters are truncated if they exceed length.

#### Arguments
[string:=""] (string): The string to pad.

[length:=0] (number): The padding length.

[chars:=" "] (string): The string used as padding.


#### Returns
(string): Returns the padded string.


#### Example

```autohotkey
A.padStart("abc", 6)
; => "   abc"

A.padStart("abc", 6, "_-")
; => "_-_abc"

A.padStart("abc", 3)
; => "abc"

```



## .parseInt

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/parseInt.ahk' class='text-muted'>source</a>

Converts string to an integer of the specified radix. If radix is `""` undefined or `0`, a radix of `10` is used unless value is a hexadecimal, in which case a radix of `16` is used.

#### Arguments
string (string): The string to convert.

[radix:=10] (number): The radix to interpret value by.


#### Returns

(number): Returns the converted integer.


#### Example

```autohotkey
A.parseInt("08")
; => 8

A.map(["6", "08", "10"], A.parseInt)
; => [6, 8, 10]

```



## .repeat

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/repeat.ahk' class='text-muted'>source</a>

Repeats the given string `n` times.


#### Arguments
[string:=""] (string): The string to repeat.

[n:=1] (number): The number of times to repeat the string.

#### Returns

(string): Returns the repeated string.


#### Example

```autohotkey
A.repeat("*", 3)
; => "***"

A.repeat("abc", 2)
; => "abcabc"

A.repeat("abc", 0)
; => ""

```



## .replace

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/replace.ahk' class='text-muted'>source</a>

Replaces matches for `pattern` in `string` with `replacement`.

#### Arguments
string (string): The string to modify.

pattern (RegExp|string): The pattern to replace.

replacement (string): The match replacement.

#### Returns

(string): Returns the modified string.


#### Example

```autohotkey
A.replace("Hi Fred", "Fred", "Barney")
; => "Hi Barney"

A.replace("1234", "/(\d+)/", "numbers")
; => "numbers"

```



## .snakeCase

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/snakeCase.ahk' class='text-muted'>source</a>

Converts `string` to snake case.

#### Arguments
[string:=""] (string): The string to convert.


#### Returns
(string): Returns the snake cased string.


#### Example

```autohotkey
A.snakeCase("Foo Bar")
; => "foo_bar"

A.snakeCase("fooBar")
; => "foo_bar"

A.snakeCase("--FOO-BAR--")
; => "foo_bar"

```



## .split

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/split.ahk' class='text-muted'>source</a>

Splits `string` by `separator`.


#### Arguments
[string:=""] (string): The string to split.

[separator:=","] (RegExp|string): The separator pattern to split by.

[limit:=0] (number): The length to truncate results to.

#### Returns
(Array): Returns the string segments.


#### Example

```autohotkey
A.split("a-b-c", "-", 2)
; => ["a", "b"]

A.split("a--b-c", "/[\-]+/")
; => ["a", "b", "c"]

```



## .startCase

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/startCase.ahk' class='text-muted'>source</a>

Converts `string` to start case.

#### Arguments
[string:=""] (string): The string to convert.

#### Returns
(string): Returns the start cased string.


#### Example

```autohotkey
A.startCase("--foo-bar--")
; => "Foo Bar"

A.startCase("fooBar")
; => "Foo Bar"

A.startCase("__FOO_BAR__")
; => "Foo Bar"

```



## .startsWith

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/startsWith.ahk' class='text-muted'>source</a>

Checks if `string` starts with the given target string.


#### Arguments
string (string): The string to inspect.

[target] (string): The string to search for.

[position:=1] (number): The position to search from.


#### Returns
(boolean): Returns true if string starts with target, else false.


#### Example

```autohotkey
A.startsWith("abc", "a")
; => true

A.startsWith("abc", "b")
; => false

A.startsWith("abc", "b", 2)
; => true

StringCaseSense, On
A.startsWith("abc", "A")
; => false

```



## .toLower

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/toLower.ahk' class='text-muted'>source</a>

Converts `string`, as a whole, to lower case.


#### Arguments
string (string): The string to convert.


#### Returns
(string): Returns the lower cased string.

#### Example

```autohotkey
A.toLower("--Foo-Bar--")
; => "--foo-bar--"

A.toLower("fooBar")
; => "foobar"

A.toLower("__FOO_BAR__")
; => "__foo_bar__"

```



## .toUpper

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/toUpper.ahk' class='text-muted'>source</a>

Converts `string`, as a whole, to upper case


#### Arguments
string (string): The string to convert.


#### Returns
(string): Returns the upper cased string.

#### Example

```autohotkey
A.toUpper("--foo-bar--")
; => "--FOO-BAR--"

A.toUpper("fooBar")
; => "FOOBAR"

A.toUpper("__foo_bar__")
; => "__FOO_BAR__"

```



## .trim

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/trim.ahk' class='text-muted'>source</a>

Removes leading and trailing whitespace or specified characters from `string`.


#### Arguments
[string:=""] (string): The string to trim.

[chars:=whitespace] (string): The characters to trim.


#### Returns
(string): Returns the trimmed string.


#### Example

```autohotkey
A.trim("  abc  ")
; => "abc"

A.trim("-_-abc-_-", "_-")
; => "abc"

A.map([" foo  ", "  bar  "], A.trim)
; => ["foo", "bar"]

```



## .trimEnd

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/trimEnd.ahk' class='text-muted'>source</a>

Removes trailing whitespace or specified characters from `string`.


#### Arguments
[string:=""] (string): The string to trim.

[chars:=whitespace] (string): The characters to trim.


#### Returns
(string): Returns the trimmed string.


#### Example

```autohotkey
A.trimEnd("  abc  ")
; => "  abc"

A.trimEnd("-_-abc-_-", "_-")
; => "-_-abc"

```



## .trimStart

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/trimStart.ahk' class='text-muted'>source</a>

Removes leading whitespace or specified characters from `string`.


#### Arguments
[string:=""] (string): The string to trim.

[chars:=whitespace] (string): The characters to trim.


#### Returns
(string): Returns the trimmed string.


#### Example

```autohotkey
A.trimStart("  abc  ")
; => "abc  "

A.trimStart("-_-abc-_-", "_-")
; => "abc-_-"

```



## .truncate

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/truncate.ahk' class='text-muted'>source</a>

Truncates `string` if it's longer than the given maximum string length. The last characters of the truncated string are replaced with the omission string which defaults to "...".


#### Arguments
[string:=""] (string): The string to truncate.

[options:={}] (Object): The options object.

[options.length:=30] (number): The maximum string length.

[options.omission:="..."] (string): The string to indicate text is omitted.

[options.separator] (RegExp|string): The separator pattern to truncate to.


#### Returns
(string): Returns the truncated string.


#### Example

```autohotkey
string := "hi-diddly-ho there, neighborino"
A.truncate(string)
; => "hi-diddly-ho there, neighbor..."

A.truncate(string, {"length": 24, "separator": " "})
; => "hi-diddly-ho there,..."

A.truncate(string, {"length": 24, "separator": "/, /"})
; => "hi-diddly-ho there..."

```



## .unescape

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/unescape.ahk' class='text-muted'>source</a>

The inverse of [A.escape](#escape) this method converts the HTML entities &amp;, &lt;, &gt;, &quot;, and &#39; in `string` to their corresponding characters.

> [!Note]
> No other HTML entities are unescaped. To unescape additional HTML entities use a dedicated third-party library.

#### Arguments
[string:=""] (string): The string to unescape.


#### Returns
(string): Returns the unescaped string.


#### Example

```autohotkey
string := "fred, barney, &amp; pebbles"
A.unescape(string)
; => "fred, barney, & pebbles"

```



## .upperCase

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/upperCase.ahk' class='text-muted'>source</a>

Converts `string`, as space separated words, to upper case.


#### Arguments
[string:=""] (string): The string to convert.


#### Returns
(string): Returns the upper cased string.


#### Example

```autohotkey
A.upperCase("--Foo-Bar--")
; => "FOO BAR"

A.upperCase("fooBar")
; => "FOO BAR"

A.upperCase("__FOO_BAR__")
; => "FOO BAR"

```



## .upperFirst

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/upperFirst.ahk' class='text-muted'>source</a>

Converts the first character of `string` to upper case.


#### Arguments
[string:=""] (string): The string to convert.


#### Returns
(string): Returns the converted string.


#### Example

```autohotkey
A.upperFirst("fred")
; => "Fred"

A.upperFirst("FRED")
; => "FRED"

```



## .words

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/string/words.ahk' class='text-muted'>source</a>

Splits `string` into an array of its words.


#### Arguments
string:="" (string): The string to inspect.

[pattern] (RegExp|string): The pattern to match words.


#### Returns

(Array): Returns the words of string.


#### Example

```autohotkey
A.words("fred, barney, & pebbles")
; => ["fred", "barney", "pebbles"]

A.words("fred, barney, & pebbles", "/[^, ]+/")
; => ["fred", "barney", "&", "pebbles"]

```




# **Util methods**
## .conforms

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/conforms.ahk' class='text-muted'>source</a>

Creates a function that invokes the predicate properties of `source` with the corresponding property values of a given object, returning true if all predicates return truthy, else false.


#### Arguments
source (Object): The object of property predicates to conform to.


#### Returns
(Function): Returns the new spec function.


#### Example

```autohotkey
objects := [{"a": 2, "b": 1}
		, {"a": 1, "b": 2}]
A.filter(objects, A.conforms({"b": func("fn_conformsFunc")}))
; => [{"a": 1, "b": 2}]

fn_conformsFunc(n)
{
	return n > 1
}
```



## .constant

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/constant.ahk' class='text-muted'>source</a>

Creates a function that returns `value`.


#### Arguments
value (*): The value to return from the new function.


#### Returns
(Function): Returns the new constant function.


#### Example

```autohotkey
object := A.times(2, A.constant({"a": 1}))
; => [{"a": 1}, {"a": 1}]
```



## .identity

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/identity.ahk' class='text-muted'>source</a>

This method returns the first argument it receives.

#### Arguments
value (*): Any value.


#### Returns
(*): Returns value.

#### Example

```autohotkey
object := {"a": 1}
A.identity(object)
; => {"a": 1}

```



## .matches

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/matches.ahk' class='text-muted'>source</a>

Creates a function that performs a shallow comparison between a given object and source, returning `true` if the given object has equivalent property values, else `false`.


#### Arguments
source (Object): The object of property values to match.


#### Returns
(Function): Returns the new spec function.


#### Example

```autohotkey
objects := [{ "a": 1, "b": 2, "c": 3 }, { "a": 4, "b": 5, "c": 6 }]
A.filter(objects, A.matches({ "a": 4, "c": 6 }))
; => [{ "a": 4, "b": 5, "c": 6 }]

functor := A.matches({ "a": 4 })
A.filter(objects, functor)
; => [{ "a": 4, "b": 5, "c": 6 }]

functor.call({ "a": 1 })
; => false

```



## .matchesProperty

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/matchesProperty.ahk' class='text-muted'>source</a>

Creates a function that performs a partial deep comparison between the value at `path` of a given object to `srcValue`, returning true if the object value is equivalent, else false.


#### Arguments
path (Array|string): The path of the property to get.

srcValue (*): The value to match.


#### Returns
(Function): Returns the new spec function.


#### Example

```autohotkey
objects := [{ "a": 1, "b": 2, "c": 3 }, { "a": 4, "b": 5, "c": 6 }]
A.find(objects, A.matchesProperty("a", 4))
; => { "a": 4, "b": 5, "c": 6 }

A.filter(objects, A.matchesProperty("a", 4))
; => [{ "a": 4, "b": 5, "c": 6 }]

objects := [{ "a": {"b": 2} }, { "a": {"b": 1} }]
A.find(objects, A.matchesProperty(["a", "b"], 1))
; => { "a": {"b": 1} }

```



## .noop

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/noop.ahk' class='text-muted'>source</a>

This method returns AutoHotkey's closest undefined equivilant; `""`.


#### Example

```autohotkey
A.times(2, A.stubObject)
; => [ {}, {} ]

```



## .nthArg

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/nthArg.ahk' class='text-muted'>source</a>

Creates a function that gets the argument at index `n`. If n is negative, the nth argument from the end is returned.


#### Arguments
[n:=1] (number): The index of the argument to return.


#### Returns
(Function): Returns the new pass-thru function.


#### Example

```autohotkey
func := A.nthArg(2)
func.call("a", "b", "c", "d")
; => "b"

func := A.nthArg(-2)
func.call("a", "b", "c", "d")
; => "c"

```



## .over

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/over.ahk' class='text-muted'>source</a>

Creates a function that invokes `iteratees` with the arguments it receives and returns their results.


#### Arguments
[iteratees:=.identity] (Function|Function[]*): The iteratees to invoke.


#### Returns
(Function): Returns the new function.


#### Example

```autohotkey
func := A.over([func("min"), func("max")])
func.call(1, 2, 3, 4)
; => [1, 4]

func := A.over([A.isBoolean, A.isNumber])
func.call(10)
; => [false, true]

```



## .print

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/print.ahk' class='text-muted'>source</a>

Prints `values` to terminal or other standard output device. Can be a string, or any other object to be converted into a string before written.


#### Arguments
values* (*): The values to print.


#### Returns
(string): Returns values in one string; stringifying any objects.


#### Example
```autohotkey
A.print([1, 2, 3])
; => "1:1, 2:2, 3:3"

msgbox, % A.print("object: ", [1, 2, 3])
; => msgboxes "object: 1:1, 2:2, 3:3"
```

#### Example

```autohotkey
objects := [{ "a": {"b": 2} }, { "a": {"b": 1} }]
A.map(objects, A.property("a.b"))
; => [2, 1]

A.map(objects, A.property(["a", "b"]))
; => [2, 1]

objects := [{"name": "fred"}, {"name": "barney"}]
A.map(objects, A.property("name"))
; => ["fred", "barney"]

```



## .propertyOf

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/propertyOf.ahk' class='text-muted'>source</a>

The opposite of [A.property](/?id=property) this method creates a function that returns the value at a given path of `object`.


#### Arguments
object (Object): The object to query.


#### Returns
(Function): Returns the new accessor function.


#### Example

```autohotkey
array := [0, 1, 2]
object := {"a": array, "b": array, "c": array}
A.map(["a[3]", "c[1]"], A.propertyOf(object))
; => [2, 0]

A.map([["a", 3], ["c", 1]], A.propertyOf(object))
; => [2, 0]

```



## .range

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/range.ahk' class='text-muted'>source</a>

Creates an array of numbers (positive and/or negative) progressing from `start` up to, but not including, `end`. A step of -1 is used if a negative start is specified without an end or step. If end is not specified, it's set to start with start then set to `0`. The array's size is used as the end when a step of `0` is specified.


#### Arguments
[start:=0] (number): The start of the range.
end (number): The end of the range.
[step:=1] (number): The value to increment or decrement by.


#### Returns
(Array): Returns the range of numbers.


#### Example

```autohotkey
A.range(4)
; => [0, 1, 2, 3]

A.range(-4)
; => [0, -1, -2, -3]

A.range(1, 5)
; => [1, 2, 3, 4]

A.range(0, 20, 5)
; => [0, 5, 10, 15]

A.range(0, -4, -1)
; => [0, -1, -2, -3]

A.range(1, 4, 0)
; => [1, 1, 1]

A.range(0)
; => []

```



## .rangeRight

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/rangeRight.ahk' class='text-muted'>source</a>

This method is like [A.range](/?id=range) except that it populates values in descending order.


#### Arguments
[start:=0] (number): The start of the range.
end (number): The end of the range.
[step:=1] (number): The value to increment or decrement by.


#### Returns
(Array): Returns the range of numbers.


#### Example

```autohotkey
A.rangeRight(4)
; => [3, 2, 1, 0]

A.rangeRight(-4)
; => [-3, -2, -1, 0]

A.rangeRight(1, 5)
; => [4, 3, 2, 1]

A.rangeRight(0, 20, 5)
; => [15, 10, 5, 0]

A.rangeRight(0, -4, -1)
; => [-3, -2, -1, 0]

A.rangeRight(1, 4, 0)
; => [1, 1, 1]

A.rangeRight(0)
; => []

```



## .stubArray

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/stubArray.ahk' class='text-muted'>source</a>

This method returns a new empty array.


#### Returns
(Array): Returns the new empty array.


#### Example

```autohotkey
A.times(2, A.stubArray)
; => [[], []]

```



## .stubFalse

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/stubFalse.ahk' class='text-muted'>source</a>

This method returns `false`.


#### Returns
(boolean): Returns `false`.


#### Example

```autohotkey
A.times(2, A.stubFalse)
; => [false, false]

```



## .stubObject

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/stubObject.ahk' class='text-muted'>source</a>

This method returns a new empty object.


#### Returns
(Object): Returns the new empty object.


#### Example

```autohotkey
A.times(2, A.stubObject)
; => [ {}, {} ]

```



## .stubString

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/stubString.ahk' class='text-muted'>source</a>

This method returns an empty string `""`.


#### Returns
(string): Returns the empty string.


#### Example

```autohotkey
A.times(2, A.stubString)
; => ["", ""]

```



## .stubTrue

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/stubTrue.ahk' class='text-muted'>source</a>

This method returns `true`.


#### Returns
(boolean): Returns `true`.


#### Example

```autohotkey
A.times(2, A.stubTrue)
; => [true, true]

```



## .times

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/times.ahk' class='text-muted'>source</a>

Invokes the `iteratee` `n` times, returning an array of the results of each invocation. The iteratee is invoked with one argument; (index).


#### Arguments
n (number): The number of times to invoke iteratee.

[iteratee:=.identity] (Function): The function invoked per iteration.


#### Returns
(Array): Returns the array of results.

#### Example
```autohotkey
A.times(4, A.constant(0))
; => [0, 0, 0, 0]

; make an array with random numbers
boundFunc := A.random.bind(A, 1, 1000, 0)
array := A.times(5, boundFunc)
; => [395, 364, 809, 904, 449]
```



## .toPath

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/toPath.ahk' class='text-muted'>source</a>

Converts `value` to a property path array.


#### Arguments
value (*): The value to convert.


#### Returns
(Array): Returns the new property path array.


#### Example

```autohotkey
A.toPath("a.b.c")
; => ["a", "b", "c"]

A.toPath("a[1].b.c")
; => ["a", "1", "b", "c"]

```



## .uniqueId

<a href='https://github.com/biga-ahk/biga.ahk/blob/master/src/util/uniqueId.ahk' class='text-muted'>source</a>

Generates a unique ID. If `prefix` is given, the ID is appended to it.


#### Arguments
[prefix:=""] (string): The value to prefix the ID with.


#### Returns
(string): Returns the unique ID.

#### Example

```autohotkey
A.uniqueId("contact_")
; => "contact_1"

A.uniqueId()
; => 2

```



