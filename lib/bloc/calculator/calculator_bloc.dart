import 'package:calculator_app/bloc/calculator/calculator_event.dart';
import 'package:calculator_app/bloc/calculator/calculator_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorInitial()) {
    on<CalculateSum>((event, emit) {
      try {
        emit(CalculatorInitial());
        int sum = _calculateSum(event.numbers);
        emit(CalculatorSuccess(sum));
      } catch (e) {
        emit(CalculatorFailure(e.toString()));
      }
    });
  }

  int _calculateSum(String input) {
    if (input.isEmpty) return 0;

    String delimiter = ',';
    String numberPart = input;

    if (input.startsWith('//')) {
      final newLineIndex = input.indexOf('\n');
      if (newLineIndex == -1) {
        throw Exception(
            "Invalid input format: Missing newline after delimiter declaration");
      }

      final delimiterPart = input.substring(2, newLineIndex);
      numberPart = input.substring(newLineIndex + 1);

      final delimiterMatches = RegExp(r'\[(.*?)\]').allMatches(delimiterPart);
      if (delimiterMatches.isNotEmpty) {
        delimiter =
            delimiterMatches.map((m) => RegExp.escape(m.group(1)!)).join('|');
      } else {
        delimiter = RegExp.escape(delimiterPart);
      }
    }

    final numbers = numberPart
        .split(RegExp('$delimiter|\n'))
        .where((e) => e.isNotEmpty)
        .toList();

    final parsedNumbers = <int>[];
    for (var num in numbers) {
      try {
        parsedNumbers.add(int.parse(num));
      } catch (e) {
        throw Exception("Invalid number format: '$num'");
      }
    }

    return parsedNumbers.where((n) => n <= 1000).fold(0, (a, b) => a + b);
  }
}
