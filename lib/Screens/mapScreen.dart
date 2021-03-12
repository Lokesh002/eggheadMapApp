import 'dart:async';

import 'package:egghead_practical/Screens/Login.dart';
import 'package:egghead_practical/backend/ReusableButton.dart';
import 'package:egghead_practical/backend/sharedPref.dart';
import 'package:egghead_practical/backend/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  SizeConfig screenSize;
  Completer<GoogleMapController> _controller = Completer();

  SavedData savedData = SavedData();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('you are in map screen');
  }

  @override
  Widget build(BuildContext context) {
    screenSize = SizeConfig(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.topRight,
        children: [
          _googleMap(context),
          Padding(
            padding: EdgeInsets.only(
                top: screenSize.screenHeight * 5,
                right: screenSize.screenWidth * 5),
            child: ReusableButton(
                onPress: () async {
                  await savedData.setLoggedIn(false);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                content: 'Sign Out',
                height: screenSize.screenHeight * 5,
                width: screenSize.screenWidth * 10),
          )
        ],
      ),
    );
  }

  Widget _googleMap(BuildContext context) {
    return Container(
      height: screenSize.screenHeight * 100,
      width: screenSize.screenWidth * 100,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(23.009529, 72.510963), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          defMarker,
          pos1Marker,
          pos2Marker,
          pos3Marker,
          pos4Marker,
          pos5Marker,
          pos6Marker
        },
      ),
    );
  }

  Marker defMarker = Marker(
    markerId: MarkerId('default'),
    position: LatLng(23.009529, 72.510963),
    infoWindow: InfoWindow(title: 'You are here'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  );

  Marker pos1Marker = Marker(
    markerId: MarkerId('default'),
    position: LatLng(21.764473, 72.151932),
    infoWindow: InfoWindow(title: 'You are here'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  );
  Marker pos2Marker = Marker(
    markerId: MarkerId('default'),
    position: LatLng(23.027750, 72.596764),
    infoWindow: InfoWindow(title: 'You are here'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  );
  Marker pos3Marker = Marker(
    markerId: MarkerId('default'),
    position: LatLng(23.215635, 72.636940),
    infoWindow: InfoWindow(title: 'You are here'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  );
  Marker pos4Marker = Marker(
    markerId: MarkerId('default'),
    position: LatLng(19.076090, 72.877426),
    infoWindow: InfoWindow(title: 'You are here'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  );
  Marker pos5Marker = Marker(
    markerId: MarkerId('default'),
    position: LatLng(22.308155, 70.800705),
    infoWindow: InfoWindow(title: 'You are here'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  );

  Marker pos6Marker = Marker(
    markerId: MarkerId('default'),
    position: LatLng(23.310696, 73.192635),
    infoWindow: InfoWindow(title: 'You are here'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  );
}
