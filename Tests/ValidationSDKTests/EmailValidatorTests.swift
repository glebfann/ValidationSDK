import Testing
import ValidationSDK

@Suite
struct EmailValidatorTests {
  private let validator = EmailValidator()

  @Test
  func test_validateSimpleValidEmail() {
    let email = "test@example.com"
    let result = validator.validate(email)
    result.expectSuccess()
  }

  @Test
  func test_validateComplexValidEmail() {
    let email = "user.name+tag@example.co.uk"
    let result = validator.validate(email)
    result.expectSuccess()
  }

  @Test
  func test_validateInvalidEmailWithMissingAtSymbol() {
    let email = "testexample.com"
    let result = validator.validate(email)
    result.expectError()
  }

  @Test
  func test_validateInvalidEmailWithMissingDomain() {
    let email = "test@"
    let result = validator.validate(email)
    result.expectError()
  }

  @Test
  func test_validateInvalidEmailWithMissingLocalPart() {
    let email = "@example.com"
    let result = validator.validate(email)
    result.expectError()
  }

  @Test
  func test_validateInvalidEmailWithInvalidCharacters() {
    let email = "test!@example.com"
    let result = validator.validate(email)
    result.expectError()
  }

  @Test
  func test_validateInvalidEmailWithEmptyString() {
    let email = ""
    let result = validator.validate(email)
    result.expectError()
  }

  @Test
  func test_validateInvalidEmailWithWhitespace() {
    let email = "test @example.com"
    let result = validator.validate(email)
    result.expectError()
  }

  @Test
  func test_validateInvalidEmailWithMultipleAtSymbols() {
    let email = "test@example@com"
    let result = validator.validate(email)
    result.expectError()
  }

  @Test
  func test_validateInvalidEmailWithTooShortDomainExtension() {
    let email = "test@example.c"
    let result = validator.validate(email)
    result.expectError()
  }
}
