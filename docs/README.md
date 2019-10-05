
# **Array**
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




## .difference
Creates an array of array values not included in the other given arrays using SameValueZero for equality comparisons. The order and references of result values are determined by the first array.

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




## .findIndex
This method is like A.find except that it returns the index of the first element predicate returns truthy for instead of the element itself.


#### Arguments

array (Array): The array to inspect.
[predicate:=A.identity] (Function): The function invoked per iteration.
[fromIndex:=0] (number): The index to search from.


#### Returns

(number): Returns the index of the found element, else -1.


#### Example

```autohotkey
A.findIndex([1, 2, 1, 2], 2)
; => 2

; Search from the `fromIndex`.A.findIndex([1, 2, 1, 2], 2, 3)
; => 4

A.findIndex(["fred", "barney"], "pebbles")
; => -1

A.caseSensitive := trueA.findIndex(["fred", "barney"], "Fred")
; => -1

A.findIndex([{name: "fred"}, {name: "barney"}], {name: "barney"})
; => 2

users := [ { "user": "barney", "age": 36, "active": true }    , { "user": "fred", "age": 40, "active": false }    , { "user": "pebbles", "age": 1, "active": true } ]A.findIndex(users, Func("findIndexFunc"))
; => 1

findIndexFunc(o) {    return % o.user == "barney"}```




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

<!-- Aliases
_.first -->

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
Gets the index at which the first occurrence of value is found in array using SameValueZero for equality comparisons. If fromIndex is negative, it's used as the offset from the end of array.


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

A.caseSensitive := trueA.indexOf(["fred", "barney"], "Fred")
; => -1

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




## .lastIndexOf
This method is like .indexOf except that it iterates over elements of array from right to left.


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

A.caseSensitive := trueA.lastIndexOf(["fred", "barney"], "Fred")
; => -1

```




## .reverse
Reverses array so that the first element becomes the last, the second element becomes the second to last, and so on.


#### Arguments

array (Array): The array to modify.

#### Returns

(Array): Returns array.

#### Example

```autohotkey
A.reverse(["a","b","c"])
; => ["c","b","a"]

A.reverse([{"foo":"bar"},"b","c"])
; => ["c","b",{"foo":"bar"}]

A.reverse([[1,2,3],"b","c"])
; => ["c","b",[1,2,3]]

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
> This method has not reached pairity with Lodash. Output will not match Lodash output in the event the length of all supplied arrays are not the same.

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
This method is like A.fromPairs except that it accepts two arrays, one of property identifiers and one of corresponding values.

Since
0.4.0

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





# **Collection**
## .filter
Iterates over elements of collection, returning an array of all elements predicate returns truthy for. The predicate is invoked with three arguments: (value, index|key, collection).

> [!Warning]
> This method has not reached pairity with Lodash.

#### Arguments

collection (Array|Object): The collection to iterate over.

function (Function): The function invoked per iteration.

#### Returns

(Array): Returns the new filtered array.


#### Example

```autohotkey
users := [{"user":"barney", "age":36, "active":true}, {"user":"fred", "age":40, "active":false}]A.filter(users,"active")
; => [{"user":"barney", "age":36, "active":true}]

A.filter(users,Func("fn_filter1"))
; => [{"user":"barney", "age":36, "active":true}]

fn_filter1(param_interatee) {    if (param_interatee.active) {         return true     }}```




## .find
Iterates over elements of collection, returning the first element predicate returns truthy for.

> [!Warning]
> This method has not reached pairity with Lodash. A.matches shorthand is not working

#### Arguments

collection (Array|Object): The collection to inspect.

function (Function): The function invoked per iteration.

[fromIndex:=1] (number): The index to search from.

#### Returns

(*): Returns the matched element, else undefined.


#### Example

```autohotkey
users := [ { "user": "barney", "age": 36, "active": true }    , { "user": "fred", "age": 40, "active": false }    , { "user": "pebbles", "age": 1, "active": true } ]A.find(users, "active")
; => { "user": "barney", "age": 36, "active": true }

A.find(users, "active", 2)
; => { "user": "pebbles", "age": 1, "active": true }

A.find(users, Func("fn_find1"))
; => { "user": "barney", "age": 36, "active": true }

fn_find1(param_interatee) {    if (param_interatee.active) {         return true     } } ```




## .forEach
Iterates over elements of collection and invokes iteratee for each element. The iteratee is invoked with three arguments: (value, index|key, collection). Iteratee functions may exit iteration early by explicitly returning false.


<!-- Aliases
_.each -->


#### Arguments

collection (Array|Object): The collection to iterate over.
[iteratee=_.identity] (Function): The function invoked per iteration.


#### Returns

(*): Returns collection.


#### Example 

```autohotkey
A.forEach([1, 2], Func("forEachFunc1")
forEachFunc1(value) {
    msgbox, % value
}
; msgboxes `1` then `2`

A.forEach({ "a": 1, "b": 2 }, Func("forEachFunc2")
forEachFunc2(value, key) {
    msgbox, % key
}
msgboxes "a" then "b"
```





## .includes
Checks if value is in collection. If collection is a string, it's checked for a substring of value, otherwise SameValueZero is used for equality comparisons.


#### Arguments

collection (Array|Object|string): The collection to inspect.

value (*): The value to search for.

[fromIndex=1] (number): The index to search from.

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

A.caseSensitive := trueA.includes("InStr", "str")
; => false

; RegEx objectA.includes("hello!", "/\D/")
; => true

