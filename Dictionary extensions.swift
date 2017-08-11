// An extension that adds a couple methods to the Dictionary data type to let you sort by values then keys, or keys then values.
// i.e. if you have a dictionary you want sorted by balue, but also want to return keys of identical value in alphabetical order.

extension Dictionary where Value: Comparable {
    var valueThenKeySorted: [(Key, Value)] {
        return sorted{ if $0.value != $1.value { return $0.value < $1.value } else { return String(describing: $0.key) < String(describing: $1.key) } }
    }
    var keyThenValueSorted: [(Key, Value)] {
        return sorted{ if $0.key != $1.key { return String(describing: $0.key) < String(describing: $1.key) } else { return $0.value < $1.value } }
    }
}
