public struct CompositeValidator<Value>: Validator {
  private let validators: [AnyValidator<Value>]
  
  public init<V: Validator>(validators: [V]) where V.Value == Value {
    self.validators = validators.map { AnyValidator(isValid: $0.validate) }
  }
  
  public func validate(_ value: Value) -> Result<Void, ValidationError> {
    for validator in validators {
      switch validator.validate(value) {
      case .success: continue
      case let .failure(error): return .failure(error)
      }
    }
    return .success(())
  }
}
