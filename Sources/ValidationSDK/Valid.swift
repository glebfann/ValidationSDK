public struct Valid<Tag, Value> {
    public let value: Value

    @usableFromInline
    internal init(_ value: Value) {
        self.value = value
    }
}
