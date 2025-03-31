import 'package:kgk/kgk.dart';

class StatusModel extends Equatable {
  final int id;
  final String name;

  const StatusModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
