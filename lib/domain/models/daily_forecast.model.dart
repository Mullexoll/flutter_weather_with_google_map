import 'temperature.model.dart';
import 'weather_condition.model.dart';

class DailyForecast {
  final int dt;
  final int sunrise;
  final int sunset;
  final int moonrise;
  final int moonset;
  final double moonPhase;
  final String summary;
  final Temperature temp;
  final Temperature feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double windSpeed;
  final int windDeg;
  final double windGust;
  final List<WeatherCondition> weather;
  final int clouds;
  final double pop;
  final double? rain;
  final double uvi;

  DailyForecast({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.summary,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.clouds,
    required this.pop,
    required this.rain,
    required this.uvi,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      dt: json['dt'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      moonrise: json['moonrise'],
      moonset: json['moonset'],
      moonPhase: json['moon_phase'].toDouble(),
      summary: json['summary'],
      temp: Temperature.fromJson(json['temp']),
      feelsLike: Temperature.fromJson(json['feels_like']),
      pressure: json['pressure'],
      humidity: json['humidity'],
      dewPoint: json['dew_point'].toDouble(),
      windSpeed: json['wind_speed'].toDouble(),
      windDeg: json['wind_deg'],
      windGust: json['wind_gust'].toDouble(),
      weather: (json['weather'] as List)
          .map((e) => WeatherCondition.fromJson(e))
          .toList(),
      clouds: json['clouds'],
      pop: json['pop'].toDouble(),
      rain: double.tryParse(json['rain'].toString()),
      uvi: json['uvi'].toDouble(),
    );
  }
}
