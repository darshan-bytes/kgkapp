class CollectionDataModel {
  int? iId;
  List<CollectionDataItemsModel>? items;

  CollectionDataModel({this.iId, this.items});

  CollectionDataModel.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    if (json['items'] != null) {
      items = <CollectionDataItemsModel>[];
      json['items'].forEach((v) {
        items!.add(CollectionDataItemsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = iId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CollectionDataItemsModel {
  String? sId;
  String? receivedAt;
  String? createdAt;
  String? updatedAt;
  String? importedFrom;
  String? suid;
  String? referenceId;
  int? refSuid;
  String? updatedDateTime;
  dynamic nameZhCN;
  String? name;
  dynamic cscName;
  String? collectionGroupRefSuid;
  dynamic subareaName;
  dynamic subareaId;
  dynamic nameThTH;
  String? nameEnUS;
  String? businessCategory;
  String? collectionGroup;
  dynamic nameArSA;
  String? collectionType;
  dynamic cscId;
  String? collectionGroupSuid;
  dynamic nameJaJP;
  String? concetNo;
  String? image;
  String? conceptName;
  dynamic video;
  String? description;
  int? month;

  CollectionDataItemsModel({
    this.sId,
    this.receivedAt,
    this.createdAt,
    this.updatedAt,
    this.importedFrom,
    this.suid,
    this.referenceId,
    this.refSuid,
    this.updatedDateTime,
    this.nameZhCN,
    this.name,
    this.cscName,
    this.collectionGroupRefSuid,
    this.subareaName,
    this.subareaId,
    this.nameThTH,
    this.nameEnUS,
    this.businessCategory,
    this.collectionGroup,
    this.nameArSA,
    this.collectionType,
    this.cscId,
    this.collectionGroupSuid,
    this.nameJaJP,
    this.concetNo,
    this.image,
    this.conceptName,
    this.video,
    this.description,
    this.month,
  });

  CollectionDataItemsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    receivedAt = json['received_at'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    importedFrom = json['imported_from'];
    suid = json['suid'];
    referenceId = json['reference_id'];
    refSuid = json['ref_suid'];
    updatedDateTime = json['updated_date_time'];
    nameZhCN = json['name_zh_CN'];
    name = json['name'];
    cscName = json['csc_name'];
    collectionGroupRefSuid = json['collection_group_ref_suid'];
    subareaName = json['subarea_name'];
    subareaId = json['subarea_id'];
    nameThTH = json['name_th_TH'];
    nameEnUS = json['name_en_US'];
    businessCategory = json['business_category'];
    collectionGroup = json['collection_group'];
    nameArSA = json['name_ar_SA'];
    collectionType = json['collection_type'];
    cscId = json['csc_id'];
    collectionGroupSuid = json['collection_group_suid'];
    nameJaJP = json['name_ja_JP'];
    concetNo = json['concet_no'];
    image = json['image'];
    conceptName = json['concept_name'];
    video = json['video'];
    description = json['description'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['received_at'] = receivedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['imported_from'] = importedFrom;
    data['suid'] = suid;
    data['reference_id'] = referenceId;
    data['ref_suid'] = refSuid;
    data['updated_date_time'] = updatedDateTime;
    data['name_zh_CN'] = nameZhCN;
    data['name'] = name;
    data['csc_name'] = cscName;
    data['collection_group_ref_suid'] = collectionGroupRefSuid;
    data['subarea_name'] = subareaName;
    data['subarea_id'] = subareaId;
    data['name_th_TH'] = nameThTH;
    data['name_en_US'] = nameEnUS;
    data['business_category'] = businessCategory;
    data['collection_group'] = collectionGroup;
    data['name_ar_SA'] = nameArSA;
    data['collection_type'] = collectionType;
    data['csc_id'] = cscId;
    data['collection_group_suid'] = collectionGroupSuid;
    data['name_ja_JP'] = nameJaJP;
    data['concet_no'] = concetNo;
    data['image'] = image;
    data['concept_name'] = conceptName;
    data['video'] = video;
    data['description'] = description;
    data['month'] = month;
    return data;
  }
}
