import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:noidaone/Controllers/ajencyUserRepo.dart';
import 'package:noidaone/Controllers/complaintForwardRepo.dart';
import 'package:noidaone/screens/viewimage.dart';
import '../Controllers/HoldComplaintRepo.dart';
import '../Controllers/bindAjencyRepo.dart';
import '../Controllers/pendingInternalComplaintRepo.dart';
import 'actionOnSchedulePoint.dart';
import 'generalFunction.dart';
import 'homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HoldComplaintScreen extends StatelessWidget {

  const HoldComplaintScreen({Key? key}) : super(key: key);

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
      home: HoldComplaint(),
    );
  }
}

class HoldComplaint extends StatefulWidget {
  const HoldComplaint({Key? key}) : super(key: key);

  @override
  State<HoldComplaint> createState() => _SchedulePointScreenState();
}

class _SchedulePointScreenState extends State<HoldComplaint> {

  var variableName;
  var variableName2;
  List<Map<String, dynamic>>? pendingInternalComplaintList;
  List<Map<String, dynamic>> _filteredData = [];
  List bindAjencyList = [];
  List userAjencyList = [];
  var iAgencyCode;
  var agencyUserId;
  TextEditingController _searchController = TextEditingController();
  double? lat;
  double? long;
  var _dropDownAgency;
  var _dropDownAgency2;
  var _dropDownValueUserAgency;
  final distDropdownFocus = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  double _borderRadius = 0.0; // Initial border radius
  var result, msg;
  var userAjencyData;

  var result1;
  var msg1;
  String? sName, sContactNo;
  GeneralFunction generalFunction = GeneralFunction();
  GeneralFunction generalfunction = GeneralFunction();
  // Function to toggle between border radii
  // Get a api response

  holdComplaintResponse() async {
    pendingInternalComplaintList =
    await HoldComplaintRepo().holdComplaintRepo(context);
    _filteredData = List<Map<String, dynamic>>.from(pendingInternalComplaintList ?? []);

    print('--44--$pendingInternalComplaintList');
    print('--45--$_filteredData');
    setState(() {});
  }

