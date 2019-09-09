# .concat


#### Example

```autohotkey
array := [1]A.concat(array, 2, [3], [[4]])
; => [1, 2, 3, [4]]

A.concat(array)
; => [1]

```

*******


# .difference
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

```

*******


# .join
Converts all elements in array into a string separated by separator.


#### Arguments

array (Array): The array to convert.

[separator=','] (string): The element separator.

#### Returns

(string): Returns the joined string.

#### Example

```autohotkey
A.join(["a", "b", "c"], "~")
; => "a~b~c"

A.join(["a", "b", "c"])
; => "a,b,c"

```

*******


# .reverse
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

*******


# .uniq
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

*******


# .filter
Iterates over elements of collection, returning an array of all elements predicate returns truthy for. The predicate is invoked with three arguments: (value, index|key, collection).

#### Arguments

collection (Array|Object): The collection to iterate over.

[predicate=_.identity] (Function): The function invoked per iteration.

#### Returns

(Array): Returns the new filtered array.

#### Example

```autohotkey
users := [{"user":"barney", "age":36, "active":true}, {"user":"fred", "age":40, "active":false}]
A.filter(users,Func("fn_filter1"))
; => [{"user":"barney", "age":36, "active":true}]
fn_filter1(param_interatee) {
    if (param_interatee.active) { 
        return true 
    }
}
A.filter(users,"active")
; => [{"user":"barney", "age":36, "active":true}]
```


*******


# .find
Iterates over elements of collection, returning the first element predicate returns truthy for.

#### Arguments

collection (Array|Object): The collection to inspect.

[predicate=_.identity] (Function): The function invoked per iteration.

[fromIndex=0] (number): The index to search from.

#### Returns

(*): Returns the matched element, else undefined.


#### Example

```autohotkey
users := [ { "user": "barney", "age": 36, "active": true }    , { "user": "fred", "age": 40, "active": false }    , { "user": "pebbles", "age": 1, "active": true } ]A.find(users,"active")
; => { "user": "barney", "age": 36, "active": true }

A.find(users,"active",2)
; => { "user": "pebbles", "age": 1, "active": true }

A.find(users,Func("fn_filter1"))
; => { "user": "barney", "age": 36, "active": true }

```

*******


# .includes
Checks if value is in collection. If collection is a string, it's checked for a substring of value, otherwise SameValueZero is used for equality comparisons.


#### Arguments

collection (Array|Object|string): The collection to inspect.

value (*): The value to search for.

[fromIndex=1] (number): The index to search from.

#### Returns

(boolean): Returns true if value is found, else false.


#### Example

```autohotkey
A([1,2,3],3)
; => true

A("InStr","Str")
; => true

A("InStr","Other")
; => false

    ; RegEx objectA("hello!","/\D/")
; => true

