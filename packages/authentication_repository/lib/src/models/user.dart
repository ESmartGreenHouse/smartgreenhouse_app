import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String email;
  final String id;
  final String name;
  final bool isCloudLinked;

  const User({
    @required this.email,
    @required this.id,
    @required this.name,
    @required this.isCloudLinked,
  })  : assert(email != null),
        assert(id != null);

  /// Empty user which represents an unauthenticated user
  static const empty = User(email: '', id: '', name: null, isCloudLinked: null);

  @override
  List<Object> get props => [email, id, name, isCloudLinked];
}
