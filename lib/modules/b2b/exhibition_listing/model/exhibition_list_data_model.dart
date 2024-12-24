import 'package:kgk/kgk.dart';

class ExhibitionListDataModel {
  String? name;
  String? description;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? venue;
  String? createdBy;
  String? updatedBy;
  String? exhibitionType;
  String? fileReferenceId;
  String? status;
  String? id;
  String? boothInfo;
  String? cscCode;
  String? city;
  String? state;
  String? fileUrl;
  UserIdDetails? createdByDetails;
  UserIdDetails? updatedByDetails;

  ExhibitionListDataModel(
      {this.name,
      this.description,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.venue,
      this.createdBy,
      this.updatedBy,
      this.exhibitionType,
      this.fileReferenceId,
      this.status,
      this.id,
      this.boothInfo,
      this.cscCode,
      this.city,
      this.state,
      this.fileUrl,
      this.createdByDetails,
      this.updatedByDetails});

  ExhibitionListDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    venue = json['venue'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    exhibitionType = json['exhibition_type'];
    fileReferenceId = json['file_reference_id'];
    status = json['status'];
    id = json['id'];
    boothInfo = json['booth_info'];
    cscCode = json['csc_code'];
    city = json['city'];
    state = json['state'];
    fileUrl = json['file_url'];
    createdByDetails = json['created_by_details'] != null ? UserIdDetails.fromJson(json['created_by_details']) : null;
    updatedByDetails = json['updated_by_details'] != null ? UserIdDetails.fromJson(json['updated_by_details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['venue'] = venue;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['exhibition_type'] = exhibitionType;
    data['file_reference_id'] = fileReferenceId;
    data['status'] = status;
    data['id'] = id;
    data['booth_info'] = boothInfo;
    data['csc_code'] = cscCode;
    data['city'] = city;
    data['state'] = state;
    data['file_url'] = fileUrl;
    if (createdByDetails != null) {
      data['created_by_details'] = createdByDetails!.toJson();
    }
    if (updatedByDetails != null) {
      data['updated_by_details'] = updatedByDetails!.toJson();
    }
    return data;
  }
}

extension ExhibitionListDataExtension on ExhibitionListDataModel {
  String get fullDate => "${startDate?.changeDateFormat(
        outputDateFormat: DateFormatter.dateFormatDD,
        inputDateFormat: DateFormatter.dateFormatYYYYMMDD,
      )} - ${endDate?.changeDateFormat(
        outputDateFormat: DateFormatter.dateFormatDDMMMYY,
        inputDateFormat: DateFormatter.dateFormatYYYYMMDD,
      )}";
  String get fullTime => "${startTime?.changeDateFormat(
        outputDateFormat: DateFormatter.timeFormatHA,
        inputDateFormat: DateFormatter.timeFormat,
      )} - ${endTime?.changeDateFormat(
        outputDateFormat: DateFormatter.timeFormatHA,
        inputDateFormat: DateFormatter.timeFormat,
      )}";
}
