import 'package:kgk/kgk.dart';

class CancellationReasonModel extends Equatable {
  final int? id;
  final String? name;

  const CancellationReasonModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
