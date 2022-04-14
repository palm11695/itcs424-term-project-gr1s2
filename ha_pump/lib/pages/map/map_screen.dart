import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ha_pump/theme.dart';

class Map extends StatefulWidget {
  const Map(this._latLng, {Key? key}) : super(key: key);
  final List<double> _latLng;

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  late GoogleMapController _googleMapController;
  late List<double> latLng;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  CameraPosition mahidolUniverity = const CameraPosition(
    target: LatLng(13.7945516, 100.324395),
    zoom: 13,
  );

  @override
  Widget build(BuildContext context) {
    Marker mahidolUniversityMarker = const Marker(
      markerId: MarkerId('origin'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(13.7920206, 100.3258028),
    );

    Marker destination = Marker(
      markerId: const MarkerId('destination'),
      infoWindow: const InfoWindow(title: 'Destination'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      position: LatLng(widget._latLng[0], widget._latLng[1]),
    );

    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text(
                  "Ha Pump",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: kPrimaryColor,
              actions: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () => {
                      Navigator.pop(context),
                    },
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: mahidolUniverity,
                  onMapCreated: (controller) =>
                      _googleMapController = controller,
                  markers: {
                    mahidolUniversityMarker,
                    destination,
                  },
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(mahidolUniverity),
              ),
              child: const Icon(Icons.center_focus_strong),
            ),
          );
        });
  }
}
