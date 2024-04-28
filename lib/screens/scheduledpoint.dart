import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:noidaone/screens/loginScreen_2.dart';
import 'package:noidaone/screens/otpverification.dart';
import 'package:noidaone/screens/viewimage.dart';
import '../Controllers/PendingScheduledPointRepo.dart';
import '../Controllers/markLocationRepo.dart';
import 'actionOnSchedulePoint.dart';
import 'drywetsegregation.dart';
import 'flull_screen_image.dart';
import 'homeScreen.dart';
import 'navigateScreen.dart';

class ScheduledPointScreen extends StatelessWidget {
  const ScheduledPointScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SchedulePointScreen(),
    );
  }
}

class SchedulePointScreen extends StatefulWidget {
  const SchedulePointScreen({Key? key}) : super(key: key);

  @override
  State<SchedulePointScreen> createState() => _SchedulePointScreenState();
}

class _SchedulePointScreenState extends State<SchedulePointScreen> {
  List<Map<String, dynamic>>? pendingSchedulepointList;
  List<Map<String, dynamic>> _filteredData = [];
  TextEditingController _searchController = TextEditingController();
  double? lat;
  double? long;

  @override
  void initState() {
    super.initState();
    schedulePointresponse();
    _searchController.addListener(_search);
    getLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // get location
  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint("-------------Position-----------------");
    debugPrint(position.latitude.toString());

    lat = position.latitude;
    long = position.longitude;
    print('-----------105----$lat');
    print('-----------106----$long');
    // setState(() {
    // });
    debugPrint("Latitude: ----1056--- $lat and Longitude: $long");
    debugPrint(position.toString());
  }

  schedulePointresponse() async {
    pendingSchedulepointList =
        await PendingSchedulePointRepo().pendingschedulepoint(context);
    _filteredData =
        List<Map<String, dynamic>>.from(pendingSchedulepointList ?? []);

    print('--59--$pendingSchedulepointList');
    print('--60--$_filteredData');
    setState(() {});
  }

  void _search() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredData = pendingSchedulepointList?.where((item) {
            String location = item['sLocation'].toLowerCase();
            String pointType = item['sPointTypeName'].toLowerCase();
            String sector = item['sSectorName'].toLowerCase();
            return location.contains(query) ||
                pointType.contains(query) ||
                sector.contains(query);
          }).toList() ??
          [];
    });
  }
  // display toast
  void displayToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF255899),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back_ios,color: Colors.white),
          ),
        ),
        title: const Text(
          'Scheduled Point',
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              // child: SearchBar(),
              child: Container(
                height: 45,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: Colors.grey, // Outline border color
                    width: 0.2, // Outline border width
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _searchController,
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: 'Enter Keywords',
                              prefixIcon: Icon(Icons.search),
                              hintStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF707d83),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // scroll item after search bar
          Expanded(
            child: ListView.builder(
              itemCount: _filteredData.length ?? 0,
              itemBuilder: (context, index) {
                Map<String, dynamic> item = _filteredData[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
                  child: Container(
                    child: Column(
                      children: [
                        Card(
                          elevation: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                color: Colors.grey, // Outline border color
                                width: 0.2, // Outline border width
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          width: 30.0,
                                          height: 30.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            border: Border.all(
                                              color: Color(
                                                  0xFF255899), // Outline border color
                                              width:
                                                  0.5, // Outline border width
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF255899),
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      SizedBox(width: 5),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            item['sPointTypeName'] ?? '',
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xff3f617d),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Text(
                                            'Point Name',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xff3f617d),
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Container(
                                      height: 0.5,
                                      color: Color(0xff3f617d),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.forward,
                                        size: 10,
                                        color: Color(0xff3f617d),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Sector',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF255899),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      item['sSectorName'] ?? '',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xff3f617d),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(Icons.forward,
                                          size: 10, color: Color(0xff3f617d)),
                                      SizedBox(width: 5),
                                      Text(
                                        'Location',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF255899),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      item['sLocation'] ?? '',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xff3f617d),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    color: Color(0xffe4e4e4),
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  print('00000000----');
                                                  var sBeforePhoto =
                                                      "${item['sBeforePhoto']}";
                                                  print('---$sBeforePhoto');

                                                  if (sBeforePhoto != null) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ImageScreen(
                                                                    sBeforePhoto:
                                                                        sBeforePhoto)));
                                                  } else {
                                                    // toast
                                                  }
                                                },
                                                child: const Text(
                                                  'View Image',
                                                  style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF255899),
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(width: 5),
                                              Icon(
                                                Icons.forward_sharp,
                                                color: Color(0xFF255899),
                                              )
                                            ],
                                          ),
                                          Container(
                                              height: 10,
                                              width: 1,
                                              color: Colors.grey),
                                          GestureDetector(
                                            onTap: () {
                                              print('----341---');
                                              var sBeforePhoto =
                                                  "${item['sBeforePhoto']}";
                                              print('----357---$sBeforePhoto');

                                              //
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ActionOnSchedultPointScreen(
                                                            sBeforePhoto:
                                                                sBeforePhoto)),
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Action',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF255899),
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Icon(
                                                      Icons.forward_sharp,
                                                      color: Color(0xFF255899),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              height: 10,
                                              width: 1,
                                              color: Colors.grey),
                                          GestureDetector(
                                            onTap: () {
                                              print('-----401--');
                                              getLocation();

                                              if(lat !=null && long!=null){

                                                Navigator.push(
                                                   context,
                                                   MaterialPageRoute(
                                                       builder: (context) =>
                                                           NavigateScreen(
                                                               lat: lat,
                                                               long: long)),
                                                 );
                                              }else{
                                                displayToast("Please check the location.");
                                              }
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(6.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text('Navigate',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
                                                          color:
                                                              Color(0xFF255899),
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  // SizedBox(width: 5),
                                                  //Icon(Icons.forward_sharp,color: Color(0xFF255899))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

