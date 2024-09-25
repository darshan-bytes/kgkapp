class SortData {
  final String name;
  final String sortKey;
  final String sortValue;

  SortData({required this.name, required this.sortKey, required this.sortValue});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SortData && other.name == name && other.sortKey == sortKey && other.sortValue == sortValue;
  }

  @override
  int get hashCode => name.hashCode ^ sortKey.hashCode ^ sortValue.hashCode;

  @override
  String toString() => 'SortData(name: $name, sortKey: $sortKey, sortValue: $sortValue)';
}
