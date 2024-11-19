import Testing
import ValidationSDK

@Suite
struct RegexValidatorTests {
  private let digitsValidator = RegexValidator(pattern: "^\\d+$")
  private let exactLengthValidator = RegexValidator(pattern: "^.{3}$")
  private let emptyStringValidator = RegexValidator(pattern: "^$")

  @Test
  func test_FailsOnInvalidPattern() {
    let validator = RegexValidator(pattern: "[")
    let result = validator.validate("test")
    result.expectError(ValidationError(message: "Invalid regex pattern"))
  }

  @Test
  func test_MatchesDigitsOnly() {
    let result = digitsValidator.validate("123")
    result.expectSuccess()
  }

  @Test
  func test_FailsOnNonDigits() {
    let result = digitsValidator.validate("abc")
    result.expectError(validationFailedError)
  }

  @Test
  func test_MatchesExactLength() {
    let result = exactLengthValidator.validate("abc")
    result.expectSuccess()
  }

  @Test
  func test_FailsOnWrongLength() {
    let result = exactLengthValidator.validate("abcd")
    result.expectError(validationFailedError)
  }

  @Test
  func test_MatchesEmptyString() {
    let result = emptyStringValidator.validate("")
    result.expectSuccess()
  }

  @Test
  func test_FailsOnNonEmptyString() {
    let result = emptyStringValidator.validate("1")
    result.expectError(validationFailedError)
  }
}

private let validationFailedError = ValidationError(message: "Regex validation failed")
