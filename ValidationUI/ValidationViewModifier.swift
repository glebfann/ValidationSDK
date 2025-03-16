import SwiftUI
import ValidationSDK

internal struct ValidationViewModifier<Value: Equatable>: ViewModifier {
  @Binding private var value: Value
  @Binding private var state: ValidationState
  private let validator: AnyValidator<Value>
  
  init(
    value: Binding<Value>,
    state: Binding<ValidationState>,
    validator: AnyValidator<Value>
  ) {
    self._value = value
    self._state = state
    self.validator = validator
  }
  
  func body(content: Content) -> some View {
    if #available(iOS 17.0, macOS 14.0, *) {
      content.onChange(of: value, initial: false, augment(validate))
    } else {
      content.onChange(of: value, perform: validate)
    }
  }
  
  private func validate(_ value: Value) {
    state = .validating
    switch validator.validate(value) {
    case .success: state = .valid
    case let .failure(error): state = .invalid(error)
    }
  }
}

// TODO: Move to FunctionalPrimitives
private func augment<Value>(_ f: @escaping (Value) -> Void) -> (Value, Value) -> Void {
  return { arg1, arg2 in
    f(arg2)
  }
}
