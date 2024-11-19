import Testing
import ValidationSDK

@Suite
struct RegexValidatorTests {
  private let digitsValidator = RegexValidator(pattern: "^\\d+$")
  private let exactLengthValidator = RegexValidator(pattern: "^.{3}$")
  private let emptyStringValidator = RegexValidator(pattern: "^$")

  @Test
  func test_failsOnInvalidPattern() {
    let validator = RegexValidator(pattern: "[")
    let result = validator.validate("test")
    result.expectError(ValidationError(message: "Invalid regex pattern"))
  }

  @Test
  func test_matchesDigitsOnly() {
    let result = digitsValidator.validate("123")
    result.expectSuccess()
  }

  @Test
  func test_failsOnNonDigits() {
    let result = digitsValidator.validate("abc")
    result.expectError(validationFailedError)
  }

  @Test
  func test_matchesExactLength() {
    let result = exactLengthValidator.validate("abc")
    result.expectSuccess()
  }

  @Test
  func test_failsOnWrongLength() {
    let result = exactLengthValidator.validate("abcd")
    result.expectError(validationFailedError)
  }

  @Test
  func test_matchesEmptyString() {
    let result = emptyStringValidator.validate("")
    result.expectSuccess()
  }

  @Test
  func test_failsOnNonEmptyString() {
    let result = emptyStringValidator.validate("1")
    result.expectError(validationFailedError)
  }
}

private let validationFailedError = ValidationError(message: "Regex validation failed")
