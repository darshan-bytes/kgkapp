import 'package:kgk/kgk.dart';

class CartProductQuantity extends Equatable {
  final String? name;
  final int? quantity;

  const CartProductQuantity({this.name, this.quantity});

  @override
  List<Object?> get props => [name, quantity];
}
