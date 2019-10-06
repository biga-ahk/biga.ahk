}

class A extends biga {

}

biga_external_matches(param_matches,param_itaree) {
    for Key, Value in param_matches {
        if (param_matches[Key] != param_itaree[Key]) {
            return false
        }
    }
    return true
}
