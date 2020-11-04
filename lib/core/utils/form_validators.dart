import 'package:meta/meta.dart';

import 'package:form_field_validator/form_field_validator.dart';

import 'package:sahayatri/core/models/checkpoint.dart';

class FormValidators {
  static TextFieldValidator requiredText([String message = 'This field is required']) {
    return RequiredValidator(errorText: message);
  }

  static MultiValidator email([String message = 'Please enter a valid email.']) {
    return MultiValidator([
      RequiredValidator(errorText: message),
      EmailValidator(errorText: message),
    ]);
  }

  static MultiValidator password([String message = 'Please enter a valid password.']) {
    return MultiValidator([
      RequiredValidator(errorText: message),
      MinLengthValidator(6, errorText: 'Password should be more than 5 characters long.')
    ]);
  }

  static FieldValidator nonNull<T>([String message = 'This field is required.']) {
    return _NonNullValidator<T>(errorText: message);
  }

  static TextFieldValidator phoneNumber() {
    return _PhoneNumberValidator(errorText: 'Please enter a valid number (98########).');
  }

  static MultiValidator duration([String message = 'Please enter a duration.']) {
    const int maxLength = 3;
    return MultiValidator([
      RequiredValidator(errorText: message),
      MaxLengthValidator(
        maxLength,
        errorText: 'Duration should be less than ${maxLength + 1} digits long.',
      ),
      PatternValidator(
        r'^[0-9]{1,3}$',
        errorText: 'Duration should only contain numbers.',
      ),
    ]);
  }

  static MultiValidator checkpoints() {
    return MultiValidator([
      _NonEmptyListValidator(errorText: 'Please create at least one checkpoint.'),
      _CheckpointsValidator(
        errorText: 'Please select date and time for all checkpoints.',
      ),
    ]);
  }
}

/// Verifies phone number follows the pattern 98########
class _PhoneNumberValidator extends TextFieldValidator {
  _PhoneNumberValidator({
    @required String errorText,
  }) : super(errorText);

  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String value) {
    return RegExp(r'^98[0-9]{8}$').hasMatch(value);
  }
}

/// Verifies value is not null
class _NonNullValidator<T> extends FieldValidator<T> {
  _NonNullValidator({
    @required String errorText,
  }) : super(errorText);

  @override
  bool isValid(T value) {
    return value != null;
  }
}

/// Verifies list is not empty
class _NonEmptyListValidator extends FieldValidator<List> {
  _NonEmptyListValidator({
    @required String errorText,
  }) : super(errorText);

  @override
  bool isValid(List list) {
    return list.isNotEmpty;
  }
}

/// Verifies list of [Checkpoint] are not templates.
class _CheckpointsValidator extends FieldValidator<List<Checkpoint>> {
  _CheckpointsValidator({
    @required String errorText,
  }) : super(errorText);

  @override
  bool isValid(List<Checkpoint> checkpoints) {
    return checkpoints.every((c) => !c.isTemplate);
  }
}
