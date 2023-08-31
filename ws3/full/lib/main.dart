import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFF9B0D1C,
          <int, Color>{
            50: Color(0xFF9B0D1C),
            100: Color(0xFF9B0D1C),
            200: Color(0xFF9B0D1C),
            300: Color(0xFF9B0D1C),
            400: Color(0xFF9B0D1C),
            500: Color(0xFF9B0D1C), // สีหลักที่ใช้ในแอปพลิเคชัน
            600: Color(0xFF9B0D1C),
            700: Color(0xFF9B0D1C),
            800: Color(0xFF9B0D1C),
            900: Color(0xFF9B0D1C),
          },
        ),
      ),
      home: _CounterArea(),
    );
  }
}

class _CounterArea extends StatefulWidget {
  const _CounterArea({Key? key}) : super(key: key);

  @override
  State<_CounterArea> createState() => __CounterAreaState();
}

class __CounterAreaState extends State<_CounterArea> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  int height = 0;
  int weight = 0;
  double bmi = 0;
  String status = '';

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF9B0D1C),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/3373/3373118.png',
                color: Colors.white,
                scale: 16,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Simple BMI".toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:
                      const Color.fromARGB(255, 255, 255, 255), //<-- SEE HERE
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              Text(
                "Calculater BMI",
                style: const TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9B0D1C),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: weightController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    labelText: 'Weight (Kg.)',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      splashColor: Colors.red, // สีพื้นหลังที่แสดงเมื่อกดปุ่ม
                      highlightColor: Colors
                          .transparent, // สีพื้นหลังที่แสดงเมื่อกดค้างปุ่ม
                      color: Colors.red, // สีไอคอน
                      onPressed: weightController.clear,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      weight = int.tryParse(value) ?? 0;
                    });
                    print(weight);
                  },
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: heightController,
                  decoration: InputDecoration(
                    labelText: 'Height (Cm.)',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      splashColor: Colors.red, // สีพื้นหลังที่แสดงเมื่อกดปุ่ม
                      highlightColor: Colors
                          .transparent, // สีพื้นหลังที่แสดงเมื่อกดค้างปุ่ม
                      color: Colors.red, // สีไอคอน
                      onPressed: heightController.clear,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      height = int.tryParse(value) ??
                          0; //แปลงค่าให้เป็นจำนวนเต็ม หากแปลงไม่ได้จะส่งค่า 0
                    });
                    print(height);
                  },
                ),
              ),
              SizedBox(height: 10),
              Text("BMI Result"),
              Text(
                "${bmi.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9B0D1C),
                ),
              ),
              Text(status),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.calculate_outlined),
          onPressed: () {
            if (heightController.text.isEmpty ||
                weightController.text.isEmpty) {
              showAlertDialog(context, 'Please Enter value.');
            } else {
              setState(() {
                if (height != 0 || weight != 0) {
                  bmi = weight / pow(height / 100, 2);

                  if (bmi < 18.5) {
                    print('ผอมเกินไป');
                    status = 'ผอมเกินไป';
                  } else if (bmi <= 24) {
                    print('น้ำหนักปกติ เหมาะสม');
                    status = 'น้ำหนักปกติ เหมาะสม';
                  } else if (bmi <= 29.9) {
                    status = 'อ้วน';
                    print('อ้วน');
                  } else {
                    status = 'อ้วนมาก';
                    print('อ้วนมาก');
                  }
                } else {
                  print('Error');
                  showAlertDialog(
                      context, 'Please Enter value Number or greater than 0.');
                }
                print(bmi.toStringAsFixed(2));
              });
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  // Function to show the alert dialog
  void showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text(message),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
