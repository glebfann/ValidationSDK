import Foundation

public struct RegexValidator: Validator {
  private let pattern: String

  public init(pattern: String) {
    self.pattern = pattern
  }

  public func validate(_ value: String) -> Result<Void, ValidationError> {
    guard let regex = try? NSRegularExpression(pattern: pattern) else {
      return .failure(.invalidRegexPattern)
    }

    let range = NSRange(location: 0, length: value.utf16.count)
    let matches = regex.matches(in: value, range: range)

    if matches.isEmpty {
      return .failure(.regexValidationFailed)
    }

    return .success
  }
}

extension ValidationError {
  fileprivate static let invalidRegexPattern = ValidationError(message: "Invalid regex pattern")
  fileprivate static let regexValidationFailed = ValidationError(message: "Regex validation failed")
}
