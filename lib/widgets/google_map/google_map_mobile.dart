part of google_map_widget;

// ignore: must_be_immutable
class _GoogleMapMobile extends StatefulWidget {
  _GoogleMapMobile({@required this.onFinished, @required this.markers});
  final Function(Completer<GoogleMapController>) onFinished;
  Completer<GoogleMapController> mapController = Completer();
  final Set<Marker> markers;
  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 18,
  );

  @override
  State<_GoogleMapMobile> createState() => _GoogleMapMobileState();
}

class _GoogleMapMobileState extends State<_GoogleMapMobile> {
  //

  @override
  Widget build(BuildContext context) {
    return new GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      mapType: MapType.normal,
      initialCameraPosition: widget.kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        widget.mapController.complete(controller);
        // getCurrentPosition(context);
        widget.onFinished(widget.mapController);
      },
      markers: widget.markers,
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}