```

*******


# .map
Creates an array of values by running each element in collection thru iteratee.

#### Arguments

collection (Array|Object): The collection to iterate over.

iteratee=_.identity (Function): The function invoked per iteration.

#### Returns

(Array): Returns the new mapped array.

#### Example

```autohotkey
square(n) {  return % n * nA.map([4,8],Func("square"))
; => [16, 64]

A.map({ "a": 4, "b": 8 },Func("square"))
; => [16, 64]

users := [{ "user": "barney" }, { "user": "fred" }]A.map(users,"user")
; => ["barney","fred"]

```

*******


# .samplesize
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


*******


# .shuffle
Creates an array of shuffled values, using a version of the [Fisher-Yates shuffle](https://en.wikipedia.org/wiki/Fisher-Yates_shuffle).

#### Arguments

collection (Array|Object): The collection to shuffle.


#### Returns

(Array): Returns the new shuffled array.


#### Example

```autohotkey
A.shuffle([1, 2, 3, 4])
; => [4, 1, 3, 2]

users := ["barney", "fred", "fred", "fred", "pebbles"]A.shuffle(users)
; => ["pebbles", "fred", "barney", "fred", "fred"]

```

*******


# .clone
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

msgbox, % A.printObj(shallowclone)
; => [{ "a": 1 }, { "b": 2 }]
```


*******


# .cloneDeep


#### Example

```autohotkey
object := [{ "a": [[1,2,3]] }, { "b": 2 }]deepclone := A.cloneDeep(object)object.a := 2assert.test(deepclone,[{ "a": [[1,2,3]] }, { "b": 2 }])```

*******


# .ismatch
Performs a partial deep comparison between object and source to determine if object contains equivalent property values.

Partial comparisons will match empty array and empty object source values against any array or object value, respectively. See _.isEqual for a list of supported value comparisons.

#### Arguments

object (Object): The object to inspect.

source (Object): The object of property values to match.

#### Returns

(boolean): Returns true if object is a match, else false.

#### Example

```autohotkey
object := { "a": 1, "b": 2, "c": 3 }A(object,{"b": 2})
; => true

A(object,{"b": 2, "c": 3})
; => true

A(object,{"b": 1})
; => false

A(object,{"b": 2, "z": 99})
; => false

```

*******


# .merge
This method recursively merges own and inherited enumerable string keyed properties of source objects into the destination object. Array and plain object properties are merged recursively. Other objects and value types are overridden by assignment. Source objects are applied from left to right. Subsequent sources overwrite property assignments of previous sources.


#### Arguments

object (Object): The destination object.

[sources] (...Object): The source objects.

#### Returns

(Object): Returns object.

#### Example

```autohotkey
object := {"options":[{"option1":"true"}]}other := {"options":[{"option2":"false"}]}A.merge(object,other)
; => {"options":[{"option1":"true","option2":"false"}]}

object := { "a": [{ "b": 2 }, { "d": 4 }] }other := { "a": [{ "c": 3 }, { "e": 5 }] }A.merge(object ,other)
; => { "a": [{ "b": "2", "c": 3 }, { "d": "4", "e": 5 }] }

```

*******


# .replace
#### Arguments

string (string): The string to modify.

pattern (RegExp|string): The pattern to replace.

replacement (string): The match replacement.

#### Returns

(string): Returns the modified string.


#### Example

```autohotkey
A.replace("Hi Fred","Fred","Barney")
; => "Hi Barney"

A.replace("1234","/(\d+)/","numbers")
; => "numbers"

```

*******


# .startCase
Converts string to start case.

#### Arguments

[string=''] (string): The string to convert.

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

*******


# .startsWith
Checks if string starts with the given target string.

#### Arguments
string (string): The string to inspect.

[target] (string): The string to search for.

[position=0] (number): The position to search from.

#### Returns
(boolean): Returns true if string starts with target, else false.


#### Example

```autohotkey
A("abc","a")
; => true

A("abc","b")
; => false

A("abc","b",2)
; => true

A.caseSensitive := trueA("abc","A")
; => false

```

*******


# .toLower
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

*******


# .toUpper
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

*******


# .trim
Removes leading and trailing whitespace or specified characters from string.

#### Arguments

[string=''] (string): The string to trim.

[chars=whitespace] (string): The characters to trim.


#### Returns

(string): Returns the trimmed string.


#### Example

```autohotkey
A.trim("  abc  ")
; => "abc"

A.trim("-_-abc-_-","_-")
; => "abc"

A.map([" foo  ", "  bar  "],A.trim)
; => ["foo", "bar"]

```

*******


# .trimEnd
Removes trailing whitespace or specified characters from string.

#### Arguments

[string=''] (string): The string to trim.

[chars=whitespace] (string): The characters to trim.


#### Returns

(string): Returns the trimmed string.


#### Example

```autohotkey
A.trimEnd("  abc  ")
; => "  abc"

A.trimEnd("-_-abc-_-","_-")
; => "-_-abc"

```

*******


# .trimStart
Removes leading whitespace or specified characters from string.

#### Arguments

[string=''] (string): The string to trim.

[chars=whitespace] (string): The characters to trim.


#### Returns

(string): Returns the trimmed string.


#### Example

```autohotkey
A.trimStart("  abc  ")
; => "abc  "

A.trimStart("-_-abc-_-","_-")
; => "abc-_-"

```

*******


# .truncate
Truncates string if it's longer than the given maximum string length. The last characters of the truncated string are replaced with the omission string which defaults to "...".



#### Arguments

[string=''] (string): The string to truncate.

[options={}] (Object): The options object.

[options.length=30] (number): The maximum string length.

[options.omission='...'] (string): The string to indicate text is omitted.

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

*******


