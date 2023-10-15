part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent extends Equatable {}

class WeatherPositionGot extends WeatherEvent {
  final LatLng currentPosition;

  WeatherPositionGot({
    required this.currentPosition,
  });

  @override
  List<Object?> get props => [
        currentPosition,
      ];
}

class WeatherAppLoadedEvent extends WeatherEvent {
  WeatherAppLoadedEvent();

  @override
  List<Object?> get props => [];
}

class WeatherPerformSearchEvent extends WeatherEvent {
  final String queryString;

  WeatherPerformSearchEvent({required this.queryString});

  @override
  List<Object?> get props => [queryString];
}

class WeatherCityGot extends WeatherEvent {
  final LatLng position;

  WeatherCityGot({required this.position});

  @override
  List<Object?> get props => [position];
}

class WeatherExceptionCanceled extends WeatherEvent {
  @override
  List<Object?> get props => [];
}
