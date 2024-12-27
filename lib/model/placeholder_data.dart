class PlaceHolderData {
  final String companyName;
  final String imageUrl;

  PlaceHolderData({required this.companyName, required this.imageUrl});

  factory PlaceHolderData.fromJson(Map<String, dynamic> json) => PlaceHolderData(
        companyName: json["company_name"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "image_url": imageUrl,
      };
}
