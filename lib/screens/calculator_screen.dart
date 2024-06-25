import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _input = "";
  double _num1 = 0;
  String _operand = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _input = "";
        _num1 = 0;
        _operand = "";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "/") {
        _num1 = double.parse(_output);
        _operand = buttonText;
        _input = "";
        _output = "0";
      } else if (buttonText == "=") {
        double num2 = double.parse(_output);
        if (_operand == "+") {
          _output = (_num1 + num2).toString();
        }
        if (_operand == "-") {
          _output = (_num1 - num2).toString();
        }
        if (_operand == "x") {
          _output = (_num1 * num2).toString();
        }
        if (_operand == "/") {
          _output = (_num1 / num2).toString();
        }
        _num1 = 0;
        _operand = "";
      } else {
        if (_output == "0") {
          _output = buttonText;
        } else {
          _output = _output + buttonText;
        }
      }
    });
  }

  Widget _buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => _buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
          child: Text(
            _output,
            style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Divider(),
        ),
        Column(
          children: [
            Row(children: [_buildButton("7"), _buildButton("8"), _buildButton("9"), _buildButton("/")]),
            Row(children: [_buildButton("4"), _buildButton("5"), _buildButton("6"), _buildButton("x")]),
            Row(children: [_buildButton("1"), _buildButton("2"), _buildButton("3"), _buildButton("-")]),
            Row(children: [_buildButton("C"), _buildButton("0"), _buildButton("="), _buildButton("+")]),
          ],
        ),
      ],
    );
  }
}