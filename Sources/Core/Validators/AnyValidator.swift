public struct AnyValidator<Value>: Validator {
  @usableFromInline
  internal let isValid: (Value) throws -> Bool
  
  init(isValid: @escaping (Value) throws -> Bool) {
    self.isValid = isValid
  }
  
  @inlinable
  public func validate(_ value: Value) -> Result<Void, ValidationError> {
    if (try? isValid(value)) == true {
      .success(())
    } else {
      .failure(.default)
    }
  }
}
