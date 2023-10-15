import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_flutter/constants/home_screen_consts.dart';

import '../../bloc/weather_bloc.dart';
import '../widgets/home_screen_widgets/google_map_widget.dart';
import '../widgets/home_screen_widgets/search_bar_widget.dart';

class WeatherHomeScreen extends StatelessWidget {
  const WeatherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return SafeArea(
          left: false,
          right: false,
          child: Scaffold(
            backgroundColor: HomeScreenConsts.primaryColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: const Text(
                'Open Weather',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
              child: Column(
                children: [
                  const CustomSearchBar(),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const GoogleMapWidget(),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
