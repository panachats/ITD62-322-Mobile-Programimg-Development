import 'package:flutter/material.dart';
import 'package:flutter_application_1/covid_today_result.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CovidToday());
  }
}

class CovidToday extends StatefulWidget {
  const CovidToday({super.key});

  @override
  State<CovidToday> createState() => _CovidTodayState();
}

class _CovidTodayState extends State<CovidToday> {
  CovidTodayResult result = CovidTodayResult();
  @override
  void initState() {
    // TODO: implement initState
    super.initState(); //ไปเรียกตัวแม่
    print("init state");
    getData();
  }

  Future<void> getData() async {
    print("get data");
    try {
      var url = Uri.https("covid19.th-stat.com", "/api/open/today");
      var response = await http.get(url); //เก็บข้อมูลการตอบกลับของ http
      print(response.body);
      setState(() {
        result = covidTodayResultFromJson(response.body);
      });
    } catch (e) {
      print("ERROR");
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    print("build state");
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid Today"),
      ),
      body: ListView(children: [
        ListTile(
          title: Text("ผู้เป่วยคิดเชื้อสะสม"),
          subtitle: Text("${result?.confirmed ?? '...'}"),
        ),
        ListTile(
          title: Text("หายแล้ว"),
          subtitle: Text("${result?.recovered ?? '...'}"),
        ),
        ListTile(
          title: Text("รักษาตัว"),
          subtitle: Text("${result?.hospitalized ?? '...'}"),
        ),
        ListTile(
          title: Text("เสียชีวิต"),
          subtitle: Text("${result?.deaths ?? '...'}"),
        ),
      ]),
    );
  }
}
