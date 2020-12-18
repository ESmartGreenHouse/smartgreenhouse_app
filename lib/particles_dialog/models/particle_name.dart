
import 'package:formz/formz.dart';

enum ParticleNameValidationError { invalid }

class ParticleName extends FormzInput<String, ParticleNameValidationError> {
  const ParticleName.pure() : super.pure('');
  const ParticleName.dirty([String value = '']) : super.dirty(value);

  @override
  ParticleNameValidationError validator(String value) {
    return value.isNotEmpty ? null : ParticleNameValidationError.invalid;
  }
}
