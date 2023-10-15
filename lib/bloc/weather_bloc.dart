import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app_flutter/domain/models/weather_data.model.dart';
import 'package:weather_app_flutter/infrastructure/datasource/api_service.dart';

import '../domain/exceptions/api_exceptions.dart';
import '../services/geolocator_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GeolocatorService geolocatorService = GeolocatorService();

  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherPositionGot>(_onWeatherPositionGot);
    on<WeatherAppLoadedEvent>(_onWeatherAppLoaded);
    on<WeatherPerformSearchEvent>(_onWeatherPerformSearchEvent);
    on<WeatherCityGot>(_onWeatherCityGot);
    on<WeatherExceptionCanceled>(_onWeatherExceptionCanceled);
  }

  FutureOr<void> _onWeatherPositionGot(
    WeatherPositionGot event,
    Emitter<WeatherState> emit,
  ) {
    emit(
      (state as WeatherLoaded).copyWith(
        currentPosition: event.currentPosition,
      ),
    );
  }

  Future<FutureOr<void>> _onWeatherAppLoaded(
    WeatherAppLoadedEvent event,
    Emitter<WeatherState> emit,
  ) async {
    try {
      final currentGeoPosition = await geolocatorService.determinePosition();
      final WeatherData? weatherData = await ApiService().getLocationWeather(
        LatLng(
          currentGeoPosition.latitude,
          currentGeoPosition.longitude,
        ),
      );

      emit(
        WeatherLoaded(
          currentPosition: LatLng(
            currentGeoPosition.latitude,
            currentGeoPosition.longitude,
          ),
          queryString: '',
          weatherData: weatherData,
          cityNotFoundException: null,
        ),
      );
    } catch (error, stacktrace) {
      debugPrint('$error $stacktrace');
      emit(
        WeatherLoaded(
          currentPosition: const LatLng(
            50.450001,
            30.523333,
          ),
          queryString: '',
          weatherData: null,
          cityNotFoundException: null,
        ),
      );
    }
  }

  Future<FutureOr<void>> _onWeatherPerformSearchEvent(
    WeatherPerformSearchEvent event,
    Emitter<WeatherState> emit,
  ) async {
    final WeatherData? weatherData =
        await ApiService().getCityWeather(event.queryString.toLowerCase());

    if (state is WeatherLoaded && weatherData != null) {
      emit(
        (state as WeatherLoaded).copyWith(
          queryString: event.queryString,
          weatherData: weatherData,
          currentPosition: LatLng(weatherData.lat, weatherData.lon),
        ),
      );
    } else {
      emit(
        (state as WeatherLoaded).copyWith(
          queryString: event.queryString,
          weatherData: weatherData,
          cityNotFoundException: CityNotFoundException(),
        ),
      );
    }
  }

  Future<FutureOr<void>> _onWeatherCityGot(
    WeatherCityGot event,
    Emitter<WeatherState> emit,
  ) async {
    final WeatherData? weatherData =
        await ApiService().getLocationWeather(event.position);

    emit(
      (state as WeatherLoaded).copyWith(
        weatherData: weatherData,
        currentPosition: event.position,
      ),
    );
  }

  FutureOr<void> _onWeatherExceptionCanceled(
    WeatherExceptionCanceled event,
    Emitter<WeatherState> emit,
  ) {
    emit(
      (state as WeatherLoaded).copyWith(cityNotFoundException: null),
    );
  }
}
