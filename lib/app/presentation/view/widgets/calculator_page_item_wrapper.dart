import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculatorPageItemWrapper extends StatelessWidget {
  final Widget child;
  final String title;

  const CalculatorPageItemWrapper(
      {super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(4, 4)),
          ],
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          const SizedBox(
            height: 8,
          ),
          child,
        ],
      ),
    );
  }
}
