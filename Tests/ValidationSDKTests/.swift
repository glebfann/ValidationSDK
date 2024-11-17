import ValidationSDK

extension Result: Equatable where Success == Void, Error == ValidationError {
}
