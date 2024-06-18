class CmsWebViewDataModel {
  String? url;
  String? title;

  CmsWebViewDataModel({
    this.url,
    this.title,
  });

  @override
  bool operator ==(Object other) {
    return other is CmsWebViewDataModel && other.url == url && other.title == title;
  }

  @override
  int get hashCode => url.hashCode ^ title.hashCode;
}
