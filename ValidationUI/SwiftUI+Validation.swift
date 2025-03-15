import SwiftUI
import ValidationSDK

extension View {
  public func validate<Value: Equatable>(
    value: Binding<Value>,
    state: Binding<ValidationState>,
    validator: AnyValidator<Value>
  ) -> some View {
    modifier(
      ValidationViewModifier(
        value: value,
        state: state,
        validator: validator.eraseToAnyValidator()
      )
    )
  }
  
  public func validate<Value: Equatable>(
    value: Binding<Value>,
    state: Binding<ValidationState>,
    validators: [AnyValidator<Value>]
  ) -> some View {
    validate(value: value, state: state, validator: CompositeValidator(validators: validators))
  }
  
  public func validate<Value: Equatable, V: Validator>(
    value: Binding<Value>,
    state: Binding<ValidationState>,
    validator: V
  ) -> some View where V.Value == Value {
    validate(value: value, state: state, validator: validator.eraseToAnyValidator())
  }
  
  public func validate<Value: Equatable, V: Validator>(
    value: Binding<Value>,
    state: Binding<ValidationState>,
    validators: V...
  ) -> some View where V.Value == Value {
    validate(value: value, state: state, validator: CompositeValidator(validators: validators))
  }
}
