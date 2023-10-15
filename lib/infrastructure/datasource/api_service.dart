import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_flutter/constants/services_consts.dart';
import 'package:weather_app_flutter/domain/models/weather_data.model.dart';

import '../../domain/exceptions/api_exceptions.dart';

class ApiService {
  final http.Client _httpClient = http.Client();

  Future<WeatherData?> getData(String url) async {
    try {
      final response = await _httpClient.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        return WeatherData.fromJson(data);
      } else {
        debugPrint('response.statusCode ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error in getData: $e');
    }

    return null;
  }

  Future<WeatherData?> getCityWeather(String cityName) async {
    final cityCoordinates = await getCityLocation(cityName);

    if (cityCoordinates != null && cityCoordinates.isNotEmpty) {
      final weatherData = await getLocationWeather(
        LatLng(cityCoordinates[0]['lat'], cityCoordinates[0]['lon']),
      );
      return weatherData;
    }

    return null;
  }

  Future<List?> getCityLocation(String cityName) async {
    try {
      if (ServicesConsts.weatherApiKey.isEmpty) {
        throw InvalidApiKeyException();
      }
      final response = await _httpClient.get(Uri.parse(
        '${ServicesConsts.cityLocationApiUrl}q=$cityName&appid=${ServicesConsts.weatherApiKey}',
      ));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        return data;
      } else {
        debugPrint('response.statusCode ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error in getCityLocation: $e');
    }

    return null;
  }

  Future<WeatherData?> getLocationWeather(LatLng location) async {
    final url =
        '${ServicesConsts.weatherApiUrl}?lat=${location.latitude}&lon=${location.longitude}&appid=${ServicesConsts.weatherApiKey}&units=metric';

    return getData(url);
  }
}
