import 'package:kgk/kgk.dart';

class CartProductQuantity extends Equatable {
  final String? name;

  const CartProductQuantity({
    this.name,
  });

  @override
  List<Object?> get props => [name];
}
