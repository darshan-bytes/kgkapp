import 'package:kgk/kgk.dart';

class BranchLinkDataModel {
  BranchLinkDataModel({required this.branchLinkType, required this.id, this.commodity, this.webPath, this.title});

  final BranchLinkTypeType? branchLinkType;
  final String? id;
  final String? commodity;
  final String? webPath;
  final String? title;

  factory BranchLinkDataModel.fromJson(Map<String, dynamic> json) {
    return BranchLinkDataModel(
      branchLinkType:
          json["branch_link_type"] == null
              ? null
              : BranchLinkTypeType.values.firstWhereOrNull((element) => element.value == json["branch_link_type"]),
      id: json["id"],
      commodity: json["commodity"],
      webPath: json["web_path"],
      title: json["title"],
    );
  }

  Map<String, dynamic> toJson() => {
    "branch_link_type": branchLinkType?.value,
    "id": id,
    "commodity": commodity,
    "web_path": webPath,
    "title": title,
  };
}

extension BranchLinkDataModelExtension on BranchLinkDataModel {
  Commodity get commodityEnum {
    return Commodity.values.firstWhereOrNull((element) => element.value == commodity) ?? Commodity.jewellery;
  }
}
