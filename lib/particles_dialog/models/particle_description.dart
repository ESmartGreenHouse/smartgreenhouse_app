
import 'package:formz/formz.dart';

enum ParticleDescriptionValidationError { invalid }

class ParticleDescription extends FormzInput<String, ParticleDescriptionValidationError> {
  const ParticleDescription.pure() : super.pure('');
  const ParticleDescription.dirty([String value = '']) : super.dirty(value);

  @override
  ParticleDescriptionValidationError validator(String value) {
    return value.isNotEmpty ? null : ParticleDescriptionValidationError.invalid;
  }
}
