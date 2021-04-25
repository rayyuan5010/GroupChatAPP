library google_map_widget;

import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';

part 'google_map_mobile.dart';
part 'google_map_tablet.dart';
part 'google_map_desktop.dart';

class GoogleMapWidget extends StatelessWidget {
  GoogleMapWidget({@required this.onFinished, @required this.markers});
  final Function(Completer<GoogleMapController>) onFinished;
  final Set<Marker> markers;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _GoogleMapMobile(onFinished: onFinished, markers: markers),
      desktop: _GoogleMapDesktop(),
      tablet: _GoogleMapTablet(),
    );
  }
}
