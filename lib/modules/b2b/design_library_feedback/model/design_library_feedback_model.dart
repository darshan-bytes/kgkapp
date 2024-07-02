class DesignLibraryFeedbackModel {
  String? id;
  String? designerImageUrl;
  String? designerName;
  String? daysAgo;
  String? feedbackMessage;

  DesignLibraryFeedbackModel({
    this.id,
    this.designerImageUrl,
    this.designerName,
    this.daysAgo,
    this.feedbackMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DesignLibraryFeedbackModel &&
        other.id == id &&
        other.designerImageUrl == designerImageUrl &&
        other.designerName == designerName &&
        other.daysAgo == daysAgo &&
        other.feedbackMessage == feedbackMessage;
  }

  @override
  int get hashCode {
    return id.hashCode ^ designerImageUrl.hashCode ^ designerName.hashCode ^ daysAgo.hashCode ^ feedbackMessage.hashCode;
  }
}
