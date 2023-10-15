import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_flutter/presentations/helpers/text_style_helper.dart';

import '../../../domain/models/daily_forecast.model.dart';
import 'part_of_day_weather.dart';

class DailyForecastCard extends StatelessWidget {
  final DailyForecast dailyForecast;

  const DailyForecastCard({
    super.key,
    required this.dailyForecast,
  });

  getForecastDayName(int timestamp) {
    DateFormat dateFormat = DateFormat('EEEE');
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String dayName = dateFormat.format(date);

    return dayName;
  }

  getForecastDayNumber(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    return date.day;
  }

  getForecastMonthName(int timestamp) {
    DateFormat dateFormat = DateFormat('MMMM');
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String monthName = dateFormat.format(date);

    return monthName;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white.withOpacity(0.9),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${getForecastDayName(dailyForecast.dt)}, ${getForecastDayNumber(dailyForecast.dt).toString()} ${getForecastMonthName(dailyForecast.dt).toString()}',
                      style: primaryTextStyle20(),
                    ),
                    SizedBox(
                      width: 210,
                      child: Text(
                        dailyForecast.summary,
                        textAlign: TextAlign.start,
                        style: primaryTextStyle12(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 16),
                      child: PartOfDayWeather(
                        dailyForecast: dailyForecast,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '${dailyForecast.temp.min?.toStringAsFixed(0)}° / ${dailyForecast.temp.max?.toStringAsFixed(0)}°',
                    style: primaryTextStyle25(),
                  ),
                  Image.network(
                    'https://openweathermap.org/img/wn/${dailyForecast.weather[0].icon}@2x.png',
                    width: 100,
                    height: 80,
                  ),
                  Text(
                    dailyForecast.weather[0].main,
                    style: primaryTextStyle15(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
