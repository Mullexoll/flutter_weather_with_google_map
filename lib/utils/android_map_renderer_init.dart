import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

class AndroidMapRendererInit {
  Completer<AndroidMapRenderer?>? _initializedRendererCompleter;

  Future<AndroidMapRenderer?> initializeMapRenderer() async {
    if (_initializedRendererCompleter != null) {
      return _initializedRendererCompleter!.future;
    }

    final Completer<AndroidMapRenderer?> completer =
    Completer<AndroidMapRenderer?>();
    _initializedRendererCompleter = completer;

    WidgetsFlutterBinding.ensureInitialized();

    final GoogleMapsFlutterPlatform platform = GoogleMapsFlutterPlatform.instance;
    unawaited((platform as GoogleMapsFlutterAndroid)
        .initializeWithRenderer(AndroidMapRenderer.latest)
        .then((AndroidMapRenderer initializedRenderer) =>
        completer.complete(initializedRenderer)));

    return completer.future;
  }

}