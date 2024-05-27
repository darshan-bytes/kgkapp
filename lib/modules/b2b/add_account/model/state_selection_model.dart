class StateModel {
  final String name;

  StateModel({required this.name});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StateModel && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'StateModel(name: $name)';
}
