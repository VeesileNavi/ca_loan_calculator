import 'package:ca_loan_calculator/core/values/constants.dart';
import 'package:flutter/cupertino.dart';

class MonthSlider extends StatefulWidget {
  final ValueChanged<int> onEnd;
  final int value;
  const MonthSlider({super.key, required this.onEnd, required this.value});

  @override
  State<MonthSlider> createState() => _MonthSliderState();
}

class _MonthSliderState extends State<MonthSlider> {
  late int _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }
  @override
  void didUpdateWidget(covariant MonthSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.value!=widget.value){
      _selectedValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoSlider(
            onChangeEnd: (value) => widget.onEnd.call(value.toInt()),
            value: _selectedValue.toDouble(),
            max: Constants.maxMonth.toDouble(),
            min: Constants.minMonth.toDouble(),
            onChanged: (value) => setState(
              () {
                _selectedValue = value.toInt();
              },
            ),
          ),
        ),
        Text('$_selectedValue мес.'),
      ],
    );
  }
}
