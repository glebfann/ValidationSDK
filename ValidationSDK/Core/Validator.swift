public protocol Validator {
  associatedtype Value
  func validate(_ value: Value) -> Result<Void, ValidationError>
}

extension Validator {
  public func validate<Tag>(
    _ value: Value,
    tag: Tag.Type
  ) -> Result<Valid<Tag, Value>, ValidationError> {
    switch validate(value) {
    case .success: .success(Valid<Tag, Value>(value))
    case let .failure(error): .failure(error)
    }
  }

  public func validate(_ value: Value) -> Bool {
    switch validate(value) {
    case .success: true
    case .failure: false
    }
  }

  @_disfavoredOverload
  @discardableResult
  public func validate<Tag>(
    _ value: Value,
    tag: Tag.Type
  ) throws(ValidationError) -> Valid<Tag, Value> {
    switch validate(value) {
    case .success:
      return Valid<Tag, Value>(value)
    case let .failure(error):
      throw error
    }
  }
}
