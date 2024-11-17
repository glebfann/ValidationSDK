public protocol Validator {
  associatedtype Value
  func validate(_ value: Value) -> Result<Void, ValidationError>
}

extension Validator {
  @discardableResult
  func validate<Tag>(_ value: Value) throws(ValidationError) -> Valid<Tag, Value> {
    switch validate(value) {
    case .success:
      return Valid(value)
    case let .failure(error):
      throw error
    }
  }
  
  func validate<Tag>(_ value: Value) -> Result<Valid<Tag, Value>, ValidationError> {
    switch validate(value) {
    case .success: .success(Valid(value))
    case let .failure(error): .failure(error)
    }
  }

  func validate(_ value: Value) -> Bool {
    switch validate(value) {
    case .success: true
    case .failure: false
    }
  }
}
