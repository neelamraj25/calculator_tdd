import 'package:bloc_test/bloc_test.dart';
import 'package:calculator_app/bloc/calculator/calculator_bloc.dart';
import 'package:calculator_app/bloc/calculator/calculator_event.dart';
import 'package:calculator_app/bloc/calculator/calculator_state.dart';
import 'package:calculator_app/screen/calculator_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/test.dart';

void main() {
  group('CalculatorBloc', () {
    late CalculatorBloc calculatorBloc;

    setUp(() {
      calculatorBloc = CalculatorBloc();
    });

    tearDown(() {
      calculatorBloc.close();
    });

    test('initial state is CalculatorInitial', () {
      expect(calculatorBloc.state, CalculatorInitial());
    });

    blocTest<CalculatorBloc, CalculatorState>(
      'emits [CalculatorSuccess(0)] when input is empty',
      build: () => calculatorBloc,
      act: (bloc) => bloc.add(CalculateSum("")),
      expect: () => [const CalculatorSuccess(0)],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'emits [CalculatorSuccess(6)] for input "1,5"',
      build: () => calculatorBloc,
      act: (bloc) => bloc.add(CalculateSum("1,5")),
      expect: () => [const CalculatorSuccess(6)],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'handles new lines as delimiters',
      build: () => calculatorBloc,
      act: (bloc) => bloc.add(CalculateSum("1\n2,3")),
      expect: () => [const CalculatorSuccess(6)],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'handles custom delimiters "//;\n1;2"',
      build: () => calculatorBloc,
      act: (bloc) => bloc.add(CalculateSum("//;\n1;2")),
      expect: () => [const CalculatorSuccess(3)],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'throws exception for negative numbers',
      build: () => calculatorBloc,
      act: (bloc) => bloc.add(CalculateSum("1,-2,3,-5")),
      expect: () =>
          [CalculatorFailure("Exception: Negatives not allowed: -2, -5")],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'ignores numbers greater than 1000',
      build: () => calculatorBloc,
      act: (bloc) => bloc.add(CalculateSum("2,1001")),
      expect: () => [const CalculatorSuccess(2)],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'handles multiple delimiters with different lengths "//[***]\n1***2***3"',
      build: () => calculatorBloc,
      act: (bloc) => bloc.add(CalculateSum("//[***]\n1***2***3")),
      expect: () => [const CalculatorSuccess(6)],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'handles multiple delimiters "//[*][%]\n1*2%3"',
      build: () => calculatorBloc,
      act: (bloc) => bloc.add(CalculateSum("//[*][%]\n1*2%3")),
      expect: () => [const CalculatorSuccess(6)],
    );
  });

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CalculatorBloc(),
        child: MaterialApp(
          home: CalculatorScreen(),
        ),
      ),
    );
  }
}
