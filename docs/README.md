# .difference
NOT IMPLEMENTED YET 2019.09.02

#### Arguments

#### Example

```autohotkey
;_; NO EXAMPLES YET ;_;
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
users := [{ "user": "barney", "age": 36, "active": true }
    , { "user": "fred", "age": 40, "active": false }
    , { "user": "pebbles", "age": 1, "active": true } ]

A.find(users,"active")
; => { "user": "barney", "age": 36, "active": true }

A.find(users,Func("fn_filter1"))
fn_filter1(para_interatee) {
    if (para_interatee.active) { 
        return true 
    }
}
; => { "user": "barney", "age": 36, "active": true }

A.find(users,"active",2)
; => { "user": "pebbles", "age": 1, "active": true }
```



*******
# .includes




*******
# .ismatch




*******
# .replace
string (string): The string to modify.

pattern (RegExp|string): The pattern to replace.

replacement (string): The match replacement.

#### Example 

```autohotkey
A.replace("Hi Fred", "Fred", "Barney")
; => "Hi Barney"

A.replace("1234", "/(\d+)/", "numbers")
; => "numbers"
```



*******
# .startCase
#### Arguments {docsify-ignore}

string (string): The string to convert.

#### Returns {docsify-ignore}
(string): Returns the start cased string.

#### Example {docsify-ignore}

```autohotkey
A.startCase("--foo-bar--")
; => "Foo Bar"
 
A.startCase("fooBar")
; => "Foo Bar"
 
A.startCase("__FOO_BAR__")
; => "FOO BAR"
```




*******
# .startsWith
Checks if string starts with the given target string.

#### Arguments {docsify-ignore}
string (string): The string to inspect.

[target] (string): The string to search for.

[position=0] (number): The position to search from.

#### Returns {docsify-ignore}
(boolean): Returns true if string starts with target, else false.

#### Example {docsify-ignore}
```autohotkey
A.startsWith("abc", "a")
; => true

A.startsWith("abc", "b")
; => false

A.startsWith("abc", "b", 2)
; => true
```



*******
