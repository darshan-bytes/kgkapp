import 'package:kgk/kgk.dart';

class ProfileListModel {
  String? image;
  String? title;
  String? subTitle;
  String? trailingIcon;
  VoidCallback? onTap;
  List<ProfileListModel>? profileChildrenList = [];
  bool isSubListExpanded = false;

  ProfileListModel({
    this.image,
    this.title,
    this.subTitle,
    this.trailingIcon,
    this.onTap,
    this.profileChildrenList,
    this.isSubListExpanded = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProfileListModel &&
        other.image == image &&
        other.title == title &&
        other.subTitle == subTitle &&
        other.trailingIcon == trailingIcon &&
        other.onTap == onTap &&
        other.profileChildrenList == profileChildrenList;
  }

  @override
  int get hashCode =>
      image.hashCode ^ title.hashCode ^ subTitle.hashCode ^ trailingIcon.hashCode ^ onTap.hashCode ^ profileChildrenList.hashCode;
}
