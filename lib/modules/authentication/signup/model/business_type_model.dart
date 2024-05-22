class BusinessType {
  final String name;
  final String code;

  BusinessType({required this.name, required this.code});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BusinessType && other.name == name && other.code == code;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode;

  @override
  String toString() => 'BusinessType(name: $name, code: $code)';
}
