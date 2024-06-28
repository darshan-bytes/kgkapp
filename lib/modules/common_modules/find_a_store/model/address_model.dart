import 'package:kgk/kgk.dart';

class AddressModel {
  String? storeName;
  String? storeDistance;
  String? storeAddress;
  bool isExpanded;
  GlobalKey<SmartExpansionTileState> addressDetailsKey;

  AddressModel({this.storeName, this.storeDistance, this.storeAddress, this.isExpanded = false, required this.addressDetailsKey});
}
