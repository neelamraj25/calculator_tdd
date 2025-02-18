import 'package:equatable/equatable.dart';

abstract class CalculatorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CalculateSum extends CalculatorEvent {
  final String numbers;
  CalculateSum(this.numbers);
}
