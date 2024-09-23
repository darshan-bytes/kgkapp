class SecondaryFilterModel {
  SecondaryFilterModel({
    required this.value,
    required this.label,
  });

  final String? value;
  final String? label;

  SecondaryFilterModel copyWith({
    String? value,
    String? label,
  }) {
    return SecondaryFilterModel(
      value: value ?? this.value,
      label: label ?? this.label,
    );
  }

  factory SecondaryFilterModel.fromJson(Map<String, dynamic> json){
    return SecondaryFilterModel(
      value: json["value"],
      label: json["label"],
    );
  }

  Map<String, dynamic> toJson() => {
    "value": value,
    "label": label,
  };

  @override
  String toString(){
    return "$value, $label, ";
  }
}
