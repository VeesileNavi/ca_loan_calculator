import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ca_loan_calculator/app/presentation/services/services.dart';

class FloatingNumberTextField extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onValueChanged;
  final TextEditingController? controller;
  final bool hasError;

  const FloatingNumberTextField({
    super.key,
    this.inputFormatters,
    this.onValueChanged,
    this.hasError = true, this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: controller,
          onChanged: onValueChanged,
          inputFormatters: [
            SingleFloatingPointFormatter(),
            OnlyDigitsFormatter(),
            ...?inputFormatters
          ],
          keyboardType: TextInputType.number,
        ),
        if (hasError && controller?.text != '')
          const Text(
            'Проверьте ввод',
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }
}
