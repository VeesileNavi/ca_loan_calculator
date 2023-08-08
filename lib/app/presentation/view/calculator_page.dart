import 'package:ca_loan_calculator/app/presentation/services/input_formatters/max_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ca_loan_calculator/core/core.dart';
import 'package:ca_loan_calculator/app/domain/domain.dart';
import 'package:ca_loan_calculator/app/internal/internal.dart';
import 'package:ca_loan_calculator/app/presentation/view_model/view_model.dart';
import 'widgets/widgets.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculatorModule.makeCalculatorBloc(),
      child: _CalculatorView(CalculatorViewModel()),
    );
  }
}

class _CalculatorView extends StatefulWidget {
  const _CalculatorView(this.calculatorViewModel);

  final CalculatorViewModel calculatorViewModel;

  @override
  State<_CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<_CalculatorView> {
  final TextEditingController _loanAmountController = TextEditingController();
  final TextEditingController _percentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Кредитный калькулятор'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: ListenableBuilder(
          listenable: widget.calculatorViewModel,
          builder: (BuildContext context, Widget? child) => ListView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            children: [
              CalculatorPageItemWrapper(
                title: 'Тип платежей',
                child: PaymentTypeSelector(
                  onValueChanged: (value) =>
                      widget.calculatorViewModel.setPaymentType(value),
                  value: widget.calculatorViewModel.paymentType,
                ),
              ),
              CalculatorPageItemWrapper(
                title: 'Сумма кредита',
                child: FloatingNumberTextField(
                  controller: _loanAmountController,
                  inputFormatters: [
                    MaxFormatter(Constants.maxCreditSum.toDouble()),
                  ],
                  hasError: widget.calculatorViewModel.creditAmount == null,
                  onValueChanged: (value) =>
                      widget.calculatorViewModel.setCreditAmount(value),
                ),
              ),
              CalculatorPageItemWrapper(
                title: 'Процентная ставка',
                child: FloatingNumberTextField(
                  controller: _percentController,
                  inputFormatters: [
                    MaxFormatter(Constants.maxPercent.toDouble()),
                  ],
                  hasError: widget.calculatorViewModel.percent == null,
                  onValueChanged: (value) =>
                      widget.calculatorViewModel.setPercent(value),
                ),
              ),
              CalculatorPageItemWrapper(
                title: 'Срок кредита (мес.)',
                child: MonthSlider(
                  onEnd: (int value) =>
                      widget.calculatorViewModel.setMonth(value),
                  value: widget.calculatorViewModel.months,
                ),
              ),
              CupertinoButton(
                onPressed: widget.calculatorViewModel.inputValid
                    ? () => context.read<CalculatorBloc>().add(
                          CalculatorEvent.calculate(
                            paymentType: widget.calculatorViewModel.paymentType,
                            creditAmount:
                                widget.calculatorViewModel.creditAmount!,
                            rate: widget.calculatorViewModel.percent!,
                            creditTermInMonths: widget.calculatorViewModel.months,
                          ),
                        )
                    : null,
                child: const Text('Рассчитать'),
              ),
              CupertinoButton(
                onPressed: () => _clear(context),
                child: const Text(
                  'Очистить',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              BlocBuilder<CalculatorBloc, CalculatorState>(
                builder: (context, state) => state.when(
                    calculated: (
                      fullCreditAmount,
                      monthPayment,
                      overpayment,
                    ) =>
                        CalculatorPageItemWrapper(
                            title: 'Результаты',
                            child: ResultsWidget(
                              fullCreditAmount: fullCreditAmount,
                              monthPayment: monthPayment,
                              overpayment: overpayment,
                            )),
                    error: (error) => const CalculatorPageItemWrapper(
                          title: 'Ошибка',
                          child: Text('error'),
                        ),
                    initial: () => const SizedBox.shrink()),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _clear(BuildContext context) {
    context.read<CalculatorBloc>().add(const CalculatorEvent.clear());
    _loanAmountController.clear();
    _percentController.clear();
    widget.calculatorViewModel.clear();
  }
}
