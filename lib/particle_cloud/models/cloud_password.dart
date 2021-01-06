import 'package:formz/formz.dart';

enum CloudPasswordValidationError { invalid }

class CloudPassword extends FormzInput<String, CloudPasswordValidationError> {
  const CloudPassword.pure() : super.pure('');
  const CloudPassword.dirty([String value = '']) : super.dirty(value);

  @override
  CloudPasswordValidationError validator(String value) {
    return value.isNotEmpty ? null : CloudPasswordValidationError.invalid;
  }
}
