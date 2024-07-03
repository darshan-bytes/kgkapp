import 'package:kgk/kgk.dart';

class WatchlistSelectionModel {
  final String name;
  bool isSelected = false;

  WatchlistSelectionModel({required this.name, this.isSelected = false});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WatchlistSelectionModel && other.name == name && other.isSelected == isSelected;
  }

  @override
  int get hashCode => name.hashCode ^ isSelected.hashCode;
}
