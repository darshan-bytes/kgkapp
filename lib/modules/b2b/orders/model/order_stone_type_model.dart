import 'package:kgk/kgk.dart';

class OrderStoneTypeModel extends Equatable {
  final String name;

  const OrderStoneTypeModel({required this.name});

  @override
  List<Object> get props => [name];
}
