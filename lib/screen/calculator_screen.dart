import 'package:calculator_app/bloc/calculator/calculator_bloc.dart';
import 'package:calculator_app/bloc/calculator/calculator_event.dart';
import 'package:calculator_app/bloc/calculator/calculator_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "String Calculator",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter numbers (e.g., 2,3,4)',
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<CalculatorBloc>(context)
                        .add(CalculateSum(_controller.text));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [Color(0xFFF2994A), Color(0xFFF2C94C)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                          offset: Offset(2, 6),
                        ),
                      ],
                    ),
                    child: Text(
                      "Calculate",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                BlocBuilder<CalculatorBloc, CalculatorState>(
                  builder: (context, state) {
                    String resultText = "Result: 0";
                    Color textColor = Colors.white;

                    if (state is CalculatorSuccess) {
                      print("Result: ${state.sum}");
                      resultText = "Result: ${state.sum}";
                      textColor = Colors.greenAccent;
                    } else if (state is CalculatorFailure) {
                      print("Error: ${state.error}");
                      resultText = "Error: ${state.error}";
                      textColor = Colors.redAccent;
                    }

                    return Text(
                      resultText,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                        shadows: [
                          Shadow(color: Colors.black45, blurRadius: 4),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
