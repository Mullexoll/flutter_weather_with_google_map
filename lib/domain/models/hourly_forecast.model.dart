import 'weather_condition.model.dart';

class HourlyForecast {
  final int dt;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double? uvi;
  final int clouds;
  final int visibility;
  final double? windSpeed;
  final int windDeg;
  final double? windGust;
  final List<WeatherCondition> weather;
  final double? pop;

  HourlyForecast({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.pop,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      dt: json['dt'],
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      dewPoint: json['dew_point'].toDouble(),
      uvi: double.tryParse(json['uvi'].toString()),
      clouds: json['clouds'],
      visibility: json['visibility'],
      windSpeed: double.tryParse(json['wind_speed'].toString()),
      windDeg: json['wind_deg'],
      windGust: json['wind_gust'].toDouble(),
      weather: (json['weather'] as List)
          .map((e) => WeatherCondition.fromJson(e))
          .toList(),
      pop: double.tryParse(json['pop'].toString()),
    );
  }
}
