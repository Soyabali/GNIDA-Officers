import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:noidaone/screens/viewimage.dart';
import 'package:oktoast/oktoast.dart';
import '../Controllers/PendingScheduledPointRepo.dart';
import '../Helpers/loader_helper.dart';
import '../resources/app_text_style.dart';
import 'actionOnSchedulePoint.dart';
import 'generalFunction.dart';
import 'gnidaofficers/supervisorDashboard/supervisiorDashboard.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';

class ScheduledPointScreen extends StatelessWidget {

  const ScheduledPointScreen({Key? key}) : super(key: key);

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
  GeneralFunction generalfunction = GeneralFunction();

  @override
  void initState() {
    super.initState();
    schedulePointresponse();
    getLocation();
    _searchController.addListener(_search);
    //getLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  // get location

  void getLocation() async {
    showLoader();
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      hideLoader();
      return Future.error('Location services are disabled.');

    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      hideLoader();
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        hideLoader();
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      hideLoader();
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint("-------------Position-----------------");
    debugPrint(position.latitude.toString());
    setState(() {
      lat = position.latitude;
      long = position.longitude;
      hideLoader();
    });

    print('-----------105----$lat');
    print('-----------106----$long');
    // setState(() {
    // });
    debugPrint("Latitude: ----1056--- $lat and Longitude: $long");
    debugPrint(position.toString());
  }
  // Scheduled Point Navigate
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


  schedulePointresponse() async {
    pendingSchedulepointList = await PendingSchedulePointRepo().pendingschedulepoint(context);
    _filteredData = List<Map<String, dynamic>>.from(pendingSchedulepointList ?? []);
    print('--59--$pendingSchedulepointList');
    print('--115----$_filteredData');
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
    // Fluttertoast.showToast(
    //     msg: msg,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
  }
  // mobile back button handle
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?',style: AppTextStyle
            .font14OpenSansRegularBlackTextStyle,),
        content: new Text('Do you want to exit app',style: AppTextStyle
            .font14OpenSansRegularBlackTextStyle,),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () {
              //  goToHomePage();
              // exit the app
              exit(0);
            }, //Navigator.of(context).pop(true), // <-- SEE HERE
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar:AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: Color(0xFF8b2355),
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
              // Status bar brightness (optional)
              // For Android (dark icons)
              // For iOS (dark icons)
            ),
            backgroundColor:  const Color(0xFFD31F76),
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SupervisiorDashBoard()));

                },
                child:const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back_ios),
                )),
            title:const Text(
              'Scheduled Point',
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
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
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
                                  prefixIcon: Icon(Icons.search,
                                  color: Colors.grey
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.fromLTRB(8.0, 6.0, 16.0, 8.0),
                                  // contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust horizontal padding as needed
                                ),
                              ),
                            )
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
                  itemCount: _filteredData.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> item = _filteredData[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          // radious
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xffe4e4e4), // Border color
                            width: 1, // Border width
                          ),
                         // borderRadius: BorderRadius.circular(10), // Optional: Border radius
                        ),
                        child: Column(
                          children: [
                            Container(
                                child: Container(
                                    color: Colors.white,
                                    //margin: EdgeInsets.only(left: 10,right: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 4,right: 4,top: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  width: 30.0,
                                                  height: 30.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(15.0),
                                                    border: Border.all(
                                                      color: Colors.black, // Outline border color
                                                      width: 0.5, // Outline border width
                                                    ),
                                                    color: Colors.white,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "${index + 1}",
                                                      style: const TextStyle(
                                                          fontFamily: 'Montserrat',
                                                          color: Colors.black,
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
                                                  // Text(
                                                  //   item['sPointTypeName'] ?? '',
                                                  //   style: const TextStyle(
                                                  //       fontFamily: 'Montserrat',
                                                  //       color: Color(0xff3f617d),
                                                  //       fontSize: 14.0,
                                                  //       fontWeight: FontWeight.bold),
                                                  // ),
                                                  // Text(
                                                  //   item['sPointTypeName'] ?? '',
                                                  // style: AppTextStyle.font16OpenSansRegularBlackTextStyle),
                                            SizedBox(width: 4),
                                            Text(item['sPointTypeName'] ?? '',
                                                style: AppTextStyle.font14OpenSansRegularBlackTextStyle),
                                                  Text(
                                                    'Point Name',
                                                      style: AppTextStyle
                                                          .font12OpenSansRegularBlack45TextStyle,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15, right: 15),
                                          child: Container(
                                            height: 0.5,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                         Padding(
                                          padding: EdgeInsets.only(left: 4,right: 4),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              const Icon(
                                                Icons.forward,
                                                size: 10,
                                                color: Color(0xff3f617d),
                                              ),
                                              SizedBox(width: 5),
                                              //  '‣ Sector',
                                              Text(
                                                'Sector',
                                                  style: AppTextStyle.font14OpenSansRegularBlackTextStyle
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 19),
                                          child: Text(
                                            item['sSectorName'] ?? '',
                                              style: AppTextStyle.font12OpenSansRegularBlack45TextStyle
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 4,right: 4),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Icon(Icons.forward,
                                                  size: 10, color: Colors.black),
                                              SizedBox(width: 5),
                                              Text(
                                                'Location',
                                                  style: AppTextStyle.font14OpenSansRegularBlackTextStyle
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 19),
                                          child: Text(
                                            item['sLocation'] ?? '',
                                            style: AppTextStyle.font12OpenSansRegularBlack45TextStyle
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
                                          child: Container(
                                            height: 40,
                                            decoration: BoxDecoration(color: Color(0xffe4e4e4),
                                              borderRadius: BorderRadius.circular(5), // Round all corners
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>
                                                [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          print('00000000----');
                                                          var sBeforePhoto = "${item['sBeforePhoto']}";
                                                          print('-----417---$sBeforePhoto');

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
                                                        child:Text(
                                                          'View Image',
                                                            style: AppTextStyle.font14OpenSansRegularBlackTextStyle
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      const Icon(
                                                        Icons.forward_sharp,
                                                        size: 15,
                                                        color: Colors.black,
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                      height: 10,
                                                      width: 1,
                                                      color: Colors.grey),
                                                  GestureDetector(
                                                    onTap: () {
                                                      print('---406--$lat');
                                                      print('---407--$long');
                                                      var sBeforePhoto = "${item['sBeforePhoto']}";
                                                      var iTaskCode = "${item['iTaskCode']}";
                                                      print('---410----$sBeforePhoto');
                                                      print('---411----$iTaskCode');

                                                      // create an instance of the class

                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ActionOnSchedultPointScreen(
                                                                    sBeforePhoto: sBeforePhoto,iTaskCode:iTaskCode,lat:lat,long:long)),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsets.all(8.0),
                                                      child: Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'Action',
                                                                style: AppTextStyle.font14OpenSansRegularBlackTextStyle
                                                            ),
                                                            SizedBox(width: 5),
                                                            const Icon(
                                                              Icons.forward_sharp,
                                                              size: 15,
                                                              color: Colors.black,
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
                                                  Padding(
                                                      padding: EdgeInsets.all(6.0),
                                                      child: InkWell(
                                                        onTap: (){
                                                          var fLatitude =  item['fLatitude'] ?? '';
                                                          var fLongitude =  item['fLongitude'] ?? '';
                                                          print('----462----${fLatitude}');
                                                          print('-----463---${fLongitude}');

                                                          if(fLatitude !=null && fLongitude!=null){
                                                            //launchGoogleMaps()
                                                            print('---472----$fLatitude');
                                                            print('---473----$fLongitude');
                                                            //generalfunction.launchGoogleMaps(fLatitude,fLongitude);
                                                            launchGoogleMaps(fLatitude,fLongitude);
                                                          }else{
                                                            displayToast("Please check the location.");
                                                          }
                                                        },
                                                        child:Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Text('Navigate',style: AppTextStyle.font14OpenSansRegularBlackTextStyle
                                                            ),
                                                            SizedBox(width: 5),
                                                            const Icon(
                                                              Icons.forward_sharp,
                                                              size: 15,
                                                              color: Colors.black,
                                                            ),
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
                                        ),
                                      ],
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
      ),
    );
  }
}

