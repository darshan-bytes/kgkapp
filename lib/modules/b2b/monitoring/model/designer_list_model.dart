class DesignerListModel {
  String name;
  String image;
  bool isSelected;

  DesignerListModel({required this.name, required this.image, this.isSelected = false});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DesignerListModel && other.name == name && other.image == image && other.isSelected == isSelected;
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ isSelected.hashCode;
}
