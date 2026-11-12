
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() =>
      _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final firstController = TextEditingController();
  final secondController = TextEditingController();

  String result = '0';

  void calculate(String operation) {
    double? num1 = double.tryParse(firstController.text);
    double? num2 = double.tryParse(secondController.text);

    if (num1 == null || num2 == null) {
      setState(() {
        result = 'Please enter valid numbers.';
      });
      return;
    }

    double answer = 0;

    switch (operation) {
      case '+':
        answer = num1 + num2;
        break;

      case '-':
        answer = num1 - num2;
        break;

      case '*':
        answer = num1 * num2;
        break;

      case '/':
        if (num2 == 0) {
          setState(() {
            result = 'Cannot divide by zero!';
          });
          return;
        }
        answer = num1 / num2;
        break;
    }

    setState(() {
      result = answer.toString();
    });
  }

  void clear() {
    firstController.clear();
    secondController.clear();

    setState(() {
      result = '0';
    });
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.calculate,
              size: 75,
              color: Colors.indigo,
            ),

            const SizedBox(height: 20),

            const Text(
              'Basic Calculator',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: firstController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'First Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.looks_one),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: secondController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Second Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.looks_two),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Select Operation',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => calculate('+'),
                  child: const Text('+'),
                ),

                ElevatedButton(
                  onPressed: () => calculate('-'),
                  child: const Text('-'),
                ),

                ElevatedButton(
                  onPressed: () => calculate('*'),
                  child: const Text('×'),
                ),

                ElevatedButton(
                  onPressed: () => calculate('/'),
                  child: const Text('÷'),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Card(
              color: Colors.indigo.shade50,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'RESULT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      result,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            OutlinedButton.icon(
              onPressed: clear,
              icon: const Icon(Icons.clear),
              label: const Text('Clear'),
            ),
          ],
        ),
      ),
    );
  }
}
