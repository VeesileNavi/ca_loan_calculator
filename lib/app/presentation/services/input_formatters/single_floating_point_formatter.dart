import 'package:flutter/services.dart';

class SingleFloatingPointFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (_containsFloatingPoint(oldValue.text) &&
        _floatingPointAtEnd(newValue.text)) {
      final text = newValue.text.replaceFirst(RegExp(r'[,.]'), '');

      return TextEditingValue(
        text: text,
        selection: TextSelection.fromPosition(
          TextPosition(
            offset: text.length,
          ),
        ),
      );
    }

    return newValue;
  }

  bool _containsFloatingPoint(String text) =>
      text.contains('.') || text.contains(',');

  bool _floatingPointAtEnd(String text) =>
      text[text.length - 1] == ',' || text[text.length - 1] == '.';
}
