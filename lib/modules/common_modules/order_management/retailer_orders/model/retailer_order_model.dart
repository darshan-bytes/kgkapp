import 'package:kgk/kgk.dart';

class RetailerOrderModel extends Equatable {
  final String name;

  const RetailerOrderModel({required this.name});

  @override
  List<Object> get props => [name];
}
