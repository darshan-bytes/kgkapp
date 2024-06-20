import 'package:kgk/kgk.dart';

class InquiryTypeModel extends Equatable {
  final int id;
  final String name;

  const InquiryTypeModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
