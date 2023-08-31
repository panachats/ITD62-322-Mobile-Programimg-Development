import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:intl/intl.dart';
import 'package:prg2_weather_report/WeatherForecast.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: weatherReport(),
    );
  }
}

class weatherReport extends StatefulWidget {
  const weatherReport({super.key});

  @override
  State<weatherReport> createState() => _weatherReportState();
}

class _weatherReportState extends State<weatherReport> {
  WeatherForecast result = WeatherForecast();
  int? cloud;
  String date = '';
  TextStyle boldTextStyle = TextStyle(fontWeight: FontWeight.bold);
  @override
  void initState() {
    // TODO: implement initState
    super.initState(); //ไปเรียกตัวแม่
    print("init state");
    fetchData();
  }

  Future<void> fetchData() async {
    double lat = 8.570653662560213;
    double long = 99.7494661623066;
    DateTime now = DateTime.now();
    date = DateFormat('yyyy-MM-dd').format(now);
    String fields = "tc_max,tc_min,rh,rain,ws10m,wd10m,cond";
    String apiStr = "/nwpapi/v1/forecast/location/daily/at?";
    apiStr += "lat=$lat&lon=$long&date=$date&fields=$fields";
    var url = Uri.https("data.tmd.go.th", apiStr);
    try {
      var response = await https.get(url, headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY4NDFiY2UwNjBlYzA5ZjIwZWQyY2RiOGQzNTY3NWM2ZThjM2Q5YjhmZjczNjlkNmUzOWE1NWQ3NmQxM2NjMWUxYTZhNjlhZjMwZTAzMGMyIn0.eyJhdWQiOiIyIiwianRpIjoiNjg0MWJjZTA2MGVjMDlmMjBlZDJjZGI4ZDM1Njc1YzZlOGMzZDliOGZmNzM2OWQ2ZTM5YTU1ZDc2ZDEzY2MxZTFhNmE2OWFmMzBlMDMwYzIiLCJpYXQiOjE2OTEwNzIyNjgsIm5iZiI6MTY5MTA3MjI2OCwiZXhwIjoxNzIyNjk0NjY4LCJzdWIiOiIyNjUzIiwic2NvcGVzIjpbXX0.eFzsfG48UnJ7g745pejX1hkfzLt0hxTJk5lg6aryeSEK-l-cBrv1knpllpdCw8Kb6XwvH9mY3ZhO9kyfFvPsOWEm1-QJm9Z2HtnBJ9yFK3R6wiTAIbtJXUfqRsgPx-ZbF9CbNvLXj8Fyz4IvCE8wTUOtmClg5SyhDWWeZwy4Ye7cQir_uriZ4JNfSnK5k8ofbYhGn3xeea2imY2mpKlqZYyun95VjU5eCsGLmSvLfs8rjYv8r5ujBxYZEVvVBTQeO0vV_dG1Lz1EKEJzq9szB1QEZG5_gNgMK7QPBxyuOMyd6NmMs2p130lJaMWJhXVBe3o2lWMUcwtnTaXLjM050N824xA2Gnig_8fuuwvMeWzpXyJodw2DlKxvfjIzSzmNolw3eP-azc-delYSkBo8QStKWwTz3_zn1TmCCseFWHGZ6j3_7-QDz3rfZB8eLdP7-Q3wP58b8Qrt0lMPudrw1X14eipez8p1XsrNOgEuDuUDxDjck-hQdhBPm_1_PLiUgaZ1oEY8ATNZ8dPrweyVdNk-qKr2nKczkTJvR3bOXsmIZEJxd3v-zpT8pPwixVWaUnh2A0L5kS_boFTooDD-0xsquA_6TLwY78RQuVOJK1_fOPomEKlek5462HTb5f65wENEGVOS6eWaKk41eP5B66Hlp_E2IE0iQSz4I0TAuBw',
      });
      print(response.body);
      setState(() {
        result = weatherForecastFromJson(response.body);
        cloud = result.weatherForecasts?[0].forecasts?[0].data?.cond;
        date = DateFormat('yyyy-MM-dd')
            .format(result.weatherForecasts![0].forecasts![0].time!);
      });
    } catch (error) {
      print("เกิดข้อผิดพลาดในการดึงข้อมูล: $error");
    }
  }

  String condCondition(coud) {
    return coud == 1
        ? 'ท้องฟ้าแจ่มใส (Clear)'
        : coud == 2
            ? 'มีเมฆบางส่วน (Partly cloudy)'
            : coud == 3
                ? 'มีเมฆบางส่วน (Partly cloudy)'
                : coud == 4
                    ? 'มีเมฆมาก (Overcast)'
                    : coud == 5
                        ? 'ฝนตกเล็กน้อย (Light rain)'
                        : coud == 6
                            ? 'ฝนปานกลาง (Moderate rain)'
                            : coud == 7
                                ? 'ฝนตกหนัก (Heavy rain)'
                                : coud == 8
                                    ? 'ฝนฟ้าคะนอง (Thunderstorm)'
                                    : coud == 9
                                        ? 'อากาศหนาวจัด (Very cold)'
                                        : coud == 10
                                            ? 'อากาศหนาว (Cold)'
                                            : coud == 11
                                                ? 'อากาศเย็น (Cool)'
                                                : coud == 12
                                                    ? 'อากาศร้อนจัด (Very hot)'
                                                    : '...';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(date),
      ),
      body: ListView(children: [
        Image.network(
            'https://s359.kapook.com/pagebuilder/f227dc6e-bc63-41e4-8ebb-3d83dec0c0f9.jpg'),
        ListTile(
          title: Text(
            "นครศรีธรรมราช",
            style: boldTextStyle,
          ),
          subtitle: Text(
            "${result.weatherForecasts?[0].location?.lat ?? '...'}, ${result.weatherForecasts?[0].location?.lon ?? '...'}",
          ),
        ),
        ListTile(
          title: Text("อุณหภูมิสูงสุด", style: boldTextStyle),
          subtitle: Text(
              "${result.weatherForecasts?[0].forecasts?[0].data?.tcMax ?? '...'} °C"),
        ),
        ListTile(
          title: Text("อุณหภูมิต่ำสุด", style: boldTextStyle),
          subtitle: Text(
              "${result.weatherForecasts?[0].forecasts?[0].data?.tcMin ?? '...'} °C"),
        ),
        ListTile(
          title: Text(
            "ความชื้นสัมพัทธเฉลี่ย",
            style: boldTextStyle,
          ),
          subtitle: Text(
              "${result.weatherForecasts?[0].forecasts?[0].data?.rh ?? '...'} %"),
        ),
        ListTile(
          title: Text(
            "ปริมาณฝนรวม 24 ชม.",
            style: boldTextStyle,
          ),
          subtitle: Text(
              "${result.weatherForecasts?[0].forecasts?[0].data?.rain ?? '...'} mm"),
        ),
        ListTile(
          title: Text(
            "ความเร็วลมสูงสุด",
            style: boldTextStyle,
          ),
          subtitle: Text(
              "${result.weatherForecasts?[0].forecasts?[0].data?.wd10M ?? '...'} m/s"),
        ),
        ListTile(
          title: Text(
            "สภาพอากาศโดยทั่วไป",
            style: boldTextStyle,
          ),
          subtitle: Text(condCondition(cloud)),
        ),
      ]),
    );
  }
}
