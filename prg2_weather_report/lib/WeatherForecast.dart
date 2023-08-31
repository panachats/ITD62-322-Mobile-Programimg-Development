// To parse this JSON data, do
//
//     final weatherForecast = weatherForecastFromJson(jsonString);

import 'dart:convert';

WeatherForecast weatherForecastFromJson(String str) =>
    WeatherForecast.fromJson(json.decode(str));

String weatherForecastToJson(WeatherForecast data) =>
    json.encode(data.toJson());

class WeatherForecast {
  List<WeatherForecastElement>? weatherForecasts;

  WeatherForecast({
    this.weatherForecasts,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) =>
      WeatherForecast(
        weatherForecasts: json["WeatherForecasts"] == null
            ? []
            : List<WeatherForecastElement>.from(json["WeatherForecasts"]!
                .map((x) => WeatherForecastElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "WeatherForecasts": weatherForecasts == null
            ? []
            : List<dynamic>.from(weatherForecasts!.map((x) => x.toJson())),
      };
}

class WeatherForecastElement {
  Location? location;
  List<Forecast>? forecasts;

  WeatherForecastElement({
    this.location,
    this.forecasts,
  });

  factory WeatherForecastElement.fromJson(Map<String, dynamic> json) =>
      WeatherForecastElement(
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        forecasts: json["forecasts"] == null
            ? []
            : List<Forecast>.from(
                json["forecasts"]!.map((x) => Forecast.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "forecasts": forecasts == null
            ? []
            : List<dynamic>.from(forecasts!.map((x) => x.toJson())),
      };
}

class Forecast {
  DateTime? time;
  Data? data;

  Forecast({
    this.time,
    this.data,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "time": time?.toIso8601String(),
        "data": data?.toJson(),
      };
}

class Data {
  int? cond;
  double? rain;
  double? rh;
  double? tcMax;
  double? tcMin;
  double? wd10M;
  double? ws10M;

  Data({
    this.cond,
    this.rain,
    this.rh,
    this.tcMax,
    this.tcMin,
    this.wd10M,
    this.ws10M,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cond: json["cond"],
        rain: json["rain"]?.toDouble(),
        rh: json["rh"]?.toDouble(),
        tcMax: json["tc_max"]?.toDouble(),
        tcMin: json["tc_min"]?.toDouble(),
        wd10M: json["wd10m"]?.toDouble(),
        ws10M: json["ws10m"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "cond": cond,
        "rain": rain,
        "rh": rh,
        "tc_max": tcMax,
        "tc_min": tcMin,
        "wd10m": wd10M,
        "ws10m": ws10M,
      };
}

class Location {
  double? lat;
  double? lon;

  Location({
    this.lat,
    this.lon,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}
