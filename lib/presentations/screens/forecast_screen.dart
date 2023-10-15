import 'package:flutter/material.dart';

import '../../constants/home_screen_consts.dart';
import '../../domain/models/weather_data.model.dart';
import '../widgets/forecast_screen_widgets/daily_forecast_card.dart';

class ForecastScreen extends StatelessWidget {
  final String currentCountry;
  final String currentCityAddress;
  final String currentAreaDistrict;
  final WeatherData weatherData;

  const ForecastScreen({
    super.key,
    required this.currentCountry,
    required this.currentCityAddress,
    required this.currentAreaDistrict,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HomeScreenConsts.primaryColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text(
            '${currentCityAddress != '' ? currentCityAddress : currentAreaDistrict} , $currentCountry',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: weatherData.daily.length,
          itemBuilder: (context, idx) {
            return DailyForecastCard(
              dailyForecast: weatherData.daily[idx],
            );
          },
        ),
      ),
    );
  }
}
