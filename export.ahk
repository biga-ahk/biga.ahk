class biga {

	__New() {
        this.caseSensitive := false
        this.limit := -1
        this.throwExceptions := true
	}

	chunk(param_array,param_size := 1) {
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
	findIndex(param_array,param_value,fromIndex := 1) {
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
	            if (param_value.Call(param_array[A_Index])) {
	                return % Index + 0
	            }
	        }
	        if (this.caseSensitive ? (Value == param_value) : (Value = param_value)) {
	            return % Index + 0
	        }
	    }
	    return % -1 + 0
	}
	indexOf(param_array,param_value,fromIndex := 1) {
	    for Index, Value in param_array {
	        if (Index < fromIndex) {
	            continue
	        }
	        if (this.caseSensitive ? (Value == param_value) : (Value = param_value)) {
	            return % Index + 0
	        }
	    }
	    return % -1 + 0
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
	            return % vNegativeIndex + 0
	        }
	    }
	    return % -1 + 0
	}
	reverse(param_collection) {
	    if (!IsObject(param_collection)) {
	        this.internal_ThrowException()
	    }
	    l_array := []
	    while (param_collection.MaxIndex() != "") {
	        l_array.push(param_collection.pop())
	    }
	    return % l_array
	}
	sortedIndex(param_array,param_value) {
	    if (param_value < param_array[1]) {
	        return % 1 + 0
	    }
	    loop, % param_array.Count() {
	        if (param_array[A_Index] < param_value && param_value < param_array[A_Index+1]) {
	            return % A_Index + 1
	        }
	    }
	    return % param_array.Count() + 1
	}
	uniq(param_collection) {
	    if (!IsObject(param_collection)) {
	        return false
	    }
	    temp_Array := []
	    l_array := []
	    loop, % param_collection.Count() {
	        printedelement := this.internal_MD5(this.printObj(param_collection[A_Index]))
	        if (this.indexOf(temp_Array, printedelement) == -1) {
	            temp_Array.push(printedelement)
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
	filter(param_collection,param_func) {
	    l_array := []
	    loop, % param_collection.MaxIndex() {
	        if (param_func is string) {
	            if (param_collection[A_Index][param_func]) {
	                l_array.push(param_collection[A_Index])
	            }
	        }
	        if (IsFunc(param_func)) {
	            if (%param_func%(param_collection[A_Index])) {
	                l_array.push(param_collection[A_Index])
	            }
	        }

	    }
	    return l_array
	}
	find(param_collection,param_iteratee,param_fromindex := 1) {
	    loop, % param_collection.MaxIndex() {
	        if (param_fromindex > A_Index) {
	            continue
	        }
	        ; A.property handling
	        if (param_iteratee is string) {
	            if (param_collection[A_Index][param_iteratee]) {
	                return param_collection[A_Index]
	            }
	        }
	        if (IsFunc(param_iteratee)) {
	            if (%param_iteratee%(param_collection[A_Index])) {
	                return param_collection[A_Index]
	            }
	        }
	        ; A.matches handling
	        if (param_iteratee.Count() > 0) {

	        }
	    }
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
	            return % RegExMatch(param_collection, RegEx_value, RE, param_fromIndex)
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
	        arrStorage.insert(l_array[SubStr(A_LoopField, InStr(A_LoopField, "+") + 1)])
	        l_array := arrStorage
	        return l_array
	}
	map(param_collection,param_iteratee := "baseProperty") {
	    if (!IsObject(param_collection)) {
	        this.internal_ThrowException()
	    }
	    l_array := []
	    ; check what kind of param_iteratee being worked with
	    if (IsFunc(param_iteratee)) {
	        BoundFunc := param_iteratee.Bind(this)
	    } else {
	        BoundFunc := false
	    }

	    ; run against every value in the collection
	    for Key, Value in param_collection {
	        if (!BoundFunc) { ; is property/string
	            if (param_iteratee == "baseProperty") {
	                l_array.push(Value)
	                continue
	            }
	            vValue := param_collection[A_Index][param_iteratee]
	            l_array.push(vValue)
	            continue
	        }
	        vValue := BoundFunc.Call(Value)
	        if (vValue) {
	            l_array.push(vValue)
	        } else {
	            l_array.push(param_iteratee.Call(Value))
	        }
	    }
	    return l_array
	}
	sample(param_collection) {
	    vSampleArray := this.sampleSize(param_collection)
	    return vSampleArray[1]
	}
	sampleSize(param_collection,param_SampleSize := 1) {
	    if (!IsObject(param_collection)) {
	        return false
	    }
	    if (param_SampleSize > param_collection.MaxIndex()) {
	        return % param_collection
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
	        return % param_collection.MaxIndex()
	    }

	    if (param_collection.Count() > 0) {
	        return % param_collection.Count()
	    }

	    return % StrLen(param_collection)
	}
	sortBy(param_collection, param_iteratees) {
	    l_array := this.cloneDeep(param_collection)
	    Order := 1

	    if (IsObject(param_iteratees)) {
	        ; sort the collection however many times is requested by the shorthand identity
	        for Key, Value in param_iteratees {
	            l_array := this.internal_sort(l_array, Value)
	        }
	    } else {
	        l_array := this.internal_sort(l_array, param_iteratees)
	    }

	    ; if (IsFunc(param_iteratees)) {


	    return l_array
	}
	; biga_matchesfunction(param_boundarg, param_iteratee) {
	;     a := new biga()

	;     for Key, Value in param_iteratee {

	;     }
	; }

	; 	; /--\--/--\--/--\--/--\--/--\
	; Internal functions
	; \--/--\--/--\--/--\--/--\--/

	printObj(param_obj) {
	    if (!IsObject(param_obj)) {
	        return param_obj
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
	        } else if (Value is not number) {
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

	internal_IsCircle(param_obj, param_objs=0) {
	    if (!param_objs) {
	        param_objs := {}
	    }
	    for Key, Value in param_obj {
	        if (IsObject(Value)&&(param_objs[&Value]||this.internal_IsCircle(Value,(param_objs,param_objs[&Value]:=1)))) {
	            return true
	        }
	    }
	    return false
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
	        return % SubStr(param_string, 2 , StrLen(param_string) - 2)
	    }
	    return false
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
	    if (!param_value || param_value == "") {
	        return true
	    }
	    return false
	}
	merge(param_collections*) {
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
	parseInt(param_string) {
	    param_string := this.trimStart(param_string,"0 -_")
	    return % param_string + 0
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
	        return % RegExReplace(param_string, l_needle, param_replacement, , this.limit)
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
	    l_string := this.replace(param_string,"/(\W)/"," ")
	    l_string := this.replace(l_string,"/([\_])/"," ")

	    ; add space before each capitalized character
	    RegExMatch(l_string, "O)([A-Z])", RE_Match)
	    if (RE_Match.Count()) {
	        loop, % RE_Match.Count() {
	            l_string := % SubStr(l_string,1,RE_Match.Pos(A_Index) - 1) " " SubStr(l_string,RE_Match.Pos(A_Index))
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
	    l_string := this.join(l_array," ")
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
	    return % OutputVar
	}
	toUpper(param_string) {
	    StringUpper, OutputVar, param_string
	    return % OutputVar
	}
	trim(param_string,param_chars := " ") {
	    if (param_chars = " ") {
	        l_string := this.trimStart(param_string, param_chars)
	        return % this.trimEnd(l_string, param_chars)
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
	        return % regexreplace(l_string, "(\s+)$") ;trim ending whitespace
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
	        return % regexreplace(param_string, "^(\s+)") ;trim beginning whitespace
	    } else {
	        l_string := param_string
	        l_removechars := "\" this.join(StrSplit(param_chars, ""), "\")

	        ; replace starting characters
	        l_string := this.replace(l_string, "/^([" l_removechars "]+)/", "")
	        return l_string
	    }
	}
	truncate(param_string, param_options := "") {
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
	        return % RegexReplace(l_string, "^(.{1," param_options.length "})" param_options.separator ".*$", "$1") param_options.omission

	    }
	    return l_string
	}
	words(param_string,param_pattern:="/[^\W]+/") {
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
}
