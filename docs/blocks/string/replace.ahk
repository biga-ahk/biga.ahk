replace(para_string := "",para_needle := "",para_replacement := "") {
    l_string := para_string
    ; RegEx
    if (l_needle := this.internal_JSRegEx(para_needle)) {
        return % RegExReplace(para_string, l_needle, para_replacement, , this.limit)
    }
    if (this.ins)
    output := StrReplace(l_string, para_needle, para_replacement, , this.limit)
    return % output
}