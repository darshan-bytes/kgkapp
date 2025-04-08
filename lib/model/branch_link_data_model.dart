import 'package:kgk/kgk.dart';

class BranchLinkDataModel {
  BranchLinkDataModel({
    required this.branchLinkType,
    required this.id,
    required this.commodity,
    this.webPath,
  });

  final BranchLinkTypeType? branchLinkType;
  final String? id;
  final String? commodity;
  final String? webPath;

  factory BranchLinkDataModel.fromJson(Map<String, dynamic> json) {
    return BranchLinkDataModel(
      branchLinkType: json["branch_link_type"] == null
          ? null
          : BranchLinkTypeType.values.firstWhereOrNull((element) => element.value == json["branch_link_type"]),
      id: json["id"],
      commodity: json["commodity"],
    );
  }

  Map<String, dynamic> toJson() => {
        "branch_link_type": branchLinkType?.value,
        "id": id,
        "commodity": commodity,
      };
}

extension BranchLinkDataModelExtension on BranchLinkDataModel {
  Commodity get commodityEnum {
    return Commodity.values.firstWhereOrNull((element) => element.value == commodity) ?? Commodity.jewellery;
  }
}
