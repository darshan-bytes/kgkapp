import 'package:kgk/kgk.dart';

/// Helper class for language detection and text processing
class LanguageHelper {
  /// Detects language from text and returns language code
  static String detectLanguage(String? text) {
    if (text == null || text.trim().isEmpty) {
      return StorageManager().getLocale()?.code ?? 'en';
    }

    // Extract valid text (letters/numbers only)
    String filteredText = _extractValidText(text);
    if (filteredText.isEmpty) {
      return StorageManager().getLocale()?.code ?? 'en';
    }

    try {
      // Check if numeric content first
      if (_isNumeric(filteredText)) {
        return 'en'; // English-style numbers
      } else if (_isCJKNumeric(filteredText)) {
        return 'ja'; // Japanese/Chinese numbers
      } else if (filteredText.length > 2) {
        return detect(filteredText);
      }
    } catch (e) {
      debugPrint("Language detection failed: $e");
    }

    return StorageManager().getLocale()?.code ?? 'en';
  }

  /// Removes symbols and keeps only letters/numbers
  static String _extractValidText(String text) {
    return text.replaceAll(RegExp(r'[^\w\u3040-\u30FF\u4E00-\u9FFF]'), '');
  }

  /// Checks if text contains only English numbers
  static bool _isNumeric(String text) {
    return RegExp(r'^[0-9]+$').hasMatch(text);
  }

  /// Checks if text contains only CJK numbers
  static bool _isCJKNumeric(String text) {
    return RegExp(r'^[\u4E00-\u9FFF]+$').hasMatch(text);
  }

  /// Applies font size adjustment based on language
  static double adjustFontSize(double baseFontSize, String languageCode) {
    return languageCode == 'ja' ? baseFontSize * 0.85 : baseFontSize;
  }
}
