import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Actuator extends Equatable {
  final String name;

  Actuator({@required this.name});

  @override
  List<Object> get props => [name];
}
