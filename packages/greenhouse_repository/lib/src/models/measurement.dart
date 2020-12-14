import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Measurement extends Equatable {
  final DateTime timestamp;
  final double value;

  Measurement({@required this.timestamp, @required this.value});

  @override
  List<Object> get props => [timestamp, value];
}
