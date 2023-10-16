import 'package:flutter/material.dart';
import 'package:weather_app_flutter/constants/home_screen_consts.dart';

import '../../../domain/models/weather_data.model.dart';
import '../../screens/forecast_screen.dart';

class CustomMarker extends StatelessWidget {
  final String currentCityAddress;
  final String currentAreaDistrict;
  final String currentCountry;

  final WeatherData? weatherData;

  const CustomMarker({
    super.key,
    required this.currentCityAddress,
    required this.currentAreaDistrict,
    required this.weatherData,
    required this.currentCountry,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ForecastScreen(
            currentCountry: currentCountry,
            currentCityAddress: currentCityAddress,
            currentAreaDistrict: currentAreaDistrict,
            weatherData: weatherData!,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color.fromRGBO(37, 111, 157, 0.8),
                border: Border.all(color: Colors.white),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey, // Shadow color
                    blurRadius: 5, // Spread of the shadow
                    offset: Offset(0, 0), // Offset from the container
                  ),
                ],
              ),
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Text(
                              currentCityAddress != ''
                                  ? currentCityAddress
                                  : currentAreaDistrict,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: HomeScreenConsts.whiteColor,
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              currentCountry,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: HomeScreenConsts.whiteColor,
                                fontFamily: 'Poppins',
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              weatherData!.current.temp.isNegative
                                  ? '${weatherData!.current.temp.toStringAsFixed(1)}°'
                                  : '+${weatherData!.current.temp.toStringAsFixed(1)}°',
                              style: const TextStyle(
                                color: HomeScreenConsts.whiteColor,
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Image.network(
                          'https://openweathermap.org/img/wn/${weatherData?.current.weather[0].icon}@2x.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (c, o, s) {
                            return const SizedBox();
                          },
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
