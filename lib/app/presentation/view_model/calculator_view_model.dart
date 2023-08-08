import 'package:ca_loan_calculator/app/presentation/values/payment_type.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/values/constants.dart';

class CalculatorViewModel extends ChangeNotifier {

  ///Loan amount
  double? get creditAmount => _creditAmount;
  double? _creditAmount;

  void setCreditAmount(String text) {
    var number = double.tryParse(text);
    if (number != null &&
        number >= Constants.minCreditSum &&
        number <= Constants.maxCreditSum) {
      _creditAmount = number;
    } else {
      _creditAmount = null;
    }
    notifyListeners();
  }

  ///Months
  int get months => _months;
  int _months = Constants.minMonth;

  void setMonth(int month) {
    _months = month;
    notifyListeners();
  }

  ///Type
  PaymentType get paymentType => _paymentType;
  PaymentType _paymentType = PaymentType.differentiated;

  void setPaymentType(PaymentType type) {
    _paymentType = type;
    notifyListeners();
  }

  ///Percents
  double? get percent => _percent;
  double? _percent;

  void setPercent(String text) {
    var number = double.tryParse(text)?.ceilToDouble();
    if (number != null &&
        number >= Constants.minPercent &&
        number <= Constants.maxPercent) {
      _percent = number;
    } else {
      _percent = null;
    }
    notifyListeners();
  }

  ///Flag that indicates is everything valid
  bool get inputValid => _percent != null && creditAmount != null;

  ///Clear

  void clear() {
    _creditAmount = null;
    _months = Constants.minMonth;
    _paymentType = PaymentType.differentiated;
    _percent = null;
    notifyListeners();
  }
}
