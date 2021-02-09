import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:greenhouse_repository/greenhouse_repository.dart';
import 'package:greenhouse_repository/src/models/actuator.dart';
import 'package:meta/meta.dart';

class Particle extends Equatable {
  final String id;
  final String name;
  final String notes;
  final DateTime lastHeard;
  final bool isShared;
  final bool isOwned;
  final List<Sensor> sensors;
  final List<Actuator> actuators;
  final List<Threshold> thresholds;

  Particle({
    @required this.id,
    @required this.name,
    this.notes = '',
    this.lastHeard,
    this.isShared = false,
    this.isOwned = false,
    this.sensors = const [],
    this.actuators = const [],
    this.thresholds = const [],
  });

  @override
  List<Object> get props => [id, name, notes, lastHeard, isShared, isOwned, sensors, actuators, thresholds];

  Particle copyWith({String name, String notes, bool isShared}) => Particle(
    id: id,
    name: name ?? this.name,
    notes: notes ?? this.notes,
    lastHeard: lastHeard,
    isShared: isShared ?? this.isShared,
    isOwned: isOwned,
    sensors: sensors,
    actuators: actuators,
    thresholds: thresholds,
  );

  static Particle fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot, bool isOwned) => Particle(
    id: snapshot.get('id') as String,
    name: snapshot.get('name') as String,
    notes: snapshot.get('notes') as String ?? '',
    isShared: snapshot.data().containsKey('shared')
      ? snapshot.get('shared') as bool ?? false
      : false,
    isOwned: isOwned,
    sensors: snapshot.data().containsKey('sensors')
      ? (snapshot.get('sensors') as List<dynamic>)?.map((s) => Sensor(name: s.toString()))?.toList() ?? []
      : [],
    actuators: snapshot.data().containsKey('actuators')
      ? (snapshot.get('actuators') as List<dynamic>)?.map((s) => Actuator(name: s.toString()))?.toList() ?? []
      : [],
    thresholds: snapshot.data().containsKey('thresholds')
      ? (snapshot.get('thresholds') as List<dynamic>)?.map((s) => Threshold(name: s.toString()))?.toList() ?? []
      : [],
  );
}
