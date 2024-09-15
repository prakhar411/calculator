import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String display = '0';
  String expression = '';
  String _operation = '';
  double _firstOperand = 0;
  double _secondOperand = 0;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        display = '0';
        expression = '';
        _firstOperand = 0;
        _secondOperand = 0;
        _operation = '';
      } else if (buttonText == '⌫') {
        display =
            display.length > 1 ? display.substring(0, display.length - 1) : '0';
      } else if (['+', '-', '*', '/'].contains(buttonText)) {
        _firstOperand = double.tryParse(display) ?? 0;
        _operation = buttonText;
        expression = '$display $buttonText';
        display = '0';
      } else if (buttonText == '=') {
        _secondOperand = double.tryParse(display) ?? 0;
        expression += ' $display';
        switch (_operation) {
          case '+':
            display = (_firstOperand + _secondOperand).toString();
            break;
          case '-':
            display = (_firstOperand - _secondOperand).toString();
            break;
          case '*':
            display = (_firstOperand * _secondOperand).toString();
            break;
          case '/':
            display = _secondOperand != 0
                ? (_firstOperand / _secondOperand).toString()
                : 'Error';
            break;
        }
        _operation = '';
      } else if (buttonText == '±') {
        display = display.startsWith('-') ? display.substring(1) : '-$display';
      } else if (buttonText == '%') {
        display = (double.tryParse(display) ?? 0 / 100).toString();
      } else {
        display = display == '0' ? buttonText : display + buttonText;
      }
    });
  }

  Widget _buildButton(String buttonText, {Color? color, double fontSize = 24}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.blueGrey.shade700,
            padding: const EdgeInsets.symmetric(vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0, bottom: 8.0),
                    child: Text(
                      expression,
                      style: TextStyle(
                          fontSize: 24.0, color: Colors.grey.shade400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      display,
                      style: const TextStyle(
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _buildButton('C', color: Colors.redAccent),
                    _buildButton('⌫', color: Colors.orangeAccent),
                    _buildButton('%', color: Colors.orangeAccent),
                    _buildButton('/', color: Colors.orangeAccent),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('*', color: Colors.orangeAccent),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('-', color: Colors.orangeAccent),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('+', color: Colors.orangeAccent),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton('±', color: Colors.blueGrey.shade500),
                    _buildButton('0'),
                    _buildButton('.', color: Colors.blueGrey.shade500),
                    _buildButton('=', color: Colors.greenAccent),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
