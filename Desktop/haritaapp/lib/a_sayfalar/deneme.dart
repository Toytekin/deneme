import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:location/location.dart';

// ignore: must_be_immutable
class DenemeSayfasi extends StatefulWidget {
  DenemeSayfasi({
    super.key,
    required this.lan,
    required this.lat,
    required this.gLan,
    required this.gLat,
  });

  double lan;
  double lat;
  double gLan;
  double gLat;

  @override
  State<DenemeSayfasi> createState() => _DenemeSayfasiState();
}

class _DenemeSayfasiState extends State<DenemeSayfasi> {
  // ignore: non_constant_identifier_names
  final String api_key = 'AIzaSyCXLzd9Wt1o_7bulhqUYA8S_SWi6mmclAU';

  LocationData? cruntLocation;
  LatLng? gelenKonumum;
  late LatLng sube;
  List<LatLng> gidilecekYerler = [];
  GoogleMapPolyline googleMapPolyline =
      GoogleMapPolyline(apiKey: 'AIzaSyCXLzd9Wt1o_7bulhqUYA8S_SWi6mmclAU');

// Anlık konum dewğişimi izleme
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    gelenKonumum = LatLng(widget.lan, widget.lat);
    sube = LatLng(widget.gLan, widget.gLat);

    gidilecekYerler.add(gelenKonumum!);
    gidilecekYerler.add(sube);
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();
    GoogleMapController googleMapController = await _controller.future;

    location.getLocation().then((location) {
      cruntLocation = location;
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
            target: LatLng(
              location.latitude!,
              location.longitude!,
            ),
          ),
        ),
      );
    });

    location.onLocationChanged.listen((yeniLokasyon) {
      cruntLocation = yeniLokasyon;
      setState(() {});
    });
  }

  Set<Marker> markers() {
    return {
      //kendi konumum
      Marker(
        infoWindow: const InfoWindow(title: "BEN"),
        markerId: const MarkerId(
          'Varılacak Şube',
        ),
        position: LatLng(
          widget.lan,
          widget.lat,
        ),
      ),
      // 1. şube konum
      Marker(
        markerId: const MarkerId('2'),
        position: sube,
        infoWindow: const InfoWindow(title: "Hedef"),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
        mapType: MapType.normal,
        polylines: {
          Polyline(
            polylineId: const PolylineId('route1'),
            points: gidilecekYerler,
            color: Colors.blue,
            width: 3,
          ),
        },
        //Set<Polyline>.of(_polylines.values),
        //Konum bilgimizi gösterme
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.lan,
            widget.lat,
          ),
          zoom: 12,
        ),

        markers: markers(),
      ),
    );
  }
}
