import 'package:kgk/kgk.dart';

class DoubleInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final String newText = newValue.text;

    // Allow empty input
    if (newText.isEmpty) {
      return newValue;
    }

    // Regular expression for valid double values
    final RegExp regex = RegExp(r'^-?\d*\.?\d*$');

    // If new text matches the regular expression, return it as the new value
    if (regex.hasMatch(newText)) {
      return newValue;
    }

    // If it doesn't match, return the old value to prevent invalid input
    return oldValue;
  }
}
