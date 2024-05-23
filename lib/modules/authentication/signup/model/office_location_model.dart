class OfficeLocation {
  final String name;
  final String code;

  OfficeLocation({required this.name, required this.code});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is OfficeLocation && other.name == name && other.code == code;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode;

  @override
  String toString() => 'OfficeLocation(name: $name, code: $code)';
}
