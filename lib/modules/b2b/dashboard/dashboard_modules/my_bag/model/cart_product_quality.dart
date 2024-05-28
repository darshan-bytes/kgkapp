class CartProductQuality {
  String name;

  CartProductQuality({required this.name});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartProductQuality && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'CartProductQuality(name: $name)';
}