  // get a local value
  getlocalvalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String? nameFirst = prefs.getString('nameFirst') ?? "";
      int? pointFirst = prefs.getInt('pointFirst');
      sName = prefs.getString('sName') ?? "";
      sContactNo = prefs.getString('sContactNo') ?? "";
      print("------146---$nameFirst");
      print("------1147---$pointFirst");
      print("------177---$sName");
      print("------178---$sContactNo");
    });
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    holdComplaintResponse();
    _searchController.addListener(_search);
    bindAjency();
    getlocalvalue();
    super.initState();
  }
  // get a local value

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  void _search() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredData = pendingInternalComplaintList?.where((item) {
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

  bindAjency() async {
    bindAjencyList = await BindAjencyRepo().bindajency();
    print(" -----157---bindAjencyList---> $bindAjencyList");
    setState(() {});
  }

  userAjency(int ajencyCode) async {
    print('-----170--$ajencyCode');
    // setState(() {
    // });
    // List ajencyUserList = [];
    userAjencyList = await AjencyUserRepo().ajencyuser(ajencyCode);
    setState(() {
    });
    print('----165--$userAjencyList');
    if(userAjencyList ==null || userAjencyList.isEmpty){
      displayToast("No Record Found");
    }else{
      displayToast("Record Found");
      print('---172--$userAjencyList');
      print('${userAjencyList.length}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: generalFunction.appbarFunction("Hold Complaints"),
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF255899),
      //   title: const Text(
      //     'Hold Complaints',
      //     style: TextStyle(
      //         fontFamily: 'Montserrat',
      //         color: Colors.white,
      //         fontSize: 18.0,
      //         fontWeight: FontWeight.bold),
      //   ),
      // ),
      // drawer
      drawer: generalFunction.drawerFunction(context,'$sName','$sContactNo'),

      body:
      pendingInternalComplaintList == null
          ? const Center(
        child: Text(
          'No record found',
          style: TextStyle(fontSize: 20),
        ),
      )
      :
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
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
                                      children: <Widget>[
                                        Container(
                                          width: 30.0,
                                          height: 30.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                            border: Border.all(
                                              color: Color(0xFF255899),
                                              // Outline border color
                                              width:
                                              0.5, // Outline border width
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Center(
                                              child:  Text(
                                                 '${index+1}',
                                                style: const TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: Color(0xff3f617d),
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        const Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Floating Garbage Point',
                                             // item['sPointTypeName'] ?? '',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xff3f617d),
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Point Name',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xff3f617d),
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 0),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              var fLatitude =
                                                  item['fLatitude'] ?? '';
                                              var fLongitude =
                                                  item['fLongitude'] ?? '';
                                              print('----462----${fLatitude}');
                                              print('-----463---${fLongitude}');
                                              if (fLatitude != null &&
                                                  fLongitude != null) {
                                                generalfunction.launchGoogleMaps(fLatitude,fLongitude);

                                              } else {
                                                displayToast(
                                                    "Please check the location.");
                                              }
                                            },
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              height: 40,
                                              width: 40,
                                              child: Image(
                                                  image: AssetImage(
                                                      'assets/images/ic_google_maps.PNG')),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Container(
                                      height: 0.5,
                                      color: const Color(0xff3f617d),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
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
                                        'Complaint No',
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
                                      item['iCompCode'].toString() ?? '',
                                      style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xff3f617d),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
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
                                      style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xff3f617d),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
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
                                        'Posted At',
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
                                      item['dPostedOn'] ?? '',
                                      style: const TextStyle(
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
                                      style: const TextStyle(
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
                                        'Description',
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
                                      item['sDescription'] ?? '',
                                      style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xff3f617d),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: 10),

                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      color: Color(0xffe4e4e4),
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top:4.0,bottom: 4.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  print('---Forward---');
                                                  //bindAjency();
                                                 // _showBottomSheet(context);
                                                },
                                                child:Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Icon(Icons.edit,size: 14,color: Color(0xFF255899)),
                                                    SizedBox(width: 2),
                                                    const Text('Scheduled At :',
                                                        style: TextStyle(
                                                            fontFamily:
                                                            'Montserrat',
                                                            color:
                                                            Color(0xFF255899),
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                            FontWeight.bold)),
                                                    SizedBox(width: 2),
                                                    Text(item['sPendingFrom'] ?? '',
                                                        style: const TextStyle(
                                                            fontFamily:
                                                            'Montserrat',
                                                            color:
                                                            Color(0xFF255899),
                                                            fontSize: 12.0,
                                                            fontWeight:
                                                            FontWeight.bold)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  var sBeforePhoto =
                                                      "${item['sBeforePhoto']}";
                                                  print('---$sBeforePhoto');

                                                  if (sBeforePhoto != null) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                ImageScreen(
                                                                    sBeforePhoto:
                                                                    sBeforePhoto)));
                                                  } else {
                                                    // toast
                                                  }
                                                },
                                                child: const Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'View Image',
                                                      style: TextStyle(
                                                          fontFamily:
                                                          'Montserrat',
                                                          color:
                                                          Color(0xFF255899),
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                    SizedBox(width: 2),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 12,
                                                      color: Color(0xFF255899),
                                                    )
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

// bottom screen
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey,
      builder: (BuildContext context) {
        return AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            height: 280,
            // Adjust height as needed
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0), // Adjust the radius as needed
                topRight: Radius.circular(20.0), // Adjust the radius as needed
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 30,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // Background color of the container
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            // Color of the shadow
                            spreadRadius: 5,
                            // Spread radius
                            blurRadius: 7,
                            // Blur radius
                            offset: Offset(0, 3), // Offset of the shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15,top: 0),
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin:
                                  EdgeInsets.only(left: 0, right: 10, top: 10),
                                  child: Image.asset(
                                    'assets/images/ic_expense.png',
                                    // Replace with your image asset path
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text('Fill the below details',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF707d83),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 5, top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      margin: const EdgeInsets.only(
                                          left: 0, right: 2, bottom: 2),
                                      child: const Icon(
                                        Icons.forward_sharp,
                                        size: 12,
                                        color: Colors.black54,
                                      )),
                                  const Text('Agency',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF707d83),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 50,
                              height: 50,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                      },
                                      hint: RichText(
                                        text: const TextSpan(
                                          text: 'Please choose a Agency ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      value: _dropDownAgency2,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _dropDownAgency2 = newValue;
                                          userAjencyList = [];
                                          _dropDownValueUserAgency = null;
                                          bindAjencyList.forEach((element) async {
                                            if (element["sAgencyName"] == _dropDownAgency2) {
                                              iAgencyCode = element['iAgencyCode'];
                                              setState(() {});
                                              if (iAgencyCode != null) {
                                                // TODO: update next api
                                                userAjency(iAgencyCode);

                                              } else {
                                                print('Please Select State name');
                                              }
                                            }
                                          });
                                          print("iAgencyCode value----xxx $iAgencyCode");
                                          print("_dropDownAgency Name----xxx$_dropDownAgency2");
                                        });
                                      },
                                      items: bindAjencyList.map((dynamic item) {
                                        return DropdownMenuItem(
                                          child: Text(item['sAgencyName'].toString()),
                                          value: item["sAgencyName"].toString(),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      margin: const EdgeInsets.only(
                                          left: 0, right: 2),
                                      child: const Icon(
                                        Icons.forward_sharp,
                                        size: 12,
                                        color: Colors.black54,
                                      )),
                                  const Text('User',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF707d83),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width - 50,
                                height: 50,
                                child:
                                SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DropdownButtonHideUnderline(
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                          },
                                          hint: RichText(
                                            text: const TextSpan(
                                              text: 'Please choose a State ',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: '*',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          value: _dropDownValueUserAgency,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _dropDownValueUserAgency = newValue;
                                              // userAjencyData = [];
                                              //_dropDownValueUserAgency = null;
                                              userAjencyList.forEach((element) async {
                                                if (element["sName"] == _dropDownValueUserAgency) {
                                                  agencyUserId = element['iUserId'];
                                                  setState(() {});
                                                  //   if (agencyUserId != null) {
                                                  //     // TODO: update next api
                                                  //     userAjency(iAgencyCode);
                                                  //
                                                  //   } else {
                                                  //     print('Please Select State name');
                                                  //   }
                                                }
                                              });
                                              print("agencyUserId value----xxx $agencyUserId");
                                              print("_dropDownValueUserAgency Name----xxx$_dropDownValueUserAgency");
                                            });
                                          },
                                          items: userAjencyList.map((dynamic item) {
                                            return DropdownMenuItem(
                                              child: Text(item['sName'].toString()),
                                              value: item["sName"].toString(),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    )

                                )
                            ),

                            SizedBox(height: 10),
                            ElevatedButton(
                                onPressed: () async {
                                  /// TODO REMOVE COMMENT AND apply proper api below and handle api data
                                  // print('----clicked--xxxxxxxx--');
                                  if (iAgencyCode != null &&
                                      agencyUserId != null) {
                                    var complaintForwardResponse = await ComplaintForwardRepo()
                                        .complaintForward(context,
                                        iAgencyCode, agencyUserId);
                                    result1 = "${complaintForwardResponse['Result']}";
                                    msg1 = "${complaintForwardResponse['Msg']}";
                                    print('---1126---$result1');
                                    if(result1=="1"){

                                      print('----1----xxx----');
                                      displayToast(msg1);
                                      Navigator.pop(context);

                                    }else{
                                      displayToast(msg1);
                                      print('----0---');
                                    }

                                  } else {
                                    print('----Not call a Api--');
                                  }
                                  /// Todo next Apply condition
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                      0xFF255899), // Hex color code (FF for alpha, followed by RGB)
                                ),
                                child: const Text("Submit",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
        );
      },
    );
  }
}


class MyListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              color: Colors.grey, // Outline border color
              width: 0.5, // Outline border width
            ),
            color: Colors.white,
          ),
          child: const Center(
            child: Text(
              "1.",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          )),
      title: const Text(
        'C&D Waste',
        style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold),
      ),
      subtitle: const Text(
        'Point Name',
        style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black54,
            fontSize: 14.0,
            fontWeight: FontWeight.bold),
      ),
      onTap: () {
        // Handle onTap
      },
    );
  }
}

