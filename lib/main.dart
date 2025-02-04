import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daniel Tran Calculator',
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _expression = "";
  String _result = "";

  void _onPressed(String value) {
    setState(() {
      if (value == "C") {
        _expression = "";
        _result = "";
      } else if (value == "=") {
        try {
          final parser = ExpressionParser();
          final exp = parser.parse(_expression);
          final evaluator = const ExpressionEvaluator();
          _result = evaluator.eval(exp, {}).toString();
        } catch (e) {
          _result = "Error";
        }
      } else if (value == "x²") {
        // Square the last number
        if (_expression.isNotEmpty) {
          _expression += "²";
          try {
            final num lastNumber =
                double.parse(_expression.replaceAll("²", ""));
            _result = (lastNumber * lastNumber).toString();
          } catch (e) {
            _result = "Error";
          }
        }
      } else if (value == "%") {
        // Add modulo operator
        _expression += "%";
      } else {
        _expression += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daniel Tran Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Text(
                _expression,
                style:
                    const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Text(
                _result,
                style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
          ),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            children: [
              _buildButton("C", Colors.red),
              _buildButton("x²", Colors.orange),
              _buildButton("%", Colors.orange),
              _buildButton("/", Colors.blue),
              _buildButton("7", Colors.white),
              _buildButton("8", Colors.white),
              _buildButton("9", Colors.white),
              _buildButton("*", Colors.blue),
              _buildButton("4", Colors.white),
              _buildButton("5", Colors.white),
              _buildButton("6", Colors.white),
              _buildButton("-", Colors.blue),
              _buildButton("1", Colors.white),
              _buildButton("2", Colors.white),
              _buildButton("3", Colors.white),
              _buildButton("+", Colors.blue),
              _buildButton("0", Colors.white),
              _buildButton(".", Colors.white),
              _buildButton("=", Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String value, Color color) {
    return TextButton(
      onPressed: () => _onPressed(value),
      style: TextButton.styleFrom(
        foregroundColor: color,
        padding: const EdgeInsets.all(20),
      ),
      child: Text(
        value,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
