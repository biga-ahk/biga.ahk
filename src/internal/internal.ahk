    ; /--\--/--\--/--\--/--\--/--\
    ; Internal functions
    ; \--/--\--/--\--/--\--/--\--/

    indexOf(param_array,param_searchTerm) {
        for index, value in param_array {
            if (this.caseSensitive ? (value == param_searchTerm) : (value = param_searchTerm)) {
                return index
            }
        }
        return -1
    }


    printObj(param_obj) {
        if (!IsObject(param_obj)) {
            return param_obj
        }
        if this.internal_IsCircle(param_obj) {
            throw { error: "Type Error", file: A_LineFile, line: A_LineNumber }
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
        Return OutPut
    }


    internal_IsCircle(param_obj, param_objs=0) {
        if (!param_objs) {
            param_objs := {}
        }
        for Key, Val in param_obj
        {
            if (IsObject(Val)&&(param_objs[&Val]||this.internal_IsCircle(Val,(param_objs,param_objs[&Val]:=1)))) {
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
        if (this.startsWith(param_string,"/") && this.startsWith(param_string,"/"),StrLen(param_string)) {
            return % SubStr(param_string, 2 , StrLen(param_string) - 2)
        }
        return false
    }

; tests
