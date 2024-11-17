open class ValidationError: Error, @unchecked Sendable {
    public static let `default` = ValidationError(message: "Validation failed")
    private let message: String

    public init(message: String) {
        self.message = message
    }
}
