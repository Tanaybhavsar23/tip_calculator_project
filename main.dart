import 'package:flutter/material.dart';

void main() {
  runApp(const TipCalculatorApp());
}

class TipCalculatorApp extends StatelessWidget {
  const TipCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tip Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF3F6FB),
      ),
      home: const TipPage(),
    );
  }
}

class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  final TextEditingController _billController = TextEditingController();

  double bill = 0;
  double tipPercent = 10;
  int people = 1;

  double get tip => bill * tipPercent / 100;
  double get total => bill + tip;
  double get tipPerPerson => tip / people;
  double get perPerson => total / people;

  String formatAmount(double amount) => '₹${amount.toStringAsFixed(2)}';

  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  void updateBill(String value) {
    final parsedAmount = double.tryParse(value.trim());
    setState(() {
      bill = parsedAmount != null && parsedAmount.isFinite && parsedAmount > 0
          ? parsedAmount
          : 0;
    });
  }

  Widget resultRow(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16)),
        Text(
          amount,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tip Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Calculate your bill',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Enter your bill and split it easily.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 25),

            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bill Amount',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _billController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        prefixText: '₹ ',
                        hintText: 'Enter bill amount',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: updateBill,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tip Percentage: ${tipPercent.round()}%',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider(
                      value: tipPercent,
                      min: 0,
                      max: 30,
                      divisions: 30,
                      activeColor: Colors.blue,
                      label: '${tipPercent.round()}%',
                      onChanged: (value) {
                        setState(() => tipPercent = value);
                      },
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('0%'), Text('30%')],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),

            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Split Between',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          tooltip: 'Remove one person',
                          onPressed: () {
                            if (people > 1) {
                              setState(() => people--);
                            }
                          },
                          icon: const Icon(Icons.remove_circle),
                          color: Colors.blue,
                        ),
                        Text(
                          '$people',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          tooltip: 'Add one person',
                          onPressed: () {
                            setState(() => people++);
                          },
                          icon: const Icon(Icons.add_circle),
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),

            const Text(
              'Bill Summary',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              color: Colors.white,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    resultRow('Tip Amount', formatAmount(tip)),
                    const Divider(height: 25),
                    resultRow('Total Bill', formatAmount(total)),
                    const Divider(height: 25),
                    resultRow('Tip Per Person', formatAmount(tipPerPerson)),
                    const Divider(height: 25),
                    const Text(
                      'Each Person Pays',
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatAmount(perPerson),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Thank you for using Tip Calculator!',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
