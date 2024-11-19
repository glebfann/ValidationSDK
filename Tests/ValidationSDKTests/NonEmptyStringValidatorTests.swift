import Testing
import ValidationSDK

@Suite
struct NonEmptyStringValidatorTests {
  private let validator = NonEmptyStringValidator()

  @Test
  func test_nonEmptyStringValidationSuccess() {
    let result = validator.validate("Non empty string")
    result.expectSuccess()
  }

  @Test
  func test_emptyStringValidationFailure() {
    let result = validator.validate("")
    result.expectError(ValidationError(message: "String is empty"))
  }
}
