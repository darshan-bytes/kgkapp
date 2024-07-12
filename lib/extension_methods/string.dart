import 'package:kgk/kgk.dart';

extension NullableStringExtensions<E> on String? {
  /// Returns `true` if this string is `null` or empty.
  bool get isNullOrEmpty {
    return this?.isEmpty ?? true;
  }

  /// Returns `true` if this string is not `null` and not empty.
  bool get isNotNullNorEmpty {
    return this?.isNotEmpty ?? false;
  }

  double? get toDouble => double.tryParse(toString());

  int? get toInt => int.tryParse(toString());
}

extension StringExtensions on String {
  String get tr {
    try {
      return AppLocalizations.of(getNavigatorKeyContext)!.translate(this) ?? this;
    } catch (e) {
      return '-';
    }
  }

  String get toUpperCamelCase {
    return split(' ').map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase()).join(' ');
  }

  String get capitalizeFirst {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get getInitials {
    if (trim().isEmpty) {
      return '';
    }
    List<String> nameParts = trim().split(' ');
    if (nameParts.isEmpty) {
      return '';
    }
    if (nameParts.length == 1) {
      if (nameParts[0].length == 1) {
        return nameParts[0].substring(0, 1);
      } else {
        return nameParts[0].substring(0, 2);
      }
    } else {
      return nameParts[0][0].toUpperCase() + nameParts[1][0];
    }
  }

  String interpolate(List params) {
    String result = this;
    for (int i = 1; i < params.length + 1; i++) {
      result = result.replaceFirst('{#}', params[i - 1].toString());
    }
    return result;
  }

  Uint8List get toBytes => base64Decode(this);

  bool get isSvgUrl => toLowerCase().endsWith('.svg');

  String get base64ToString => utf8.decode(base64.decode(this));

  String get utf8convert {
    try {
      List<int> bytes = toString().codeUnits;
      return utf8.decode(bytes);
    } catch (e) {
      return this;
    }
  }

  ImageType get imageType {
    if (startsWith('http')) {
      return ImageType.network;
    } else if (toLowerCase().endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('assets/') && endsWith('.png')) {
      return ImageType.asset;
    } else {
      return ImageType.file;
    }
  }

  DateTime? stringToDateTime({String? inputDateFormat}) {
    if (inputDateFormat != null) {
      return DateFormat(inputDateFormat).parse(this).toLocal();
    } else {
      return DateTime.tryParse(this)?.toLocal();
    }
  }

  String changeDateFormat(
      {String inputDateFormat = DateFormatter.dateFormatYYYYMMDDHHMMSS, String outputDateFormat = DateFormatter.dateFormatDDMMMYYYY}) {
    return DateFormat(outputDateFormat).format(DateFormat(inputDateFormat).parse(this));
  }
}
