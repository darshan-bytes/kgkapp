class SortData {
  final String name;
  final String code;

  SortData({required this.name, required this.code});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SortData && other.name == name && other.code == code;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode;

  @override
  String toString() => 'SortData(name: $name, code: $code)';
}
