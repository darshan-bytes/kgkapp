class CmsWebViewDataModel {
  final String? url;
  final String? title;
  final String? attribute;
  final bool showLoader;

  CmsWebViewDataModel({
    this.url,
    this.title,
    this.attribute,
    this.showLoader = false,
  });

  @override
  bool operator ==(Object other) {
    return other is CmsWebViewDataModel &&
        other.url == url &&
        other.title == title &&
        other.attribute == attribute &&
        other.showLoader == showLoader;
  }

  @override
  int get hashCode => url.hashCode ^ title.hashCode ^ attribute.hashCode ^ showLoader.hashCode;
}
