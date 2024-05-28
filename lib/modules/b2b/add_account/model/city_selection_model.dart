class City {
  final String name;

  City({required this.name});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is City && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'City(name: $name)';
}
