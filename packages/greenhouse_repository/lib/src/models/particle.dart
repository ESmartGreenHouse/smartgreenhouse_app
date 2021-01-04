import 'package:equatable/equatable.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:meta/meta.dart';

class Particle extends Equatable {
  final String id;
  final String name;
  final String description;
  final String ownerUid;
  final List<Sensor> sensors;
  final List<String> readUids;
  final List<String> writeUids;

  Particle({
    @required this.id,
    @required this.name,
    this.description = '',
    @required this.ownerUid,
    this.sensors = const [],
    this.writeUids = const [],
    this.readUids = const [],
  });

  @override
  List<Object> get props => [id, name, description, ownerUid, sensors, readUids, writeUids];

  Particle copyWith({List<String> readUids, List<String> writeUids}) => Particle(
    id: id,
    name: name,
    description: description,
    ownerUid: ownerUid,
    sensors: sensors,
    readUids: readUids ?? this.readUids,
    writeUids: writeUids ?? this.writeUids,
  );
}
