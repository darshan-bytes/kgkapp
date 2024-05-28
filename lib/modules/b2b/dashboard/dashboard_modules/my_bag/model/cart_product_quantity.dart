class CartProductQuantity {
  String name;

  CartProductQuantity({required this.name});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartProductQuantity && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'CartProductQuantity(name: $name)';
}
