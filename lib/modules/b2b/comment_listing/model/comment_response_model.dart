import '../../../../kgk.dart';

class CommentsAddedResponseModel {
  String? sId;
  String? catalogueId;
  String? productId;
  int? iV;
  List<Comments>? comments;
  String? createdAt;
  String? updatedAt;

  CommentsAddedResponseModel({this.sId, this.catalogueId, this.productId, this.iV, this.comments, this.createdAt, this.updatedAt});

  CommentsAddedResponseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    catalogueId = json['catalogue_id'];
    productId = json['product_id'];
    iV = json['__v'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments?.add(Comments.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['catalogue_id'] = catalogueId;
    data['product_id'] = productId;
    data['__v'] = iV;
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Comments {
  String? message;
  bool? isEdited;
  String? createdAt;
  int? commentedBy;
  String? sId;
  UserIdDetails? updatedIdDetails;

  Comments({this.message, this.isEdited, this.createdAt, this.commentedBy, this.sId, this.updatedIdDetails});

  Comments.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isEdited = json['is_edited'];
    createdAt = json['created_at'];
    commentedBy = json['commented_by'];
    sId = json['_id'];
    updatedIdDetails = json["user"] == null ? null : UserIdDetails.fromJson(json["user"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['is_edited'] = isEdited;
    data['created_at'] = createdAt;
    data['commented_by'] = commentedBy;
    data['_id'] = sId;
    data['user'] = updatedIdDetails?.toJson();
    return data;
  }

  String? get displayDate => createdAt?.stringToDateTime()?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMMYYYYHHMMA2);

  bool get isCreatedByMe => updatedIdDetails?.userAccountId == StorageManager.instance.getUserId();
}
