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
Creates an array of elements split into groups the length of size. If array can't be split evenly, the final chunk will be the remaining elements.


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
Creates an array with all falsey values removed. The values false, 0, and "" are falsey.


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
Creates a new array concatenating array with any additional arrays and/or values.

#### Arguments
array (Array): The array to concatenate.

[values] (...*): The values to concatenate.


#### Returns
(Array): Returns the new concatenated array.


#### Example

```autohotkey
array := [1]A.concat(array, 2, [3], [[4]])
; => [1, 2, 3, [4]]

A.concat(array)
; => [1]

```



## .depthOf
This method is explores the array and returns the maximum depth.


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
Creates an array of array values not included in the other given arrays. The order of result values are determined by the first array.

#### Arguments
array (Array): The array to inspect.

values (...Array): The values to exclude.


#### Returns
(Array): Returns the new array of filtered values.


#### Example

```autohotkey
A.difference([2, 1], [2, 3])
; => [1]

A.difference([2, 1], [3])
; => [2, 1]

A.difference([2, 1], 3)
; => [2, 1]

```



## .drop
Creates a slice of array with n elements dropped from the beginning.


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
Creates a slice of array with n elements dropped from the end.


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
Creates a slice of array excluding elements dropped from the end. Elements are dropped until predicate returns falsey. The predicate is invoked with three arguments: (value, index, array).


#### Arguments
array (Array): The array to query.

[predicate:=.identity] (Function): The function invoked per iteration.


#### Returns

(Array): Returns the slice of array.


#### Example

```autohotkey
users := [ {"user": "barney", 	"active": true}		, {"user": "fred",		"active": false}		, {"user": "pebbles", 	"active": false} ]A.dropRightWhile(users, Func("fn_dropRightWhile"))
; => [{"user": "barney", "active": true }]

fn_dropRightWhile(o){	return !o.active}; The A.matches iteratee shorthand.A.dropRightWhile(users, {"user": "pebbles", "active": false})
; => [ {"user": "barney", "active": true }, {"user": "fred", "active": false} ]

; The A.matchesProperty iteratee shorthand.A.dropRightWhile(users, ["active", false])
; => [ {"user": "barney", "active": true } ]

; The A.property iteratee shorthand.A.dropRightWhile(users, "active")
; => [ {"user": "barney", "active": true }, {"user": "fred", "active": false }, {"user": "pebbles", "active": false} ]

```



## .dropWhile
Creates a slice of array excluding elements dropped from the beginning. Elements are dropped until predicate returns falsey. The predicate is invoked with three arguments: (value, index, array).


#### Arguments
array (Array): The array to query.

[predicate:=.identity] (Function): The function invoked per iteration.


#### Returns
(Array): Returns the slice of array.


#### Example

```autohotkey
users := [ {"user": "barney", 	"active": false }		, { "user": "fred", 	"active": false }		, { "user": "pebbles", 	"active": true } ]A.dropWhile(users, Func("fn_dropWhile"))
; => [{ "user": "pebbles", "active": true }]

fn_dropWhile(o){	return !o.active}; The A.matches iteratee shorthand.A.dropWhile(users, {"user": "barney", "active": false})
; => [ { "user": "fred", "active": false }, { "user": "pebbles", "active": true } ]

; The A.matchesProperty iteratee shorthand.A.dropWhile(users, ["active", false])
; => [ {"user": "pebbles", "active": true } ]

; The A.property iteratee shorthand.A.dropWhile(users, "active")
; => [ {"user": "barney", "active": false }, { "user": "fred", "active": false }, { "user": "pebbles", "active": true } ]

```



## .fill
Fills elements of array with value from start up to, but not including, end.

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
array := [1, 2, 3]A.fill(array, "a")
; => ["a", "a", "a"]

A.fill([4, 6, 8, 10], "*", 2, 3)
; => [4, "*", "*", 10]

```



## .findIndex
This method is like [A.find](/?id=find) except that it returns the index of the first element predicate returns truthy for instead of the element itself.


#### Arguments
array (Array): The array to inspect.

[predicate:=.identity] (Function): The function invoked per iteration.

[fromIndex:=1] (number): The index to search from.


#### Returns
(number): Returns the index of the found element, else -1.


#### Example

```autohotkey
users := [ { "user": "barney", "age": 36, "active": true }	, { "user": "fred", "age": 40, "active": false }	, { "user": "pebbles", "age": 1, "active": true } ]; The A.matches iteratee shorthand.A.findIndex(users, { "age": 1, "active": true })
; => 3

; The A.matchesProperty iteratee shorthand.A.findIndex(users, ["active", false])
; => 2

; The A.property iteratee shorthand.A.findIndex(users, "active")
; => 1

```



## .findLastIndex
This method is like [A.findIndex](/?id=findindex) except that it iterates over elements of collection from right to left.

#### Arguments
array (Array): The array to inspect.

[predicate:=.identity] (Function): The function invoked per iteration.

[fromIndex:=array.count()] (number): The index to search from.


#### Returns
(key): Returns the key of the found element, else -1.


#### Example

```autohotkey
users := [{"user": "barney", "active": true}		, {"user": "fred", "active": false}		, {"user": "pebbles", "active": false}]A.findLastIndex(users, {"user": "barney", "active": true})
; => 1

