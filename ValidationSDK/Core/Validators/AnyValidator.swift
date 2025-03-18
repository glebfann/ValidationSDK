public struct AnyValidator<Value>: Validator {
  @usableFromInline
  internal let _isValid: (Value) -> Result<Void, ValidationError>

  public init(isValid: @escaping (Value) -> Result<Void, ValidationError>) {
    _isValid = isValid
  }

  public init<V: Validator>(_ validator: V) where V.Value == Value {
    _isValid = validator.validate
  }
  
  public init(isValid: @escaping (Value) -> Bool) {
    _isValid = { isValid($0) ? .success : .failure(.default) }
  }

  @inlinable
  public func validate(_ value: Value) -> Result<Void, ValidationError> {
    _isValid(value)
  }
}

extension Validator {
  @inlinable @inline(__always)
  public func eraseToAnyValidator() -> AnyValidator<Value> {
    AnyValidator(self)
  }
}
