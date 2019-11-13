class biga {    ; class attributes    static throwExceptions := true    static caseSensitive := false    static limit := -1	chunk(param_array,param_size := 1) {
	    if (!IsObject(param_array)) {
	        this.internal_ThrowException()
	    }
	    l_array := []
	    param_array := this.clone(param_array)

	    ; keep working till the parameter array is empty
	    while (this.size(param_array) > 0) {
	        l_InnerArr := []
	        ; fill the Inner Array to the max size of the size parameter
	        loop, % param_size {
	            ; exit loop if there is nothing left in parameter array to work with
	            if (this.size(param_array) == 0) {
	                break
	            }
	            l_InnerArr.push(param_array.RemoveAt(1))
	        }
	    l_array.push(l_InnerArr)
	    }
	    return l_array
	}
	compact(param_array) {
	    if (!IsObject(param_array)) {
	        this.internal_ThrowException()
	    }
	    l_array := []

	    for Key, Value in param_array {
	        if (Value != "" && Value != 0 && Value != false) {
	            l_array.push(Value)
	        }
	    }
	    return l_array
	}
	concat(param_array,param_values*) {
	    if (!IsObject(param_array)) {
	        this.internal_ThrowException()
	    }
	    l_array := this.clone(param_array)
	    for i, obj in param_values {
	        if (!IsObject(obj)) {
	            ; push on any plain values
	            l_array.push(obj)
	        } else {
	            loop, % obj.MaxIndex() {
	                l_array.push(obj[A_Index])
	            }
	        }
	    }
	    return l_array
	}
	difference(param_array, param_values*) {
	    if (!IsObject(param_array)) {
	        this.internal_ThrowException()
	    }
	    l_array := this.clone(param_array)

	    ; loop all Variadic inputs
	    for i, obj in param_values {
	        loop, % obj.MaxIndex() {
	            foundIndex := this.indexOf(l_array, obj[A_Index])
	            if (foundIndex != -1) {
	                l_array.RemoveAt(foundIndex)
	            }
	        }
	    }
	    return l_array
	}
	drop(param_array,param_n:=1) {
	    if param_n is not number
	    {
	        this.internal_ThrowException()
	    }

	    if (IsObject(param_array)) {
	        l_array := this.clone(param_array)
	    }
	    if (param_array is alnum) {
	        l_array := StrSplit(param_array)
	    }

	    ; create the slice
	    loop, % param_n
	    {
	        l_array.RemoveAt(1)
	    }
	    ; return empty array if empty
	    if (l_array.Count() == 0) {
	        return []
	    }
	    return l_array
	}
	dropRight(param_array,param_n:=1) {
	    if param_n is not number 
	    {
	        this.internal_ThrowException()
	    }

	    if (IsObject(param_array)) {
	        l_array := this.clone(param_array)
	    }
	    if (param_array is alnum) {
	        l_array := StrSplit(param_array)
	    }

	    ; create the slice
	    loop, % param_n
	    {
	        l_array.RemoveAt(l_array.Count())
	    }
	    ; return empty array if empty
	    if (l_array.Count() == 0) {
	        return []
	    }
	    return l_array
	}
	findIndex(param_array,param_value,fromIndex := 1) {
	    if (!IsObject(param_array)) {
	        this.internal_ThrowException()
	    }

	    if (IsFunc(param_value)) {
	        vFunctionparam := true
	    }
	    if (IsObject(param_value) && !vFunctionparam) { ; do not convert objects that are functions
	        vSearchingobjects := true
	        param_value := this.printObj(param_value)
	    }
	    for Index, Value in param_array {
	        if (Index < fromIndex) {
	            continue
	        }
	        if (vSearchingobjects) {
	            Value := this.printObj(Value)
	        }
	        if (vFunctionparam) {
	            if (param_value.call(param_array[A_Index])) {
	                return Index + 0
	            }
	        }
	        if (this.caseSensitive ? (Value == param_value) : (Value = param_value)) {
	            return Index + 0
	        }
	    }
	    return -1 + 0
	}
	fromPairs(param_pairs) {
	    if (!IsObject(param_pairs)) {
	        this.internal_ThrowException()
	    }

	    l_obj := {}
	    for Key, Value in param_pairs {
	        l_obj[Value[1]] := Value[2]
	    }
	    return l_obj
	}
	head(param_array) {

	    return this.take(param_array)[1]
	}
	indexOf(param_array,param_value,fromIndex := 1) {
	    if (!IsObject(param_array)) {
	        this.internal_ThrowException()
	    }

	    for Index, Value in param_array {
	        if (Index < fromIndex) {
	            continue
	        }
	        if (this.caseSensitive ? (Value == param_value) : (Value = param_value)) {
	            return Index + 0
	        }
	    }
	    return -1 + 0
	}
	intersection(param_arrays*) {
	    if (!IsObject(param_arrays)) {
	        this.internal_ThrowException()
	    }

	    ; prepare data
	    tempArray := A.cloneDeep(param_arrays[1])
	    l_array := []

	    ; create the slice
	    for Key, Value in tempArray { ;for each value in first array
	        for Key2, Value2 in param_arrays { ;for each array sent to the method
	            ; search entire array for value in first array
	            if (this.indexOf(Value2, Value) != -1) {
	                found := true
	            } else {
	                found := false
	            }
	        }
	        if (found) {
	            l_array.push(Value)
	        }
	    }
	    return l_array
	}
	join(param_array,param_sepatator := ",") {
	    if (!IsObject(param_array) || IsObject(param_sepatator)) {
	        this.internal_ThrowException()
	    }
	    l_array := this.clone(param_array)
	    loop, % l_array.Count() {
	        if (A_Index == 1) {
	            l_string := "" l_array[A_Index]
	            continue
	        }
	        l_string := l_string param_sepatator l_array[A_Index]
	    }
	    return l_string
	}
	lastIndexOf(param_array,param_value,param_fromIndex := 0) {
	    if (param_fromIndex == 0) {
	        param_fromIndex := param_array.Count()
	    }
	    for Index, Value in param_array {
	        Index -= 1
	        vNegativeIndex := param_array.Count() - Index
	        if (vNegativeIndex > param_fromIndex) { ;skip search if 
	            continue
	        }
	        if (this.caseSensitive ? (param_array[vNegativeIndex] == param_value) : (param_array[vNegativeIndex] = param_value)) {
	            return vNegativeIndex + 0
	        }
	    }
	    return -1 + 0
	}
	nth(param_array,param_n:=1) {
	    if param_n is not number
	    {
	        this.internal_ThrowException()
	    }

	    if (IsObject(param_array)) {
	        l_array := this.clone(param_array)
	    }
	    if (param_array is alnum) {
	        l_array := StrSplit(param_array)
	    }
	    if (param_n == 0) {
	        param_n := 1
	    }

	    ; create the slice
	    if (l_array.Count() < param_n) { ;return "" if n is greater than the array's size
	        return ""
	    }
	    if (param_n > 0) {
	        return l_array[param_n]
	    }
	    ; return empty array if empty
	    if (l_array.Count() == 0) {
	        return ""
	    }
	    ; if called with negative n, call self with reversed array and positive number
	    l_array := this.reverse(l_array)
	    param_n := 0 - param_n
	    return this.nth(l_array, param_n)
	}
	reverse(param_collection) {
	    if (!IsObject(param_collection)) {
	        this.internal_ThrowException()
	    }
	    l_array := []
	    while (param_collection.MaxIndex() != "") {
	        l_array.push(param_collection.pop())
	    }
	    return l_array
	}
	sortedIndex(param_array,param_value) {
	    if (param_value < param_array[1]) {
	        return 1 + 0
	    }
	    loop, % param_array.Count() {
	        if (param_array[A_Index] < param_value && param_value < param_array[A_Index+1]) {
	            return A_Index + 1
	        }
	    }
	    return param_array.Count() + 1
	}
	tail(param_array) {

	    return this.drop(param_array)
	}
	take(param_array,param_n:=1) {
	    if param_n is not number 
	    {
	        this.internal_ThrowException()
	    }

	    if (IsObject(param_array)) {
	        param_array := this.clone(param_array)
	    }
	    if (param_array is alnum) {
	        param_array := StrSplit(param_array)
	    }
	    l_array := []

	    ; create the slice
	    loop, % param_n
	    {
	        ;continue if requested index is higher than param_array can account for
	        if (param_array.Count() < A_Index) {
	            continue
	        }
	        l_array.push(param_array[A_Index])
	    }
	    ; return empty array if empty
	    if (l_array.Count() == 0 || param_n == 0) {
	        return []
	    }
	    return l_array
	}
	takeRight(param_array,param_n:=1) {
	    if param_n is not number 
	    {
	        this.internal_ThrowException()
	    }

	    if (IsObject(param_array)) {
	        param_array := this.clone(param_array)
	    }
	    if (param_array is alnum) {
	        param_array := StrSplit(param_array)
	    }
	    l_array := []

	    ; create the slice
	    loop, % param_n
	    {
	        if (param_array.Count() == 0) {
	            continue
	        }
	        vValue := param_array.pop()
	        l_array.push(vValue)
	    }
	    ; return empty array if empty
	    if (l_array.Count() == 0 || param_n == 0) {
	        return []
	    }
	    return this.reverse(l_array)
	}
	uniq(param_collection) {
	    if (!IsObject(param_collection)) {
	        return false
	    }

	    ; prepare data
	    tempArray := []
	    l_array := []

	    ; create the slice
	    loop, % param_collection.Count() {
	        printedelement := this.internal_MD5(this.printObj(param_collection[A_Index]))
	        if (this.indexOf(tempArray, printedelement) == -1) {
	            tempArray.push(printedelement)
	            l_array.push(param_collection[A_Index])
	        }
	    }
	    return l_array
	}
	without(param_array, param_values*) {
	    if (!IsObject(param_array)) {
	        this.internal_ThrowException()
	    }
	    l_array := this.clone(param_array)

	    ; loop all Variadic inputs
	    for i, val in param_values {
	        while (foundindex := this.indexOf(l_array, val) != -1) {
	            l_array.RemoveAt(foundindex)
	        }
	    }
	    return l_array
	}
	zip(param_arrays*) {
	    if (!IsObject(param_arrays)) {
	        this.internal_ThrowException()
	    }
	    l_array := []

	    ; loop all Variadic inputs
	    for Key, Value in param_arrays {
	        ; for each value in the supplied set of array(s)
	        for Key2, Value2 in Value {
	            loop, % param_arrays.Count() {
	                if (Key2 == A_Index) {
	                    ; create array if not encountered yet
	                    if (!IsObject(l_array[A_Index])) {
	                        l_array[A_Index] := []
	                    }
	                    ; push values onto the array for their position in the supplied arrays
	                    l_array[A_Index].push(Value2)
	                }
	            }
	        }
	    }
	    return l_array
	}
	zipObject(param_props,param_values) {
	    if (!IsObject(param_props)) {
	        param_props := []
	    }
	    if (!IsObject(param_values)) {
	        param_values := []
	    }

	    l_obj := {}
	    for Key, Value in param_props {
	        vValue := param_values[A_Index]
	        l_obj[Value] := vValue
	    }
	    return l_obj
	}
	every(param_collection,param_predicate) {
	    if (!IsObject(param_collection)) {
	        this.internal_ThrowException()
	    }

	    ; data setup
	    l_array := []
	    short_hand := this.internal_differenciateShorthand(param_predicate, param_collection)
	    if (short_hand != false) {
	        boundFunc := this.internal_createShorthandfn(param_predicate, param_collection)
	    }
	    for Key, Value in param_collection {
	        if (!this.isUndefined(param_predicate.call(Value))) {
	            boundFunc := param_predicate.bind()
	        }
	        break
	    }

	    ; perform the action
	    for Key, Value in param_collection {
	        ; msgbox, % "value is " this.printObj(Value)
	        if (short_hand != false) {
	            if (boundFunc.call(Value, Key, param_collection) == true) {
	                continue
	            }
	            return false
	        }
	        if (param_predicate.call(Value, Key, param_collection) == true) {
	            continue
	        }
	    }
	    return true
	}
	filter(param_collection,param_predicate) {
	    if (!IsObject(param_collection)) {
	        this.internal_ThrowException()
	    }

	    ; data setup
	    shorthand := this.internal_differenciateShorthand(param_predicate, param_collection)
	    if (short_hand != false) {
	        boundFunc := this.internal_createShorthandfn(param_predicate, param_collection)
	    }
	    l_array := []

	    ; create the slice
	    for Key, Value in param_collection {
	        ; functor
	        ; predefined !functor handling (slower as it .calls blindly)
	        if (IsFunc(param_predicate)) {
	            if (param_predicate.call(Value)) {
	                l_array.push(Value)
	            }
	            continue
	        }
	        vValue := param_predicate.call(Value)
	        if (vValue) {
	            l_array.push(Value)
	            continue
	        }
	        ; shorthand
	        if (short_hand != false) {
	            if (boundFunc.call(Value)) {
	                l_array.push(Value)
	            }
	            continue
	        }
	    }
	    return l_array
	}
	find(param_collection,param_predicate,param_fromindex := 1) {
	    if (!IsObject(param_collection)) {
	        this.internal_ThrowException()
	    }

	    ; data setup
	    shorthand := this.internal_differenciateShorthand(param_predicate, param_collection)
	    if (short_hand != false) {
	        boundFunc := this.internal_createShorthandfn(param_predicate, param_collection)
	    }

	    ; perform
	    for Key, Value in param_collection {
	        if (param_fromindex > A_Index) {
	            continue
	        }
	        ; regular function
	        if (IsFunc(param_predicate)) {
	            if (param_predicate.call(Value)) {
	                return Value
	            }
	            continue
	        }
	        ; undeteriminable functor
	        if (param_predicate.call(Value)) {
	            return Value
	        }
	        ; shorthand
	        if (shorthand) {
	            if (boundFunc.call(Value)) {
	                return Value
	            }
	            continue
	        }
	    }
	}
	forEach(param_collection,param_iteratee := "baseProperty") {
	    if (!IsObject(param_collection)) {
	        this.internal_ThrowException()
	    }
	    ; check what kind of param_iteratee being worked with
	    if (!IsFunc(param_iteratee)) {
	        BoundFunc := param_iteratee.Bind(this)
	    }

	    ; prepare data
	    l_paramAmmount := param_iteratee.MaxParams
	    if (l_paramAmmount == 3) {
	        collectionClone := this.cloneDeep(param_collection)
	    }

	    ; run against every value in the collection
	    for Key, Value in param_collection {
	        if (!BoundFunc) { ; is property/string
	            ;nothing currently
	        }
	        if (l_paramAmmount == 3) {
	            if (!BoundFunc.call(Value, Key, collectionClone)) {
	                vIteratee := param_iteratee.call(Value, Key, collectionClone)
	            }
	        }
	        if (l_paramAmmount == 2) {
	            if (!BoundFunc.call(Value, Key)) {
	                vIteratee := param_iteratee.call(Value, Key)
	            }
	        }
	        if (l_paramAmmount == 1) {
	            if (!BoundFunc.call(Value)) {
	                vIteratee := param_iteratee.call(Value)
	            }
	        }
	        ; exit iteration early by explicitly returning false
	        if (vIteratee == false) {
	            return param_collection
	        }
	    }
	    return param_collection
	}
	includes(param_collection,param_value,param_fromIndex := 1) {
	    if (IsObject(param_collection)) {
	        for Key, Value in param_collection {
	            if (param_fromIndex > A_Index) {
	                continue
	            }
	            if (this.caseSensitive ? (Value == param_value) : (Value = param_value)) {
	                return true
	            }
	        }
	        return false
	    } else {
	        ; RegEx
	        if (RegEx_value := this.internal_JSRegEx(param_value)) {
	            return  RegExMatch(param_collection, RegEx_value, RE, param_fromIndex)
	        }
	        ; Normal string search
	        if (InStr(param_collection, param_value, this.caseSensitive, param_fromIndex)) {
	            return true
	        } else {
	            return false
	        }
	    }
	}
	internal_sort(param_collection, param_iteratees := "name") {
	    l_array := this.cloneDeep(param_collection)

	        for Index, obj in l_array {
	            out .= obj[param_iteratees] "+" Index "|" ; "+" allows for sort to work with just the value
	            ; out will look like:   value+index|value+index|
	        }

	        Value := l_array[l_array.minIndex(), param_iteratees]
	        if Value is number 
	            type := " N "
	        StringTrimRight, out, out, 1 ; remove trailing | 
	        Sort, out, % "D| "
	        arrStorage := []
	        loop, parse, out, |
	        arrStorage.push(l_array[SubStr(A_LoopField, InStr(A_LoopField, "+") + 1)])
	        l_array := arrStorage
	        return l_array
	}
	map(param_collection,param_iteratee:="baseProperty") {
	    if (!IsObject(param_collection)) {
	        this.internal_ThrowException()
	    }

	    l_array := []

	    ; data setup
	    short_hand := this.internal_differenciateShorthand(param_iteratee, param_collection)
	    if (short_hand == ".property") {
	        param_iteratee := this.property(param_iteratee)
	    }
	    for Key, Value in param_collection {
	        if (!this.isUndefined(param_iteratee.call(Value))) {
	            thisthing := "function"
	        }
	        break
	    }
	    l_array := []

	    ; create the array
	    for Key, Value in param_collection {
	        if (param_iteratee == "baseProperty") {
	            l_array.push(Value)
	            continue
	        }
	        if (thisthing == "function") {
	            l_array.push(param_iteratee.call(Value))
	            continue
	        }
	        if (IsFunc(param_iteratee)) { ;if calling own method
	            BoundFunc := param_iteratee.Bind(this)
	            l_array.push(BoundFunc.call(Value))
	        }
	    }
	    return l_array
	}
	partition(param_collection,param_predicate) {
	    if (!IsObject(param_collection)) {
	        this.internal_ThrowException()
	    }

	    ; data setup
	    trueArray := []
	    falseArray := []
	    short_hand := this.internal_differenciateShorthand(param_predicate, param_collection)
	    if (short_hand != false) {
	        BoundFunc := this.internal_createShorthandfn(param_predicate, param_collection)
	    }
	    for Key, Value in param_collection {
	        if (!this.isUndefined(param_predicate.call(Value))) {
	            BoundFunc := param_predicate.bind()
	        }
	        break
	    }

	    ; perform the action
	    for Key, Value in param_collection {
	        if (BoundFunc.call(Value) == true) {
	            trueArray.push(Value)
	        } else {
	            falseArray.push(Value)
	        }
	    }
	    return [trueArray, falseArray] 
	}
	sample(param_collection) {
	    if (!IsObject(param_collection)) {
	        this.internal_ThrowException()
	    }

	    vSampleArray := this.sampleSize(param_collection)
	    return vSampleArray[1]
	}
	sampleSize(param_collection,param_SampleSize := 1) {
	    if (!IsObject(param_collection)) {
	        this.internal_ThrowException()
	    }

	    if (param_SampleSize > param_collection.MaxIndex()) {
	        return  param_collection
	    }

	    l_array := []
	    tempArray := []
	    loop, %param_SampleSize%
	    {
	        Random, randomNum, 1, param_collection.MaxIndex()
	        while (this.indexOf(tempArray,randomNum) != -1) {
	            tempArray.push(randomNum)
	            Random, randomNum, 1, param_collection.MaxIndex()
	        }
	        l_array.push(param_collection[randomNum])
	        param_collection.RemoveAt(randomNum)
	    }
	    return l_array
	}
	shuffle(param_collection) {
	    if (!IsObject(param_collection)) {
	        this.internal_ThrowException()
	    }

	    l_shuffledArray := []
	    loop, % param_collection.MaxIndex() {
	        Random, randomvar, 1, param_collection.MaxIndex()
	        l_shuffledArray.push(param_collection.RemoveAt(randomvar))
	    }
	    return l_shuffledArray
	}
	size(param_collection) {
	    if (param_collection.MaxIndex() > 0) {
	        return  param_collection.MaxIndex()
	    }

	    if (param_collection.Count() > 0) {
	        return  param_collection.Count()
	    }

	    return  StrLen(param_collection)
	}
	sortBy(param_collection, param_iteratees) {
	    if (!IsObject(param_collection)) {
	        this.internal_ThrowException()
	    }

	    l_array := this.cloneDeep(param_collection)
	    ; Order := 1

	    ; create the slice
	    ; func
	    if (IsFunc(param_iteratees)) {
	        tempArray := []
	        for Key, Value in param_collection {
	            bigaIndex := param_iteratees.call(param_collection[Key])
	            param_collection[Key].bigaIndex := bigaIndex
	            tempArray.push(param_collection[Key])
	        }
	        l_array := this.sortBy(tempArray, "bigaIndex")
	        for Key, Value in l_array {
	            l_array[Key].Remove("bigaIndex")
	        }
	        return l_array
	    }

	    if (IsObject(param_iteratees)) {
	        ; sort the collection however many times is requested by the shorthand identity
	        for Key, Value in param_iteratees {
	            l_array := this.internal_sort(l_array, Value)
	        }
	    } else {
	        l_array := this.internal_sort(l_array, param_iteratees)
	    }
	    return l_array
	}
	; /--\--/--\--/--\--/--\--/--\
	; Internal functions
	; \--/--\--/--\--/--\--/--\--/

	printObj(param_obj) {
	    if (!IsObject(param_obj)) {
	        return """" param_obj """"
	    }
	    if this.internal_IsCircle(param_obj) {
	        this.internal_ThrowException()
	    }

	    for Key, Value in param_obj {
	        if Key is not Number 
	        {
	            Output .= """" . Key . """:"
	        } else {
	            Output .= Key . ":"
	        }
	        if (IsObject(Value)) {
	            Output .= "[" . this.printObj(Value) . "]"
	        } else if Value is not number
	        {
	            Output .= """" . Value . """"
	        }
	        else {
	            Output .= Value
	        }
	        Output .= ", "
	    }
	    StringTrimRight, OutPut, OutPut, 2
	    return OutPut
	}

	internal_MD5(param_string, case := 0) {
	    static MD5_DIGEST_LENGTH := 16
	    hModule := DllCall("LoadLibrary", "Str", "advapi32.dll", "Ptr")
	    , VarSetCapacity(MD5_CTX, 104, 0), DllCall("advapi32\MD5Init", "Ptr", &MD5_CTX)
	    , DllCall("advapi32\MD5Update", "Ptr", &MD5_CTX, "AStr", param_string, "UInt", StrLen(param_string))
	    , DllCall("advapi32\MD5Final", "Ptr", &MD5_CTX)
	    loop % MD5_DIGEST_LENGTH
	        o .= Format("{:02" (case ? "X" : "x") "}", NumGet(MD5_CTX, 87 + A_Index, "UChar"))
	    return o, DllCall("FreeLibrary", "Ptr", hModule)
	}

	internal_JSRegEx(param_string) {
	    if (this.startsWith(param_string, "/") && this.startsWith(param_string, "/", StrLen(param_string))) {
	        return  SubStr(param_string, 2 , StrLen(param_string) - 2)
	    }
	    return false
	}

	internal_differenciateShorthand(param_shorthand,param_objects:="") {
	    if (IsObject(param_shorthand)) {
	        for Key, in param_shorthand {
	            if Key is number
	            {
	                continue
	            } else {
	                return ".matches"
	            }
	        }
	        return ".matchesProperty"
	    }
	    if (this.size(param_shorthand) > 0) {   
	        if (IsObject(param_objects)) {
	            if (param_objects[1][param_shorthand] != "") {
	                return ".property"
	            }
	        }
	    }
	    return false
	}

	internal_createShorthandfn(param_shorthand,param_objects) {
	    short_hand := this.internal_differenciateShorthand(param_shorthand, param_objects)
	    if (short_hand == ".matches") {
	        return this.matches(param_shorthand)
	    }
	    if (short_hand == ".matchesProperty") {
	        return this.matchesProperty(param_shorthand[1], param_shorthand[2])
	    }
	    if (short_hand == ".property") {
	        return this.property(param_shorthand)
	    }
	}

	internal_ThrowException() {
	    if (this.throwExceptions == true) {
	        throw Exception("Type Error", -2)
	    }
	}
	clone(param_value) {
	    if (IsObject(param_value)) {
	        return param_value.Clone()
	    } else {
	        return param_value
	    }
	}
	cloneDeep(param_array) {
	    Objs := {}
	    Obj := param_array.Clone()
	    Objs[&param_array] := Obj ; Save this new array
	    for Key, Value in Obj {
	        if (IsObject(Value)) ; if it is a subarray
	            Obj[Key] := Objs[&Value] ; if we already know of a refrence to this array
	            ? Objs[&Value] ; Then point it to the new array
	            : this.clone(Value, Objs) ; Otherwise, clone this sub-array
	    }
	    return Obj
	}
	isEqual(param_value, param_other) {
	    if (IsObject(param_value)) {
	        param_value := this.printObj(param_value)
	        param_other := this.printObj(param_other)
	    }

	    if (this.caseSensitive ? (param_value == param_other) : (param_value = param_other)) {
	        return true
	    }
	    return false
	}
	isMatch(param_object,param_source) {
	    for Key, Value in param_source {
	        if (param_object[key] == Value) {
	            continue
	        } else {
	            return false
	        }
	    }
	    return true
	}
	isUndefined(param_value) {
	    if (param_value == "") {
	        return true
	    }
	    return false
	}
	add(param_augend,param_addend) {
	    if (IsObject(param_augend) || IsObject(param_addend)) {
	        this.internal_ThrowException()
	    }

	    ; create the return
	    param_augend += param_addend
	    return param_augend + 0
	}
	divide(param_dividend,param_divisor) {
	    if (IsObject(param_dividend) || IsObject(param_divisor)) {
	        this.internal_ThrowException()
	    }

	    ; create the return
	    vValue := param_dividend / param_divisor
	    return vValue + 0
	}
	max(param_array) {
	    if (!IsObject(param_array)) {
	        this.internal_ThrowException()
	    }

	    for Key, Value in param_array {
	        if (vMax < Value || vMax == "") {
	            vMax := Value
	        }
	    }
	    return vMax
	}
	mean(param_array) {
	    if (!IsObject(param_array)) {
	        this.internal_ThrowException()
	    }

	    vSum := 0
	    for Key, Value in param_array {
	        vSum += Value
	    }
	    return vSum / this.size(param_array)
	}
	min(param_array) {
	    if (!IsObject(param_array)) {
	        this.internal_ThrowException()
	    }

	    for Key, Value in param_array {
	        if (vMin > Value || vMin == "") {
	            vMin := Value
	        }
	    }
	    return vMin
	}
	multiply(param_multiplier,param_multiplicand) {
	    if (IsObject(param_multiplier) || IsObject(param_multiplicand)) {
	        this.internal_ThrowException()
	    }

	    ; create the return
	    vValue := param_multiplier * param_multiplicand
	    return vValue + 0
	}
	round(param_number,param_precision:=0) {
	    if (IsObject(param_number) || IsObject(param_precision)) {
	        this.internal_ThrowException()
	    }

	    ; create the return
	    return round(param_number, param_precision)
	}
	subtract(param_minuend,param_subtrahend) {
	    if (IsObject(param_minuend) || IsObject(param_subtrahend)) {
	        this.internal_ThrowException()
	    }

	    ; create the return
	    param_minuend -= param_subtrahend
	    return param_minuend + 0
	}
	sum(param_array) {
	    if (!IsObject(param_array)) {
	        this.internal_ThrowException()
	    }

	    vSum := 0
	    for Key, Value in param_array {
	        vSum += Value
	    }
	    return vSum
	}
	clamp(param_number,param_lower,param_upper) {
	    if (IsObject(param_number) || IsObject(param_lower) || IsObject(param_upper)) {
	        this.internal_ThrowException()
	    }

	    ; check the lower bound
	    if (param_number < param_lower) {
	        param_number := param_lower
	    }
	    ; check the upper bound
	    if (param_number > param_upper) {
	        param_number := param_upper
	    }
	    return param_number + 0
	}
	inRange(param_number,param_lower,param_upper) {
	    if (IsObject(param_number) || IsObject(param_lower) || IsObject(param_upper)) {
	        this.internal_ThrowException()
	    }

	    ; prepare data
	    if (param_lower > param_upper) {
	        x := param_lower
	        param_lower := param_upper
	        param_upper := x
	    }

	    ; check the bounds
	    if (param_number > param_lower && param_number < param_upper) {
	        return true
	    }
	    return false
	}
	random(param_lower:=0,param_upper:=1,param_floating:=false) {
	    if (IsObject(param_lower) || IsObject(param_upper) || IsObject(param_floating)) {
	        this.internal_ThrowException()
	    }

	    ; prepare data
	    if (param_lower > param_upper) {
	        x := param_lower
	        param_lower := param_upper
	        param_upper := x
	    }
	    if (param_floating) {
	        param_lower += 0.0
	        param_upper += 0.0
	    }

	    ; create the return
	    Random, vRandom, param_lower, param_upper
	    return vRandom
	}
	merge(param_collections*) {
	    if (!IsObject(param_collections)) {
	        this.internal_ThrowException()
	    }

	    result := param_collections[1]
	    for index, obj in param_collections {
	        if(A_Index = 1) {
	            continue 
	        }
	        result := this.internal_Merge(result, obj)
	    }
	    return result
	}

	internal_Merge(param_collection1, param_collection2) {
	    if(!IsObject(param_collection1) && !IsObject(param_collection2)) {
	        ; if only one OR the other exist, display them together. 
	        if(param_collection1 = "" || param_collection2 = "") {
	            return param_collection2 param_collection1
	        }
	        ; return only one if they are the same
	        if (param_collection1 = param_collection2)
	            return param_collection1
	        ; otherwise, return them together as an object. 
	        return [param_collection1, param_collection2]
	    }

	    ; initialize an associative array
	    combined := {}

	    for Key, Value in param_collection1 {
	        combined[Key] := this.internal_Merge(Value, param_collection2[Key])
	    }
	    for Key, Value in param_collection2 {
	        if(!combined.HasKey(Key)) {
	            combined[Key] := Value
	        }
	    }
	    return combined
	}
	pick(param_object,param_paths) {
	    if (!IsObject(param_object)) {
	        this.internal_ThrowException()
	    }

	    ; data setup
	    l_obj := {}

	    ; create the return
	    if (IsObject(param_paths)) {
	        for Key, Value in param_paths {
	            vValue := this.internal_property(Value, param_object)
	            l_obj[Value] := vValue
	        }
	    } else {
	        vValue := this.internal_property(param_paths, param_object)
	        l_obj[param_paths] := vValue
	    }
	    return  l_obj
	}
	toPairs(param_object) {
	    if (!IsObject(param_object)) {
	        this.internal_ThrowException()
	    }

	    l_array := []
	    for Key, Value in param_object {
	        l_array.push([Key, Value])
	    }
	    return l_array
	}
	escape(param_string:="") {
	    if (IsObject(param_string)) {
	        this.internal_ThrowException()
	    }

	    ; prepare data
	    HTMLmap := [["&","&amp;"], ["<","&lt;"], [">","&gt;"], ["""","&quot;"], ["'","&#39;"]]

	    for Key, Value in HTMLmap {
	        element := Value
	        param_string := StrReplace(param_string, element.1, element.2, , -1)
	    }
	    return param_string
	}
	parseInt(param_string:="0") {

	    param_string := this.trimStart(param_string, "0 -_")
	    return  param_string + 0
	}
	repeat(param_string,param_number:=1) {
	    if (IsObject(param_string)) {
	        this.internal_ThrowException()
	    }

	    if (param_number == 0) {
	        return ""
	    }
	    return StrReplace(Format("{:0" param_number "}", 0), "0", param_string)
	}
	replace(param_string := "",param_needle := "",param_replacement := "") {
	    l_string := param_string
	    ; RegEx
	    if (l_needle := this.internal_JSRegEx(param_needle)) {
	        return  RegExReplace(param_string, l_needle, param_replacement, , this.limit)
	    }
	    output := StrReplace(l_string, param_needle, param_replacement, , this.limit)
	    return output
	}
	split(param_string := "",param_separator := ",", param_limit := 0) {
	    if (IsObject(param_string) || IsObject(param_string) || IsObject(param_limit)) {
	        this.internal_ThrowException()
	    }
	    ; regex
	    if (this.internal_JSRegEx(param_separator)) {
	        param_string := this.replace(param_string, param_separator, ",")
	        param_separator := ","
	    }

	    oSplitArray := StrSplit(param_string, param_separator)
	    if (!param_limit) {
	        return oSplitArray
	    } else {
	        oReducedArray := []
	        loop, % param_limit {
	            if (A_Index <= oSplitArray.MaxIndex()) {
	                oReducedArray.push(oSplitArray[A_Index])
	            }
	        }
	    }
	    return oReducedArray
	}
	startCase(param_string := "") {
	    l_string := this.replace(param_string, "/(\W)/", " ")
	    l_string := this.replace(l_string, "/([\_])/", " ")

	    ; add space before each capitalized character
	    RegExMatch(l_string, "O)([A-Z])", RE_Match)
	    if (RE_Match.Count()) {
	        loop, % RE_Match.Count() {
	            l_string := % SubStr(l_string, 1, RE_Match.Pos(A_Index) - 1) " " SubStr(l_string, RE_Match.Pos(A_Index))
	        }
	    }
	    ; Split the string into array and Titlecase each element in the array
	    l_array := StrSplit(l_string, " ")
	    loop, % l_array.MaxIndex() {
	        x_string := l_array[A_Index]
	        StringUpper, x_string, x_string, T
	        l_array[A_Index] := x_string
	    }
	    ; join the string back together from Titlecased array elements
	    l_string := this.join(l_array, " ")
	    l_string := this.trim(l_string)
	    return l_string
	}
	startsWith(param_string, param_needle, param_fromIndex := 1) {
	    l_startString := SubStr(param_string, param_fromIndex, StrLen(param_needle))
	    ; check if substring matches
	    if (this.caseSensitive ? (l_startString == param_needle) : (l_startString = param_needle)) {
	        return true
	    }
	    return false
	}
	toLower(param_string) {
	    if (IsObject(param_string)) {
	        this.internal_ThrowException()
	    }
	    StringLower, OutputVar, param_string
	    return  OutputVar
	}
	toUpper(param_string) {
	    StringUpper, OutputVar, param_string
	    return  OutputVar
	}
	trim(param_string,param_chars := " ") {
	    if (param_chars = " ") {
	        l_string := this.trimStart(param_string, param_chars)
	        return  this.trimEnd(l_string, param_chars)
	    } else {
	        l_string := param_string
	        l_removechars := "\" this.join(StrSplit(param_chars, ""), "\")

	        ; replace starting characters
	        l_string := this.trimStart(l_string, param_chars)
	        ; replace ending characters
	        l_string := this.trimEnd(l_string, param_chars)
	        return l_string
	    }
	}
	trimEnd(param_string, param_chars := " ") {
	    if (param_chars = " ") {
	        l_string := param_string
	        return  regexreplace(l_string, "(\s+)$") ;trim ending whitespace
	    } else {
	        l_string := param_string
	        l_removechars := "\" this.join(StrSplit(param_chars, ""), "\")

	        ; replace ending characters
	        l_string := this.replace(l_string, "/([" l_removechars "]+)$/", "")
	        return l_string
	    }
	}
	trimStart(param_string,param_chars := " ") {
	    if (param_chars = " ") {
	        return  regexreplace(param_string, "^(\s+)") ;trim beginning whitespace
	    } else {
	        l_string := param_string
	        l_removechars := "\" this.join(StrSplit(param_chars, ""), "\")

	        ; replace starting characters
	        l_string := this.replace(l_string, "/^([" l_removechars "]+)/", "")
	        return l_string
	    }
	}
	truncate(param_string,param_options:="") {
	    if (IsObject(param_string)) {
	        this.internal_ThrowException()
	    }

	    ; prepare default options object
	    if (!IsObject(param_options)) {
	        param_options := {}
	        param_options.length := 30
	    }
	    if (!param_options.omission) {
	        param_options.omission := "..."
	    }

	    ; check that length is even worth working on
	    if (StrLen(param_string) + StrLen(param_options.omission) < param_options.length && !param_options.separator) {
	        return param_string
	    }

	    l_array := StrSplit(param_string, "")
	    l_string := ""
	    ; cut length of the string by character count + the omission's length
	    if (param_options.length) {
	        loop, % l_array.MaxIndex() {
	            if (A_Index > param_options.length - StrLen(param_options.omission)) {
	                l_string := l_string param_options.omission
	                break
	            }
	            l_string := l_string l_array[A_Index]
	        }
	    }

	    ; separator
	    if (this.internal_JSRegEx(param_options.separator)) {
	        param_options.separator := this.internal_JSRegEx(param_options.separator)
	    }
	    if (param_options.separator) {
	        return  RegexReplace(l_string, "^(.{1," param_options.length "})" param_options.separator ".*$", "$1") param_options.omission

	    }
	    return l_string
	}
	unescape(param_string:="") {
	    if (IsObject(param_string)) {
	        this.internal_ThrowException()
	    }

	    ; prepare data
	    HTMLmap := [["&","&amp;"], ["<","&lt;"], [">","&gt;"], ["""","&quot;"], ["'","&#39;"]]

	    for Key, Value in HTMLmap {
	        element := Value
	        param_string := StrReplace(param_string, element.2, element.1, , -1)
	    }
	    return param_string
	}
	words(param_string,param_pattern:="/[^\W]+/") {
	    if (IsObject(param_string) || IsObject(param_pattern)) {
	        this.internal_ThrowException()
	    }

	    l_string := param_string
	    l_array := []
	    if (l_needle := this.internal_JSRegEx(param_pattern)) {
	        param_pattern := l_needle

	    }
	    l_needle := "O)" param_pattern
	    while(RegExMatch(l_string, l_needle, RE_Match)) {
	        tempString := RE_Match.Value()
	        l_array.push(tempString)
	        l_string := SubStr(l_string, RE_Match.Pos()+RE_Match.Len())
	    }
	    return l_array
	}
	matches(param_source) {
	    if (!IsObject(param_source)) {
	        this.internal_ThrowException()
	    }

	    BoundFunc := ObjBindMethod(this, "internal_matches", param_source)
	    return BoundFunc
	}

	internal_matches(param_matches,param_itaree) {
	    for Key, Value in param_matches {
	        if (this.caseSensitive ? (param_matches[Key] !== param_itaree[Key]) : (param_matches[Key] != param_itaree[Key])) {
	            return false
	        }
	    }
	    return true
	}
	matchesProperty(param_path,param_srcValue) {
	    if (IsObject(param_srcValue)) {
	        this.internal_ThrowException()
	    }

	    ; create the property fn
	    fnProperty := this.property(param_path)
	    ; create the fn
	    boundFunc := ObjBindMethod(this, "internal_matchesProperty", fnProperty, param_srcValue)
	    return boundFunc
	}

	internal_matchesProperty(param_property,param_matchvalue,param_itaree) {
	    itareeValue := param_property.call(param_itaree)
	    ; msgbox, % "comparing " this.printObj(param_matchvalue) " to " this.printObj(itareeValue) " from(" this.printObj(param_itaree) ")"
	    if (!this.isUndefined(itareeValue)) {
	        if (this.caseSensitive ? (itareeValue == param_matchvalue) : (itareeValue = param_matchvalue)) {
	            return true
	        }
	    }    
	    return false
	}
	property(param_source) {
	    if (IsObject(param_srcValue)) {
	        this.internal_ThrowException()
	    }

	    ; prepare data
	    if (this.includes(param_source, ".")) {
	        param_source := this.split(param_source, ".")
	    }

	    ; create the fn
	    if (IsObject(param_source)) {
	        keyArray := []
	        for Key, Value in param_source {
	            keyArray.push(Value) 
	        }
	        BoundFunc := ObjBindMethod(this, "internal_property", keyArray)
	        return BoundFunc
	    } else {
	        BoundFunc := ObjBindMethod(this, "internal_property", param_source)
	    return BoundFunc
	    }
	}

	internal_property(param_property,param_itaree) {
	    if (IsObject(param_property)) {
	        for Key, Value in param_property {
	            if (param_property.Count() == 1) {
	                ; msgbox, % "dove deep and found: " ObjRawGet(param_itaree, Value)
	                return  ObjRawGet(param_itaree, Value)
	            } else if (param_itaree.hasKey(Value)){
	                rvalue := this.internal_property(this.tail(param_property), param_itaree[Value])
	            }
	        }
	        return rvalue
	    }
	    return  param_itaree[param_property]
	}
}class A extends biga {}