```




## .map
Creates an array of values by running each element in collection thru iteratee.

#### Arguments

collection (Array|Object): The collection to iterate over.

iteratee:=A.identity (Function): The function invoked per iteration.

#### Returns

(Array): Returns the new mapped array.

#### Example

```autohotkey
square(n) {  return % n * n}A.map([4, 8], Func("square"))
; => [16, 64]

A.map({ "a": 4, "b": 8 }, Func("square"))
; => [16, 64]

A.map({ "a": 4, "b": 8 })
; => [4, 8]

users := [{ "user": "barney" }, { "user": "fred" }]A.map(users, "user")
; => ["barney", "fred"]

```




## .sample
Gets a single random element from collection.

#### Arguments

collection (Array|Object): The collection to sample.


#### Returns

(*): Returns the random element.

#### Example

```autohotkey
A.sample([1, 2, 3, 4])
; => 2
```





## .samplesize
Gets `n` random elements at unique keys from collection up to the size of collection.


#### Arguments

collection (Array|Object): The collection to sample.

[n=1] (number): The number of elements to sample.

#### Returns

(Array): Returns the random elements.

#### Example

```autohotkey
output := A.sampleSize([1, 2, 3], 2)
; => [3, 1]

output := A.sampleSize([1, 2, 3], 4)
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




## .sortBy
Creates an array of elements, sorted in ascending order by the results of running each element in a collection thru each iteratee. This method performs a stable sort, that is, it preserves the original sort order of equal elements. The iteratees are invoked with one argument: (value).


#### Arguments

collection (Array|Object): The collection to iterate over.

[iteratees:=[A.identity]] (...(Function|Function[])): The iteratees to sort by.

#### Returns

(Array): Returns the new sorted array.


#### Example

```autohotkey
users := [  , { "name": "fred",   "age": 40 }  , { "name": "barney", "age": 34 }  , { "name": "bernard", "age": 36 }  , { "name": "zeddy", "age": 40 }]A.sortBy(users, ["age", "name"])
; => [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zeddy"}]

A.sortBy(users, "age")
; => [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zeddy"}]

```





# **Lang**
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
This method is like A.clone except that it recursively clones value.


#### Arguments

value (*): The value to recursively clone.


#### Returns

(*): Returns the deep cloned value.


#### Example

```autohotkey
object := [{ "a": [[1, 2, 3]] }, { "b": 2 }]deepclone := A.cloneDeep(object)object[1].a := 2; object; => [{ "a": 2 }, { "b": 2 }]; deepclone; => [{ "a": [[1, 2, 3]] }, { "b": 2 }]```




## .isEqual
Performs a deep comparison between two values to determine if they are equivalent.

This method supports comparing strings and objects.


#### Arguments

value (*): The value to compare.

other (*): The other value to compare.

#### Returns

(boolean): Returns true if the values are equivalent, else false.

#### Example

```autohotkey
A.isEqual(1, 1)
; => true

A.isEqual({ "a": 1 }, { "a": 1 })
; => true

A.isEqual(1, 2)
; => false

A.caseSensitive := trueA.isEqual({ "a": "a" }, { "a": "A" })
; => false

```




## .ismatch
Performs a partial deep comparison between object and source to determine if object contains equivalent property values.

Partial comparisons will match empty array and empty object source values against any array or object value, respectively. See A.isEqual for a list of supported value comparisons.

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




## .isUndefined
Checks if value is undefined or blank


#### Arguments

value (*): The value to check.


#### Returns

(boolean): Returns true if value is undefined, else false.


#### Example

```autohotkey
A.isUndefined(neverIntializedVar)
; => true

A.isUndefined("")
; => true

A.isUndefined({})
; => false

A.isUndefined(" ")
; => false

```





# **Object**
## .merge
This method recursively merges own and inherited enumerable string keyed properties of source objects into the destination object. Array and plain object properties are merged recursively. Other objects and value types are overridden by assignment. Source objects are applied from left to right. Subsequent sources overwrite property assignments of previous sources.


#### Arguments

object (Object): The destination object.

[sources] (...Object): The source objects.

#### Returns

(Object): Returns object.

#### Example

```autohotkey
object := {"options":[{"option1":"true"}]}other := {"options":[{"option2":"false"}]}A.merge(object, other)
; => {"options":[{"option1":"true", "option2":"false"}]}

object := { "a": [{ "b": 2 }, { "d": 4 }] }other := { "a": [{ "c": 3 }, { "e": 5 }] }A.merge(object, other)
; => { "a": [{ "b": "2", "c": 3 }, { "d": "4", "e": 5 }] }

```




## .toPairs
Creates an array of own enumerable string keyed-value pairs for object which can be consumed by A.fromPairs.


<!-- ## Aliases
A.entries -->

#### Arguments

object (Object): The object to query.


#### Returns

(Array): Returns the key-value pairs.


#### Example

```autohotkey
A.toPairs({"a": 1, "b": 2})
; => [["a", 1], ["b", 2]]

```





# **String**
## .parseInt
Converts string to an integer.

> [!Warning]
> This method has not reached pairity with Lodash.

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

[position=0] (number): The position to search from.

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

A.caseSensitive := trueA.startsWith("abc", "A")
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

[strins:=""] (string): The string to trim.

[chars=whitespace] (string): The characters to trim.


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
; => "hi-diddly-ho there, neighbo..."

A.truncate(string, {"length": 24, "separator": " "})
; => "hi-diddly-ho there,..."

A.truncate(string, {"length": 24, "separator": "/, /"})
; => "hi-diddly-ho there..."

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