A.findLastIndex(users, ["active", true])
; => 1

A.findLastIndex(users, "active")
; => 1

```



## .flatten
Flattens array a single level deep.


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
Recursively flattens array.


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
Recursively flatten array up to depth times.


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
Gets the first element of array.

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
Gets the index at which the first occurrence of value is found in array. If fromIndex is negative, it's used as the offset from the end of array.


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

; Search from the `fromIndex`.A.indexOf([1, 2, 1, 2], 2, 3)
; => 4

A.indexOf(["fred", "barney"], "pebbles")
; => -1

StringCaseSense, OnA.indexOf(["fred", "barney"], "Fred")
; => -1

```



## .initial
Gets all but the last element of array.


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
Converts all elements in array into a string separated by separator.


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
Gets the last element of array.


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

A.last("fred")
; => "d"

A.last(100)
; => "0"

```



## .lastIndexOf
This method is like [A.indexOf](/?id=indexof) except that it iterates over elements of array from right to left.


#### Arguments
array (Array): The array to inspect.

value (*): The value to search for.

[fromIndex:=array.Count()] (number): The index to search from.


#### Returns
(number): Returns the index of the matched value, else -1.


#### Example

```autohotkey
A.lastIndexOf([1, 2, 1, 2], 2)
; => 4

; Search from the `fromIndex`.A.lastIndexOf([1, 2, 1, 2], 1, 2)
; => 1

StringCaseSense, OnA.lastIndexOf(["fred", "barney"], "Fred")
; => -1

```



## .nth
Gets the element at index n of array. If n is negative, the nth element from the end is returned.


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
Reverses array so that the first element becomes the last, the second element becomes the second to last, and so on.


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
Creates a slice of array from start up to end.


#### Arguments
array (Array): The array to slice.

[start:=1] (number): The start position.

[end:=array.Count()] (number): The end position.


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
Uses a search to determine the lowest index at which value should be inserted into array in order to maintain its sort order.


#### Arguments
array (Array): The sorted array to inspect.

value (*): The value to evaluate.


#### Returns
(number): Returns the index at which value should be inserted into array.


#### Example

```autohotkey
A.sortedIndex([30, 50], 40)
; => 2

A.sortedIndex([30, 50], 20)
; => 1

A.sortedIndex([30, 50], 99)
; => 3

```



## .sortedUniq
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
Gets all but the first element of array.


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
Creates a slice of array with n elements taken from the beginning.


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
Creates a slice of array with n elements taken from the end.


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
Creates a duplicate-free version of an array, in which only the first occurrence of each element is kept. The order of result values is determined by the order they occur in the array.


#### Arguments
array (Array): The array to inspect.


#### Returns
(Array): Returns the new duplicate free array.

#### Example

```autohotkey
A.uniq([2, 1, 2])
; => [2, 1]

```



## .without
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
Creates an array of grouped elements, the first of which contains the first elements of the given arrays, the second of which contains the second elements of the given arrays, and so on.

> [!Warning]
> This method has not reached pairity with Lodash.
> Output will not match Lodash output in the event the length of all supplied arrays are not the same.

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
Gets the number of occurrences of value if found in collection, else `0`

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

users := [ {"user": "fred", "age": 40, "active": true}		, {"user": "barney", "age": 36, "active": false}		, {"user": "pebbles", "age": 1, "active": false} ]; The A.matches iteratee shorthand.A.count(users, {"age": 1, "active": false})
; => 1

; The A.matchesProperty iteratee shorthand.A.count(users, ["active", false])
; => 2

; The A.property iteratee shorthand.A.count(users, "active")
; => 1

```



## .countBy
Creates an object composed of keys generated from the results of running each element of collection thru iteratee. The corresponding value of each key is the number of times the key was returned by iteratee. The iteratee is invoked with one argument: (value).


#### Arguments
object (Array|Object): The collection to iterate over.

[predicate:=.identity] (Function): The iteratee to transform keys.


#### Returns
(Object): Returns the composed aggregate object.


#### Example

```autohotkey
A.countBy([6.1, 4.2, 6.3], Func("floor"))
; => {"4": 1, "6": 2}

; The A.property iteratee shorthand.A.countBy(["one", "two", "three"], A.size)
; => {"3": 2, "5": 1}

```



## .every
Checks if predicate returns truthy for all elements of collection. Iteration is stopped once predicate returns falsey. The predicate is invoked with three arguments: (value, index|key, collection).

> [!Note]
> This method returns true for empty collections because everything is true of elements of empty collections.


#### Arguments
collection (Array|Object): The collection to iterate over.

[predicate:=.identity] (Function): The function invoked per iteration.


#### Returns
(boolean): Returns true if all elements pass the predicate check, else false.


#### Example

```autohotkey
users := [{ "user": "barney", "age": 36, "active": false }, { "user": "fred", "age": 40, "active": false }]A.every(users, func("fn_isOver18"))
; => true

fn_isOver18(o){	return % o.age >= 18}; The A.matches iteratee shorthand.A.every(users, {"user": "barney", "age": 36, "active": false})
; => false

; The A.matchesProperty iteratee shorthand.A.every(users, ["active", false])
; => true

; The A.property iteratee shorthand.A.every(users, "active")
; => false

```



