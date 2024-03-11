#Include %A_ScriptDir%\..\export.ahk
#Include %A_ScriptDir%\..\node_modules
#Include expect.ahk\export.ahk
#NoTrayIcon
#SingleInstance, force
SetBatchLines, -1
StringCaseSense, On

A := new biga()
assert := new expect()

; Start speed function
QPC(1)

assert.group(".chunk")
assert.label("default tests")
assert.test(A.chunk(["a", "b", "c", "d"], 2), [["a", "b"], ["c", "d"]])
assert.test(A.chunk(["a", "b", "c", "d"], 3), [["a", "b", "c"], ["d"]])

; omit
assert.test(A.chunk([], 2), [])
assert.test(A.chunk(["a", "b", "c", "d", "e"], 2), [["a", "b"], ["c", "d"], ["e"]])
assert.test(A.chunk(["a", "b", "c", "d", "e"], 1), [["a"], ["b"], ["c"], ["d"], ["e"]])
assert.test(A.chunk(["a", "b", "c", "d", "e"], 5), [["a", "b", "c", "d", "e"]])
assert.test(A.chunk(["a", "b", "c", "d", "e"], 6), [["a", "b", "c", "d", "e"]])

var := [1,2,3]
A.chunk(var, 2)
assert.label("parameter mutation")
assert.test(var, [1,2,3])

assert.group(".compact")
assert.label("default tests")
assert.test(A.compact([0, 1, false, 2, "", 3]), [1, 2, 3])


; omit
assert.test(A.compact([1, 2, 3, 4, 5, 6, "", "", ""]), [1, 2, 3, 4, 5, 6])
assert.test(A.compact([]), [])
assert.test(A.compact(["", 0, false]), [])
assert.test(A.compact(["", 0, "hello", "", 1]), ["hello", 1])
assert.test(A.compact([false, 0, ""]), [])

assert.group(".concat")
assert.label("default tests")
array := [1]
assert.test(A.concat(array, 2, [3], [[4]]), [1, 2, 3, [4]])
assert.test(A.concat(array), [1])

; omit
assert.test(A.concat(array, 1), [1, 1])
assert.label("associative object")
assert.test(A.concat([], {"a": "abc", "b": "bcd"}), ["abc", "bcd"])
assert.test(A.concat([1, 2], [3, 4]), [1, 2, 3, 4])
assert.test(A.concat([], []), [])
assert.test(A.concat([], [1, 2], [3], [[4]]), [1, 2, 3, [4]])
assert.test(A.concat(["a", "b"], ["c", "d"]), ["a", "b", "c", "d"])
assert.test(A.concat(["a"], []), ["a"])
; the correct way to concat associative objects AND retain their keys is A.merge as confirmed with lodash tests

assert.group(".depthOf")
assert.label("default tests")
assert.test(A.depthOf([1]), 1)
assert.test(A.depthOf([1, [2]]), 2)
assert.test(A.depthOf([1, [[2]]]), 3)
assert.test(A.depthOf([1, [2, [3, [4]], 5]]), 4)

; omit
assert.test(A.depthOf({"key": 1}), 1)
assert.test(A.depthOf([]), 1)
assert.test(A.depthOf([1, 2, 3]), 1)
assert.test(A.depthOf([[1, 2], [3, 4]]), 2)
assert.test(A.depthOf([[[1]], [[2]], [[3]]]), 3)
assert.test(A.depthOf([1, [2, [3, [4]]]]), 4)

assert.group(".difference")
assert.label("default tests")
assert.test(A.difference([2, 1], [2, 3]), [1])


; omit
assert.test(A.difference([2, 1], [3]), [2, 1])
assert.test(A.difference(["Barney", "Fred"], ["Fred"]), ["Barney"])
assert.test(A.difference(["Barney", "Fred"], []), ["Barney", "Fred"])
assert.test(A.difference(["Barney", "Fred"], ["Pebbles"], ["Fred"]), ["Barney"])

assert.test(A.difference([], [1, 2, 3]), [])
assert.test(A.difference([1, 2, 3], []), [1, 2, 3])
assert.test(A.difference([1, 2, 3], [1, 2, 3]), [])
assert.test(A.difference([1, 2, 3], [4, 5, 6]), [1, 2, 3])
assert.test(A.difference([1, 2, 3], [2, 3]), [1])

assert.test(A.difference([50, 50, 90], [50, 80]), [90], "remove repeat values")

assert.group(".drop")
assert.label("default tests")
assert.test(A.drop([1, 2, 3]), [2, 3])
assert.test(A.drop([1, 2, 3], 2), [3])
assert.test(A.drop([1, 2, 3], 5), [])
assert.test(A.drop([1, 2, 3], 0), [1, 2, 3])
assert.test(A.drop("fred"), ["r", "e", "d"])
assert.test(A.drop(100), ["0", "0"])


; omit
assert.test(A.drop([]), [])
assert.test(A.drop([1, 2, 3], 3), [])
assert.test(A.drop(["a", "b", "c", "d"], 2), ["c", "d"], "non-numeric values")
; lodash .drop does not work with associative arrays

assert.group(".dropRight")
assert.label("default tests")
assert.test(A.dropRight([1, 2, 3]), [1, 2])
assert.test(A.dropRight([1, 2, 3], 2), [1])
assert.test(A.dropRight([1, 2, 3], 5), [])
assert.test(A.dropRight([1, 2, 3], 0), [1, 2, 3])
assert.test(A.dropRight("fred"), ["f", "r", "e"])
assert.test(A.dropRight(100), ["1", "0"])

; omit
assert.test(A.dropRight([]), [])
assert.test(A.dropRight([1, 2, 3], 3), [])
assert.test(A.dropRight([1, 2, 3], 4), [], "param_n larger than the provided array param")
assert.test(A.dropRight(["a", "b", "c", "d"], 2), ["a", "b"])
assert.group(".dropRightWhile")
assert.label("default tests")
users := [ {"user": "barney", 	"active": true}
		, {"user": "fred",		"active": false}
		, {"user": "pebbles", 	"active": false} ]
assert.test(A.dropRightWhile(users, func("fn_dropRightWhile")), [{"user": "barney", "active": true }])
fn_dropRightWhile(o)
{
	return !o.active
}

; The A.matches iteratee shorthand.
assert.label("A.matches iteratee shorthand")
assert.test(A.dropRightWhile(users, {"user": "pebbles", "active": false}), [ {"user": "barney", "active": true }, {"user": "fred", "active": false} ])

; The A.matchesProperty iteratee shorthand.
assert.label("A.matchesProperty iteratee shorthand")
assert.test(A.dropRightWhile(users, ["active", false]), [ {"user": "barney", "active": true } ])

; The A.property iteratee shorthand.
assert.label("A.property iteratee shorthand")
assert.test(A.dropRightWhile(users, "active"), [ {"user": "barney", "active": true }, {"user": "fred", "active": false }, {"user": "pebbles", "active": false} ])


; omit
assert.label("empty array")
assert.test(A.dropRightWhile([]), [])

assert.label("A.property iteratee no drops")
assert.test(A.dropRightWhile([{"user": "barney", "active": false}, {"user": "fred", "active": false}], "active"), [{"user": "barney", "active": false }, {"user": "fred", "active": false}])

assert.label("A.property iteratee all dropped")
assert.test(A.dropRightWhile([{"user": "barney", "active": false}, {"user": "fred", "active": false}], "active"), [{"user": "barney", "active": false }, {"user": "fred", "active": false}])

assert.label("check that input has not been mutated")
assert.test(users[3], {"user": "pebbles",	"active": false})

assert.label("default .identity argument")
assert.test(A.dropRightWhile(["foo", 0, "bar"]), ["foo", 0])

assert.label("undefined array")
assert.test(A.dropRightWhile([]), [])

assert.label("undefined elements")
assert.test(A.dropRightWhile(["", "", ""]), ["", "", ""])

assert.group(".dropWhile")
assert.label("default tests")
users := [ {"user": "barney", 	"active": false }
		, { "user": "fred", 	"active": false }
		, { "user": "pebbles", 	"active": true } ]
assert.test(A.dropWhile(users, func("fn_dropWhile")), [{ "user": "pebbles", "active": true }])
fn_dropWhile(o)
{
	return !o.active
}

; The A.matches iteratee shorthand.
assert.test(A.dropWhile(users, {"user": "barney", "active": false}), [ { "user": "fred", "active": false }, { "user": "pebbles", "active": true } ])

; The A.matchesProperty iteratee shorthand.
assert.test(A.dropWhile(users, ["active", false]), [ {"user": "pebbles", "active": true } ])

; The A.property iteratee shorthand.
assert.test(A.dropWhile(users, "active"), [ {"user": "barney", "active": false }, { "user": "fred", "active": false }, { "user": "pebbles", "active": true } ])


; omit
assert.label("keep all dropped")
assert.test(A.dropWhile([{"user": "barney", "active": true}], Func("fn_dropWhile")), [{"user": "barney", "active": true}])

assert.label("all dropped")
assert.test(A.dropWhile([{"user": "barney", "active": false}, {"user": "fred", "active": false}], Func("fn_dropWhile")), [])

assert.label("empty array input")
assert.test(A.dropWhile([]), [])

assert.label("default .identity argument")
assert.test(A.dropWhile(["foo", 0, "bar"]), [0, "bar"])

assert.label("undefined elements")
assert.test(A.dropWhile(["", "", ""]), ["", "", ""])

assert.group(".fill")
assert.label("default tests")
array := [1, 2, 3]
assert.test(A.fill(array, "a"), ["a", "a", "a"])
assert.test(A.fill([4, 6, 8, 10], "*", 2, 3), [4, "*", "*", 10])


; omit
assert.test(A.fill([]), [])
assert.test(A.fill([1, 2, 3], "a"), ["a", "a", "a"])
assert.test(A.fill([4, 6, 8, 10], "*", 1, 3), ["*", "*", "*", 10])
assert.test(A.fill([4, 6, 8, 10], "*", 0, 3), ["*", "*", "*", 10], "if zero index is specified")
assert.test(A.fill([4, 6, 8, 10], "*", 3, 1), [4, 6, 8, 10], "param_start is geater than param_end")

assert.label("ensure that mutation did not occur")
assert.test(array, [1, 2, 3])

assert.group(".findIndex")
assert.label("default tests")
users := [ { "user": "barney", "age": 36, "active": true }
	, { "user": "fred", "age": 40, "active": false }
	, { "user": "pebbles", "age": 1, "active": true } ]

; The A.matches iteratee shorthand.
assert.test(A.findIndex(users, { "age": 1, "active": true }), 3)

; The A.matchesProperty iteratee shorthand.
assert.test(A.findIndex(users, ["active", false]), 2)

; The A.property iteratee shorthand.
assert.test(A.findIndex(users, "active"), 1)


; omit
assert.label("find object")
assert.test(A.findIndex(users, { "user": "pebbles", "age": 1, "active": true }), 3)

keyedUsers := { "key1": { "user": "barney", "age": 36, "active": true }
	, "key2": { "user": "fred", "age": 40, "active": false }
	, "key3": { "user": "pebbles", "age": 1, "active": true } }
assert.test(A.findIndex(keyedUsers, { "user": "pebbles", "age": 1, "active": true }), "key3")

StringCaseSense, On
assert.label("case sensitive")
assert.test(A.findIndex(["fred", "barney"], "Fred"), -1)
assert.test(A.findIndex([{"name": "fred"}, {"name": "barney"}], {"name": "barney"}), 2)
StringCaseSense, Off

assert.label("function")
assert.test(A.findIndex(users, func("fn_findIndexFunc")), 2)
fn_findIndexFunc(o) {
	return o.user == "fred"
}

assert.label("fromIndex")
users := [{"user": "barney", "active": true}
	, {"user": "fred", "active": false}
	, {"user": "pebbles", "active": false}]
assert.test(A.findIndex(users, ["active", false], 3), 3)

assert.label("boundFunc")
employees := [{"name": "Mike Smith", "tenureYears": 4}, {"name": "Nath Samuel", "tenureYears": 2}]
boundFunc := func("fn_checkNameTenure").bind("Mike Smith", 4)
assert.test(A.findIndex(employees, boundFunc), 1)

fn_checkNameTenure(name, minTenure, obj)
{
	if (obj.tenureYears >= minTenure) {
		return true
	}
}

assert.label("default .identity argument")
assert.test(A.findIndex(["foo", 0, "bar"]), 1)

assert.group(".findLastIndex")
assert.label("default tests")
users := [{"user": "barney", "active": true}
		, {"user": "fred", "active": false}
		, {"user": "pebbles", "active": false}]

assert.test(A.findLastIndex(users, {"user": "barney", "active": true}), 1)
assert.test(A.findLastIndex(users, ["active", true]), 1)
assert.test(A.findLastIndex(users, "active"), 1)


; omit
assert.label("default .identity argument")
assert.test(A.findLastIndex(["foo", 0, "bar"]), 3)

assert.group(".flatten")
assert.label("default tests")
assert.test(A.flatten([1, [2, [3, [4]], 5]]), [1, 2, [3, [4]], 5])
assert.test(A.flatten([[1, 2, 3], [4, 5, 6]]), [1, 2, 3, 4, 5, 6])

; omit
assert.test(A.flatten([]), [], "Flatten an empty array")
assert.test(A.flatten([[], [], []]), [], "Flatten an array with nested empty arrays")
assert.test(A.flatten([1, ["", ""], [3, 4]]), [1, "", "", 3, 4], "Flatten an array with undefined elements")

assert.group(".flattenDeep")
assert.label("default tests")
assert.test(A.flattenDeep([1]), [1])
assert.test(A.flattenDeep([1, [2]]), [1, 2])
assert.test(A.flattenDeep([1, [2, [3, [4]], 5]]), [1, 2, 3, 4, 5])

