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
  String? nameZh;
  String? name;
  String? cscName;
  String? collectionGroupRefSuid;
  String? subareaName;
  int? subareaId;
  String? nameTh;
  String? nameEn;
  String? businessCategory;
  String? collectionGroup;
  String? nameArSA;
  String? collectionType;
  String? cscId;
  String? collectionGroupSuid;
  String? nameJa;
  String? concetNo;
  String? image;
  String? conceptName;
  String? video;
  String? collectionCode;
  String? forCollection;
  String? guestUser;
  String? subareaCode;
  String? description;
  int? month;
  int? year;

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
    this.nameZh,
    this.name,
    this.cscName,
    this.collectionGroupRefSuid,
    this.subareaName,
    this.subareaId,
    this.nameTh,
    this.nameEn,
    this.businessCategory,
    this.collectionGroup,
    this.nameArSA,
    this.collectionType,
    this.cscId,
    this.collectionGroupSuid,
    this.nameJa,
    this.concetNo,
    this.image,
    this.conceptName,
    this.video,
    this.collectionCode,
    this.forCollection,
    this.guestUser,
    this.subareaCode,
    this.description,
    this.month,
    this.year,
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
    nameZh = json['name_zh'];
    name = json['name'];
    cscName = json['csc_name'];
    collectionGroupRefSuid = json['collection_group_ref_suid'];
    subareaName = json['subarea_name'];
    subareaId = json['subarea_id'];
    nameTh = json['name_th'];
    nameEn = json['name_en'];
    businessCategory = json['business_category'];
    collectionGroup = json['collection_group'];
    nameArSA = json['name_ar_SA'];
    collectionType = json['collection_type'];
    cscId = json['csc_id'];
    collectionGroupSuid = json['collection_group_suid'];
    nameJa = json['name_ja'];
    concetNo = json['concet_no'];
    image = json['image'];
    conceptName = json['concept_name'];
    video = json['video'];
    collectionCode = json['collection_code'];
    forCollection = json['for_collection'];
    guestUser = json['guest_user'];
    subareaCode = json['subarea_code'];
    description = json['description'];
    month = json['month'];
    year = json['year'];
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
    data['name_zh'] = nameZh;
    data['name'] = name;
    data['csc_name'] = cscName;
    data['collection_group_ref_suid'] = collectionGroupRefSuid;
    data['subarea_name'] = subareaName;
    data['subarea_id'] = subareaId;
    data['name_th'] = nameTh;
    data['name_en'] = nameEn;
    data['business_category'] = businessCategory;
    data['collection_group'] = collectionGroup;
    data['name_ar_SA'] = nameArSA;
    data['collection_type'] = collectionType;
    data['csc_id'] = cscId;
    data['collection_group_suid'] = collectionGroupSuid;
    data['name_ja'] = nameJa;
    data['concet_no'] = concetNo;
    data['image'] = image;
    data['concept_name'] = conceptName;
    data['video'] = video;
    data['collection_code'] = collectionCode;
    data['for_collection'] = forCollection;
    data['guest_user'] = guestUser;
    data['subarea_code'] = subareaCode;
    data['description'] = description;
    data['month'] = month;
    data['year'] = year;
    return data;
  }
}
