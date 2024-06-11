class PaymentCondition {
  String? title;
  String? id;

  PaymentCondition({
    this.title,
    this.id,
  });

  PaymentCondition.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;
    return data;
  }

  @override
  bool operator ==(Object other) {
    return other is PaymentCondition && other.id == id && other.title == title;
  }

  @override
  int get hashCode => title.hashCode ^ id.hashCode;
}
