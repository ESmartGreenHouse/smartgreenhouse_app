import 'package:equatable/equatable.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';

class Particle extends Equatable {
  final String id;
  final String name;
  final String description;
  final List<Sensor> sensors;

  Particle({@required this.id, @required this.name, this.description = '', this.sensors = const []});

  @override
  List<Object> get props => [id, name, description, sensors];
}
