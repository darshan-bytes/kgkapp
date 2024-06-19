import 'package:kgk/kgk.dart';

class CartProductQuality extends Equatable {
  final String? name;

  const CartProductQuality({
    this.name,
  });

  @override
  List<Object?> get props => [name];
}
