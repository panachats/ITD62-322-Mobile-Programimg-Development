import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: vat());
  }
}

class vat extends StatefulWidget {
  const vat({super.key});

  @override
  State<vat> createState() => _vatState();
}

class _vatState extends State<vat> {
  double total_price = 0;
  double vat = 0;
  double net_price = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("VAT 7%"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Total Price',
                ),
                onChanged: (value) {
                  setState(() {
                    total_price = double.tryParse(value) ?? 0;
                  });
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                vat = total_price * 0.07;
                net_price = total_price - vat;
                setState(() {});
              },
              icon: Icon(
                Icons.calculate,
                size: 24.0,
              ),
              label: Text('Calculate'),
            ),
            SizedBox(height: 10),
            Text(
              "Total Price: ${NumberFormat('###,###.##').format(total_price)}\n VAT: ${NumberFormat('###,###.##').format(vat)}\n Net Price: ${NumberFormat('###,###.##').format(net_price)}",
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
