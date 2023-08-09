import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ca_loan_calculator/core/values/constants.dart';
import 'package:ca_loan_calculator/app/domain/values/values.dart';

part 'calculator_event.dart';

part 'calculator_state.dart';

part 'calculator_bloc.freezed.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(const _Initial()) {
    on<_Calculate>(_onCalculate);
    on<_Clear>(_onClear);
  }

  void _onCalculate(_Calculate event, Emitter emit) {
    if (_validateData(
      rate: event.rate,
      creditTermInMonths: event.creditTermInMonths,
      creditAmount: event.creditAmount,
    )) {
      emit(const _Error(message: 'Проверьте корректность данных'));
      return;
    }
    double monthPayment = 0;
    switch (event.paymentType) {
      case PaymentType.annuity:
        monthPayment = event.creditAmount *
            (event.rate /
                (100 * 12) /
                (1 -
                    pow(1 + event.rate / (100 * 12),
                        -event.creditTermInMonths + 1)));
        break;
      case PaymentType.differentiated:
        final body = event.creditAmount / event.creditTermInMonths;
        final percents = event.creditAmount * (event.rate/100);
        monthPayment = body + percents;
        break;
    }

    final fullCreditAmount = monthPayment * event.creditTermInMonths;
    final overpayment = fullCreditAmount - event.creditAmount;

    emit(
      _Calculated(
        fullCreditAmount: fullCreditAmount,
        monthPayment: monthPayment,
        overpayment: overpayment,
      ),
    );
  }

  void _onClear(_Clear event, Emitter emit) {
    emit(const _Initial());
  }

  bool _validateData(
          {required double rate,
          required int creditTermInMonths,
          required double creditAmount}) =>
      rate < Constants.minPercent && rate > Constants.maxPercent ||
      creditTermInMonths < Constants.minMonth ||
      creditTermInMonths > Constants.maxMonth ||
      creditAmount < Constants.minCreditSum ||
      creditAmount > Constants.maxCreditSum;
}
