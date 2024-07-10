class MessagesModel {
  String? id;
  String? userName;
  String? userImageUrl;
  String? message;
  String? timeAgo;
  bool isFavorite;

  MessagesModel({
    this.id,
    this.userName,
    this.userImageUrl,
    this.message,
    this.timeAgo,
    this.isFavorite = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MessagesModel &&
        other.id == id &&
        other.userName == userName &&
        other.userImageUrl == userImageUrl &&
        other.message == message &&
        other.timeAgo == timeAgo &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode => id.hashCode ^ userName.hashCode ^ userImageUrl.hashCode ^ message.hashCode ^ timeAgo.hashCode ^ isFavorite.hashCode;
}