## .filter
Iterates over elements of collection, returning an array of all elements predicate returns truthy for. The predicate is invoked with three arguments: (value, index|key, collection).


#### Arguments
collection (Array|Object): The collection to iterate over.

function (Function): The function invoked per iteration.


#### Returns
(Array): Returns the new filtered array.


#### Example

```autohotkey
users := [{"user":"barney", "age":36, "active":true}, {"user":"fred", "age":40, "active":false}]A.filter(users, Func("fn_filterFunc"))
; => [{"user":"barney", "age":36, "active":true}]

fn_filterFunc(param_iteratee){	if (param_iteratee.active) {		return true	}}; The A.matches shorthandA.filter(users, {"age":36, "active":true})
; => [{"user":"barney", "age":36, "active":true}]

; The A.matchesProperty shorthandA.filter(users, ["active", false])
; => [{"user":"fred", "age":40, "active":false}]

; The A.property shorthandA.filter(users, "active")
; => [{"user":"barney", "age":36, "active":true}]

```



## .find
Iterates over elements of collection, returning the first element predicate returns truthy for.


#### Arguments
collection (Array|Object): The collection to inspect.

function (Function): The function invoked per iteration.

[fromIndex:=1] (number): The index to search from.


#### Returns
(*): Returns the matched element, else `false`.


#### Example

```autohotkey
users := [ {"user": "barney", "age": 36, "active": true}	, {"user": "fred", "age": 40, "active": false}	, {"user": "pebbles", "age": 1, "active": true} ]A.find(users, Func("fn_findFunc"))
; => { "user": "barney", "age": 36, "active": true }

fn_findFunc(o){	return o.active}; The A.matches iteratee shorthand.A.find(users, { "age": 1, "active": true })
; => { "user": "pebbles", "age": 1, "active": true }

; The A.matchesProperty iteratee shorthand.A.find(users, ["active", false])
; => { "user": "fred", "age": 40, "active": false }

; The A.property iteratee shorthand.A.find(users, "active")
; => { "user": "barney", "age": 36, "active": true }

```



## .findLast
This method is like [A.find](/?id=find) except that it iterates over elements of collection from right to left.


#### Arguments
collection (Array|Object): The collection to inspect.

function (Function): The function invoked per iteration.


#### Returns
(*): Returns the matched element, else `false`.


#### Example

```autohotkey
A.findLast([1, 2, 3, 4], Func("fn_findLastFunc"))
; => 3

fn_findLastFunc(n){	return mod(n, 2) == 1}```



## .forEach
Iterates over elements of collection and invokes iteratee for each element. The iteratee is invoked with three arguments: (value, index|key, collection). Iteratee functions may exit iteration early by explicitly returning false.


#### Aliases
`.each`


#### Arguments
collection (Array|Object): The collection to iterate over.

[iteratee:=.identity] (Function): The function invoked per iteration.


#### Returns
(*): Returns collection.


#### Example

```autohotkey
A.forEach([1, 2], Func("fn_forEachFunc1"))
fn_forEachFunc1(value)
{
	msgbox, % value
}
; msgboxes 1 then 2

A.forEach({ "a": 1, "b": 2 }, Func("fn_forEachFunc2"))
fn_forEachFunc2(value, key)
{
	msgbox, % key
}
; msgboxes "a" then "b"
```




## .forEachRight
This method is like [A.forEach](/?id=foreach) except that it iterates over elements of collection from right to left.


#### Aliases
`.eachRight`


#### Arguments
collection (Array|Object): The collection to iterate over.

[iteratee:=.identity] (Function): The function invoked per iteration.


#### Returns
(*): Returns collection.


#### Example

```autohotkey
A.forEach([1, 2], Func("fn_forEachFunc1"))
fn_forEachFunc1(value)
{
	msgbox, % value
}
; msgboxes 2 then 1

A.forEach({ "a": 1, "b": s2 }, Func("fn_forEachFunc2"))
fn_forEachFunc2(value, key)
{
	msgbox, % key
}
; msgboxes "b" then "a"
```




## .groupBy
Creates an object composed of keys generated from the results of running each element of collection thru iteratee. The order of grouped values is determined by the order they occur in collection. The corresponding value of each key is an array of elements responsible for generating the key. The iteratee is invoked with one argument: (value).


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

A.groupBy([6.1, 4.2, 6.3], func("Ceil"))
; => {5: [4.2], 7: [6.1, 6.3]}

```



## .includes
Checks if value is in collection. If collection is a string, it's checked for a substring of value.


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

A.includes("InStr", "Str")
; => true

StringCaseSense, OnA.includes("InStr", "str")
; => false

; RegEx objectA.includes("hello!", "/\D/")
; => true

```



## .keyBy
Creates an object composed of keys generated from the results of running each element of collection thru iteratee. The corresponding value of each key is the last element responsible for generating the key. The iteratee is invoked with one argument: (value).


#### Arguments
collection (Array|Object): The collection to iterate over.

