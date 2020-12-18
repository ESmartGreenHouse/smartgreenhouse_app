
import 'package:formz/formz.dart';

enum ParticleMacValidationError { invalid }

class ParticleMac extends FormzInput<String, ParticleMacValidationError> {
  const ParticleMac.pure() : super.pure('');
  const ParticleMac.dirty([String value = '']) : super.dirty(value);

  static final RegExp _macRegExp = RegExp(
    r'^([0-9a-fA-F][0-9a-fA-F]:){5}([0-9a-fA-F][0-9a-fA-F])$',
  );

  @override
  ParticleMacValidationError validator(String value) {
    return _macRegExp.hasMatch(value) ? null : ParticleMacValidationError.invalid;
  }
}
