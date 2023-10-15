part of 'weather_bloc.dart';

@immutable
sealed class WeatherState extends Equatable {}

final class WeatherInitial extends WeatherState {
  @override
  List<Object?> get props => [];
}

final class WeatherLoading extends WeatherState {
  @override
  List<Object?> get props => [];
}

final class WeatherLoaded extends WeatherState {
  final LatLng currentPosition;
  final String queryString;
  final WeatherData? weatherData;
  final CityNotFoundException? cityNotFoundException;

  WeatherLoaded({
    required this.currentPosition,
    required this.queryString,
    required this.weatherData,
    required this.cityNotFoundException,
  });

  WeatherLoaded copyWith({
    LatLng? currentPosition,
    String? queryString,
    WeatherData? weatherData,
    CityNotFoundException? cityNotFoundException,
  }) {
    return WeatherLoaded(
      currentPosition: currentPosition ?? this.currentPosition,
      queryString: queryString ?? this.queryString,
      weatherData: weatherData ?? this.weatherData,
      cityNotFoundException: cityNotFoundException,
    );
  }

  @override
  List<Object?> get props => [
        currentPosition,
        queryString,
        weatherData,
        cityNotFoundException,
      ];
}
