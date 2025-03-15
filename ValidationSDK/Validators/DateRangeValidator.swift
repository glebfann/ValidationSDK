import Foundation

public struct DateRangeValidator: Validator {
  private let minDate: Date
  private let maxDate: Date

  public init(minDate: Date, maxDate: Date) {
    assert(minDate <= maxDate)
    self.minDate = minDate
    self.maxDate = maxDate
  }

  public func validate(_ value: Date) -> Result<Void, ValidationError> {
    guard value >= minDate else {
      return .failure(ValidationError(message: "Date should not be earlier than \(minDate)"))
    }

    guard value <= maxDate else {
      return .failure(ValidationError(message: "Date should not be later than \(maxDate)"))
    }

    return .success
  }
}
