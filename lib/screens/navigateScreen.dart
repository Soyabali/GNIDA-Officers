import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class NavigateScreen extends StatefulWidget {

  final lat;
  final long;
  NavigateScreen({super.key, this.lat, this.long});

  @override
  State<NavigateScreen> createState() => _MyAppState();
}

class _MyAppState extends State<NavigateScreen> {
  late GoogleMapController mapController;
 double? lat;
 double? long;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    print('----24---lat--${widget.lat}');
    print('----24---long---${widget.long}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF255899),
          leading: GestureDetector(
              onTap: () {
                //Navigator.of(context).pop();
                //
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const LoginScreen_2()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back_ios),
              )),
          title: const Text(
            'Navigate',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}

