import 'package:equatable/equatable.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';

class Particle extends Equatable {
  final String id;
  final String name;
  final String notes;
  final DateTime lastHeard;
  final bool isShared;
  final bool isOwned;
  final List<Sensor> sensors;

  Particle({
    @required this.id,
    @required this.name,
    this.notes = '',
    this.lastHeard,
    this.isShared = false,
    this.isOwned = false,
    this.sensors = const [],
  });

  @override
  List<Object> get props => [id, name, notes, lastHeard, isShared, isOwned, sensors];

  Particle copyWith({String name, String notes, bool isShared}) => Particle(
    id: id,
    name: name ?? this.name,
    notes: notes ?? this.notes,
    lastHeard: lastHeard,
    isShared: isShared ?? this.isShared,
    isOwned: isOwned,
    sensors: sensors,
  );
}
