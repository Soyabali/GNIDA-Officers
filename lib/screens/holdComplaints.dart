import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:geolocator/geolocator.dart';
import 'package:noidaone/Controllers/ajencyUserRepo.dart';
import 'package:noidaone/screens/viewimage.dart';
import 'package:oktoast/oktoast.dart';
import '../Controllers/HoldComplaintRepo.dart';
import '../Controllers/bindAjencyRepo.dart';
import '../resources/app_text_style.dart';
import 'generalFunction.dart';
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
  final distDropdownFocus = GlobalKey();
  var result, msg;
  var userAjencyData;

  var result1;
  var msg1;
  String? sName, sContactNo;
  GeneralFunction generalFunction = GeneralFunction();
  GeneralFunction generalfunction = GeneralFunction();


  holdComplaintResponse() async {
    pendingInternalComplaintList =
    await HoldComplaintRepo().holdComplaintRepo(context);
    _filteredData = List<Map<String, dynamic>>.from(pendingInternalComplaintList ?? []);

    setState(() {});
  }

  // get a local value
  getlocalvalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sName = prefs.getString('sName') ?? "";
      sContactNo = prefs.getString('sContactNo') ?? "";
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
    // setState(() {
    // });
    debugPrint("Latitude: ----1056--- $lat and Longitude: $long");
    debugPrint(position.toString());
  }
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
  bindAjency() async {
    bindAjencyList = await BindAjencyRepo().bindajency();
    print(" -----157---bindAjencyList---> $bindAjencyList");
    setState(() {});
  }
  userAjency(int ajencyCode) async {
    print('-----170--$ajencyCode');
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
  // backbutton
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
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Color(0xFF8b2355),
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          backgroundColor:  const Color(0xFFD31F76),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child:const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back_ios),
              )),
          title:const Text(
            'Hold Complaints',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          elevation: 1,
          iconTheme: const IconThemeData(
            color: Colors.white, // 👈 sets drawer icon color to white
          ),
        ),
        // drawer
        drawer: generalFunction.drawerFunction(context,'$sName','$sContactNo'),
        body: pendingInternalComplaintList == null
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
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
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
            // scroll item after search bar
            Expanded(
              child: ListView.builder(
                itemCount: _filteredData.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> item = _filteredData[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, top: 8, right: 10),
                    child: Container(
                     // color: Colors.white,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // Background color
                        borderRadius: BorderRadius.circular(10),
                        // Border radius
                        border: Border.all(
                          color: Colors.grey, // Border color
                          width: 1, // Border width
                        ),
                      ),
                      child: Column(
                        children: [
                          Card(
                            //elevation: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                  color: Colors.white, // Outline border color
                                  width: 0.2, // Outline border width
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0, right: 0),
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10),
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
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    child: const Image(
                                                        image: AssetImage(
                                                            'assets/images/ic_google_maps.PNG')),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        const SizedBox(height: 5),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15, right: 15),
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
                                            item['iCompCode'].toString(),
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
                                        SizedBox(height: 5),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
                                          child: Container(
                                            //color: Color(0xffe4e4e4),
                                            height: 40,
                                            decoration: const BoxDecoration(
                                              color: Color(0xffe4e4e4),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5), // Only the top-left corner
                                              ),
                                            ),

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
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          SizedBox(width: 2),
                                                          Icon(Icons.lock_clock,size: 14,color: Color(0xFF255899)),
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
                                                    padding: const EdgeInsets.all(8.0),
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
                                                                fontFamily: 'Montserrat',
                                                                color: Color(0xFF255899),
                                                                fontSize: 12.0,
                                                                fontWeight: FontWeight.bold),
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

