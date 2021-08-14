import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_chat/core/base/base_view_model.dart';

class MessagePageViewModel extends BaseViewModel {
  MessagePageViewModel({@required this.title});
  final String title;
  PageController controller = new PageController();
  Completer<GoogleMapController> mapController = Completer();

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  TextEditingController textEditingController = new TextEditingController();
  double showForTop(height) => height / 100 * 50;
  bool first = true;
  double showForBottom(height) => height / 100 * 41;
  bool isShow = true;
  bool isContainerShow = false;
  Set<Marker> markers = {};
  Position position;

  void getPosition(context) async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14.4746,
    )));

    markers.add(Marker(
        markerId: MarkerId("marker_1"),
        position: LatLng(position.latitude, position.longitude),
        onTap: () {
          final snackBar = SnackBar(content: Text('你的位置'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }));
    notifyListeners();
    print("ready");
  }
}
