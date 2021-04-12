import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_chat/core/base/base_view_model.dart';

class MessagePageViewModel extends BaseViewModel {
  MessagePageViewModel({@required this.title});
  final String title;
  PageController controller = new PageController();
  static Completer<GoogleMapController> mapController = Completer();

  static final CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  double showForTop(height) => height / 100 * 52;
  static bool first = false;
  double showForBottom(height) => height / 100 * 40;
  bool isShow = true;
  bool isContainerShow = false;

  List<Widget> pages = [
    GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: MessagePageViewModel.kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        if (first) {
          mapController.complete(controller);
          first = false;
          // notifyListeners();
        }
      },
      markers: {
        Marker(
          markerId: MarkerId("marker_1"),
          position: LatLng(37.42796133580664, -122.085749655962),
        )
      },
    ),
    Container(child: Text('p2')),
  ];
}
