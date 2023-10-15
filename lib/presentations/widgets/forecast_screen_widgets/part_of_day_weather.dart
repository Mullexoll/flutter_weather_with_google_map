import 'package:flutter/material.dart';
import 'package:weather_app_flutter/domain/models/daily_forecast.model.dart';
import 'package:weather_app_flutter/presentations/helpers/part_of_day_data.dart';

class PartOfDayWeather extends StatelessWidget {
  final DailyForecast dailyForecast;

  const PartOfDayWeather({
    super.key,
    required this.dailyForecast,
  });

  buildPartOfDaysForecast() {
    List<Widget> partOfDays = [];

    partOfDayDataList.forEach((key, value) {
      switch (key) {
        case 'night':
          partOfDays.add(
            Column(
              children: [
                Image.asset(
                  value,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${dailyForecast.temp.night.toStringAsFixed(0)}°',
                ),
              ],
            ),
          );
          partOfDays.add(const SizedBox(
            width: 15,
          ));
        case 'morn':
          partOfDays.add(
            Column(
              children: [
                Image.asset(
                  value,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${dailyForecast.temp.morn.toStringAsFixed(0)}°',
                ),
              ],
            ),
          );
          partOfDays.add(const SizedBox(
            width: 15,
          ));
        case 'day':
          partOfDays.add(
            Column(
              children: [
                Image.asset(
                  value,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${dailyForecast.temp.day.toStringAsFixed(0)}°',
                ),
              ],
            ),
          );
          partOfDays.add(const SizedBox(
            width: 15,
          ));
        case 'eve':
          partOfDays.add(
            Column(
              children: [
                Image.asset(
                  value,
                  width: 30,
                  height: 30,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${dailyForecast.temp.eve.toStringAsFixed(0)}°',
                ),
              ],
            ),
          );
          partOfDays.add(const SizedBox(
            width: 15,
          ));
      }
    });

    return partOfDays;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ...buildPartOfDaysForecast(),
    ]);
  }
}
