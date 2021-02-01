import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Actuator extends Equatable {
  final String name;
  final bool value;

  Actuator({
    @required this.name,
    this.value,
  });

  @override
  List<Object> get props => [name, value];

  Actuator copyWith({bool value}) => Actuator(
    name: name,
    value: value ?? this.value,
  );
}