; omit
assert.test(A.flattenDeep({"key": 1}), [1])
assert.label("multiple levels of nesting")
assert.test(A.flattenDeep([1, [2, [3, [4, [5]]]]]), [1, 2, 3, 4, 5])
assert.label("deeply nested arrays and mixed data types")
assert.test(A.flattenDeep([1, [2, [3, [4, ["five", [6]]]]]]), [1, 2, 3, 4, "five", 6])
assert.label("deeply nested arrays and empty arrays")
assert.test(A.flattenDeep([1, [2, [3, [4, [], [5, []]]]]]), [1, 2, 3, 4, 5])
assert.label("deeply nested arrays and null/undefined elements")
assert.test(A.flattenDeep([1, [2, [3, [4, ["", ""], [5, [""]]]]]]), [1, 2, 3, 4, "", "", 5, ""])
assert.label("deeply nested arrays and arrays containing only non-array elements")
assert.test(A.flattenDeep([1, [2, [3, [4, [5], [6]], [7, 8, 9]]]]), [1, 2, 3, 4, 5, 6, 7, 8, 9])
assert.test(A.flattenDeep([]), [], "an empty array")

assert.group(".flattenDepth")
assert.label("default tests")
assert.test(A.flattenDepth([1, [2, [3, [4]], 5]], 1), [1, 2, [3, [4]], 5])
assert.test(A.flattenDepth([1, [2, [3, [4]], 5]], 2), [1, 2, 3, [4], 5])

; omit
assert.test(A.flattenDepth([], 1), [], "empty array with depth 1")
assert.test(A.flattenDepth([1, [2, [3]]], 0), [1, [2, [3]]], "with depth 0")

assert.group(".fromPairs")
assert.label("default tests")
assert.test(A.fromPairs([["a", 1], ["b", 2]]), {"a": 1, "b": 2})

; omit
assert.label("Empty array")
assert.test(A.fromPairs([], {}), {})

assert.label("Single pair")
assert.test(A.fromPairs([["a", 1]], {"a": 1}), {"a": 1})

assert.label("Multiple pairs with unique keys")
assert.test(A.fromPairs([["a", 1], ["b", 2], ["c", 3]]), {"a": 1, "b": 2, "c": 3})

assert.label("Multiple pairs with duplicate keys")
assert.test(A.fromPairs([["a", 1], ["b", 2], ["a", 3]]), {"a": 3, "b": 2})

assert.label("With keys of different types (string, number, boolean)")
assert.test(A.fromPairs([["a", 1], [2, "two"], [true, false]]), {"1": false, "a": 1, "2": "two"})

assert.label("With empty strings as keys")
assert.test(A.fromPairs([["", 1], ["b", 2]]), {"": 1, "b": 2})

assert.label("With empty values")
assert.test(A.fromPairs([["a", ""], ["b", ""], ["c", ""]]), {"a": "", "b": "", "c": ""})

assert.label("With keys containing special characters")
assert.test(A.fromPairs([["$key", 1], ["key_2", 2], ["key-3", 3]]), {"$key": 1, "key_2": 2, "key-3": 3})

assert.group(".head")
assert.label("default tests")
assert.test(A.head([1, 2, 3]), 1)
assert.test(A.head([]), "")
assert.test(A.head("fred"), "f")
assert.test(A.head(100), "1")


; omit
assert.test(A.head({"a": 1, "b": 2, "c":3}), 1)

assert.label("alias")
assert.test(A.first([1, 2, 3]), 1)

assert.label("Empty array")
assert.test(A.first([]), "")

assert.label("String as input")
assert.test(A.first("fred"), "f")

assert.label("Number as input")
assert.test(A.first(100), "1")

assert.group(".indexOf")
assert.label("default tests")
assert.test(A.indexOf([1, 2, 1, 2], 2), 2)

; Search from the `fromIndex`.
assert.test(A.indexOf([1, 2, 1, 2], 2, 3), 4)

assert.test(A.indexOf(["fred", "barney"], "pebbles"), -1)

StringCaseSense, On
assert.test(A.indexOf(["fred", "barney"], "Fred"), -1)


; omit
StringCaseSense, Off

assert.label("array of empty object")
assert.test(A.indexOf([{}], {}), 1)

assert.group(".initial")
assert.label("default tests")
assert.test(A.initial([1, 2, 3]), [1, 2])
assert.test(A.initial("fred"), ["f", "r", "e"])
assert.test(A.initial(100), ["1", "0"])


; omit
assert.test(A.initial([]), [])
assert.test(A.initial([1]), [])

assert.group(".intersection")
assert.label("default tests")
assert.test(A.intersection([2, 1], [2, 3]), [2])


; omit
assert.label("many arrays")
assert.test(A.intersection([2, 1], [2, 3], [1, 2], [2]), [2])
assert.label("no intersecting values")
assert.test(A.intersection([1,2,3], [0], [1,2,3]), [])
assert.label("keyed object")
intersectionVar := {"a": 1, "b": 2}
assert.test(A.intersection([1,2,3], intersectionVar), [1,2])

assert.test(A.intersection([], [1, 2, 3]), [], "one empty array input")
assert.test(A.intersection([1, 2, 3], []), [], "one empty array input")
assert.test(A.intersection([1, 2, 2, 3], [2, 3, 3, 4]), [2, 3], "duplicate interestions")
assert.test(A.intersection(["a", "b", "c"], ["b", "c", "d"]), ["b", "c"], "non-numeric input")

assert.label("no mutation of input")
intersectionVar := [1,2,3]
assert.test(A.intersection(intersectionVar, [1]), [1])
assert.test(intersectionVar, [1,2,3])

assert.group(".join")
assert.label("default tests")
assert.test(A.join(["a", "b", "c"], "~"), "a~b~c")
assert.test(A.join(["a", "b", "c"]), "a,b,c")


; omit
assert.test(A.join({"first": 1, "second": 2, "third": 3}), "1,2,3")
assert.test(A.join({"first": 1, "second": 2, "third": 3}, "~"), "1~2~3")

assert.label("Join an array of strings with a specified delimiter")
assert.test(A.join(["a", "b", "c"], "~"), "a~b~c")

assert.label("Join an array of strings with the default delimiter (comma)")
assert.test(A.join(["a", "b", "c"]), "a,b,c")

assert.label("Join an array of integers with a specified delimiter")
assert.test(A.join([1, 2, 3], "~"), "1~2~3")

assert.label("Join an array of mixed types with a specified delimiter")
assert.test(A.join(["a", 1, true], "~"), "a~1~1")

assert.label("Join an array with empty strings with a specified delimiter")
assert.test(A.join(["", "b", "", "d"], "~"), "~b~~d")

assert.label("Join an empty array should return an empty string")
assert.test(A.join([]), "")

assert.label("Join an array with a single element should return the element itself")
assert.test(A.join(["hello"]), "hello")

assert.label("Join an array with non-string elements should convert them to strings")
assert.test(A.join([1, true, "", non_existant_var]), "1,1,,")

assert.group(".last")
assert.label("default tests")
assert.test(A.last([1, 2, 3]), 3)
assert.test(A.last([]), "")
assert.test(A.last("fred"), "d")
assert.test(A.last(100), "0")


; omit
assert.label("no mutations")
array := [1, 2, "hey"]
assert.test(A.last(array), "hey")
assert.test(array.count(), 3)

assert.label("Array with last element as array")
assert.test(A.last([1, 2, [3, 4]]), [3, 4])

assert.label("Array with last element as associative array")
assert.test(A.last([1, {"a": 1, "b": 2}]), {"a": 1, "b": 2})

assert.label("Array with last element as empty associative array")
assert.test(A.last([1, {}]), {})

assert.label("String with last character as whitespace")
assert.test(A.last("Hello "), " ")

assert.label("String with last character as special character")
assert.test(A.last("Hello!"), "!")

assert.label("String with last character as number")
assert.test(A.last("12345"), "5")

assert.label("String with last character as special symbol")
assert.test(A.last("Hello$"), "$")

assert.label("Number with multiple digits")
assert.test(A.last(12345), "5")

assert.group(".lastIndexOf")
assert.label("default tests")
assert.label("Array with multiple occurrences of the search element")
assert.test(A.lastIndexOf([1, 2, 1, 2], 2), 4)

; Search from the `fromIndex`.
assert.label("Search from the specified index")
assert.test(A.lastIndexOf([1, 2, 1, 2], 1, 2), 1)

StringCaseSense, On
assert.label("Case-sensitive search with no match")
assert.test(A.lastIndexOf(["fred", "barney"], "Fred"), -1)


; omit
StringCaseSense, Off

assert.group(".nth")
assert.label("default tests")
assert.label("Array with positive index")
assert.test(A.nth([1, 2, 3]), 1)
assert.label("Array with negative index")
assert.test(A.nth([1, 2, 3], -3), 1)
assert.label("Array with index out of range")
assert.test(A.nth([1, 2, 3], 5), "")
assert.label("String as input")
assert.test(A.nth("fred"), "f")
assert.label("Number as input")
assert.test(A.nth(100), "1")
assert.label("Array with index 0")
assert.test(A.nth([1, 2, 3], 0), 1)


; omit
assert.label("empty array input")
assert.test(A.nth([]), "")

assert.group(".reverse")
assert.label("default tests")
assert.label("Array with strings")
assert.test(A.reverse(["a", "b", "c"]), ["c", "b", "a"])
assert.label("Array with mixed types including objects")
assert.test(A.reverse([{"foo": "bar"}, "b", "c"]), ["c", "b", {"foo": "bar"}])
assert.label("Array with nested arrays")
assert.test(A.reverse([[1, 2, 3], "b", "c"]), ["c", "b", [1, 2, 3]])

; omit
assert.label("Ensure no mutation")
reverseVar := [1,2,3]
assert.test(A.reverse(reverseVar), [3, 2, 1])
assert.test(reverseVar, [1,2,3])

assert.label("Empty array")
assert.test(A.reverse([]), [])

assert.label("Array with a single element")
assert.test(A.reverse(["a"]), ["a"])

assert.label("Array with multiple elements")
assert.test(A.reverse(["a", "b", "c"]), ["c", "b", "a"])

assert.label("Array with nested arrays")
assert.test(A.reverse([[1, 2], [3, 4], [5, 6]]), [[5, 6], [3, 4], [1, 2]])

assert.label("Array with mixed types")
assert.test(A.reverse(["a", 1, true]), [true, 1, "a"])

assert.group(".slice")
assert.label("default tests")
assert.test(A.slice([1, 2, 3], 1, 2), [1, 2])
assert.test(A.slice([1, 2, 3], 1), [1, 2, 3])
assert.test(A.slice([1, 2, 3], 5), [])
assert.test(A.slice("fred"), ["f", "r", "e", "d"])
assert.test(A.slice(100), ["1", "0", "0"])


; omit
assert.label("Array with negative start index")
assert.test(A.slice([1, 2, 3], -2), [2, 3])
assert.test(A.slice([1, 2, 3], -5), [1, 2, 3])

assert.label("Array with negative end index")
assert.test(A.slice([1, 2, 3], 0, -1), [1, 2])

assert.label("Array with negative start and end indices")
assert.test(A.slice([1, 2, 3], -2, -1), [2])

assert.label("Array with start index greater than end index")
assert.test(A.slice([1, 2, 3], 2, 1), [])
assert.test(A.slice([1, 2, 3], 100, 1), [])

assert.label("undefined elements")
assert.test(A.slice([1, 2, "", 4], 1, 4), [1, 2, "", 4])

assert.label("empty array")
assert.test(A.slice([], 1, 4), [])

assert.label("partial string")
assert.test(A.slice("hello", 1, 2), ["h", "e"])

assert.group(".sortedIndex")
assert.label("default tests")
assert.label("Insert value into sorted array at the beginning")
assert.test(A.sortedIndex([30, 50], 40),2)
assert.label("Insert value into sorted array at the middle")
assert.test(A.sortedIndex([30, 50], 20),1)
assert.label("Insert value into sorted array at the end")
assert.test(A.sortedIndex([30, 50], 99),3)

; omit

assert.group(".sortedUniq")
assert.label("default tests")
assert.test(A.sortedUniq([1, 1, 2]), [1, 2])


; omit
StringCaseSense, On
assert.test(A.sortedUniq(["Fred", "Barney", "barney", "barney"]), ["Fred", "Barney", "barney"])
StringCaseSense, off

assert.label("Array with multiple duplicates")
arr := [1, 2, 3, 3, 4, 4, 5, 6, 7, 7, 7, 8, 8, 9, 10]
arr2 := A.sortedUniq(arr)
assert.test(arr.count(), 15)
assert.test(arr2.count(), 10)

assert.test(A.sortedUniq([4, 1, 2, 3]), [4, 1, 2, 3])

assert.label("Array with no duplicates")
assert.test(A.sortedUniq([1, 2, 3]), [1, 2, 3])

assert.label("Array with string types and duplicates")
assert.test(A.sortedUniq(["apple", "banana", "banana", "orange", "orange", "orange", "peach"]), ["apple", "banana", "orange", "peach"])

assert.label("Empty array")
assert.test(A.sortedUniq([]), [])

assert.label("No mutation of input array")
arr := [1, 2, 2, 3, 3, 3]
A.sortedUniq(arr)
assert.test(arr, [1, 2, 2, 3, 3, 3])

assert.group(".tail")
assert.label("default tests")
assert.test(A.tail([1, 2, 3]), [2, 3])
assert.test(A.tail("fred"), ["r", "e", "d"])
assert.test(A.tail(100), ["0", "0"])

; omit
assert.test(A.tail([]), [])
assert.label("Array with a single element")
assert.test(A.tail([1]), [])

assert.label("Array with two elements")
assert.test(A.tail([1, 2]), [2])

assert.label("Array with multiple elements")
assert.test(A.tail([1, 2, 3, 4]), [2, 3, 4])

assert.label("String with a single character")
assert.test(A.tail("f"), [])

assert.label("String with two characters")
assert.test(A.tail("fe"), ["e"])

assert.label("String with multiple characters")
assert.test(A.tail("fred"), ["r", "e", "d"])

assert.label("Number input")
assert.test(A.tail(100), ["0", "0"])

assert.test(A.tail([5]), [])

assert.group(".take")
assert.label("default tests")
assert.test(A.take([1, 2, 3]), [1])
assert.test(A.take([1, 2, 3], 2), [1, 2])
assert.test(A.take([1, 2, 3], 5), [1, 2, 3])
assert.test(A.take([1, 2, 3], 0), [])
assert.test(A.take("fred"), ["f"])
assert.test(A.take(100), ["1"])
; omit
assert.label("Empty array input")
assert.test(A.take([]), [])

