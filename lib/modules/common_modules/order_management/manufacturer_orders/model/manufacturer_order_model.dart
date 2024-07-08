import 'package:kgk/kgk.dart';

class ManufacturerOrderModel extends Equatable {
  final String name;

  const ManufacturerOrderModel({required this.name});

  @override
  List<Object> get props => [name];
}
