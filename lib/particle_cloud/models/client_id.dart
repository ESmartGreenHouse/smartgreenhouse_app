import 'package:formz/formz.dart';

enum ClientIdValidationError { invalid }

class ClientId extends FormzInput<String, ClientIdValidationError> {
  const ClientId.pure() : super.pure('');
  const ClientId.dirty([String value = '']) : super.dirty(value);

  @override
  ClientIdValidationError validator(String value) {
    return value.isNotEmpty ? null : ClientIdValidationError.invalid;
  }
}