assert.label("Array with a single element")
assert.test(A.take([1], 1), [1])

assert.label("Array with two elements")
assert.test(A.take([1, 2], 1), [1])

assert.label("Array with multiple elements")
assert.test(A.take([1, 2, 3, 4], 3), [1, 2, 3])

assert.label("String with a single character")
assert.test(A.take("f", 1), ["f"])

assert.label("String with two characters")
assert.test(A.take("fe", 1), ["f"])

assert.label("String with multiple characters")
assert.test(A.take("fred", 2), ["f", "r"])

assert.label("Number")
assert.test(A.take(100, 1), ["1"])

assert.group(".takeRight")
assert.label("default tests")
assert.test(A.takeRight([1, 2, 3]), [3])
assert.test(A.takeRight([1, 2, 3], 2), [2, 3])
assert.test(A.takeRight([1, 2, 3], 5), [1, 2, 3])
assert.test(A.takeRight([1, 2, 3], 0), [])
assert.test(A.takeRight("fred"), ["d"])
assert.test(A.takeRight(100), ["0"])

; omit
assert.test(A.takeRight([]), [])
assert.test(A.takeRight("fred", 3), ["r","e","d"])

assert.label("mutation")
string := "fred"
assert.test(A.takeRight(string, 4), ["f","r","e","d"])
assert.test(string, "fred")

obj := [1, 2, 3]
assert.test(A.takeRight(obj), [3])
assert.test(obj, [1, 2, 3])

assert.label("Array with a single element")
assert.test(A.takeRight([1], 1), [1])

assert.label("Array with two elements")
assert.test(A.takeRight([1, 2], 1), [2])

assert.label("Array with multiple elements")
assert.test(A.takeRight([1, 2, 3, 4], 2), [3, 4])

assert.label("String with a single character")
assert.test(A.takeRight("f", 1), ["f"])

assert.label("String with two characters")
assert.test(A.takeRight("fe", 1), ["e"])

assert.label("String with multiple characters")
assert.test(A.takeRight("fred", 2), ["e", "d"])

assert.label("Number input")
assert.test(A.takeRight(100, 1), ["0"])

assert.group(".union")
assert.label("default tests")
assert.test(A.union([2], [1, 2]), [2, 1])


; omit
assert.test(A.union(["Fred", "Barney", "barney", "barney"]), ["Fred", "Barney", "barney"])
assert.test(A.union("hello!"), ["hello!"])

assert.label("Arrays with no common elements")
assert.test(A.union([1, 2, 3], [4, 5, 6]), [1, 2, 3, 4, 5, 6])

assert.label("Arrays with some common elements")
assert.test(A.union([1, 2, 3], [3, 4, 5]), [1, 2, 3, 4, 5])

assert.label("Arrays with all elements identical")
assert.test(A.union([1, 2, 3], [1, 2, 3]), [1, 2, 3])

assert.label("Arrays with identical elements but in different orders")
assert.test(A.union([1, 2, 3], [3, 2, 1]), [1, 2, 3])

assert.label("Empty arrays")
assert.test(A.union([], []), [])

assert.group(".uniq")
assert.label("default tests")
assert.test(A.uniq([2, 1, 2]), [2, 1])


; omit
assert.test(A.uniq(["Fred", "Barney", "barney", "barney"]), ["Fred", "Barney", "barney"])

arr := [70, 88, 12, 52, 27, 14, 86, 54, 24, 55, 29, 33, 33, 25, 99]
arr2 := A.uniq(arr)
assert.test(arr.count(), 15)
assert.test(arr2.count(), 14)

assert.label("Array with duplicate elements")
assert.test(A.uniq([2, 1, 2]), [2, 1])

assert.label("Array with no duplicate elements")
assert.test(A.uniq([1, 2, 3]), [1, 2, 3])

assert.label("Array with all elements identical")
assert.test(A.uniq([1, 1, 1]), [1])

assert.label("Empty array")
assert.test(A.uniq([]), [])

assert.group(".unzip")
assert.label("default tests")
zipped := A.zip(["a", "b"], [1, 2], [true, false])
; => [["a", 1, true], ["b", 2, true]]
assert.test(A.unzip(zipped), [["a", "b"], [1, 2], [true, false]])


; omit
assert.label("Empty array")
assert.test(A.unzip([]), [])

assert.group(".without")
assert.label("default tests")
assert.label("Array with multiple instances of the excluded elements")
assert.test(A.without([2, 1, 2, 3], 1, 2), [3])


; omit
assert.label("Array with single instance of the excluded element")
assert.test(A.without([2, 1, 2, 3], 1), [2, 2, 3])

assert.label("Array with no excluded elements")
assert.test(A.without([2, 1, 2, 3], 4), [2, 1, 2, 3])

assert.label("Empty array")
assert.test(A.without([], 1, 2), [])

assert.group(".zip")
assert.label("default tests")
assert.test(A.zip(["a", "b"], [1, 2], [true, true]),[["a", 1, true], ["b", 2, true]])


; omit
obj1 := ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
obj2 := ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]
assert.test(A.zip(obj1, obj2),[["one", "one"], ["two", "two"], ["three", "three"], ["four", "four"], ["five", "five"], ["six", "six"], ["seven", "seven"], ["eight", "eight"], ["nine", "nine"], ["ten", "ten"]])

assert.group(".zipObject")
assert.label("default tests")
assert.test(A.zipObject(["a", "b"], [1, 2]), {"a": 1, "b": 2})


; omit
assert.test(A.zipObject(["a", "b", "c"], [1, 2]), {"a": 1, "b": 2, "c": ""})

assert.group(".count")
assert.label("default tests")
assert.test(A.count([1, 2, 3], 2), 1)
assert.test(A.count("pebbles", "b"), 2)
assert.test(A.count(["fred", "barney", "pebbles"], "barney"), 1)

users := [ {"user": "fred", "age": 40, "active": true}
		, {"user": "barney", "age": 36, "active": false}
		, {"user": "pebbles", "age": 1, "active": false} ]

; The A.matches iteratee shorthand.
assert.test(A.count(users, {"age": 1, "active": false}), 1)

; The A.matchesProperty iteratee shorthand.
assert.test(A.count(users, ["active", false]), 2)

; The A.property iteratee shorthand.
assert.test(A.count(users, "active"), 1)


; omit
assert.label("double characters")
assert.test(A.count("pebbles", "bb"), 1)
assert.label("non alnum input")
assert.test(A.count("3.14", "."), 1)
assert.label("with double special character parameter")
assert.test(A.count("....", ".."), 2)
assert.label("with space character parameter")
assert.test(A.count("   ", "test"), 0)
assert.label("with numeric input")
assert.test(A.count(1221221221, 22), 3)


assert.group(".countBy")
assert.label("default tests")
assert.test(A.countBy([6.1, 4.2, 6.3], func("floor")), {"4": 1, "6": 2})

; The A.property iteratee shorthand.
assert.test(A.countBy(["one", "two", "three"], A.size), {"3": 2, "5": 1})


; omit
assert.label("count word occurances")
wordOccurances := A.countBy(["one", "two", "three", "one", "two", "three"], A.toLower)
assert.equal(wordOccurances, {"one": 2, "two": 2, "three": 2})
wordOccurances := A.countBy(["one", "two", "three", "one", "two", "three"])
assert.equal(wordOccurances, {"one": 2, "two": 2, "three": 2})

assert.test(A.countBy(["one", "two", "three", "four"], A.size), {"3": 2, "4": 1, "5": 1})

assert.test(A.countBy(["one", "two", "three", "one", "two", "three", "four"], A.toLower), {"one": 2, "two": 2, "three": 2, "four": 1})

assert.group(".every")
assert.label("default tests")
assert.false(A.every([true, 1, false, "yes"], A.isBoolean))

users := [{ "user": "barney", "age": 36, "active": false }
, { "user": "fred", "age": 40, "active": false }]

; The A.matches iteratee shorthand.
assert.false(A.every(users, {"user": "barney", "age": 36, "active": false}))

; The A.matchesProperty iteratee shorthand.
assert.true(A.every(users, ["active", false]))

; The A.property iteratee shorthand.
assert.false(A.every(users, "active"))


; omit
assert.true(A.every([], func("fn_istrue")))
assert.true(A.every([1, 2, 3], func("isPositive")))
isPositive(value) {
	if (value > 0) {
		return true
	}
	return false
}

assert.false(A.every([true, false, true, true], func("fn_istrue")))
fn_istrue(value)
{
	if (value != true) {
		return false
	}
	return true
}
assert.true(A.every([true, true, true, true], func("fn_istrue")))


userVotes := [{"name":"fred", "votes": ["yes","yes"]}
			, {"name":"bill", "votes": ["no","yes"]}
			, {"name":"jake", "votes": ["no","yes"]}]

assert.false(A.every(userVotes, ["votes.1", "yes"]))
assert.true(A.every(userVotes, ["votes.2", "yes"]))


assert.label("detect all undefined array")
assert.true(A.every(["", "", ""], A.isUndefined))
assert.false(A.every(["", "", 1], A.isUndefined))

assert.label("Use other methods for param_predicate")
assert.true(A.every(["hey", "you", "there"], A.isString))

assert.label("default .identity argument")
assert.true(A.every([true, true, true]))
assert.false(A.every([true, true, false]))

assert.group(".filter")
assert.label("default tests")
users := [{"user":"barney", "age":36, "active":true}, {"user":"fred", "age":40, "active":false}]

assert.test(A.filter(users, func("fn_filterFunc")), [{"user":"barney", "age":36, "active":true}])
fn_filterFunc(param_iteratee)
{
	if (param_iteratee.active) {
		return true
	}
}

; The A.matches shorthand
assert.test(A.filter(users, {"age":36, "active":true}), [{"user":"barney", "age":36, "active":true}])

; The A.matchesProperty shorthand
assert.test(A.filter(users, ["active", false]), [{"user":"fred", "age":40, "active":false}])

; The A.property shorthand
assert.test(A.filter(users, "active"), [{"user":"barney", "age":36, "active":true}])


; omit
assert.label(".matches longhand")
assert.test(A.filter(users, A.matches({"user": "fred"})), [{"user":"fred", "age":40, "active":false}])

assert.label("call own biga.ahk method (guarded)")
; assert.test(A.filter(users, A.random), ["hey", "hey", "hey"])

assert.label("call own biga.ahk method (unguarded)")
assert.test(A.filter(users, A.isObject), users)


assert.label("using value")
assert.test(A.filter([1,2,3,-10,1.9], func("fn_filter2")), [2,3])
fn_filter2(param_iteratee) {
	if (param_iteratee >= 2) {
		return true
	}
}

assert.label("using value and key")
assert.test(A.filter([1,2,3,-10,1.9,"even"], func("fn_filter3")), [2,-10,"even"])
fn_filter3(param_iteratee, param_key) {
	if (mod(param_key, 2) = 0) {
		return true
	}
}

assert.label("using value, key, and collection")
assert.test(A.filter([1,2,3,-10,1.9,"even"], func("fn_filter4")), [2])
fn_filter4(param_iteratee, param_key, param_collection) {
	A := new biga()
	if (mod(param_key, 2) = 0 && A.indexOf(param_collection, param_iteratee / 2) != -1) {
		return true
	}
}

assert.group(".find")
assert.label("default tests")
users := [ {"user": "barney", "age": 36, "active": true}
	, {"user": "fred", "age": 40, "active": false}
	, {"user": "pebbles", "age": 1, "active": true} ]

assert.test(A.find(users, func("fn_findFunc")), { "user": "barney", "age": 36, "active": true })
fn_findFunc(o)
{
	return o.active
}

; The A.matches iteratee shorthand.
assert.test(A.find(users, { "age": 1, "active": true }), { "user": "pebbles", "age": 1, "active": true })

; The A.matchesProperty iteratee shorthand.
assert.test(A.find(users, ["active", false]), { "user": "fred", "age": 40, "active": false })

; The A.property iteratee shorthand.
assert.test(A.find(users, "active"), { "user": "barney", "age": 36, "active": true })


; omit
assert.label("fromindex argument")
assert.test(A.find(users, "active", 2), { "user": "pebbles", "age": 1, "active": true })

assert.group(".findLast")
assert.label("default tests")
assert.test(A.findLast([1, 2, 3, 4], func("fn_findLastFunc")), 3)
fn_findLastFunc(n)
{
	return mod(n, 2) == 1
}


; omit
assert.test(A.findLast([2, 4, 6, 7, 8], func("fn_findLastFunc")), 7)

assert.test(A.findLast([1, 2, 3, 4, 5, 6], func("fn_findLastFunc")), 5)

assert.group(".forEach")
assert.label("default tests")


; omit
assert.label("order")
obj := []
A.forEach([1, 2], func("fn_forEachGlobal"))
assert.test(obj, [2, 3])
fn_forEachGlobal(value)
{
	global
	obj.push(value + 1)
}


assert.label("alias")
assert.test(A.each([1, 2], func("fn_forEachFunc")), [1, 2])

assert.label("default .identity argument")
assert.test(A.forEach(["foo", 0, "bar"]), ["foo", 0, "bar"])

assert.test(A.forEach([], func("fn_forEachGlobal")), [])

assert.test(A.forEach([5], func("fn_forEachGlobal")), [5])

assert.label("with own method")
assert.test(A.forEach(["apple", "banana", "cherry"], A.size()), ["apple", "banana", "cherry"])

assert.group(".forEachRight")
assert.label("default tests")


; omit
assert.label("order")
obj := []
A.forEachRight([1, 2], func("fn_forEachRightFuncGlobal"))
assert.test(obj, [3, 2])
fn_forEachRightFuncGlobal(value)
{
	global
	obj.push(value + 1)
}


assert.label("alias")
assert.test(A.eachRight([1, 2], func("fn_forEachRightFuncGlobal")), [1, 2])

assert.label("default .identity argument")
assert.test(A.forEachRight([1, 2], func("fn_forEachRightFunc")), [1, 2])

