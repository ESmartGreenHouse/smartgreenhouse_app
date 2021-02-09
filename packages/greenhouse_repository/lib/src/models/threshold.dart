import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Threshold extends Equatable {
  final String name;
  final double value;

  Threshold({
    @required this.name,
    this.value,
  });

  @override
  List<Object> get props => [name, value];

  Threshold copyWith({double value}) => Threshold(
    name: name,
    value: value,
  );
}
