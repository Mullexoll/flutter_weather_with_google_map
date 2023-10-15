import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:weather_app_flutter/bloc/weather_bloc.dart';
import 'package:weather_app_flutter/presentations/screens/home_screen.dart';
import 'package:weather_app_flutter/utils/android_map_renderer_init.dart';

void main() {
  final GoogleMapsFlutterPlatform platform = GoogleMapsFlutterPlatform.instance;
  (platform as GoogleMapsFlutterAndroid).useAndroidViewSurface = true;
  final _ = AndroidMapRendererInit().initializeMapRenderer();

  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  WeatherAppState createState() => WeatherAppState();
}

class WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc()
        ..add(
          WeatherAppLoadedEvent(),
        ),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const WeatherHomeScreen(),
      ),
    );
  }
}
