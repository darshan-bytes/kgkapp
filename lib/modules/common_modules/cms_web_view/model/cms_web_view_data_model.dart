class CmsWebViewDataModel {
  String? url;
  String? title;
  String? attribute;

  CmsWebViewDataModel({
    this.url,
    this.title,
    this.attribute,
  });

  @override
  bool operator ==(Object other) {
    return other is CmsWebViewDataModel && other.url == url && other.title == title && other.attribute == attribute;
  }

  @override
  int get hashCode => url.hashCode ^ title.hashCode ^ attribute.hashCode;
}
