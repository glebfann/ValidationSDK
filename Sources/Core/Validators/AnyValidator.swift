public struct AnyValidator<Value>: Validator {
  @usableFromInline
  internal let _isValid: (Value) throws -> Bool

  public init(isValid: @escaping (Value) throws -> Bool) {
    _isValid = isValid
  }

  public init<V: Validator>(_ validator: V) where V.Value == Value {
    _isValid = validator.validate
  }

  @inlinable
  public func validate(_ value: Value) -> Result<Void, ValidationError> {
    if (try? _isValid(value)) == true {
      .success(())
    } else {
      // TODO: specialize error
      .failure(.default)
    }
  }
}

extension Validator {
  @inlinable @inline(__always)
  public func eraseToAnyValidator() -> AnyValidator<Value> {
    AnyValidator(self)
  }
}
