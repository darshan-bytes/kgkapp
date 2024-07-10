import 'package:kgk/kgk.dart';

class MessagesModel {
  String? id;
  String? userName;
  String? userImageUrl;
  String? message;
  String? timeAgo;
  bool isFavorite;
  String? fullMessage;
  List<MessagesDetailsModel>? details = [];

  MessagesModel(
      {this.id, this.userName, this.userImageUrl, this.message, this.timeAgo, this.isFavorite = false, this.fullMessage, this.details});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MessagesModel &&
        other.id == id &&
        other.userName == userName &&
        other.userImageUrl == userImageUrl &&
        other.message == message &&
        other.timeAgo == timeAgo &&
        other.isFavorite == isFavorite &&
        other.fullMessage == fullMessage &&
        other.details == details;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      userName.hashCode ^
      userImageUrl.hashCode ^
      message.hashCode ^
      timeAgo.hashCode ^
      isFavorite.hashCode ^
      fullMessage.hashCode ^
      details.hashCode;
}

class MessagesDetailsModel {
  String? id;
  String? userName;
  String? userImageUrl;
  String? timeAgo;
  String? toUserName;
  bool isExpanded;
  bool toMe;
  String? fullMessage;
  GlobalKey<SmartExpansionTileState> messageDetailsKey;

  MessagesDetailsModel(
      {this.id,
      this.userName,
      this.userImageUrl,
      this.timeAgo,
      this.toUserName,
      this.isExpanded = false,
      this.toMe = false,
      this.fullMessage,
      required this.messageDetailsKey});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MessagesDetailsModel &&
        other.id == id &&
        other.userName == userName &&
        other.userImageUrl == userImageUrl &&
        other.timeAgo == timeAgo &&
        other.toUserName == toUserName &&
        other.isExpanded == isExpanded &&
        other.toMe == toMe &&
        other.fullMessage == fullMessage &&
        other.messageDetailsKey == messageDetailsKey;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      userName.hashCode ^
      userImageUrl.hashCode ^
      timeAgo.hashCode ^
      toUserName.hashCode ^
      isExpanded.hashCode ^
      toMe.hashCode ^
      fullMessage.hashCode ^
      messageDetailsKey.hashCode;
}
