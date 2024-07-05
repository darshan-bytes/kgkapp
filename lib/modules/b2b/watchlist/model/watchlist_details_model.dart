import 'package:kgk/kgk.dart';

class WatchlistDetailsModel {
  int? id;
  String? name;
  String? description;
  String? remainingTime;
  String? watchlistFromDate;
  String? watchlistToDate;
  String? watchlistStatus;

  WatchlistDetailsModel({
    this.id,
    this.name,
    this.description,
    this.remainingTime,
    this.watchlistFromDate,
    this.watchlistToDate,
    this.watchlistStatus,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WatchlistDetailsModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.remainingTime == remainingTime &&
        other.watchlistFromDate == watchlistFromDate &&
        other.watchlistToDate == watchlistToDate &&
        other.watchlistStatus == watchlistStatus;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      remainingTime.hashCode ^
      watchlistFromDate.hashCode ^
      watchlistToDate.hashCode ^
      watchlistStatus.hashCode;
}

extension WatchlistDetailsModelExtension on WatchlistDetailsModel {
  ProjectStatus get status =>
      ProjectStatus.values.firstWhereOrNull((element) => element.value == watchlistStatus) ?? ProjectStatus.inActive;
}
