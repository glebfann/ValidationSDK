import Testing
import XCTest
import Foundation
import ValidationSDK

@Suite
final class DateRangeValidatorTests {
  private let minDate = Date(timeIntervalSince1970: 86400) // 1970-01-02
  private let maxDate = Date(timeIntervalSince1970: 31536000) // 1971-01-01
  private lazy var validator = DateRangeValidator(minDate: minDate, maxDate: maxDate)

  @Test
  func test_validateDate_withinRange_returnsSuccess() {
    let testDate = Date(timeIntervalSince1970: 15768000) // 1970-07-02
    let result = validator.validate(testDate)
    result.expectSuccess()
  }

  @Test
  func test_validateDate_equalToMinDate_returnsSuccess() {
    let result = validator.validate(minDate)
    result.expectSuccess()
  }

  @Test
  func test_validateDate_equalToMaxDate_returnsSuccess() {
    let result = validator.validate(maxDate)
    result.expectSuccess()
  }

  @Test
  func test_validateDate_afterMaxDate_returnsFailure() {
    let testDate = Date(timeIntervalSince1970: 31622400) // One day after maxDate
    let result = validator.validate(testDate)
    result.expectError()
  }

  @Test
  func test_validateDate_beforeMinDate_returnsFailure() {
    let testDate = Date(timeIntervalSince1970: 0) // One day before minDate
    let result = validator.validate(testDate)
    result.expectError()
  }

  // TODO
  @Test(.enabled(if: _isDebugAssertConfiguration()))
  func test_initValidator_withMinDateLaterThanMaxDate_shouldAssert() throws {
//    #expect(exitsWith: .signal(SIGABRT)) {
//      _ = DateRangeValidator(minDate: maxDate, maxDate: minDate)
//    }
  }
}