assert.label("with own method")
assert.test(A.forEach(["apple", "banana", "cherry"], A.size()), ["apple", "banana", "cherry"])

assert.label("no mutation")
arr := ["apple", "banana", "cherry"]
A.forEach(["apple", "banana", "cherry"], A.size())
assert.test(arr, ["apple", "banana", "cherry"])

assert.group(".groupBy")
assert.label("default tests")
assert.test(A.groupBy([6.1, 4.2, 6.3], A.floor), {4: [4.2], 6: [6.1, 6.3]})

assert.test(A.groupBy(["one", "two", "three"], A.size), {3: ["one", "two"], 5: ["three"]})

assert.test(A.groupBy([6.1, 4.2, 6.3], func("ceil")), {5: [4.2], 7: [6.1, 6.3]})


; omit
users := [ { "user": "barney", "lastActive": "Tuesday" }
		, { "user": "fred", "lastActive": "Monday" }
		, { "user": "pebbles", "lastActive": "Tuesday" } ]

assert.test(A.groupBy(users, "lastActive"), {"Monday": [{ "user": "fred", "lastActive": "Monday" }], "Tuesday": [{ "user": "barney", "lastActive": "Tuesday" }, { "user": "pebbles", "lastActive": "Tuesday" }]})

assert.label("default .identity argument")
assert.test(A.groupBy([6.1, 4.2, 6.3]), {"6.1": [6.1], "4.2": [4.2], "6.3": [6.3]})

assert.group(".includes")
assert.label("default tests")
assert.true(A.includes([1, 2, 3], 1))
assert.true(A.includes({ "a": 1, "b": 2 }, 1))
assert.true(A.includes("inStr", "Str"))
StringCaseSense, On
assert.false(A.includes("inStr", "str"))
; RegEx object
assert.true(A.includes("hello!", "/\D/"))


; omit
StringCaseSense, Off
assert.false(A.includes("inStr", "Other"))
assert.label("object search")
assert.true(A.includes([[1], [2]], [2]))

assert.label("not found")
assert.false(A.includes([1, 2, 3], 4))

assert.label("not found")
assert.false(A.includes({ "a": 1, "b": 2 }, 3))

assert.group(".keyBy")
assert.label("default tests")
array := [ {"dir": "left", "code": 97}
	, {"dir": "right", "code": 100}]
assert.test(A.keyBy(array, func("fn_keyByFunc")), {"left": {"dir": "left", "code": 97}, "right": {"dir": "right", "code": 100}})

fn_keyByFunc(value)
{
	return value.dir
}

; The A.property iteratee shorthand.
assert.test(A.keyBy(array, "dir"), {"left": {"dir": "left", "code": 97}, "right": {"dir": "right", "code": 100}})


; omit
assert.label("default .identity argument")
assert.test(A.keyBy([1, 2, 3]), [1, 2, 3])

assert.group(".map")
assert.label("default tests")
fn_square(n)
{
	return n * n
}

assert.test(A.map([4, 8], func("fn_square")), [16, 64])
assert.test(A.map({ "a": 4, "b": 8 }, func("fn_square")), [16, 64])
assert.test(A.map({ "a": 4, "b": 8 }), [4, 8])

; The A.property shorthand
assert.label(".property shorthand")
users := [{ "user": "barney" }, { "user": "fred" }]
assert.test(A.map(users, "user"), ["barney", "fred"])


; omit
assert.label("call own biga.ahk method (guarded)")
assert.test(A.map([" hey ", "hey", " hey	"], A.trim), ["hey", "hey", "hey"])

assert.label("call own biga.ahk method (unguarded)")
assert.test(A.map(["hello", "world"], A.castArray), [["hello"], ["world"]])

assert.label("call with 2 parameters")
assert.test(A.map([1, 2], func("fn_map2")), ["1-1", "2-2"])
fn_map2(param1, param2)
{
	return param1 "-" param2
}

assert.label("call with 3 parameters")
assert.test(A.map([1, 2], func("fn_map3")), ["1-1-1", "2-2-1"])
fn_map3(param1, param2, param3)
{
	return param1 "-" param2 "-" param3[1]
}

assert.label("default .identity argument")
assert.test(A.map([1, 2, 3]), [1, 2, 3])


assert.label("guarded random method")
rands := A.map([1, 2, 3, 4, 5, 6, 7, 8], A.random)
assert.test(rands.count(), 8)
assert.true(A.every(rands, A.isNumber))

assert.group(".partition")
assert.label("default tests")
users := [ { "user": "barney", "age": 36, "active": false }
	, { "user": "fred", "age": 40, "active": true }
	, { "user": "pebbles", "age": 1, "active": false } ]

assert.test(A.partition(users, func("fn_partitionFunc")), [[{ "user": "fred", "age": 40, "active": true }], [{ "user": "barney", "age": 36, "active": false }, { "user": "pebbles", "age": 1, "active": false }]])
fn_partitionFunc(o)
{
	return o.active
}

; The A.matches iteratee shorthand.
assert.test(A.partition(users, {"age": 1, "active": false}), [[{ "user": "pebbles", "age": 1, "active": false }], [{ "user": "barney", "age": 36, "active": false }, { "user": "fred", "age": 40, "active": true }]])

; The A.propertyMatches iteratee shorthand.
assert.test(A.partition(users, ["active", false]), [[{ "user": "barney", "age": 36, "active": false }, { "user": "pebbles", "age": 1, "active": false }] ,[{ "user": "fred", "age": 40, "active": true }]])

; The A.property iteratee shorthand.
assert.test(A.partition(users, "active"), [[{ "user": "fred", "age": 40, "active": true }], [{ "user": "barney", "age": 36, "active": false }, { "user": "pebbles", "age": 1, "active": false }]])


; omit
assert.label("default .identity argument")
assert.test(A.partition([1, 2, 3]), [[1, 2, 3], []])

assert.label("empty array input")
assert.test(A.partition([]), [[], []])

assert.group(".reject")
assert.label("default tests")
users := [{"user":"barney", "age":36, "active":false}, {"user":"fred", "age":40, "active":true}]

assert.test(A.reject(users, func("fn_rejectFunc")), [{"user":"fred", "age":40, "active":true}])
fn_rejectFunc(o)
{
	return !o.active
}

; The A.matches shorthand
assert.test(A.reject(users, {"age":40, "active":true}), [{"user":"barney", "age":36, "active":false}])

; The A.matchesProperty shorthand
assert.test(A.reject(users, ["active", false]), [{"user":"fred", "age":40, "active":true}])

; The A.property shorthand
assert.test(A.reject(users, "active"), [{"user":"barney", "age":36, "active":false}])


; omit
assert.label("default .identity argument")
assert.test(A.reject([0, 1, 2]), [0])

assert.label("rejecting objects where the object is exact match")
assert.test(A.reject(users, {"user": "barney"}), [{"user":"fred", "age":40, "active":true}])

assert.label("rejecting objects where the age is less than 40")
assert.test(A.reject(users, func("fn_ageLessThan40")), [{"user":"fred", "age":40, "active":true}])
fn_ageLessThan40(o)
{
	return o.age < 40
}

assert.group(".sample")
assert.label("default tests")


; omit
output := A.sample([1, 2, 3])
assert.test(A.size(output), 1)
assert.false(isObject(output))

output := A.sample([{"obj": 1} , {"obj": 2}, {"obj": 3}])
assert.test(A.size(output), 1)
assert.true(isObject(output))

output := A.sample([{"obj": "value"} , {"obj": "value"}, {"obj": "value"}])
assert.true(A.includes(output, "value"))

assert.label("string input")
output := A.sample("abc")
assert.true(A.includes(["a", "b", "c"], output))
assert.true(A.isString(output))

assert.label("empty input")
assert.test(A.size(A.sample([])), 0)
assert.undefinded(A.sample([]))

assert.group(".sampleSize")
assert.label("default tests")
output := A.sampleSize([1, 2, 3], 2)
assert.test(output.count(), 2)

output := A.sampleSize([1, 2, 3], 4)
assert.test(output.count(), 3)


; omit
output := A.sampleSize({1:1, 8:2, "key":"value"}, 2)
assert.test(output.count(), 2)

output := A.sampleSize({1:1, 8:2, "key":"value"}, 3)
assert.true(A.includes(output, 1))
assert.true(A.includes(output, 2))
assert.true(A.includes(output, "value"))

assert.group(".shuffle")
assert.label("default tests")


; omit
shuffleTestVar := A.shuffle([1, 2, 3, 4])
assert.test(shuffleTestVar.count(), 4)

shuffleTestVar := A.shuffle(["barney", "fred", "pebbles"])
assert.test(shuffleTestVar.count(), 3)

shuffleTestVar := A.shuffle([{"x": 1}, {"x": 1}, {"x": 1}])
assert.test(shuffleTestVar.count(), 3)
assert.test(shuffleTestVar[1], {"x": 1})
assert.test(shuffleTestVar[2], {"x": 1})
assert.test(shuffleTestVar[3], {"x": 1})

assert.label("empty array")
assert.test(A.shuffle([]), [])

assert.label("sparse arrays")
shuffleTestVar := A.shuffle({2: 1, 4: 1, 6: 1})
shuffleTestVar := A.map(A.compact(shuffleTestVar))
assert.test(shuffleTestVar.count(), 3)
assert.test(shuffleTestVar[1], 1)
assert.test(shuffleTestVar[2], 1)
assert.test(shuffleTestVar[3], 1)
shuffleTestVar := A.shuffle({2: 1, 600: 1})
shuffleTestVar := A.map(A.compact(shuffleTestVar))
assert.test(shuffleTestVar.count(), 2)
assert.test(shuffleTestVar[1], 1)
assert.test(shuffleTestVar[2], 1)

assert.label("no mutation of input object")
arr := [1, 2, 3, 4, 5]
A.shuffle(arr)
assert.test(arr, [1, 2, 3, 4, 5])

assert.group(".size")
assert.label("default tests")
assert.test(A.size([1, 2, 3]), 3)
assert.test(A.size({ "a": 1, "b": 2 }), 2)
assert.test(A.size("pebbles"), 7)


; omit
assert.label("empty array")
assert.test(A.size([]), 0)
assert.test(A.size({}), 0)

assert.label("objects")
users := [{"user": "barney", "active": true}
	, {"user": "fred", "active": false}
	, {"user": "pebbles", "active": false}]
assert.test(A.size(users), 3)

assert.label("empty values")
assert.test(A.size(["A", "", "C"]), 3)

assert.label("empty string input")
assert.test(A.size(""), 0)

assert.group(".some")
assert.label("default tests")
users := [{ "user": "barney", "active": true }, { "user": "fred", "active": false }]

; The A.matches iteratee shorthand.
assert.label("A.matches iteratee shorthand.")
assert.false(A.some(users, { "user": "barney", "active": false }))

; The A.matchesProperty iteratee shorthand.
assert.label("A.matchesProperty iteratee shorthand.")
assert.true(A.some(users, ["active", false]))

; The A.property iteratee shorthand.
assert.label("A.property iteratee shorthand.")
assert.true(A.some(users, "active"))


; omit
assert.label("default .identity argument")
assert.true(A.some([0, 1, 2]))

assert.group(".sortBy")
assert.label("default tests")
assert.test(A.sortBy(["b", "f", "e", "c", "d", "a"]),["a", "b", "c", "d", "e", "f"])
users := [{ "name": "fred", "age": 40 }
 , { "name": "barney", "age": 34 }
 , { "name": "bernard", "age": 36 }
 , { "name": "zoey", "age": 40 }]

