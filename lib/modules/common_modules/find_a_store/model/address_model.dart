import 'package:kgk/kgk.dart';

class AddressModel {
  String? storeName;
  String? storeDistance;
  String? storeAddress;
  bool isExpanded;
  GlobalKey<SmartExpansionTileState> addressDetailsKey;

  AddressModel({this.storeName, this.storeDistance, this.storeAddress, this.isExpanded = false, required this.addressDetailsKey});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressModel &&
          runtimeType == other.runtimeType &&
          storeName == other.storeName &&
          storeDistance == other.storeDistance &&
          storeAddress == other.storeAddress &&
          isExpanded == other.isExpanded &&
          addressDetailsKey == other.addressDetailsKey;

  @override
  int get hashCode =>
      storeName.hashCode ^ storeDistance.hashCode ^ storeAddress.hashCode ^ isExpanded.hashCode ^ addressDetailsKey.hashCode;
}
