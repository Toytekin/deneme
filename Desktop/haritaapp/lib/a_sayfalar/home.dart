import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:location/location.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
    required this.lan,
    required this.lat,
  });

  double lan;
  double lat;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// En kısa konum bulan APİ

  //1.Şube bilgileri
  static const LatLng sube1 = LatLng(37.7652808, 38.2727324);

  //10.Şube bilgileri
  static const LatLng sube10 =
      LatLng(37.7912903, 38.6322274); //37.7912903,38.6322274

  //2.Şube bilgileri
  static const LatLng sube2 = LatLng(37.7628096, 38.2741782);

  //3.Şube bilgileri
  static const LatLng sube3 = LatLng(37.7607196, 38.2509744);

  //4.Şube bilgileri
  static const LatLng sube4 = LatLng(37.7577433, 38.2742209);

//5.Şube bilgileri
  static const LatLng sube5 = LatLng(37.756994, 38.2732165);

//6.Şube bilgileri
  static const LatLng sube6 = LatLng(37.7550367, 38.2644882);

  //7.Şube bilgileri
  static const LatLng sube7 = LatLng(37.7830836, 38.5855726); //kahta ,

  //8.Şube bilgileri
  static const LatLng sube8 =
      LatLng(37.7951209, 38.6105707); //37.7951209,38.6105707

  //9.Şube bilgileri
  static const LatLng sube9 =
      LatLng(37.7996382, 38.6188157); //37.7996382,38.6188157

  // ignore: non_constant_identifier_names
  final String api_key = 'AIzaSyCXLzd9Wt1o_7bulhqUYA8S_SWi6mmclAU';

  LocationData? cruntLocation;
  LatLng? gelenKonumum;
  List<LatLng> gidilecekYerler = [];
  GoogleMapPolyline googleMapPolyline =
      GoogleMapPolyline(apiKey: 'AIzaSyCXLzd9Wt1o_7bulhqUYA8S_SWi6mmclAU');

// Anlık konum dewğişimi izleme
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    gelenKonumum = LatLng(widget.lan, widget.lat);
    gidilecekYerler.add(gelenKonumum!);
    gidilecekYerler.add(sube1);
    gidilecekYerler.add(sube2);
    gidilecekYerler.add(sube3);
    gidilecekYerler.add(sube4);
    gidilecekYerler.add(sube5);
    gidilecekYerler.add(sube6);
    gidilecekYerler.add(sube7);
    gidilecekYerler.add(sube8);
    gidilecekYerler.add(sube9);
    gidilecekYerler.add(sube10);
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
          '1',
        ),
        position: LatLng(
          widget.lan,
          widget.lat,
        ),
      ),
      // 1. şube konum
      const Marker(
        markerId: MarkerId('2'),
        position: sube1,
        infoWindow: InfoWindow(title: "Şube 3"),
      ),
      const Marker(
          markerId: MarkerId('3'),
          position: sube2,
          infoWindow: InfoWindow(title: "Şube 1")),
      const Marker(
          markerId: MarkerId('4'),
          position: sube3,
          infoWindow: InfoWindow(title: "Şube 2")),
      const Marker(
          markerId: MarkerId('5'),
          position: sube4,
          infoWindow: InfoWindow(title: "Şube 4")),
      const Marker(
          markerId: MarkerId('6'),
          position: sube5,
          infoWindow: InfoWindow(title: "Şube 5")),
      const Marker(
          markerId: MarkerId('7'),
          position: sube6,
          infoWindow: InfoWindow(title: "Şube 6")),
      const Marker(
          markerId: MarkerId('8'),
          position: sube7,
          infoWindow: InfoWindow(title: "Şube 6")),
      const Marker(
          markerId: MarkerId('9'),
          position: sube8,
          infoWindow: InfoWindow(title: "Şube 7")),
      const Marker(
          markerId: MarkerId('10'),
          position: sube9,
          infoWindow: InfoWindow(title: "Şube 8")),
      const Marker(
          markerId: MarkerId('11'),
          position: sube10,
          infoWindow: InfoWindow(title: "Şube 9")),
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
