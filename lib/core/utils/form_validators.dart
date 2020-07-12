import 'package:form_field_validator/form_field_validator.dart';

class FormValidators {
  static TextFieldValidator requiredText([
    String message = 'This field is required',
  ]) {
    return RequiredValidator(errorText: message);
  }

  static TextFieldValidator phoneNumber([
    String message = 'Please enter a valid number.',
  ]) {
    return _PhoneNumberValidator(errorText: message);
  }

  static MultiValidator duration([
    String message = 'Please enter a valid duration.',
  ]) {
    return MultiValidator([
      requiredText(),
      MaxLengthValidator(3, errorText: message),
    ]);
  }

  static FieldValidator nonNull<T>([
    String message = 'This field is required.',
  ]) {
    return _NonNullValidator<T>(errorText: message);
  }
}

class _PhoneNumberValidator extends TextFieldValidator {
  _PhoneNumberValidator({
    String errorText = 'Please enter a valid number.',
  }) : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String value) {
    return RegExp('98[0-9]{8}').hasMatch(value);
  }
}

class _NonNullValidator<T> extends FieldValidator<T> {
  _NonNullValidator({
    String errorText,
  }) : super(errorText);

  @override
  bool isValid(T value) {
    return value != null;
  }
}
