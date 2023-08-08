import 'package:flutter/services.dart';

class OnlyDigitsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final numberAndFloatingDotPattern = RegExp(r"[0-9,.]*");
    final text = numberAndFloatingDotPattern.stringMatch(newValue.text);

    return TextEditingValue(
      text: text ?? '',
      selection: TextSelection.fromPosition(
        TextPosition(
          offset: text?.length ?? -1,
        ),
      ),
    );
  }
}