assert.test(A.sortBy(users, "age"), [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"zoey"}, {"age":40, "name":"fred"}])
assert.test(A.sortBy(users, ["age", "name"]), [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zoey"}])
assert.test(A.sortBy(users, func("fn_sortByFunc")), [{"age":34, "name":"barney"}, {"age":36, "name":"bernard"}, {"age":40, "name":"fred"}, {"age":40, "name":"zoey"}])
fn_sortByFunc(o)
{
	return o.name
}

; sort using result of another method
assert.label("calling own method")
assert.test(A.sortBy(["ab", "a", " abc", "abc"], A.size), ["a", "ab", "abc", " abc"])

; omit
myArray := [3, 4, 2, 9, 4, 12, 2]
assert.test(A.sortBy(myArray),[2, 2, 3, 4, 4, 9, 12])

myArray := ["100", "333", "987", "54", "1", "0", "-263", "543"]
assert.test(A.sortBy(myArray),["-263", "0", "1", "54", "100", "333", "543", "987"])

enemies := [
	, {"name": "bear", "hp": 200, "armor": 20}
	, {"name": "wolf", "hp": 100, "armor": 12}]
sortedEnemies := A.sortBy(enemies, "hp")
assert.test(A.sortBy(enemies, "hp"), [{"name": "wolf", "hp": 100, "armor": 12}, {"name": "bear", "hp": 200, "armor": 20}])

users := [{ "name": "fred", "age": 46 }
 , { "name": "barney", "age": 34 }
 , { "name": "bernard", "age": 36 }
 , { "name": "zoey", "age": 40 }]
assert.test(A.sortBy(users,"name"),[{"age":34,"name":"barney"},{"age":36,"name":"bernard"},{"age":46,"name":"fred"},{"age":40,"name":"zoey"}])

assert.label("non-existant key")
assert.test(A.sortBy(users, "null"), users)

assert.label("number key")
assert.test(A.sortBy(users, 1), users)

assert.label("default .identity argument")
assert.test(A.sortBy([2, 0, 1]), [0, 1, 2])

assert.label("with abnormal key values")
users := [{ "name": "fred", "age |[]-=!@#$%^&*()_+": 46 }
 , { "name": "barney", "age |[]-=!@#$%^&*()_+": 34 }]
assert.test(A.sortBy(users, "age |[]-=!@#$%^&*()_+"), [{"age |[]-=!@#$%^&*()_+":34, "name":"barney"}, {"age |[]-=!@#$%^&*()_+":46, "name":"fred"}])

assert.group(".now")
assert.label("default tests")


; omit
assert.label("timestamps have 13 digits")
assert.test(A.size(A.now()), 13)

assert.label("number output")
assert.true(A.isNumber(A.now()))

assert.group(".ary")
assert.label("default tests")
aryFunc := A.ary(Func("fn_aryFunc"), 2)
assert.test(aryFunc.call("a", "b", "c", "d"), ["a", "b"])

fn_aryFunc(arguments*) {
	return arguments
}


; omit
assert.label("with zero params")
aryFunc := A.ary(Func("fn_aryFunc"), 0)
assert.test(aryFunc.call("a", "b", "c", "d"), [])

assert.label("with one param")
aryFunc := A.ary(Func("fn_aryFunc"), 1)
assert.test(aryFunc.call("a", "b", "c", "d"), ["a"])

assert.group(".delay")
assert.label("default tests")


; omit
assert.label("return true")
boundFunc := A.random.bind(A, 99, 99, 0)
assert.true(A.delay(boundFunc, 1000))


A.delay(Func("fn_delayTest"), 10, "hello", "world")
fn_delayTest(msg, msg2) {
	global assert
	assert.group(".delay")
	assert.label("callback")
	assert.test(msg " " msg2, "hello world")
}
; same but as a boundfunc
boundfunc := func("fn_delayTest").bind("hello", "world")
A.delay(boundfunc, 10)

A.delay(Func("fn_delayTest2"), 10)
fn_delayTest2() {
	global assert
	assert.group(".delay")
	assert.label("callback with zero parameters")
	assert.test("hello world", "hello world")
}
; same but as a boundfunc
boundfunc := func("fn_delayTest2").bind()
A.delay(boundfunc, 10)

assert.group(".flip")
assert.label("default tests")
flippedFunc1 := A.flip(Func("inStr"))
assert.test(flippedFunc1.call("s", "string"), 1)

flippedFunc2 := A.flip(Func("fn_flipFunc"))
assert.test(flippedFunc2.call("a", "b", "c", "d"), ["d", "c", "b", "a"])

fn_flipFunc(arguments*) {
	return biga.toArray(arguments)
}


; omit
flippedFunc3 := A.flip(Func("fn_flipEmptyFunc"))
assert.test(flippedFunc3.call(), [])

fn_flipEmptyFunc() {
    return []
}

assert.group(".internal")
assert.label("default tests")
assert.label("_internal_JSRegEx")
assert.test(A._internal_JSRegEx("/RegEx(capture)/"),"RegEx(capture)")

assert.label("md5")
assert.notEqual(A._internal_MD5({"a": [1,2,[3]]}), A._internal_MD5({"a": [1,2,[99]]}))

assert.label("isFalsey")
assert.true(A.isFalsey(0))
assert.true(A.isFalsey(""))
assert.false(A.isFalsey([]))
assert.false(A.isFalsey({}))


; omit
assert.group("._internal_MD5")
; assert.label("boolean value")
; assert.test(A._internal_MD5(true), [true])
; assert.test(A._internal_MD5(false), [false])

; assert.label("an undefined value")
; assert.test(A._internal_MD5(non_existant_var), [non_existant_var])
; assert.test(A._internal_MD5(""), [""])

; assert.label("number that is not 1")
; assert.test(A._internal_MD5(0), [0])
; assert.test(A._internal_MD5(2), [2])

; assert.label("string input")
; assert.test(A._internal_MD5("def"), ["def"])

; assert.label("complex object")
; assert.test(A._internal_MD5({"a": 1, "b": 2}), {"a": 1, "b": 2})

; assert.label("an array of multiple elements")
; assert.test(A._internal_MD5([1, 2, 3, 4]), [1, 2, 3, 4])

; assert.label("an empty object")
; assert.test(A._internal_MD5({}), [{}])

; assert.label("an empty array")
; assert.test(A._internal_MD5([]), [[]])

; assert.label("string containing special characters")
; assert.test(A._internal_MD5("@#$%^&*()"), ["@#$%^&*()"])

; assert.label("negative number")
; assert.test(A._internal_MD5(-1), [-1])

assert.group(".castArray")
assert.label("default tests")
assert.test(A.castArray(1), [1])
assert.test(A.castArray({"a": 1}), {"a": 1})
assert.test(A.castArray("abc"), ["abc"])
assert.test(A.castArray(""), [""])


; omit
assert.test(A.castArray([1, 2, 3]), [1, 2, 3])

assert.label("boolean value")
assert.test(A.castArray(true), [true])
assert.test(A.castArray(false), [false])

assert.label("an undefined value")
assert.test(A.castArray(""), [""])

assert.label("number that is not 1")
assert.test(A.castArray(0), [0])
assert.test(A.castArray(2), [2])

assert.label("string input")
assert.test(A.castArray("ghi"), ["ghi"])

assert.label("complex object")
assert.test(A.castArray({"a": 1, "b": 2}), {"a": 1, "b": 2})

assert.label("an array of multiple elements that is not [1, 2, 3]")
assert.test(A.castArray([4, 5, 6]), [4, 5, 6])

assert.label("an empty object")
assert.test(A.castArray({}), [{}])

assert.label("an empty array")
assert.test(A.castArray([]), [[]])

assert.label("string containing special characters")
assert.test(A.castArray("@#$%^&*()"), ["@#$%^&*()"])

assert.label("negative number")
assert.test(A.castArray(-1), [-1])

assert.group(".clone")
assert.label("default tests")
object := [{ "a": 1 }, { "b": 2 }]
shallowclone := A.clone(object)
object.a := 2
assert.test(shallowclone, [{ "a": 1 }, { "b": 2 }])


; omit
var := 33
clone := A.clone(var)
clone++
assert.notEqual(var, clone)

assert.label("boolean value")
assert.test(A.clone(true), true)
assert.test(A.clone(false), false)

assert.label("undefined value")
assert.test(A.clone(""), "")

assert.label("number that is not 33")
assert.test(A.clone(0), 0)
assert.test(A.clone(2), 2)

assert.label("string")
assert.test(A.clone("abc"), "abc")

assert.label("array of multiple elements")
assert.test(A.clone([4, 5, 6]), [4, 5, 6])

assert.label("empty object")
assert.test(A.clone({}), {})

assert.label("empty array")
assert.test(A.clone([]), [])

assert.label("string containing special characters")
assert.test(A.clone("@#$%^&*()"), "@#$%^&*()")

; Test with a negative number:
assert.label("negative number")
assert.test(A.clone(-1), -1)

assert.group(".cloneDeep")
assert.label("default tests")
object := [{ "a": [[1, 2, 3]] }, { "b": 2 }]
deepclone := A.cloneDeep(object)
object[1].a := 2
; object
; => [{ "a": 2 }, { "b": 2 }]
; deepclone
; => [{ "a": [[1, 2, 3]] }, { "b": 2 }]


; omit
assert.test(deepclone, [{ "a": [[1, 2, 3]] }, { "b": 2 }])
assert.test(object, [{ "a": 2 }, { "b": 2 }])

assert.group(".conformsTo")
assert.label("default tests")
object := {"a": 1, "b": 2}

assert.true(A.conformsTo(object, {"b": func("fn_conformsToFunc1")}))
assert.false(A.conformsTo(object, {"b": func("fn_conformsToFunc2")}))

fn_conformsToFunc1(n)
{
	return n > 1
}

fn_conformsToFunc2(n)
{
	return n > 2
}


; omit
object := {"a": 1, "b": 2, "c": 2}
assert.true(A.conformsTo(object, {"b": func("fn_conformsToFunc1"), "c": func("fn_conformsToFunc1")}))

assert.label("Testing with a different object")
assert.true(A.conformsTo({"a": 3, "b": 4}, {"b": func("fn_conformsToFunc1")}))

assert.label("Testing with an extra key in the object")
assert.true(A.conformsTo({"a": 1, "b": 2, "c": 3}, {"b": func("fn_conformsToFunc1")}))

assert.label("Testing with a missing key in the object")
assert.false(A.conformsTo({"a": 1}, {"b": func("fn_conformsToFunc1")}))

assert.label("Testing with an empty object")
assert.false(A.conformsTo({}, {"b": func("fn_conformsToFunc1")}))

assert.group(".eq")
assert.label("default tests")
object := {"a": 1}
other := {"a": 1}

assert.true(A.eq(object, other))
assert.true(A.eq("a", "a"))
assert.true(A.eq("", ""))


; omit
assert.label("different object")
assert.false(A.eq({"a": 2}, {"a": 1}))

assert.label("different string")
assert.false(A.eq("b", "a"))

assert.label("different empty string")
assert.false(A.eq(" ", ""))

assert.label("number")
assert.true(A.eq(1, 1))

assert.label("different number")
assert.false(A.eq(2, 1))

assert.label("boolean")
assert.true(A.eq(true, true))

assert.label("different boolean")
assert.false(A.eq(true, false))

assert.label("Testing with undefined values")
assert.true(A.eq("", ""))

assert.group(".gt")
assert.label("default tests")
assert.true(A.gt(3, 1))
assert.false(A.gt(3, 3))
assert.false(A.gt(1, 3))


; omit
assert.label("equal numbers")
assert.false(A.gt(1, 1))

assert.label("smaller first number")
assert.false(A.gt(1, 2))

assert.label("zero as first number")
assert.false(A.gt(0, 1))

assert.label("zero as second number")
assert.true(A.gt(1, 0))

assert.label("negative numbers")
assert.true(A.gt(-1, -2))

assert.label("negative and positive number")
assert.false(A.gt(-1, 1))

assert.label("fractions")
assert.true(A.gt(0.5, 0.2))

assert.label("equal fractions")
assert.false(A.gt(0.5, 0.5))

assert.label("large numbers")
assert.true(A.gt(1000000, 999999))

assert.group(".gte")
assert.label("default tests")
assert.true(A.gte(3, 1))
assert.true(A.gte(3, 3))
assert.false(A.gte(1, 3))


; omit
assert.label("smaller first number")
assert.false(A.gte(1, 2))

assert.label("zero as first number")
assert.false(A.gte(0, 1))

assert.label("zero as second number")
assert.true(A.gte(1, 0))

assert.label("negative numbers")
assert.true(A.gte(-1, -2))

assert.label("equal negative numbers")
assert.true(A.gte(-1, -1))

assert.label("negative and positive number")
assert.false(A.gte(-1, 1))

assert.label("fractions")
assert.true(A.gte(0.5, 0.2))

assert.label("equal fractions")
assert.true(A.gte(0.5, 0.5))

assert.label("smaller fraction as first number")
assert.false(A.gte(0.2, 0.5))

assert.label("large numbers")
assert.true(A.gte(1000000, 999999))

assert.label("equal large numbers")
assert.true(A.gte(1000000, 1000000))

assert.group(".isAlnum")
assert.label("default tests")
assert.true(A.isAlnum(1))
assert.true(A.isAlnum("hello"))
assert.false(A.isAlnum([]))
assert.false(A.isAlnum({}))


; omit
assert.label("number preceeded by zero")
assert.true(A.isAlnum("08"))

assert.label("number preceeded by zeros")
assert.true(A.isAlnum("0000008"))

assert.label("Testing with a number string")
assert.true(A.isAlnum("123"))

assert.label("Testing with a alphanumeric string")
assert.true(A.isAlnum("abc123"))

assert.label("Testing with a string containing special characters")
assert.false(A.isAlnum("abc123!"))

assert.label("Testing with a string containing spaces")
assert.false(A.isAlnum("abc 123"))

assert.label("Testing with an undefined value")
assert.true(A.isAlnum(""))

assert.label("Testing with a boolean value")
assert.true(A.isAlnum(true))

assert.label("Testing with a negative number")
assert.false(A.isAlnum(-1))

assert.label("Testing with a fraction")
assert.false(A.isAlnum(0.5))

assert.group(".isArray")
assert.label("default tests")
assert.true(A.isArray([1, 2, 3]))
assert.label("string input")
assert.false(A.isArray("abc"))
assert.label("keyed object")
assert.true(A.isArray({"key": "value"}))


; omit
assert.false(A.isArray(1))
assert.false(A.isArray(""))

assert.label("number")
assert.false(A.isArray(123))

assert.label("boolean")
assert.false(A.isArray(true))

assert.label("undefined value")
assert.false(A.isArray(""))

assert.label("object containing an array")
assert.true(A.isArray({"key": [1, 2, 3]}))

assert.label("array of strings")
assert.true(A.isArray(["a", "b", "c"]))

assert.label("array of objects")
assert.true(A.isArray([{"a": 1}, {"b": 2}, {"c": 3}]))

assert.label("nested array")
assert.true(A.isArray([[1, 2, 3], [4, 5, 6], [7, 8, 9]]))

assert.group(".isBoolean")
assert.label("default tests")
assert.true(A.isBoolean(true))
assert.true(A.isBoolean(1))
assert.true(A.isBoolean(false))
assert.true(A.isBoolean(0))


; omit
assert.false(A.isBoolean(0.1))
assert.false(A.isBoolean(1.1))
assert.false(A.isBoolean("1.1"))
assert.false(A.isBoolean("false"))
assert.false(A.isBoolean("true"))

assert.group(".isEqual")
assert.label("default tests")
assert.true(A.isEqual(1, 1))
assert.true(A.isEqual({ "a": 1 }, { "a": 1 }))
assert.false(A.isEqual(1, 1, 2))
StringCaseSense, On
assert.false(A.isEqual({ "a": "a" }, { "a": "A" }))


; omit
StringCaseSense, Off
assert.false(A.isEqual({ "a": 1 }, { "a": 2 }))

assert.label("variadric parameters")
assert.true(A.isEqual(1, 1, 1))
assert.true(A.isEqual({ "a": 1 }, { "a": 1 }, { "a": 1 }))
assert.false(A.isEqual(1, 1, { "a": 1 }))

assert.label("leading zero numbers")
assert.true(A.isEqual(00011, 11))
assert.true(A.isEqual(011, 11))
assert.true(A.isEqual(11, 11))

assert.label("decimal places")
assert.true(A.isEqual(1.0, 1.000))
assert.true(A.isEqual(11, 11.000))
assert.false(A.isEqual(11, 11.0000000001))

assert.label("string comparison")
assert.true(A.isEqual(11, "11"))
assert.true(A.isEqual("11", "11"))

assert.label("empty object")
assert.true(A.isEqual({}, {}))

assert.label("different keys")
assert.false(A.isEqual({"a": 1}, {"b": 1}))
assert.false(A.isEqual({"a": 1}, [1]))

assert.label("different lengths")
assert.false(A.isEqual({"a": 1}, {"a": 1, "c": 2}))
assert.false(A.isEqual({"a": 1, "c": 2}, {"a": 1}))

assert.group(".isError")
assert.label("default tests")
assert.true(A.isError(Exception("something broke")))


; omit
assert.false(A.isError({"message": "", "what":"", "file":""}))

assert.label("object with blank values")
assert.true(A.isError({"message": "", "what":"", "file":"", "line": 10}))

assert.group(".isFloat")
assert.label("default tests")
assert.true(A.isFloat(1.0))
assert.false(A.isFloat(1))


; omit
assert.label("negative float")
assert.true(A.isFloat(-3.14))

assert.group(".isFunction")
assert.label("default tests")
boundFunc := func("strLen").bind()
assert.true(A.isFunction(boundFunc))
assert.false(IsFunc(boundFunc))
assert.true(A.isFunction(A.isString))
assert.true(A.isFunction(A.matchesProperty("a", 1)))
assert.false(A.isFunction([1, 2, 3]))


; omit
assert.false(A.isFunction([]))
assert.false(A.isFunction({}))
assert.false(A.isFunction("string"))

assert.group(".isInteger")
assert.label("default tests")
assert.true(A.isInteger(1))
assert.false(A.isInteger("1"))

; omit
assert.label("omit")
; assert.true(A.isInteger(1.0000))
assert.true(A.isInteger(-1))
assert.true(A.isInteger(-10))
assert.false(A.isInteger(1.00001))
assert.false(A.isInteger([]))
assert.false(A.isInteger({}))

assert.group(".isMatch")
assert.label("default tests")
object := { "a": 1, "b": 2, "c": 3 }
assert.true(A.isMatch(object, {"b": 2}))
assert.true(A.isMatch(object, {"b": 2, "c": 3}))

assert.false(A.isMatch(object, {"b": 1}))
assert.false(A.isMatch(object, {"b": 2, "z": 99}))

assert.group(".isNumber")
assert.label("default tests")
assert.true(A.isNumber(1))
assert.true(A.isNumber("1"))
assert.true(A.isNumber("1.001"))


; omit
assert.false(A.isNumber([]))
assert.false(A.isNumber({}))
assert.false(A.isNumber(""))
assert.false(A.isNumber("hello world"))

assert.group(".isObject")
assert.label("default tests")
assert.true(A.isObject({}))
assert.true(A.isObject([1, 2, 3]))
assert.false(A.isObject(""))


; omit
assert.false(A.isObject(42))

assert.group(".isString")
assert.label("default tests")
assert.true(A.isString("abc"))
assert.false(A.isString(1))


; omit
assert.true(A.isString("1"))
assert.true(A.isString("."))
; assert.false(A.isString(1.0000))
; assert.false(A.isString(1.0001))
assert.true(A.isString("1.0000"))
assert.false(A.isString({}))

assert.group(".isUndefined")
assert.label("default tests")
assert.true(A.isUndefined(""))
assert.true(A.isUndefined(non_existant_var))
assert.false(A.isUndefined({}))
assert.false(A.isUndefined(" "))
assert.false(A.isUndefined(0))
assert.false(A.isUndefined(false))

assert.group(".lt")
assert.label("default tests")
assert.true(A.lt(1, 3))
assert.false(A.lt(3, 3))
assert.false(A.lt(3, 1))


; omit
assert.label("equal numbers")
assert.false(A.lt(1, 1))

assert.label("smaller first number")
assert.true(A.lt(1, 2))

assert.label("zero as first number")
assert.true(A.lt(0, 1))

assert.label("zero as second number")
assert.false(A.lt(1, 0))

assert.label("negative numbers")
assert.false(A.lt(-1, -2))

assert.label("negative and positive number")
assert.true(A.lt(-1, 1))

assert.label("fractions")
assert.false(A.lt(0.5, 0.2))

assert.label("equal fractions")
assert.false(A.lt(0.5, 0.5))

assert.label("large numbers")
assert.false(A.lt(1000000, 999999))

assert.group(".lte")
assert.label("default tests")
assert.true(A.lte(1, 3))
assert.true(A.lte(3, 3))
assert.false(A.lte(3, 1))

; omit
assert.label("equal numbers")
assert.true(A.lte(1, 1))

assert.label("smaller first number")
assert.true(A.lte(1, 2))

assert.label("zero as first number")
assert.true(A.lte(0, 1))

assert.label("zero as second number")
assert.false(A.lte(1, 0))

assert.label("negative numbers")
assert.false(A.lte(-1, -2))

assert.label("negative and positive number")
assert.true(A.lte(-1, 1))

assert.label("fractions")
assert.false(A.lte(0.5, 0.2))

assert.label("equal fractions")
assert.true(A.lte(0.5, 0.5))

assert.label("large numbers")
assert.false(A.lte(1000000, 999999))

assert.group(".toArray")
assert.label("default tests")
assert.test(A.toArray({"a": 1, "b": 2}), [1, 2])
assert.test(A.toArray("abc"), ["a", "b", "c"])
assert.test(A.toArray(1), [])
assert.test(A.toArray(""), [])

; omit
assert.test(A.toArray("123"), [1, 2, 3])
assert.test(A.toArray(99), [])
assert.test(A.toArray({"a": 1, "b": 2, "c": 3}), [1, 2, 3])

assert.group(".toLength")
assert.label("default tests")
assert.test(A.toLength(3.2), 3)
assert.test(A.toLength("3.2"), 3)


; omit
assert.test(A.toLength("hello"), 0)
assert.test(A.toLength([]), 0)
assert.test(A.toLength({}), 0)

assert.group(".toString")
assert.label("default tests")
assert.test(A.toString(non_existant_var), "")
assert.test(A.toString(-0), "-0")
assert.test(A.toString([1, 2, 3]), "1,2,3")


; omit

assert.group(".typeOf")
assert.label("default tests")
assert.test(A.typeOf(42), "integer")
assert.test(A.typeOf(0.25), "float")
assert.test(A.typeOf("blubber"), "string")
assert.test(A.typeOf([]), "object")
assert.test(A.typeOf(undeclaredVariable), "undefined")


; omit
; fix to string if ever possible
assert.test(A.typeOf("0.25"), "float") ;

; ahk `true` is indistinguishable from `1`, etc
; assert.test(A.typeOf(true), "boolean")

assert.group(".add")
assert.label("default tests")
assert.test(A.add(6, 4), 10)


; omit
assert.test(A.add(10, -1), 9)
assert.test(A.add(-10, -10), -20)
assert.test(A.add(10, 0.01), 10.01)

assert.label("parameter mutation")
value := 10
A.add(value, 10)
assert.test(value, 10)

assert.group(".ceil")
assert.label("default tests")
assert.test(A.ceil(4.006), 5)
assert.test(A.ceil(6.004, 2), 6.01)
assert.test(A.ceil(6040, -2), 6100)


; omit
assert.test(A.ceil(4.1), 5)
assert.test(A.ceil(4.5), 5)
assert.test(A.ceil(41), 41)
assert.test(A.ceil(6.004, 2), 6.01)
assert.test(A.ceil(6.004, 1), 6.1)
assert.test(A.ceil(6040, -3), 7000)
assert.test(A.ceil(2.22, 2), 2.22)

assert.test(A.ceil(-2.22000000000000020, 2), -2.22)
assert.test(A.ceil(2.22000000000000020, 2), 2.23)

assert.group(".divide")
assert.label("default tests")
assert.test(A.divide(6, 4), 1.5)


; omit
assert.test(A.divide(10, -1), -10)
assert.test(A.divide(-10, -10), 1)
assert.test(A.divide(0, 5), 0)
assert.test(A.divide(10, 0), "")

assert.group(".floor")
assert.label("default tests")
assert.test(A.floor(4.006), 4)
assert.test(A.floor(0.046, 2), 0.04)
assert.test(A.floor(4060, -2), 4000)


; omit
assert.test(A.floor(4.1), 4)
assert.test(A.floor(4.6), 4)
assert.test(A.floor(41), 41)
assert.test(A.floor(45), 45)
assert.test(A.floor(6.004, 2), 6.00)
assert.test(A.floor(6.004, 1), 6.0)
assert.test(A.floor(6040, -3), 6000)
assert.test(A.floor(2.22, 1), 2.2)

assert.test(A.floor(-2.22000000000000020, 2), -2.22)
assert.test(A.floor(2.22000000000000020, 2), 2.22)
assert.test(A.floor(4.999), 4)

assert.group(".max")
assert.label("default tests")
assert.test(A.max([4, 2, 8, 6]), 8)
assert.test(A.max([]), "")


; omit
assert.label("associative array")
assert.test(A.max({"foo": 10, "bar": 20}), 20)
assert.test(A.max([-10, -20, -5]), -5)

assert.group(".maxBy")
assert.label("default tests")
objects := [ {"n": 4 }, { "n": 2 }, { "n": 8 }, { "n": 6 } ]

assert.test(A.maxBy(objects, func("fn_maxByFunc")), { "n": 8 })
fn_maxByFunc(o)
{
	return o.n
}

; The A.property iteratee shorthand
assert.test(A.maxBy(objects, "n"), { "n": 8 })


; omit
assert.label("default .identity argument")
assert.test(A.maxBy([0, 1, 2]), 2)

assert.test(A.maxBy(objects, func("fn_maxByNegativeFunc")), { "n": 2 })
fn_maxByNegativeFunc(o)
{
	return -o.n
}
assert.group(".mean")
assert.label("default tests")
assert.test(A.mean([4, 2, 8, 6]), 5)


; omit
assert.label("same value")
assert.test(A.mean([10, 10, 10]), 10)

assert.label("with string value")
assert.test(A.mean([10, "10", 10]), 10)

assert.label("decimals")
assert.test(A.mean([10.1, 42.2]), 26.150000)

assert.label("empty values")
assert.test(A.mean([4, 2, , 8, 6]), 4)

assert.group(".meanBy")
assert.label("default tests")
objects := [{"n": 4}, {"n": 2}, {"n": 8}, {"n": 6}]
assert.test(A.meanBy(objects, func("fn_meanByFunc")), 5)
fn_meanByFunc(o)
{
	return o.n
}

; The A.property iteratee shorthand.
assert.test(A.meanBy(objects, "n"), 5)


; omit
assert.label("default .identity argument")
assert.test(A.meanBy([0, 1, 2]), 1)

assert.group(".min")
assert.label("default tests")
assert.test(A.min([4, 2, 8, 6]), 2)
assert.test(A.min([]), "")


; omit
assert.label("associative array")
assert.test(A.min({"foo": 10, "bar": 20}), 10)

assert.label("negative numbers")
assert.test(A.min([-100, -50, 0, 10]), -100)

assert.group(".minBy")
assert.label("default tests")
objects := [ {"n": 4 }, { "n": 2 }, { "n": 8 }, { "n": 6 } ]

assert.test(A.minBy(objects, func("fn_minByFunc")), { "n": 2 })
fn_minByFunc(o)
{
	return o.n
}

; The A.property iteratee shorthand
assert.test(A.minBy(objects, "n"), { "n": 2 })


; omit
assert.label("default .identity argument")
assert.test(A.minBy([0, 1, 2], {"age": 1, "active": true}), 0)

assert.group(".multiply")
assert.label("default tests")
assert.test(A.multiply(6, 4), 24)


; omit
assert.label("negative numbers")
assert.test(A.multiply(10, -1), -10)
assert.test(A.multiply(-10, -10), 100)

assert.group(".round")
assert.label("default tests")
assert.label("without precision")
assert.test(A.round(4.006), 4)
assert.label("with precision")
assert.test(A.round(4.006, 2), 4.01)
assert.test(A.round(4060, -2), 4100)


; omit

assert.group(".subtract")
assert.label("default tests")
assert.test(A.subtract(6, 4), 2)


; omit
assert.label("negtive number")
assert.test(A.subtract(10, -1), 11)
assert.test(A.subtract(-10, -10), 0)
assert.test(A.subtract(-6, -4), -2)


assert.label("decimal")
assert.test(A.subtract(10, 0.01), 9.99)

assert.label("parameter mutation")
g_value := 10
assert.test(A.subtract(g_value, 10), 0)
assert.test(g_value, 10)

assert.group(".sum")
assert.label("default tests")
assert.test(A.sum([4, 2, 8, 6]), 20)


; omit
assert.label("associative array")
assert.test(A.sum({"key1": 4, "key2": 6}), 10)

assert.label("negtive number")
assert.test(A.sum([-4, 2, -8, 6]), -4)

assert.group(".sumBy")
assert.label("default tests")
objects := [ {"n": 4 }, { "n": 2 }, { "n": 8 }, { "n": 6 } ]

assert.test(A.sumBy(objects, func("fn_sumByFunc")), 20)
fn_sumByFunc(o)
{
	return o.n
}

; The A.property iteratee shorthand
assert.test(A.sumBy(objects, "n"), 20)


; omit
assert.label("default .identity argument")
assert.test(A.sumBy([0, 1, 2]), 3)

assert.label("negative input")
assert.test(A.sumBy(objects, func("fn_sumByNegativeFunc")), -20)
fn_sumByNegativeFunc(o)
{
    return -o.n
}

assert.group(".clamp")
assert.label("default tests")
assert.test(A.clamp(-10, -5, 5), -5)
assert.test(A.clamp(10, -5, 5), 5)


; omit
assert.test(A.clamp(0, -5, 5), 0)

assert.label("parameter mutation")
var := -10
assert.test(A.clamp(var, -5, 5), -5)
assert.test(var, -10)

value := 10
A.clamp(value, -5, 5)
assert.test(value, 10)

assert.group(".inRange")
assert.label("default tests")
assert.true(A.inRange(3, 2, 4))
assert.true(A.inRange(4, 8))
assert.false(A.inRange(4, 2))
assert.false(A.inRange(2, 2))
assert.true(A.inRange(1.2, 2))
assert.false(A.inRange(5.2, 4))
assert.true(A.inRange(-3, -2, -6))


; omit
assert.true(A.inRange(2, 2, 4))
assert.false(A.inRange(4, 2, 4))

assert.group(".random")
assert.label("default tests")


; omit
output := A.random(0, 1)
assert.false(isObject(output))

assert.label("floating point is returned")
output := A.random(0, 1, true)
assert.test(A.includes(output, "."), true)

assert.label("integer is returned")
output := A.random(0, 1)
assert.false(A.includes(output, "."))

assert.group(".at")
assert.label("default tests")
object := {"a": [{ "b": {"c": 3} }, 4]}
assert.test(A.at(object, ["a[1].b.c", "a[2]"]), [3, 4])


; omit
assert.test(A.at(object, ["a[1]", "a[2]"]), [{ "b": {"c": 3} }, 4])

assert.group(".defaults")
assert.label("default tests")
assert.test(A.defaults({"a": 1}, {"b": 2}, {"a": 3}), {"a": 1, "b": 2})


; omit
object := {"a": 1}
assert.test(A.defaults(object, {"b": 2, "c": 3}), {"a": 1, "b": 2, "c": 3})
assert.test(object, {"a": 1})
assert.test(A.defaults({"a": 1}, {"a": 2}, {"a": 3}), {"a": 1})

assert.group(".findKey")
assert.label("default tests")
users := { "barney": {"age": 36, "active": true}
, "fred": {"age": 40, "active": false}
, "pebbles": {"age": 1, "active": true} }

assert.test(A.findKey(users, func("fn_findKeyFunc")), "barney")
fn_findKeyFunc(o)
{
	return o.age < 40
}

; The A.matches iteratee shorthand.
assert.test(A.findKey(users, {"age": 1, "active": true}), "pebbles")

; The A.matchesProperty iteratee shorthand.
assert.test(A.findKey(users, ["active", false]), "fred")

; The A.property iteratee shorthand.
assert.test(A.findKey(users, "active"), "barney")


; omit
assert.label("fromindex argument")
assert.test(A.findKey(users, "active", 2), "pebbles")

assert.group(".forIn")
assert.label("default tests")
object := {"a": 1, "b": 2}
assert.test(A.forIn(object, func("fn_forInFunc")), {"a": 1, "b": 2})

fn_forInFunc(value, key) {
	; msgbox, % key
}

; omit
assert.label("no mutation")
assert.test(object, {"a": 1, "b": 2})

assert.group(".forInRight")
assert.label("default tests")
object := [1, 2, 3]
assert.test(A.forInRight(object, func("fn_forInRightFunc")), object)

fn_forInRightFunc(value, key) {
	; msgbox, % value
}

; omit
assert.label("no mutation")
assert.test(object, [1, 2, 3])

assert.group(".get")
assert.label("default tests")
object := {"a": [{ "b": {"c": 3} }]}

assert.test(A.get(object, "a[1].b.c"), 3)
assert.test(A.get(object, ["a", "1", "b", "c"]), 3)
assert.test(A.get(object, "a.b.c", "default"), "default")


; omit
assert.test(A.get(object, "a[0]"), [{ "b": {"c": 3} }])

assert.group(".has")
assert.label("default tests")
object := {"a": { "b": ""}}

assert.true(A.has(object, "a"))
assert.true(A.has(object, "a.b"))
assert.true(A.has(object, ["a", "b"]))
assert.false(A.has(object, "a.b.c"))

; omit
assert.label("no mutation")
assert.test(object, {"a": { "b": ""}})

assert.group(".invert")
assert.label("default tests")
object := {"a": 1, "b": 2, "c": 1}
assert.test(A.invert(object), {"1": "c", "2": "b"})

assert.test(A.invert({1: "a", 2: "A"}), {"a": 2})


; omit
assert.label("no mutation")
object := {"a": 1}
assert.test(A.invert(object), {"1": "a"})
assert.test(object, {"a": 1})

assert.label("empty object")
assert.test(A.invert({}), {})

assert.group(".invertBy")
assert.label("default tests")
object := {"a": 1, "b": 2, "c": 1}
assert.test(A.invertBy(object), {"1": ["a", "c"], "2":["b"]})

assert.test(A.invertBy(object, func("invertByFunc")), {"group1": ["a", "c"], "group2": ["b"]})
invertByFunc(value)
{
	return "group" value
}


; omit
assert.label("no mutation")
object := {"a": 1}
assert.test(A.invertBy(object), {1:["a"]})
assert.test(object, {"a": 1})

assert.label("blank object")
assert.test(A.invertBy({}), {})

assert.label("default .identity argument")
assert.test(A.invertBy([1, 2, 3]), {"1": [1], "2":[2], "3":[3]})

assert.group(".keys")
assert.label("default tests")
object := {"a": 1, "b": 2, "c": 3}
assert.test(A.keys(object), ["a", "b", "c"])

assert.test(A.keys("hi"), [1, 2])


; omit
assert.test(A.keys({"x": 1, "y": 2, "z": 3}), ["x", "y", "z"])

assert.group(".mapKeys")
assert.label("default tests")
assert.test(A.mapKeys({"a": 1, "b": 2}, func("fn_mapKeysFunc")), {"a+1": 1, "b+2": 2})
fn_mapKeysFunc(value, key)
{
	return key "+" value
}


; omit
; assert.test(A.mapkeys([ {"false": 0}, {"true": 1} ]), [ {0: "false"}, {1: "true"} ])

assert.label("default .identity argument")
assert.test(A.mapkeys([0, 1, 2]), {"0": 1, "1": 2, "2": 3})
assert.test(A.mapkeys([1, 2, 3]), [1, 2, 3])
assert.test(A.mapKeys({"x": 1, "y": 2, "z": 3}, func("fn_mapKeysFunc")), {"x+1": 1, "y+2": 2, "z+3": 3})

assert.group(".mapValues")
assert.label("default tests")
users := {"fred": {"user": "fred", "age": 40}
		,"pebbles": {"user": "pebbles", "age": 1}}
assert.test(A.mapValues(users, func("fn_mapValuesFunc")), {"fred": 40, "pebbles": 1})
fn_mapValuesFunc(o)
{
	return o.age
}

; The A.property iteratee shorthand.
assert.test(A.mapValues(users, "age"), {"fred": 40, "pebbles": 1})

; omit

assert.label("default .identity argument")
assert.test(A.mapValues([0, 1, 2]), {"1": 0, "2": 1, "3": 2})
assert.test(A.mapValues([1, 2, 3]), [1, 2, 3])

assert.group(".merge")
assert.label("default tests")
object := {"options": [{"option1": true}]}
other := {"options": [{"option2": false}]}
assert.test(A.merge(object, other), {"options": [{"option1": true, "option2": false}]})

object := { "a": [{ "b": 2 }, { "d": 4 }] }
other := { "a": [{ "c": 3 }, { "e": 5 }] }
assert.test(A.merge(object, other), { "a": [{ "b": "2", "c": 3 }, { "d": "4", "e": 5 }] })


; omit
obj1 := [100, "Fred", true]
obj2 := [100, "Fred", false, true]
assert.test(A.merge(obj1, obj2), [100, "Fred", false, true])

assert.group(".omit")
assert.label("default tests")
object := {"a": 1, "b": "2", "c": 3}
assert.test(A.omit(object, ["a", "c"]), {"b": "2"})


; omit
assert.test(A.omit(object, "a"), {"b": "2", "c": 3})

assert.group(".pick")
assert.label("default tests")
object := {"a": 1, "b": "2", "c": 3}
assert.test(A.pick(object, ["a", "c"]), {"a": 1, "c": 3})


; omit
assert.test(A.pick(object, "a"), {"a": 1})
assert.label("with dropped keys")
assert.test(A.pick({"a": {"b": 2}}, "a"), { "a": {"b": 2}})

assert.label("deep object")
assert.test(A.pick({"a": {"b": 2}}, "a.b"), {"a": {"b": 2}})

assert.label("deep object with dropped keys")
object := {"a": {"b": 2, "c": 3}}
assert.test(A.pick(object, "a.b"), {"a": {"b": 2}})
assert.label("mutation")
assert.test(object, {"a": {"b": 2, "c": 3}})

assert.label("complicated path with dropped keys")
object := {"a": [{"b": 2, "c": 3}], "d": 4}
assert.test(A.pick(object, "a[1].c"), {"a": [{"c": 3}]})
assert.label("mutation")
assert.test(object, {"a": [{"b": 2, "c": 3}], "d": 4})
assert.group(".pickBy")
assert.label("default tests")
object := {"a": 1, "b": "two", "c": 3}
assert.test(A.pickBy(object, A.isNumber), {"a": 1, "c": 3})


; omit
assert.label("default .identity argument")
assert.test(A.pickBy([0, 1, 2]), {"2": 1, "3": 2})

assert.group(".toPairs")
assert.label("default tests")
assert.test(A.toPairs({"a": 1, "b": 2}), [["a", 1], ["b", 2]])


; omit


assert.label("alias")
assert.test(A.entries({"a": 1, "b": 2}), [["a", 1], ["b", 2]])

assert.group(".camelCase")
assert.label("default tests")
assert.test(A.camelCase("--foo-bar--"), "fooBar")
assert.test(A.camelCase("fooBar"), "fooBar")
assert.test(A.camelCase("__FOO_BAR__"), "fooBar")


; omit
assert.test(A.camelCase("FooBar"), "fooBar")
assert.test(A.camelCase("_this_is_FOO_BAR__"), "thisIsFooBar")

assert.group(".endsWith")
assert.label("default tests")
assert.true(A.endsWith("abc", "c"))
assert.false(A.endsWith("abc", "b"))
assert.true(A.endsWith("abc", "b", 2))


; omit

assert.label("ahk `; comment detection")
assert.true(A.endsWith("String;", ";"))
assert.true(A.endsWith("String;", "ing;"))
assert.true(A.endsWith("String;", "String;"))

assert.label("fromIndex")
assert.true(A.endsWith("String;", "g", 6))

assert.group(".escape")
assert.label("default tests")
string := "fred, barney, & pebbles"
assert.test(A.escape(string), "fred, barney, &amp; pebbles")


; omit
assert.test(A.escape("&&&"), "&amp;&amp;&amp;")

assert.group(".kebabCase")
assert.label("default tests")
assert.test(A.kebabCase("Foo Bar"), "foo-bar")
assert.test(A.kebabCase("fooBar"), "foo-bar")
assert.test(A.kebabCase("--FOO_BAR--"), "foo-bar")


; omit
assert.test(A.kebabCase("  Foo-Bar--"), "foo-bar")
assert.test(A.kebabCase("foo  Bar"), "foo-bar")

assert.group(".lowerCase")
assert.label("default tests")
assert.test(A.lowerCase("--Foo-Bar--"), "foo bar")
assert.test(A.lowerCase("fooBar"), "foo bar")
assert.test(A.lowerCase("__FOO_BAR__"), "foo bar")


; omit
assert.test(A.lowerCase("  Foo-Bar--"), "foo bar")

assert.group(".lowerFirst")
assert.label("default tests")
assert.test(A.lowerFirst("Fred"), "fred")
assert.test(A.lowerFirst("FRED"), "fRED")


; omit
assert.test(A.lowerFirst("--foo-bar--"), "--foo-bar--")
assert.test(A.lowerFirst("fooBar"), "fooBar")
assert.test(A.lowerFirst("__FOO_BAR__"), "__FOO_BAR__")

assert.group(".pad")
assert.label("default tests")
assert.test(A.pad("abc", 8), "  abc   ")
assert.test(A.pad("abc", 8, "_-"), "_-abc_-_")
assert.test(A.pad("abc", 3), "abc")


; omit
assert.test(A.pad("abc", 4), "abc ")
assert.test(A.pad("abc", 9), "   abc   ")

assert.group(".padEnd")
assert.label("default tests")
assert.test(A.padEnd("abc", 6), "abc   ")
assert.test(A.padEnd("abc", 6, "_-"), "abc_-_")
assert.test(A.padEnd("abc", 3), "abc")


; omit

assert.group(".padStart")
assert.label("default tests")
assert.test(A.padStart("abc", 6), "   abc")
assert.test(A.padStart("abc", 6, "_-"), "_-_abc")
assert.test(A.padStart("abc", 3), "abc")


; omit

assert.group(".parseInt")
assert.label("default tests")
assert.test(A.parseInt("08"), 8)
assert.test(A.map(["6", "08", "10"], A.parseInt), [6, 8, 10])


; omit
assert.test(A.parseInt("0"), 0)

assert.label("decimal places")
assert.test(A.parseInt("1.0"), 1.0)
assert.test(A.parseInt("1.0001"), 1.0001)

assert.label("string representations")
assert.test(A.parseInt("10,00"), 1000)
assert.test(A.parseInt(" 10 00"), 1000)
assert.test(A.parseInt(" 10+10"), 1010)

assert.label("invalid input")
assert.test(A.parseInt(" "), "")

assert.group(".repeat")
assert.label("default tests")
assert.test(A.repeat("*", 3), "***")
assert.test(A.repeat("abc", 2), "abcabc")
assert.test(A.repeat("abc", 0), "")

assert.group(".replace")
assert.label("default tests")
assert.test(A.replace("Hi Fred", "Fred", "Barney"), "Hi Barney")
assert.test(A.replace("1234", "/(\d+)/", "numbers"), "numbers")


; omit
assert.label("blank parameters")
assert.test(A.replace("Hi Barney"), "Hi Barney")
assert.test(A.replace(), "")

assert.group(".snakeCase")
assert.label("default tests")
assert.test(A.snakeCase("Foo Bar"), "foo_bar")
assert.test(A.snakeCase("fooBar"), "foo_bar")
assert.test(A.snakeCase("--FOO-BAR--"), "foo_bar")


; omit
assert.test(A.snakeCase("  Foo-Bar--"), "foo_bar")

assert.group(".split")
assert.label("default tests")
assert.test(A.split("a-b-c", "-", 2), ["a", "b"])
assert.test(A.split("a--b-c", "/[\-]+/"), ["a", "b", "c"])


; omit
assert.test(A.split("concat.ahk", "."), ["concat", "ahk"])
assert.test(A.split("a--b-c", ","), ["a--b-c"])
assert.label("blank seperator")
assert.test(A.split("a--b-c", ""), ["a","-","-","b","-","c"])
assert.label("whitespace seperator")
assert.test(A.split("one     two", "/\s+/"), ["one", "two"])

assert.group(".startCase")
assert.label("default tests")
assert.test(A.startCase("--foo-bar--"), "Foo Bar")
assert.test(A.startCase("fooBar"), "Foo Bar")
assert.test(A.startCase("__FOO_BAR__"), "Foo Bar")

assert.group(".startsWith")
assert.label("default tests")
assert.true(A.startsWith("abc", "a"))
assert.false(A.startsWith("abc", "b"))
assert.true(A.startsWith("abc", "b", 2))
StringCaseSense, On
assert.false(A.startsWith("abc", "A"))


; omit
; set caseSensitive back to false
StringCaseSense, Off

; make sure comment detection works
assert.true(A.startsWith("; String", ";"))
assert.true(A.startsWith("; String", "; "))
assert.true(A.startsWith("; String", "; String"))

assert.group(".toLower")
assert.label("default tests")
assert.test(A.toLower("--Foo-Bar--"), "--foo-bar--")
assert.test(A.toLower("fooBar"), "foobar")
assert.test(A.toLower("__FOO_BAR__"), "__foo_bar__")

assert.group(".toUpper")
assert.label("default tests")
assert.test(A.toUpper("--foo-bar--"), "--FOO-BAR--")
assert.test(A.toUpper("fooBar"), "FOOBAR")
assert.test(A.toUpper("__foo_bar__"), "__FOO_BAR__")

assert.group(".trim")
assert.label("default tests")
assert.test(A.trim("  abc  "), "abc")
assert.test(A.trim("-_-abc-_-", "_-"), "abc")
assert.test(A.map([" foo  ", "  bar  "], A.trim), ["foo", "bar"])


; omit
assert.label("multiple types of whitespace")
assert.test(A.trim(A_space A_tab "  abc  " A_tab), "abc")
assert.label("multiple types of newline")
assert.test(A.trim("  `rabc`n  "), "abc")

assert.group(".trimEnd")
assert.label("default tests")
assert.test(A.trimEnd("  abc  "), "  abc")
assert.test(A.trimEnd("-_-abc-_-", "_-"), "-_-abc")


; omit
assert.test(A.trimEnd("filename.txt", ".txt"), "filename")
assert.test(A.trimEnd(1000.00, 0), 1000.)

assert.group(".trimStart")
assert.label("default tests")
assert.test(A.trimStart("  abc  "), "abc  ")
assert.test(A.trimStart("-_-abc-_-", "_-"), "abc-_-")

assert.group(".truncate")
assert.label("default tests")
string := "hi-diddly-ho there, neighborino"
assert.test(A.truncate(string), "hi-diddly-ho there, neighbor...")

assert.test(A.truncate(string, {"length": 24, "separator": " "}), "hi-diddly-ho there,...")

assert.test(A.truncate(string, {"length": 24, "separator": "/, /"}), "hi-diddly-ho there...")

; omit
string := "the quick red fox jumped into something"
assert.test(A.truncate(string, {"length": A.size(string) - 1, "omission":""}), "the quick red fox jumped into somethin")

assert.group(".unescape")
assert.label("default tests")
string := "fred, barney, &amp; pebbles"
assert.test(A.unescape(string), "fred, barney, & pebbles")


; omit
assert.test(A.unescape("&amp;&amp;&amp;"), "&&&")

assert.group(".upperCase")
assert.label("default tests")
assert.test(A.upperCase("--Foo-Bar--"), "FOO BAR")
assert.test(A.upperCase("fooBar"), "FOO BAR")
assert.test(A.upperCase("__FOO_BAR__"), "FOO BAR")


; omit
assert.test(A.upperCase("  Foo-Bar--"), "FOO BAR")
assert.group(".upperFirst")
assert.label("default tests")
assert.test(A.upperFirst("fred"), "Fred")
assert.test(A.upperFirst("FRED"), "FRED")


; omit
assert.test(A.upperFirst("--foo-bar--"), "--foo-bar--")
assert.test(A.upperFirst("fooBar"), "FooBar")
assert.test(A.upperFirst("__FOO_BAR__"), "__FOO_BAR__")

assert.group(".words")
assert.label("default tests")
assert.test(A.words("fred, barney, & pebbles"), ["fred", "barney", "pebbles"])

assert.test(A.words("fred, barney, & pebbles", "/[^, ]+/"), ["fred", "barney", "&", "pebbles"])


; omit
assert.test(A.words("One, and a two, and a one two three"), ["One", "and", "a", "two", "and", "a", "one", "two", "three"])
asser.label("appostroies")
assert.test(A.words("it's I'd ok. ok' k'o."), ["it's", "I'd", "ok", "ok", "k'o"])

assert.group(".conforms")
assert.label("default tests")
objects := [{"a": 2, "b": 1}
		, {"a": 1, "b": 2}]
assert.test(A.filter(objects, A.conforms({"b": func("fn_conformsFunc")})), [{"a": 1, "b": 2}])

fn_conformsFunc(n)
{
	return n > 1
}

; omit
objects := [{"a": 2, "b": "hello world"}
		, {"a": 1, "b": 2}]
assert.test(A.filter(objects, A.conforms({"b": A.isString.bind(A)})), [{"a": 2, "b": "hello world"}])

assert.group(".constant")
assert.label("default tests")
object := A.times(2, A.constant({"a": 1}))
; => [{"a": 1}, {"a": 1}]


; omit
assert.test(object, [{"a": 1}, {"a": 1}])
functor := A.constant({ "a": 1 })
assert.test(functor.call({ "a": 1 }), {"a": 1})

assert.label("string")
object := A.times(2, A.constant("string"))
assert.test(object, ["string", "string"])

assert.group(".identity")
assert.label("default tests")
object := {"a": 1}
assert.test(A.identity(object), {"a": 1})


; omit

assert.group(".matches")
assert.label("default tests")
objects := [{ "a": 1, "b": 2, "c": 3 }, { "a": 4, "b": 5, "c": 6 }]
assert.test(A.filter(objects, A.matches({ "a": 4, "c": 6 })), [{ "a": 4, "b": 5, "c": 6 }])
functor := A.matches({ "a": 4 })
assert.test(A.filter(objects, functor), [{ "a": 4, "b": 5, "c": 6 }])
assert.false(functor.call({ "a": 1 }))


; omit

assert.group(".matchesProperty")
assert.label("default tests")
objects := [{ "a": 1, "b": 2, "c": 3 }, { "a": 4, "b": 5, "c": 6 }]
assert.test(A.find(objects, A.matchesProperty("a", 4)), { "a": 4, "b": 5, "c": 6 })
assert.test(A.filter(objects, A.matchesProperty("a", 4)), [{ "a": 4, "b": 5, "c": 6 }])

objects := [{ "a": {"b": 2} }, { "a": {"b": 1} }]
assert.test(A.find(objects, A.matchesProperty(["a", "b"], 1)), { "a": {"b": 1} })

; omit
fn := A.matchesProperty("a", 1)

assert.true(fn.call({ "a": 1, "b": 2, "c": 3 }))

fn := A.matchesProperty("b", 2)
assert.true(fn.call({ "a": 1, "b": 2, "c": 3 }))
assert.false(fn.call({ "a": 1 }))
assert.false(fn.call({}))
assert.false(fn.call([]))
assert.false(fn.call(""))
assert.false(fn.call(" "))

objects := [{ "options": {"private": true} }, { "options": {"private": false} }, { "options": {"private": false} }]
assert.test(A.filter(objects, A.matchesProperty("options.private", false)), [{ "options": {"private": false} }, { "options": {"private": false} }])
assert.test(A.filter(objects, A.matchesProperty(["options", "private"], false)), [{ "options": {"private": false} }, { "options": {"private": false} }])

objects := [{ "name": "fred", "options": {"private": true} }
	, { "name": "barney", "options": {"private": false} }
	, { "name": "pebbles", "options": {"private": false} }]
assert.test(A.filter(objects, A.matchesProperty("options.private", false)), [{ "name": "barney", "options": {"private": false} }, { "name": "pebbles", "options": {"private": false} }])
assert.test(A.filter(objects, A.matchesProperty(["options", "private"], false)), [{ "name": "barney", "options": {"private": false} }, { "name": "pebbles", "options": {"private": false} }])

assert.group(".noop")
assert.label("default tests")
assert.test(A.times(2, A.stubObject), [ {}, {} ])


; omit

assert.group(".nthArg")
assert.label("default tests")
func := A.nthArg(2)
assert.test(func.call("a", "b", "c", "d"), "b")

func := A.nthArg(-2)
assert.test(func.call("a", "b", "c", "d"), "c")

; omit
assert.label("default argument")
func := A.nthArg()
assert.test(func.call("a", "b", "c", "d"), "a")
assert.group(".over")
assert.label("default tests")
func := A.over([func("min"), func("max")])
assert.test(func.call(1, 2, 3, 4), [1, 4])

func := A.over([A.isBoolean, A.isNumber])
assert.test(func.call(10), [false, true])


; omit
assert.test(func.call(1), [true, true])
assert.test(func.call("string"), [false, false])


assert.label("with other own methods")
func := A.over([A.identity, A.typeOf])
assert.test(func.call([1,2,3]), [[1,2,3], "object"])
assert.test(func.call("C"), ["C", "string"])

assert.label("default to .identity")
func := A.over()
assert.test(func.call("hello world"), ["hello world"])
func := A.over(["" , A.isNumber, A.isString])
assert.test(func.call(1), [1, true, false])

assert.label("round")
func := A.over(A.round)
assert.test(func.call(11.0001), [11])

assert.group(".print")
assert.label("default tests")
assert.test(A.print([1, 2, 3]), "1:1, 2:2, 3:3")

; omit
assert.test(A.print("object: ", [1, 2, 3]), "object: 1:1, 2:2, 3:3")
assert.test(A.print("hello ", "world ", [1, 2, 3]), "hello world 1:1, 2:2, 3:3")

assert.group(".property")
assert.label("default tests")
objects := [{ "a": {"b": 2} }, { "a": {"b": 1} }]
assert.test(A.map(objects, A.property("a.b")), [2, 1])
assert.test(A.map(objects, A.property(["a", "b"])), [2, 1])

objects := [{"name": "fred"}, {"name": "barney"}]
assert.test(A.map(objects, A.property("name")), ["fred", "barney"])


; omit
; assert.test(A.map(A.sortBy(objects, A.property(["a", "b"]))), [2, 1])
fn := A.property("a.b")
assert.test(fn.call({ "a": {"b": 2} }), "2")

fn := A.property("a")
assert.test(fn.call({ "a": 1, "b": 2 }), 1)

assert.group(".propertyOf")
assert.label("default tests")
array := [0, 1, 2]
object := {"a": array, "b": array, "c": array}
assert.test(A.map(["a[3]", "c[1]"], A.propertyOf(object)), [2, 0])

assert.test(A.map([["a", 3], ["c", 1]], A.propertyOf(object)), [2, 0])


; omit

assert.group(".range")
assert.label("default tests")
assert.test(A.range(4), [0, 1, 2, 3])

assert.test(A.range(-4), [0, -1, -2, -3])

assert.test(A.range(1, 5), [1, 2, 3, 4])

assert.test(A.range(0, 20, 5), [0, 5, 10, 15])

assert.test(A.range(0, -4, -1), [0, -1, -2, -3])

assert.test(A.range(1, 4, 0), [1, 1, 1])

assert.test(A.range(0), [])


; omit

assert.group(".stubArray")
assert.label("default tests")
assert.test(A.times(2, A.stubArray), [[], []])


; omit

assert.group(".stubFalse")
assert.label("default tests")
assert.test(A.times(2, A.stubFalse), [false, false])


; omit

assert.group(".stubObject")
assert.label("default tests")
assert.test(A.times(2, A.stubObject), [ {}, {} ])


; omit

assert.group(".stubString")
assert.label("default tests")
assert.test(A.times(2, A.stubString), ["", ""])


; omit

assert.group(".stubTrue")
assert.label("default tests")
assert.test(A.times(2, A.stubTrue), [true, true])


; omit

assert.group(".times")
assert.label("default tests")
assert.test(A.times(4, A.constant(0)), [0, 0, 0, 0])


; omit
assert.label("random array of numbers with boundFunc A.random")
boundFunc := A.random.bind(A, 99, 99, 0)
output := A.times(5, boundFunc)
assert.test(output, [99, 99, 99, 99, 99])

assert.label("random array of letters with boundFunc A.sample")
boundFunc := A.sample.bind(A, "abcdefghijklmnopqrstuvwxyz")
output := A.times(5, boundFunc)
assert.true(A.every(output, func("strLen"))) ;all strings longer than 0 chars

assert.label("default .identity argument")
assert.test(A.times(2), [1, 2])

assert.group(".toPath")
assert.label("default tests")
assert.test(A.toPath("a.b.c"), ["a", "b", "c"])
assert.test(A.toPath("a[1].b.c"), ["a", "1", "b", "c"])


; omit
assert.test(A.toPath("a"), ["a"])
assert.test(A.toPath(["a", "1", "b", "c"]), ["a", "1", "b", "c"])
assert.test(A.toPath(["a", "1", "b", "", "c"]), ["a", "1", "b", "", "c"])

assert.group(".uniqueId")
assert.label("default tests")
assert.test(A.uniqueId("contact_"), "contact_1")
assert.test(A.uniqueId(), 2)

; omit
;; Display test results in GUI
speed := QPC(0)
sleep, 200 ; allow callback tests to complete
assert.fullReport()
assert.writeResultsToFile()
msgbox, % speed
exitApp

QPC(R := 0)
{
	static P := 0, F := 0, Q := dllCall("QueryPerformanceFrequency", "Int64P", F)
	return ! dllCall("QueryPerformanceCounter", "Int64P", Q) + (R ? (P := Q) / F : (Q - P) / F)
}
