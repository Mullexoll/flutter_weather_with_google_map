import 'weather_condition.model.dart';

class CurrentWeather {
  final int dt;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final int visibility;
  final double? windSpeed;
  final int windDeg;
  final double? windGust;
  final List<WeatherCondition> weather;

  CurrentWeather({
    required this.dt,
    required this.sunrise,
    required this.sunset,
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
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      dt: json['dt'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      pressure: json['pressure'],
      humidity: json['humidity'],
      dewPoint: json['dew_point'],
      uvi: json['uvi'].toDouble(),
      clouds: json['clouds'],
      visibility: json['visibility'],
      windSpeed: double.tryParse(json['wind_speed'].toString()),
      windDeg: json['wind_deg'],
      windGust: double.tryParse(json['wind_gust'].toString()),
      weather: (json['weather'] as List)
          .map((e) => WeatherCondition.fromJson(e))
          .toList(),
    );
  }
}
