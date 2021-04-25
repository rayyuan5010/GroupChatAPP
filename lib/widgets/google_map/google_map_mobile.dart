part of google_map_widget;

// ignore: must_be_immutable
class _GoogleMapMobile extends StatelessWidget {
  _GoogleMapMobile({@required this.onFinished, @required this.markers});
  final Function(Completer<GoogleMapController>) onFinished;
  Completer<GoogleMapController> mapController = Completer();
  final Set<Marker> markers;
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return new GoogleMap(
      myLocationButtonEnabled: false,
      mapType: MapType.hybrid,
      initialCameraPosition: kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        mapController.complete(controller);
        // getCurrentPosition(context);
        onFinished(mapController);
      },
      markers: markers,
    );
  }
}
