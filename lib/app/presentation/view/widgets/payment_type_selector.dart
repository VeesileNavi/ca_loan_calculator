import 'package:ca_loan_calculator/app/presentation/values/payment_type.dart';
import 'package:flutter/cupertino.dart';

class PaymentTypeSelector extends StatelessWidget {
  final ValueChanged<PaymentType> onValueChanged;
  final PaymentType value;
  const PaymentTypeSelector({super.key, required this.onValueChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControl<PaymentType>(
      children: const {
        PaymentType.differentiated:
            _PaymentTypeSelectorItem(title: 'Дифференцированный'),
        PaymentType.annuity: _PaymentTypeSelectorItem(title: 'Аннуитентный'),
      },
      onValueChanged: onValueChanged,
      groupValue: value,
    );
  }
}

class _PaymentTypeSelectorItem extends StatelessWidget {
  final String title;

  const _PaymentTypeSelectorItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: FittedBox(child: Text(title)),
    );
  }
}
