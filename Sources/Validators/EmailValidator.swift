public struct EmailValidator: Validator {
  private let emailPattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
  private let regexValidator: AnyValidator<String>

  public init() {
    regexValidator = RegexValidator(pattern: emailPattern)
      .eraseToAnyValidator()
  }

  public func validate(_ value: String) -> Result<Void, ValidationError> {
    switch regexValidator.validate(value) {
    case .success: .success
    case .failure: .failure(.invalidEmail)
    }
  }
}

extension ValidationError {
  fileprivate static let invalidEmail = ValidationError(message: "String is not email")
}
