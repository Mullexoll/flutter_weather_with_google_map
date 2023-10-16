import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app_flutter/constants/home_screen_consts.dart';
import 'package:weather_app_flutter/presentations/helpers/text_style_helper.dart';
import 'package:weather_app_flutter/presentations/widgets/home_screen_widgets/custom_map_marker_widget.dart';

import '../../../bloc/weather_bloc.dart';
import '../../../domain/models/weather_data.model.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key});

  @override
  GoogleMapWidgetAppState createState() => GoogleMapWidgetAppState();
}

class GoogleMapWidgetAppState extends State<GoogleMapWidget> {
  late String _mapStyle;
  final Completer<GoogleMapController> _controller = Completer();
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  late Marker myMarker = const Marker(markerId: MarkerId('markerId'));
  LatLng center = const LatLng(50.450001, 30.523333);

  @override
  void initState() {
    super.initState();

    rootBundle
        .loadString('assets/map_styles/google_map_aubergine_style.txt')
        .then((string) {
      _mapStyle = string;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _customInfoWindowController.googleMapController = controller;
    controller.setMapStyle(_mapStyle);
    _controller.complete(controller);
  }

  Future _addMarkerLongPressed(
    LatLng latlang,
    WeatherData? weatherData,
  ) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latlang.latitude, latlang.longitude);

    Placemark place1 = placemarks[0];
    String currentCityAddress = "${place1.locality}";
    String currentAreaDistrict = "${place1.administrativeArea}";
    String currentCountry = "${place1.country}";

    if (weatherData != null) {
      setState(() {
        addNewMarker(
          latlang,
          currentCityAddress,
          currentAreaDistrict,
          currentCountry,
          weatherData,
        );
      });
    } else {
      final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
      final _ = weatherBloc.add(WeatherCityGot(position: latlang));
      WeatherData? weatherData =
          (weatherBloc.state as WeatherLoaded).weatherData;

      setState(() {
        addNewMarker(
          latlang,
          currentCityAddress,
          currentAreaDistrict,
          currentCountry,
          weatherData,
        );
      });
    }

    //This is optional, it will zoom when the marker has been created
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(latlang, 8.0));
  }

  void addNewMarker(
    LatLng latlang,
    String currentCityAddress,
    String currentAreaDistrict,
    String currentCountry,
    WeatherData? weatherData,
  ) {
    const MarkerId markerId = MarkerId("RANDOM_ID");
    myMarker = Marker(
      markerId: markerId,
      draggable: true,
      consumeTapEvents: true,
      position: latlang,
      //With this parameter you automatically obtain latitude and longitude
      onTap: () {
        _customInfoWindowController.addInfoWindow!(
          CustomMarker(
            currentCityAddress: currentCityAddress,
            currentAreaDistrict: currentAreaDistrict,
            weatherData: weatherData,
            currentCountry: currentCountry,
          ),
          latlang,
        );
      },
      icon: BitmapDescriptor.defaultMarker,
    );
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherBloc, WeatherState>(
      listener: (BuildContext context, Object? state) async {
        if (state is WeatherLoaded) {
          if (state.cityNotFoundException != null) {
            final snackBar = SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                'City not found, please try again!',
                style: primaryTextStyle15(),
              ),
              duration: const Duration(days: 1),
              action: SnackBarAction(
                textColor: HomeScreenConsts.primaryColor,
                label: 'OK',
                onPressed: () {
                  BlocProvider.of<WeatherBloc>(context).add(
                    WeatherExceptionCanceled(),
                  );
                },
              ),
            );
            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newLatLngZoom(
              state.currentPosition,
              8.0,
            ),
          );
          setState(() {
            _addMarkerLongPressed(state.currentPosition, state.weatherData!);
            center = state.currentPosition;
          });
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: center,
                zoom: 10,
              ),
              markers: <Marker>{myMarker},
              onLongPress: (latlang) {
                _addMarkerLongPressed(
                  latlang,
                  null,
                ); //we will call this function when pressed on the map
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onCameraMoveStarted: () =>
                  _customInfoWindowController.hideInfoWindow!(),
            ),
            CustomInfoWindow(
              controller: _customInfoWindowController,
              height: 85,
              width: 190,
              offset: 50,
            ),
          ],
        );
      },
    );
  }
}
