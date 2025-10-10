
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:noidaone/screens/viewimage.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Controllers/internalComplaintStatusRepo.dart';
import '../resources/app_text_style.dart';
import 'generalFunction.dart';
import 'gnidaofficers/gnoidadashboard.dart';

class ComplaintStatusScreen extends StatelessWidget {

  const ComplaintStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white, // Change the color of the drawer icon here
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: ComplaintScreen(),
    );
  }
}

class ComplaintScreen extends StatefulWidget {

  const ComplaintScreen({Key? key}) : super(key: key);

  @override
  State<ComplaintScreen> createState() => _SchedulePointScreenState();
}

class _SchedulePointScreenState extends State<ComplaintScreen> {
  var variableName;
  var variableName2;
  List<Map<String, dynamic>>? internalComplaintList;
  List<Map<String, dynamic>> _filteredData = [];
  List bindAjencyList = [];
  List userAjencyList = [];
  var iAgencyCode;
  var agencyUserId;
  TextEditingController _searchController = TextEditingController();
  double? lat;
  double? long;
  GeneralFunction generalfunction = GeneralFunction();
  final distDropdownFocus = GlobalKey();
   // Initial border radius
  var result,msg;

  // Get a api response
  intStatusComplaintResponse() async {
    internalComplaintList = await InternalComplaintStatusRepo().internalComplaintStatus(context);
    _filteredData = List<Map<String, dynamic>>.from(internalComplaintList ?? []);
    //print('--60--$internalComplaintList');
    //print('--61--$_filteredData');
    debugPrint("--61--$_filteredData", wrapWidth: 1024);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    intStatusComplaintResponse();
    _searchController.addListener(_search);
    super.initState();
  }
  // navigate google map
  Future<void> launchGoogleMaps(double latitude, double longitude) async {
    final String googleMapsUrl = "comgooglemaps://?q=$latitude,$longitude";
    final String appleMapsUrl = "http://maps.apple.com/?q=$latitude,$longitude";
    final String androidGoogleMapsUrl = "google.navigation:q=$latitude,$longitude";

    Uri uri;

    if (Platform.isAndroid) {
      // For Android
      uri = Uri.parse(androidGoogleMapsUrl);
    } else if (Platform.isIOS) {
      // For iOS (try Google Maps, else fallback to Apple Maps)
      uri = Uri.parse(googleMapsUrl);

      if (!await canLaunchUrl(uri)) {
        uri = Uri.parse(appleMapsUrl); // fallback to Apple Maps
      }
    } else {
      debugPrint("Unsupported platform");
      return;
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch Maps');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  void _search() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredData = internalComplaintList?.where((item) {
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

  // location
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
  //
  void displayToast(String msg) {
    showToast(
      msg,
      duration: const Duration(seconds: 1),
      position: ToastPosition.center,
      backgroundColor: Colors.red,
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    );
  }

  Future<void> openGoogleMapPath(double sourceLat, double sourceLng, double destLat, double destLng) async {
    final Uri googleMapUrl = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&origin=$sourceLat,$sourceLng&destination=$destLat,$destLng&travelmode=driving',
    );

    if (await canLaunchUrl(googleMapUrl)) {
      await launchUrl(googleMapUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $googleMapUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFD31F76),
          leading: GestureDetector(
              onTap: () {
                //Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const GnoidaOfficersHome()));
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back_ios),
              )),
          title: const Text(
            'Complaint Status',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15,top: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.grey, // Outline border color
                      width: 0.2, // Outline border width
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _searchController,
                          autofocus: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Enter Keywords',
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
            // scroll item after search bar
            Expanded(
              child: ListView.builder(
                itemCount: _filteredData.length,
                itemBuilder: (context, index) {
                Map<String, dynamic> item = _filteredData[index];

                return Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
                    child: Container(
                      child: Column(
                        children: [
                             Card(
                              elevation: 1,
                               color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: Colors.grey, // Outline border color
                                    width: 0.2, // Outline border width
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8, right: 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8),
                                              child: Container(
                                                height: 45,
                                                width:2,
                                                color:Colors.red
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('${index+1}.',style: AppTextStyle.font16OpenSansRegularBlackTextStyle),
                                                    SizedBox(width: 4),
                                                    Text(item['sPointTypeName'] ?? '',
                                                        style: AppTextStyle.font16OpenSansRegularBlackTextStyle),
                                                  ],
                                                ),
                                                Text(
                                                  'Point Name',
                                                  style: AppTextStyle
                                                      .font14OpenSansRegularBlack45TextStyle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 15),
                                        child: Container(
                                          height: 0.5,
                                          color: Color(0xff3f617d),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                       Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          const Icon(
                                            Icons.forward,
                                            size: 10,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'Sector',
                                              style: AppTextStyle.font16OpenSansRegularBlackTextStyle
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          item['sSectorName'] ?? '',
                                          style: AppTextStyle
                                              .font14OpenSansRegularBlack45TextStyle,
                                        ),
                                      ),
                                       SizedBox(height: 5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          const Icon(
                                            Icons.forward,
                                            size: 10,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                              'Agency Name',
                                              style: AppTextStyle.font16OpenSansRegularBlackTextStyle
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          item['sAgencyName'] ?? '',
                                          style: AppTextStyle
                                              .font14OpenSansRegularBlack45TextStyle,
                                        ),
                                      ),
                                       SizedBox(height: 2),
                                       Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          const Icon(
                                            Icons.forward,
                                            size: 10,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            'Posted At',
                                            style: AppTextStyle
                                            .font14OpenSansRegularBlackTextStyle,
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          item['dPostedOn'] ?? '',
                                          style: AppTextStyle
                                              .font14OpenSansRegularBlack45TextStyle,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          const Icon(Icons.forward,
                                              size: 10, color: Colors.black),
                                          SizedBox(width: 5),
                                          Text(
                                            'Location',
                                            style: AppTextStyle
                                                .font14OpenSansRegularBlackTextStyle,
                                          )
                                        ],
                                      ),
                                       Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          item['sLocation'] ?? '',
                                          style: AppTextStyle
                                              .font14OpenSansRegularBlack45TextStyle,
                                        ),
                                      ),
                                       Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          const Icon(Icons.forward,
                                              size: 10, color: Colors.black),
                                          SizedBox(width: 5),
                                          Text(
                                            'Description',
                                            style: AppTextStyle
                                                .font14OpenSansRegularBlackTextStyle,
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                        child: Text(
                                          item['sDescription'] ?? '',
                                          style: AppTextStyle
                                              .font14OpenSansRegularBlack45TextStyle,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      const Divider(
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                      //SizedBox(height: 5),
                                      Container(
                                        height: 60,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              flex:1,
                                              child: Container(
                                                child: Icon(Icons.file_copy,
                                                  size: 25,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 6,
                                              child: Container(
                                                child:  Text(item['sPendingFrom'] ?? '',style: AppTextStyle
                                                    .font14OpenSansRegularBlackTextStyle,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  softWrap: false,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 2),
                                                child: Container(
                                                  height: 35,
                                                  width: 75, // you can adjust or use double.infinity for full width
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFD31F76), // background color
                                                    borderRadius: BorderRadius.circular(20), // half of height
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    item['sStatusName'] ?? '',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: 40,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [Colors.white, Colors.grey, Colors.white],
                                              stops: [0.0, 0.5, 1.0],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              // Left Column
                                              Expanded(
                                                child: InkWell(
                                                  onTap:(){
                                                    print("Left Button ");
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          var fLatitude = item['fLatitude'] ?? '';
                                                          var fLongitude = item['fLongitude'] ?? '';

                                                          if (fLatitude != null &&
                                                              fLongitude != null) {
                                                            launchGoogleMaps(fLatitude,fLongitude);
                                                           // generalfunction.launchGoogleMaps(fLatitude,fLongitude);

                                                          } else {
                                                            displayToast("Please check the location.");
                                                          }

                                                          },
                                                        child: const Text("Navigate"),
                                                      ),
                                                      const Icon(Icons.arrow_forward_ios, size: 16),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // Divider in Middle
                                              Container(
                                                width: 1,
                                                height: 40,
                                                color: Colors.grey,
                                              ),

                                              // Right Column
                                              Expanded(
                                                child: InkWell(
                                                  onTap: (){
                                                    // print('Right Button');
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          var images = item['sBeforePhoto'];
                                                          print("----529----$images");
                                                          // print(images);
                                                          //ImageScreen(sBeforePhoto: images);
                                                          if(images!=null){
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        ImageScreen(sBeforePhoto: images)));
                                                          }else{
                                                            displayToast('Image is not selected');
                                                          }
                                                         // ✅ Passing image URL
                                                        },
                                                        child: const Text("View Image"),
                                                      ),
                                                      const Icon(Icons.arrow_forward_ios, size: 16),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )

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
      ),
    );
  }
}
