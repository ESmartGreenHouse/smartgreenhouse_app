import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Particle extends Equatable {
  final String id;
  final String name;
  final String description;

  Particle({@required this.id, @required this.name, this.description = ''});

  @override
  List<Object> get props => [id, name, description];
}
