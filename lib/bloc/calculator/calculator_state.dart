import 'package:equatable/equatable.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object> get props => [];
}

class CalculatorInitial extends CalculatorState {}

class CalculatorSuccess extends CalculatorState {
  final int sum;
  const CalculatorSuccess(this.sum);
}

class CalculatorFailure extends CalculatorState {
  final String error;
  const CalculatorFailure(this.error);
}

