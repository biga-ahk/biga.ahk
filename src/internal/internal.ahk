; /--\--/--\--/--\--/--\--/--\
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
    if param_shorthand is alnum
    {   
        if (IsObject(param_objects)) {
            if (param_objects[1][param_shorthand] != "") {
                return ".property"
            }
        }
    }
    return false
}

internal_ThrowException() {
    if (this.throwExceptions == true) {
        throw Exception("Type Error", -2)
    }
}

; tests
assert.test(A.internal_JSRegEx("/RegEx(capture)/"),"RegEx(capture)")

; omit
