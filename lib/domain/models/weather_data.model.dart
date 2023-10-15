import 'current_weather.model.dart';
import 'daily_forecast.model.dart';
import 'hourly_forecast.model.dart';
import 'minutely_forecast.model.dart';
import 'weather_alert.model.dart';

class WeatherData {
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final CurrentWeather current;
  final List<MinutelyForecast> minutely;
  final List<HourlyForecast> hourly;
  final List<DailyForecast> daily;
  final List<Alert> alerts;

  WeatherData({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.minutely,
    required this.hourly,
    required this.daily,
    required this.alerts,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      lat: json['lat'],
      lon: json['lon'],
      timezone: json['timezone'],
      timezoneOffset: json['timezone_offset'],
      current: CurrentWeather.fromJson(json['current']),
      minutely: json['minutely'] != null
          ? (json['minutely'] as List)
              .map((e) => MinutelyForecast.fromJson(e))
              .toList()
          : [],
      hourly: (json['hourly'] as List)
          .map((e) => HourlyForecast.fromJson(e))
          .toList(),
      daily: (json['daily'] as List)
          .map((e) => DailyForecast.fromJson(e))
          .toList(),
      alerts: json['alerts'] == null
          ? []
          : (json['alerts'] as List).map((e) => Alert.fromJson(e)).toList(),
    );
  }
}
