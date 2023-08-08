part of 'calculator_bloc.dart';

@freezed
class CalculatorEvent with _$CalculatorEvent {
  const factory CalculatorEvent.clear() = _Clear;

  const factory CalculatorEvent.calculate({
    required PaymentType paymentType,
    required double creditAmount,
    required double rate,
    required int creditTermInMonths,
  }) = _Calculate;
}
