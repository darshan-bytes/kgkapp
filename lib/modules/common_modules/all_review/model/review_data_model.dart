import 'package:kgk/kgk.dart';

class ReviewDataModel {
  int? id;
  String? userName;
  int? rating;
  String? title;
  String? review;
  String? date;
  List<String>? images;

  ReviewDataModel({
    this.id,
    this.userName,
    this.rating,
    this.title,
    this.review,
    this.date,
    this.images,
  });

  ReviewDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    rating = json['rating'];
    title = json['title'];
    review = json['review'];
    date = json['date'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['rating'] = rating;
    data['title'] = title;
    data['review'] = review;
    data['date'] = date;
    data['images'] = images;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewDataModel &&
        other.id == id &&
        other.userName == userName &&
        other.rating == rating &&
        other.title == title &&
        other.review == review &&
        other.date == date &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return id.hashCode ^ userName.hashCode ^ rating.hashCode ^ title.hashCode ^ review.hashCode ^ date.hashCode ^ images.hashCode;
  }
}
