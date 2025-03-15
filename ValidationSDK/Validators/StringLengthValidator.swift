public struct StringLengthValidator: Validator {
  private let minLength: Int
  private let maxLength: Int

  public init(minLength: Int = 0, maxLength: Int = Int.max) {
    self.minLength = minLength
    self.maxLength = maxLength
  }

  public func validate(_ value: String) -> Result<Void, ValidationError> {
    let length = value.count
    if length < minLength {
      return .failure(.shortLength)
    }
    if length > maxLength {
      return .failure(.longLength)
    }
    return .success
  }
}

extension ValidationError {
  fileprivate static let shortLength = ValidationError(message: "Validation failed: short length")
  fileprivate static let longLength = ValidationError(message: "Validation failed: long length")
}
