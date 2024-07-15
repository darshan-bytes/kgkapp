import 'package:kgk/kgk.dart';

class ProfileListModel {
  String? image;
  String? title;
  String? subTitle;
  String? trailingIcon;

  // VoidCallback? onTap;
  Function(BuildContext)? onTap;
  List<ProfileListModel>? profileSubList = [];
  bool isSubListExpanded = false;

  ProfileListModel({
    this.image,
    this.title,
    this.subTitle,
    this.trailingIcon,
    this.onTap,
    this.profileSubList,
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
        other.profileSubList == profileSubList;
  }

  @override
  int get hashCode =>
      image.hashCode ^ title.hashCode ^ subTitle.hashCode ^ trailingIcon.hashCode ^ onTap.hashCode ^ profileSubList.hashCode;
}