[iteratee:=A.identity] (Function): The iteratee to transform keys.


#### Returns
(Object): Returns the composed aggregate object.


#### Example

```autohotkey
array := [ {"dir": "left", "code": 97}	, {"dir": "right", "code": 100}]A.keyBy(array, Func("fn_keyByFunc"))
; => {"left": {"dir": "left", "code": 97}, "right": {"dir": "right", "code": 100}}

fn_keyByFunc(value){	return value.dir}; The A.property iteratee shorthand.A.keyBy(array, "dir")
; => {"left": {"dir": "left", "code": 97}, "right": {"dir": "right", "code": 100}}

```



## .map
Creates an array of values by running each element in collection thru iteratee. The iteratee is invoked with three arguments: (value, index|key, collection).


#### Arguments
collection (Array|Object): The collection to iterate over.

[iteratee:=.identity] (Function): The function invoked per iteration.


#### Returns
(Array): Returns the new mapped array.


#### Example

```autohotkey
fn_square(n){	return n * n}A.map([4, 8], Func("fn_square"))
; => [16, 64]

A.map({ "a": 4, "b": 8 }, Func("fn_square"))
; => [16, 64]

A.map({ "a": 4, "b": 8 })
; => [4, 8]

; The A.property shorthandusers := [{ "user": "barney" }, { "user": "fred" }]A.map(users, "user")
; => ["barney", "fred"]

```



## .partition
Creates an array of elements split into two groups, the first of which contains elements predicate returns truthy for, the second of which contains elements predicate returns falsey for. The predicate is invoked with one argument: (value).


#### Arguments
collection (Array|Object): The collection to iterate over.

[predicate:=.identity] (Function): The function invoked per iteration.


#### Returns
(Array): Returns the array of grouped elements.


#### Example

```autohotkey
users := [ { "user": "barney", "age": 36, "active": false }	, { "user": "fred", "age": 40, "active": true }	, { "user": "pebbles", "age": 1, "active": false } ]A.partition(users, func("fn_partitionFunc"))
; => [[{ "user": "fred", "age": 40, "active": true }], [{ "user": "barney", "age": 36, "active": false }, { "user": "pebbles", "age": 1, "active": false }]]

fn_partitionFunc(o){	return o.active}; The A.matches iteratee shorthand.A.partition(users, {"age": 1, "active": false})
; => [[{ "user": "pebbles", "age": 1, "active": false }], [{ "user": "barney", "age": 36, "active": false }, { "user": "fred", "age": 40, "active": true }]]

; The A.propertyMatches iteratee shorthand.A.partition(users, ["active", false])
; => [[{ "user": "barney", "age": 36, "active": false }, { "user": "pebbles", "age": 1, "active": false }] ,[{ "user": "fred", "age": 40, "active": true }]]

; The A.property iteratee shorthand.A.partition(users, "active")
; => [[{ "user": "fred", "age": 40, "active": true }], [{ "user": "barney", "age": 36, "active": false }, { "user": "pebbles", "age": 1, "active": false }]]

```



## .reject
The opposite of [A.filter](/?id=filter) this method returns the elements of collection that predicate does **not** return truthy for.

#### Arguments
collection (Array|Object): The collection to iterate over.

[predicate:=.identity] (Function): The function invoked per iteration.


#### Returns
(Array): Returns the new filtered array.


#### Example

```autohotkey
users := [{"user":"barney", "age":36, "active":false}, {"user":"fred", "age":40, "active":true}]A.reject(users, Func("fn_rejectFunc"))
; => [{"user":"fred", "age":40, "active":true}]

fn_rejectFunc(o){	return !o.active}; The A.matches shorthandA.reject(users, {"age":40, "active":true})
; => [{"user":"barney", "age":36, "active":false}]

; The A.matchesProperty shorthandA.reject(users, ["active", false])
; => [{"user":"fred", "age":40, "active":true}]

; The A.property shorthandA.reject(users, "active")
; => [{"user":"barney", "age":36, "active":false}]

```



## .sample
Gets a single random element from collection.

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
Gets `n` random elements at unique keys from collection up to the size of collection.


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
Gets the size of collection by returning its length for array-like values or the number of own enumerable string keyed properties for objects.


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
Checks if predicate returns truthy for **any** element of collection. Iteration is stopped once predicate returns truthy. The predicate is invoked with three arguments: (value, index|key, collection).


#### Arguments
collection (Array|Object): The collection to iterate over.

[iteratees:=.identity] (Function): The function invoked per iteration.


#### Returns
(Array): Returns true if any element passes the predicate check, else false.


#### Example

```autohotkey
users := [{ "user": "barney", "active": true }, { "user": "fred", "active": false }]; The A.matches iteratee shorthand.A.some(users, { "user": "barney", "active": false })
; => false

; The A.matchesProperty iteratee shorthand.A.some(users, ["active", false])
; => true

; The A.property iteratee shorthand.A.some(users, "active")
; => true

```



## .sortBy
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

users := [ , { "name": "fred", "age": 40 } , { "name": "barney", "age": 34 } , { "name": "bernard", "age": 36 } , { "name": "zoey", "age": 40 }]A.sortBy(users, "age")
; => [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"zoey"}, {"age":40, "name":"fred"}]

