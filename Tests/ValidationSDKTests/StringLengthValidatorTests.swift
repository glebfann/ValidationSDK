import Testing
import ValidationSDK

@Suite
struct StringLengthValidatorTests {
  private let validator = StringLengthValidator(minLength: 2, maxLength: 5)
  private let defaultValidator = StringLengthValidator()

  @Test
  func test_validStringLength() {
    let result = validator.validate("abc")
    result.expectSuccess()
  }

  @Test
  func test_stringTooShort() {
    let result = validator.validate("a")
    result.expectError(shortLengthError)
  }

  @Test
  func test_stringTooLong() {
    let result = validator.validate("abcdef")
    result.expectError(longLengthError)
  }

  @Test
  func test_minimumLengthBoundary() {
    let result = validator.validate("ab")
    result.expectSuccess()
  }

  @Test
  func test_maximumLengthBoundary() {
    let result = validator.validate("abcde")
    result.expectSuccess()
  }

  @Test
  func test_emptyStringWithDefaultValues() {
    let result = defaultValidator.validate("")
    result.expectSuccess()
  }

  @Test
  func test_someStringWithDefaultValues() {
    let result = defaultValidator.validate("abc")
    result.expectSuccess()
  }
}

private let shortLengthError = ValidationError(message: "Validation failed: short length")
private let longLengthError = ValidationError(message: "Validation failed: long length")
