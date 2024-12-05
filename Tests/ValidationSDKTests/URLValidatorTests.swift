import Testing
import ValidationSDK

@Suite
struct URLValidatorTests {
  private let validator = URLValidator()

  @Test
  func test_validHTTPURL() {
    let result = validator.validate("http://www.example.com")
    result.expectSuccess()
  }

  @Test
  func test_validHTTPSURL() {
    let result = validator.validate("https://www.example.com")
    result.expectSuccess()
  }

  @Test
  func test_validSchemeURL() {
    let result = validator.validate("scheme://username:password@host.com:9090/path?query=value")
    result.expectSuccess()
  }

  @Test
  func test_invalidURLNoScheme() {
    let result = validator.validate("www.example.com")
    result.expectError()
  }

  @Test
  func test_invalidURLNoHost() {
    let result = validator.validate("http:///")
    result.expectError()
  }

  @Test
  func test_invalidURL() {
    let result = validator.validate("invalid-url")
    result.expectError()
  }
}
