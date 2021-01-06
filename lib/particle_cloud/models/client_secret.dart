import 'package:formz/formz.dart';

enum ClientSecretValidationError { invalid }

class ClientSecret extends FormzInput<String, ClientSecretValidationError> {
  const ClientSecret.pure() : super.pure('');
  const ClientSecret.dirty([String value = '']) : super.dirty(value);

  @override
  ClientSecretValidationError validator(String value) {
    return value.isNotEmpty ? null : ClientSecretValidationError.invalid;
  }
}
