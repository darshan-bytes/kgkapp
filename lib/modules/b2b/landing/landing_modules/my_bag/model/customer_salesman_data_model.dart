import 'package:kgk/kgk.dart';

class CustomerSalesmanModel {
  CustomerSalesmanModel({required this.customerId, required this.assignClient});

  final String? customerId;
  final AssignClient? assignClient;

  CustomerSalesmanModel copyWith({String? customerId, AssignClient? assignClient}) {
    return CustomerSalesmanModel(customerId: customerId ?? this.customerId, assignClient: assignClient ?? this.assignClient);
  }

  factory CustomerSalesmanModel.fromJson(Map<String, dynamic> json) {
    return CustomerSalesmanModel(
      customerId: json["customer_id"],
      assignClient: json["assignClient"] == null ? null : AssignClient.fromJson(json["assignClient"]),
    );
  }

  Map<String, dynamic> toJson() => {"customer_id": customerId, "assignClient": assignClient?.toJson()};
}

class AssignClient {
  AssignClient({required this.id, required this.email, required this.internalUser});

  final String? id;
  final String? email;
  final UserIdDetails? internalUser;

  AssignClient copyWith({String? id, String? email, UserIdDetails? internalUser}) {
    return AssignClient(id: id ?? this.id, email: email ?? this.email, internalUser: internalUser ?? this.internalUser);
  }

  factory AssignClient.fromJson(Map<String, dynamic> json) {
    return AssignClient(
      id: json["id"],
      email: json["email"],
      internalUser: json["internalUser"] == null ? null : UserIdDetails.fromJson(json["internalUser"]),
    );
  }

  Map<String, dynamic> toJson() => {"id": id, "email": email, "internalUser": internalUser?.toJson()};
}
