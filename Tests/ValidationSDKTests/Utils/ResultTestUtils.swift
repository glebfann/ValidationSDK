import Testing
import ValidationSDK

extension Result<Void, ValidationError> {
  func expectSuccess() {
    switch self {
    case .success: return
    case let .failure(error):
      Issue.record(error, "Expected success, but found error")
    }
  }

  func expectError(_ expectedError: ValidationError? = nil) {
    switch self {
    case .success:
      Issue.record("Expected error, but found success")
    case let .failure(error):
      guard let expectedError else { return }
      #expect(error == expectedError)
    }
  }
}
