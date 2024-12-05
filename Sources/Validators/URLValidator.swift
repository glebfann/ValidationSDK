import Foundation

public struct URLValidator: Validator {
  public init() {}
  public func validate(_ value: String) -> Result<Void, ValidationError> {
    guard let url = URL(string: value), url.scheme != nil, url.host != nil else {
      return .failure(.invalidURL)
    }
    return .success
  }
}

public extension ValidationError {
  fileprivate static let invalidURL = ValidationError(message: "Invalid URL")
}
