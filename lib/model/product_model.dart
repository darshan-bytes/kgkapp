import 'package:kgk/kgk.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;

  const ProductModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
