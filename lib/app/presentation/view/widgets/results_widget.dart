import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultsWidget extends StatelessWidget {
  final double fullCreditAmount, monthPayment, overpayment;

  const ResultsWidget(
      {super.key, required this.fullCreditAmount, required this.monthPayment, required this.overpayment});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ResultsItem(
          title: 'Полная сумма кредита', value: fullCreditAmount.toStringAsFixed(2),),
        const Divider(height: 8,),
        _ResultsItem(
          title: 'Платеж в месяц', value: monthPayment.toStringAsFixed(2),),
        const Divider(height: 8,),
        _ResultsItem(
          title: 'Переплата', value: overpayment.toStringAsFixed(2),),
      ],
    );
  }
}


class _ResultsItem extends StatelessWidget {
  final String title;
  final String value;

  const _ResultsItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey),),
        Text(value, style: const TextStyle(fontSize: 16,),)
      ],
    );
  }

}