A.sortBy(users, ["age", "name"])
; => [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zoey"}]

A.sortBy(users, Func("fn_sortByFunc"))
; => [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zoey"}]

fn_sortByFunc(o){	return o.name}; sort using result of another methodA.sortBy(["ab", "a", " abc", "abc"], A.size)
; => ["a", "ab", "abc", " abc"]

```




# **Date methods**
## .now
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
## .delay
Invokes func after wait milliseconds. Any additional arguments are provided to func when it's invoked.


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





# **Lang methods**
## .castArray
Casts value as an array if it's not one.

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
Creates a shallow clone of value. Supports cloning arrays, objects, numbers, strings.

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
This method is like [A.clone](/?id=clone) except that it recursively clones value.


#### Arguments
value (*): The value to recursively clone.


#### Returns
(*): Returns the deep cloned value.


#### Example

```autohotkey
object := [{ "a": [[1, 2, 3]] }, { "b": 2 }]deepclone := A.cloneDeep(object)object[1].a := 2; object; => [{ "a": 2 }, { "b": 2 }]; deepclone; => [{ "a": [[1, 2, 3]] }, { "b": 2 }]```



## .isAlnum
Checks if value is an alnum.


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
Checks if value is classified as a boolean.


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



## .isEqual
Performs a deep comparison between two values to determine if they are equivalent.

This method supports comparing strings and objects.


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

StringCaseSense, OnA.isEqual({ "a": "a" }, { "a": "A" })
; => false

```



## .isFloat
Checks if `value` is a float.


#### Arguments
value (*): The `value` to check.


#### Returns
(boolean): Returns `true` if `value` is a float, else `false`.


#### Example

```autohotkey
A.isFloat(1.0)
; => true

A.isFloat(1)
; => false

```



## .isFunction
Checks if `value` is callable as a function object, bound function, or object method.


#### Arguments
value (*): The `value` to check.


#### Returns
(boolean): Returns `true` if `value` is callable, else `false`.


#### Example

```autohotkey
boundFunc := Func("strLen").bind()A.isFunction(boundFunc)
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
Checks if value is an integer.


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



## .isMatch
Performs a partial deep comparison between object and source to determine if object contains equivalent property values.

Partial comparisons will match empty array and empty object source values against any array or object value, respectively. See [A.isEqual](/?id=isEqual) for a list of supported value comparisons.


#### Arguments
object (Object): The object to inspect.

source (Object): The object of property values to match.


#### Returns
(boolean): Returns true if object is a match, else false.

#### Example

```autohotkey
object := { "a": 1, "b": 2, "c": 3 }A.isMatch(object, {"b": 2})
; => true

A.isMatch(object, {"b": 2, "c": 3})
; => true

A.isMatch(object, {"b": 1})
; => false

A.isMatch(object, {"b": 2, "z": 99})
; => false

```



## .isNumber
Checks if value is a number.


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
Checks if value is an object.


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
Checks if value is classified as a string.


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
Checks if value is undefined or blank.


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



## .toArray
Converts value to an array.


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



## .toString
Converts value to a string. An empty string is returned for undefined values. The sign of `-0` is preserved.


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
Computes number rounded up to precision.


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
Computes number rounded down to precision.


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
Computes the maximum value of array. If array is empty or falsey, `""` is returned.


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
This method is like [A.max](/?id=max) except that it accepts iteratee which is invoked for each element in array to generate the criterion by which the value is ranked. The iteratee is invoked with one argument: (value).

#### Arguments
array (Array): The array to iterate over.

[iteratee:=.identity] (Function): The iteratee invoked per element.


#### Returns
(*): Returns the maximum value.

#### Example

```autohotkey
objects := [ {"n": 4 }, { "n": 2 }, { "n": 8 }, { "n": 6 } ]A.maxBy(objects, Func("fn_maxByFunc"))
; => { "n": 8 }

fn_maxByFunc(o){	return o.n}; The A.property iteratee shorthandA.maxBy(objects, "n")
; => { "n": 8 }

```



## .mean
Computes the mean of the values in array.


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
This method is like [A.mean](/?id=mean) except that it accepts iteratee which is invoked for each element in array to generate the value to be averaged. The iteratee is invoked with one argument: (value).

#### Arguments
array (Array): The array to iterate over.

[iteratee:=.identity] (Function): The iteratee invoked per element.


#### Returns
(number): Returns the mean.

#### Example

```autohotkey
objects := [{"n": 4}, {"n": 2}, {"n": 8}, {"n": 6}]A.meanBy(objects, Func("fn_meanByFunc"))
; => 5

fn_meanByFunc(o){	return o.n}; The A.property iteratee shorthand.A.meanBy(objects, "n")
; => 5

```



## .min
Computes the minimum value of array. If array is empty or falsey, `""` is returned.


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
This method is like [A.min](/?id=min) except that it accepts iteratee which is invoked for each element in array to generate the criterion by which the value is ranked. The iteratee is invoked with one argument: (value).

#### Arguments
array (Array): The array to iterate over.

[iteratee:=.identity] (Function): The iteratee invoked per element.


#### Returns
(*): Returns the minimum value.

#### Example

```autohotkey
objects := [ {"n": 4 }, { "n": 2 }, { "n": 8 }, { "n": 6 } ]A.minBy(objects, Func("fn_minByFunc"))
; => { "n": 2 }

fn_minByFunc(o){	return o.n}; The A.property iteratee shorthandA.minBy(objects, "n")
; => { "n": 2 }

```



## .multiply
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
Computes number rounded to precision.


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
Computes the sum of the values in array.


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
This method is like [A.sum](/?id=sum) except that it accepts iteratee which is invoked for each element in array to generate the value to be summed. The iteratee is invoked with one argument: (value).


#### Arguments
array (Array): The array to iterate over.
[iteratee=_.identity] (Function): The iteratee invoked per element.


#### Returns
(number): Returns the sum.


#### Example

```autohotkey
objects := [ {"n": 4 }, { "n": 2 }, { "n": 8 }, { "n": 6 } ]A.sumBy(objects, Func("fn_sumByFunc"))
; => 20

fn_sumByFunc(o){	return o.n}; The A.property iteratee shorthandA.sumBy(objects, "n")
; => 20

```




# **Number methods**
## .clamp
Clamps number within the inclusive lower and upper bounds.


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
Checks if n is between start and up to, but not including, end. If end is not specified, it's set to start with start then set to 0. If start is greater than end the params are swapped to support negative ranges.


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
Produces a random number between the inclusive lower and upper bounds. If floating is true, or either lower or upper are floats, a floating-point number is returned instead of an integer. Uses AutoHotkey's pseudo-random [Random](https://www.autohotkey.com/docs/commands/Random.htm) command.


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


#### Example

```autohotkey
object := {"a": [{ "b": { "c": 3} }, 4]}A.at(object, ["a[1].b.c", "a[2]"])
; => [3, 4]

```



## .defaults
Assigns own and inherited enumerable string keyed properties of source objects to the destination object for all destination properties. Source objects are applied from left to right. Once a property is set, additional values of the same property are ignored.

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
This method is like [A.find](/?id=find) except that it returns the key of the first element predicate returns truthy for instead of the element itself.


#### Arguments
collection (Array|Object): The collection to inspect.

function (Function): The function invoked per iteration.

[fromIndex:=1] (number): The index to search from.


#### Returns
(*): Returns the matched element, else false.


#### Example

```autohotkey
users := { "barney": {"age": 36, "active": true}, "fred": {"age": 40, "active": false}, "pebbles": {"age": 1, "active": true} }A.findKey(users, Func("fn_findKeyFunc"))
; => "barney"

fn_findKeyFunc(o){	return o.age < 40}; The A.matches iteratee shorthand.A.findKey(users, {"age": 1, "active": true})
; => "pebbles"

; The A.matchesProperty iteratee shorthand.A.findKey(users, ["active", false])
; => "fred"

; The A.property iteratee shorthand.A.findKey(users, "active")
; => "barney"

```



## .get
Gets the value at path of object. If the resolved value is `""`, the defaultValue is returned in its place.


#### Arguments
object (Object): The object to query.

path (Array|string): The path of the property to get.

[defaultValue] (*): The value returned for undefined resolved values.


#### Returns
(*): Returns the resolved value.


#### Example

```autohotkey
object := {"a": [{ "b": { "c": 3} }]}A.get(object, "a[1].b.c")
; => 3

A.get(object, ["a", "1", "b", "c"])
; => 3

A.get(object, "a.b.c", "default")
; => "default"

```



## .invert
Creates an object composed of the inverted keys and values of object. If object contains duplicate values, subsequent values overwrite property assignments of previous values.

> [!Note]
> AutoHotkey object keys are always converted to lowercase.

#### Arguments
object (Object): The object to invert.


#### Returns
(Array): Returns the new inverted object.


#### Example

```autohotkey
object := {"a": 1, "b": 2, "c": 1}A.invert(object)
; => {"1": "c", "2": "b"}

A.invert({1: "a", 2: "A"})
; => {"a": 2}

```



## .invertBy
This method is like [A.invert](/?id=invert) except that the inverted object is generated from the results of running each element of object thru iteratee. The corresponding inverted value of each inverted key is an array of keys responsible for generating the inverted value. The iteratee is invoked with one argument: (value).

> [!Note]
> AutoHotkey object keys are always converted to lowercase.

#### Arguments
object (Object): The object to invert.

[iteratee=A.identity] (Function): The iteratee invoked per element.

#### Returns
(Array): Returns the new inverted object.


#### Example

```autohotkey
object := {"a": 1, "b": 2, "c": 1}A.invertBy(object)
; => {"1": ["a", "c"], "2":["b"]}

A.invertBy(object, Func("invertByFunc"))
; => {"group1": ["a", "c"], "group2": ["b"]}

invertByFunc(value){	return "group" value}```



## .keys
Creates an array of the own enumerable properties of object.


#### Arguments
object (Object): The object to query.


#### Returns
(Array): Returns the array of property names.


#### Example

```autohotkey
object := {"a": 1, "b": 2, "c": 3}A.keys(object)
; => ["a", "b", "c"]

A.keys("hi")
; => [1, 2]

```



## .mapKeys
The opposite of [A.mapValues](/?id=mapvalues) this method creates an object with the same values as object and keys generated by running each own enumerable string keyed property of object thru iteratee. The iteratee is invoked with three arguments: (value, index|key, object).


#### Arguments
object (Object): The object to iterate over.

[iteratee:=.identity] (Function): The function invoked per iteration.


#### Returns
(Object): Returns the new mapped object.


#### Example

```autohotkey
A.mapKeys({"a": 1, "b": 2}, Func("fn_mapKeysFunc"))
; => {"a+1": 1, "b+2": 2}

fn_mapKeysFunc(value, key){	return key "+" value}```



## .mapValues
Creates an object with the same keys as object and values generated by running each own enumerable string keyed property of object thru iteratee. The iteratee is invoked with three arguments: (value, index|key, object).


#### Arguments
object (Object): The object to iterate over.

[iteratee:=.identity] (Function): The function invoked per iteration.


#### Returns
(Object): Returns the new mapped object.


#### Example

```autohotkey
users := {"fred": {"user": "fred", "age": 40}		,"pebbles": {"user": "pebbles", "age": 1}}A.mapValues(users, Func("fn_mapValuesFunc"))
; => {"fred": 40, "pebbles": 1}

fn_mapValuesFunc(o){	return o.age}; The A.property iteratee shorthand.A.mapValues(users, "age")
; => {"fred": 40, "pebbles": 1}

```



## .merge
This method recursively merges own and inherited enumerable string keyed properties of source objects into the destination object. Array and plain object properties are merged recursively. Other objects and value types are overridden by assignment. Source objects are applied from left to right. Subsequent sources overwrite property assignments of previous sources.


#### Arguments
object (Object): The destination object.

[sources] (...Object): The source objects.


#### Returns
(Object): Returns object.


#### Example

```autohotkey
object := {"options": [{"option1": true}]}other := {"options": [{"option2": false}]}A.merge(object, other)
; => {"options": [{"option1": true, "option2": false}]}

object := { "a": [{ "b": 2 }, { "d": 4 }] }other := { "a": [{ "c": 3 }, { "e": 5 }] }A.merge(object, other)
; => { "a": [{ "b": "2", "c": 3 }, { "d": "4", "e": 5 }] }

```



## .omit
The opposite of [A.pick](/?id=pick) this method creates an object composed of the own and inherited enumerable property paths of object that are not omitted.


#### Arguments
object (Object): The source object.

[paths] (...(string|string[])): The property paths to omit.

#### Returns
(Object): Returns the new object.


#### Example

```autohotkey
object := {"a": 1, "b": "2", "c": 3}A.omit(object, ["a", "c"])
; => {"b": "2"}

```



## .pick
Creates an object composed of the picked object properties.


#### Arguments
object (Object): The source object.

[paths] (...(string|string[])): The property paths to pick.

#### Returns
(Object): Returns the new object.


#### Example

```autohotkey
object := {"a": 1, "b": "2", "c": 3}A.pick(object, ["a", "c"])
; => {"a": 1, "c": 3}

```



## .pickBy
Creates an object composed of the object properties predicate returns truthy for. The predicate is invoked with two arguments: (value, key).


#### Arguments
object (Object): The source object.

[predicate:=.identity] (Function): The function invoked per property.


#### Returns
(Object): Returns the new object.


#### Example

```autohotkey
object := {"a": 1, "b": "two", "c": 3}A.pickBy(object, A.isNumber)
; => {"a": 1, "c": 3}

```



## .toPairs
Creates an array of own enumerable string keyed-value pairs for object which can be consumed by A.fromPairs.


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




# **String methods**
## .camelCase
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
Checks if string ends with the given target string.


#### Arguments
string (string): The string to inspect.

[target] (string): The string to search for.

[position:=StrLen()] (number): The position to search up to.


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
Converts the characters "&", "<", ">", '"', and "'" in string to their corresponding HTML entities.

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
string := "fred, barney, & pebbles"A.escape(string)
; => "fred, barney, &amp; pebbles"

```



## .kebabCase
Converts string to kebab case.


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
Converts string, as space separated words, to lower case.


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



## .pad
Pads string on the left and right sides if it's shorter than length. Padding characters are truncated if they can't be evenly divided by length.

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
Pads string on the right side if it's shorter than length. Padding characters are truncated if they exceed length.

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
Pads string on the left side if it's shorter than length. Padding characters are truncated if they exceed length.

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
Converts string to an integer.

> [!Warning]
> This method has not reached pairity with Lodash.
> missing the radix to interpret value by parameter

#### Arguments
string (string): The string to convert.

<!-- [radix:=10] (number): The radix to interpret value by. -->


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
Converts string to snake case.

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
Splits string by separator.


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
Converts string to start case.

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
Checks if string starts with the given target string.


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

StringCaseSense, OnA.startsWith("abc", "A")
; => false

```



## .toLower
Converts string, as a whole, to lower case.


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
Converts string, as a whole, to upper case


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
Removes leading and trailing whitespace or specified characters from string.


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
Removes trailing whitespace or specified characters from string.


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
Removes leading whitespace or specified characters from string.


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
Truncates string if it's longer than the given maximum string length. The last characters of the truncated string are replaced with the omission string which defaults to "...".


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
string := "hi-diddly-ho there, neighborino"A.truncate(string)
; => "hi-diddly-ho there, neighbor..."

A.truncate(string, {"length": 24, "separator": " "})
; => "hi-diddly-ho there,..."

A.truncate(string, {"length": 24, "separator": "/, /"})
; => "hi-diddly-ho there..."

```



## .unescape
The inverse of [A.escape](#escape) this method converts the HTML entities &amp;, &lt;, &gt;, &quot;, and &#39; in string to their corresponding characters.

> [!Note]
> No other HTML entities are unescaped. To unescape additional HTML entities use a dedicated third-party library.

#### Arguments
[string:=""] (string): The string to unescape.


#### Returns
(string): Returns the unescaped string.


#### Example

```autohotkey
string := "fred, barney, &amp; pebbles"A.unescape(string)
; => "fred, barney, & pebbles"

```



## .upperCase
Converts string, as space separated words, to upper case.


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



## .words
Splits string into an array of its words.


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
## .constant
Creates a function that returns value.


#### Arguments
value (*): The value to return from the new function.


#### Returns
(Function): Returns the new constant function.


#### Example

```autohotkey
object := A.times(2, A.constant({"a": 1})); => [{"a": 1}, {"a": 1}]```



## .identity
This method returns the first argument it receives.

#### Arguments
value (*): Any value.


#### Returns
(*): Returns value.

#### Example

```autohotkey
object := {"a": 1}A.identity(object)
; => {"a": 1}

```



## .matches
Creates a function that performs a shallow comparison between a given object and source, returning true if the given object has equivalent property values, else false.


#### Arguments
source (Object): The object of property values to match.


#### Returns
(Function): Returns the new spec function.


#### Example

```autohotkey
objects := [{ "a": 1, "b": 2, "c": 3 }, { "a": 4, "b": 5, "c": 6 }]A.filter(objects, A.matches({ "a": 4, "c": 6 }))
; => [{ "a": 4, "b": 5, "c": 6 }]

functor := A.matches({ "a": 4 })A.filter(objects, functor)
; => [{ "a": 4, "b": 5, "c": 6 }]

functor.call({ "a": 1 })
; => false

```



## .matchesProperty
Creates a function that performs a partial deep comparison between the value at path of a given object to srcValue, returning true if the object value is equivalent, else false.


#### Arguments
path (Array|string): The path of the property to get.

srcValue (*): The value to match.


#### Returns
(Function): Returns the new spec function.


#### Example

```autohotkey
objects := [{ "a": 1, "b": 2, "c": 3 }, { "a": 4, "b": 5, "c": 6 }]A.find(objects, A.matchesProperty("a", 4))
; => { "a": 4, "b": 5, "c": 6 }

A.filter(objects, A.matchesProperty("a", 4))
; => [{ "a": 4, "b": 5, "c": 6 }]

objects := [{ "a": {"b": 2} }, { "a": {"b": 1} }]A.find(objects, A.matchesProperty(["a", "b"], 1))
; => { "a": {"b": 1} }

```



## .print
Prints the specified `value` to terminal or other standard output device. Can be a string, or any other object to be converted into a string before written.


#### Arguments
values* (*): The values to print.


#### Returns
(string): Returns values in one string; stringifying any objects.


#### Example

```autohotkey
A.print([1, 2, 3])
; => "1:1, 2:2, 3:3"

```



## .property
Creates a function that returns the value at path of a given object.


#### Arguments
path (Array|string): The path of the property to get.


#### Returns
(Function): Returns the new accessor function.


#### Example

```autohotkey
objects := [{ "a": {"b": 2} }, { "a": {"b": 1} }]A.map(objects, A.property("a.b"))
; => ["2", "1"]

objects := [{"name": "fred"}, {"name": "barney"}]A.map(objects, A.property("name"))
; => ["fred", "barney"]

```



## .stubArray
This method returns a new empty array.


#### Returns
(Array): Returns the new empty array.


#### Example

```autohotkey
A.times(2, A.stubArray)
; => [[], []]

```



## .stubFalse
This method returns `false`.


#### Returns
(boolean): Returns `false`.


#### Example

```autohotkey
A.times(2, A.stubFalse)
; => [false, false]

```



## .stubObject
This method returns a new empty object.


#### Returns
(Object): Returns the new empty object.


#### Example

```autohotkey
A.times(2, A.stubObject)
; => [ {}, {} ]

```



## .stubString
This method returns an empty string.


#### Returns
(string): Returns the empty string.


#### Example

```autohotkey
A.times(2, A.stubString)
; => ["", ""]

```



## .stubTrue
This method returns `true`.


#### Returns
(boolean): Returns `true`.


#### Example

```autohotkey
A.times(2, A.stubTrue)
; => [true, true]

```



## .times
Invokes the iteratee `n` times, returning an array of the results of each invocation. The iteratee is invoked with one argument; (index).


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



