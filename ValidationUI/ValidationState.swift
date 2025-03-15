import ValidationSDK

public enum ValidationState {
  case idle
  case validating
  case valid
  case invalid(ValidationError)
  
  public var isValid: Bool {
    if case .valid = self { return true }
    return false
  }
  
  public var error: ValidationError? {
    if case let .invalid(error) = self { return error }
    return nil
  }
}
