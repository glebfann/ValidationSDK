public struct Valid<Tag, Value> {
  public let value: Value
  
  @usableFromInline
  internal init(_ value: Value) {
    self.value = value
  }
}

extension Valid: CustomStringConvertible {
  public var description: String {
    String(describing: value)
  }
}
