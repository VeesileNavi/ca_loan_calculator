import 'package:flutter/services.dart';

class MaxFormatter extends TextInputFormatter {
  final double max;

  MaxFormatter(this.max);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else if (double.parse(newValue.text) > max) {
      final text = max.toStringAsFixed(2);
      return TextEditingValue(
        text: text,
        selection: TextSelection.fromPosition(
          TextPosition(offset: text.length),
        ),
      );
    } else {
      return double.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}
