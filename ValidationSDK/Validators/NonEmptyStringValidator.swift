public struct NonEmptyStringValidator: Validator {
  public init() {}
  public func validate(_ value: String) -> Result<Void, ValidationError> {
    if value.isEmpty {
      .failure(.emptyString)
    } else {
      .success
    }
  }
}

extension Validator {
  public static var nonEmptyString: any Validator { NonEmptyStringValidator() }
}

extension ValidationError {
  fileprivate static let emptyString = ValidationError(message: "String is empty")
}
