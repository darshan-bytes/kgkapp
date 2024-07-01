class BusinessType {
  String? name;
  String? code;
  bool isSelected;

  BusinessType({
    this.name,
    this.code,
    this.isSelected = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BusinessType && other.name == name && other.code == code && other.isSelected == isSelected;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ isSelected.hashCode;

  @override
  String toString() => 'BusinessType(name: $name, code: $code, isSelected: $isSelected)';
}
