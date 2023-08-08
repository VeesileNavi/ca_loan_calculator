part of 'calculator_bloc.dart';

@freezed
class CalculatorState with _$CalculatorState {
  const factory CalculatorState.calculated({
    required double fullCreditAmount,
    required double monthPayment,
    required double overpayment,
  }) = _Calculated;

  const factory CalculatorState.initial() = _Initial;

  const factory CalculatorState.error({required String message}) = _Error;
}
