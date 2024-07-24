import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noidaone/Controllers/ajencyUserRepo.dart';
import 'package:noidaone/Controllers/complaintForwardRepo.dart';
import 'package:noidaone/screens/viewimage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controllers/baseurl.dart';
import '../Controllers/bindAjencyRepo.dart';
import '../Controllers/bindHoldRepo.dart';
import '../Controllers/bindPointTypeRepo.dart';
import '../Controllers/changePointTypeRepo.dart';
import '../Controllers/holoComplaintRepo.dart';
import '../Controllers/pendingInternalComplaintRepo.dart';
import '../Controllers/postimage_2_Repo.dart';
import '../Helpers/loader_helper.dart';
import 'actionOnSchedulePoint.dart';
import 'flull_screen_image.dart';
import 'generalFunction.dart';
import 'package:http/http.dart' as http;


class HomeScreen_2 extends StatelessWidget {
  const HomeScreen_2({Key? key}) : super(key: key);

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
      home: HomeScreenPage_2(),
    );
  }
}

class HomeScreenPage_2 extends StatefulWidget {
  const HomeScreenPage_2({Key? key}) : super(key: key);

  @override
  State<HomeScreenPage_2> createState() => _SchedulePointScreenState();
}

class _SchedulePointScreenState extends State<HomeScreenPage_2> {

  GeneralFunction generalFunction = GeneralFunction();

  var variableName;
  var variableName2;
  List<Map<String, dynamic>>? pendingInternalComplaintList;
  List<Map<String, dynamic>> _filteredData = [];
  List bindAjencyList = [];
  List bindPointTypeDropDown = [];
  List bindHoldList = [];
  List userAjencyList = [];
  var iAgencyCode;
  var agencyUserId;
  File? _imageFile;
  File? image;
  var iCompCode;
  TextEditingController _searchController = TextEditingController();
  double? lat;
  double? long;
  var _dropDownAgency;
  var _dropDownAgency2;
  var _dropDownComplaintType;
  var _dropDownHold;
  var _dropDownValueUserAgency;
  final distDropdownFocus = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  double _borderRadius = 0.0; // Initial border radius
  var result, msg;
  var userAjencyData;
  var uplodedImage;

  var result1;
  var msg1;
  var selectedHoldValue;
  var selectedComplaintValue;
  var iTotalComp,iResolved;
  GeneralFunction generalfunction = GeneralFunction();
  // Function to toggle between border radii

  // Get a api response
  pendingInternalComplaintResponse() async {
    pendingInternalComplaintList = await PendingInternalComplaintRepo().pendingInternalComplaint(context);
    _filteredData = List<Map<String, dynamic>>.from(pendingInternalComplaintList ?? []);

    print('--77-----$pendingInternalComplaintList');
    print('--45--$_filteredData');
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    pendingInternalComplaintResponse();
    _searchController.addListener(_search);
    bindAjency();
    bindHold();
    getComplaintStatus();
    bindPointTypeDropDown_2();
    super.initState();
  }
   getComplaintStatus() async {
     //Future<List<Map<String, dynamic>>?> pendingInternalComplaint(BuildContext context) async {
       SharedPreferences prefs = await SharedPreferences.getInstance();
       String? sToken = prefs.getString('sToken');
       String? iUserId = prefs.getString('iUserId');

       try {
         var baseURL = BaseRepo().baseurl;
         var endPoint = "PendingInternalComplaint_V2/PendingInternalComplaint_V2";
         var pendingInternalComplaintApi = "$baseURL$endPoint";

         showLoader();
         var headers = {
           'token': '$sToken',
           'Content-Type': 'application/json'
         };
         var request = http.Request('POST', Uri.parse('$pendingInternalComplaintApi'));
         request.body = json.encode({
           "iUserId": iUserId,
           "iPage":"",
           "iPageSize":""
         });
         request.headers.addAll(headers);
         http.StreamedResponse response = await request.send();

         if (response.statusCode == 200) {
           hideLoader();
           var data = await response.stream.bytesToString();
           Map<String, dynamic> parsedJson = jsonDecode(data);
           print('------40----$parsedJson');
           iTotalComp = parsedJson['iTotalComp'];
           iResolved = parsedJson['iResolved'];

           print('------140---$iTotalComp');
           print('------141---$iResolved');

       // List<dynamic>? dataList = parsedJson['Data'];
           //
           // if (dataList != null) {
           //   List<Map<String, dynamic>> pendingInternalComplaintList = dataList.cast<Map<String, dynamic>>();
           //   print("Dist list: $pendingInternalComplaintList");
           //   return pendingInternalComplaintList;
           // } else if(response.statusCode==401) {
           //   generalFunction.logout(context);
           // }
         } else {
           hideLoader();
           return null;
         }
       } catch (e) {
         hideLoader();
         debugPrint("Exception: $e");
         throw e;
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
  // pick a images
  // pick images
  // Future<void> _getImageFromCamera() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  //
  //   if (image != null) {
  //     setState(() {
  //       _imageFile = File(image.path);
  //     });
  //     if(_imageFile!=null){
  //       var imagePath = PostImageRepo_2().postImage(context, _imageFile);
  //       print('----179----$imagePath');
  //
  //     }
  //     print('----129---$_imageFile');
  //   }
  // }

  Future pickImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    print('---Token----113--$sToken');

    try {
      final pickFileid = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 65);
      if (pickFileid != null) {
        image = File(pickFileid.path);
        setState(() {});
        print('Image File path Id Proof-------135----->$image');
        // multipartProdecudre();
        uploadImage(sToken!, image!);
      } else {
        print('no image selected');
      }
    } catch (e) {}
  }

  // upload images
  Future<void> uploadImage(String token, File imageFile) async {
    try {
      showLoader();
      // Create a multipart request
      var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://upegov.in/noidaoneapi/Api/PostImage/PostImage'));
      // Add headers
      request.headers['token'] = token;
      // Add the image file as a part of the request
      request.files.add(await http.MultipartFile.fromPath('sFolder', imageFile.path));
      // Send the request
      var streamedResponse = await request.send();
      // Get the response
      var response = await http.Response.fromStream(streamedResponse);
      // Parse the response JSON
      var responseData = json.decode(response.body);
      // Print the response data
      print(responseData);
      hideLoader();
      print('---------238---$responseData');
      uplodedImage = "${responseData['Data'][0]['sImagePath']}";
      print('----242--xxx-----$uplodedImage');
    } catch (error) {
      showLoader();
      print('Error uploading image: $error');
    }
  }

  bindAjency() async {
    bindAjencyList = [];
    bindAjencyList = await BindAjencyRepo().bindajency();
    print(" -----302---bindAjencyList---> $bindAjencyList");
    setState(() {});
  }
  // complaintType dropdown value
  bindPointTypeDropDown_2() async {
   // bindPointTypeDropDown = [];
    bindPointTypeDropDown = await BindPointTypeDropDownRepo().bindPointType();
    print(" -----310---bindPointType---> $bindPointTypeDropDown");
    setState(() {});
  }

  // bind Hold
  bindHold() async {
    bindHoldList = [];
    bindHoldList = await BindHoldRepo().bindHold();
    print(" -----252---bindHoldList---> $bindHoldList");
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
      appBar: AppBar(
        backgroundColor: Color(0xFF255899),
        title: const Text(
          'Complaint Status',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      // drawer
      drawer: generalFunction.drawerFunction(context,'',''),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Padding(
                 padding: EdgeInsets.only(left: 18,top: 10),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     const Text('Total', style: TextStyle(
                         fontFamily: 'Montserrat',
                         color: Color(0xff3f617d),
                         fontSize: 14.0,
                         fontWeight: FontWeight.bold)),
                     const SizedBox(width: 10),
                     const Text(':', style: TextStyle(
                         fontFamily: 'Montserrat',
                         color: Color(0xff3f617d),
                         fontSize: 14.0,
                         fontWeight: FontWeight.bold)),
                     SizedBox(width: 10),
                     Text('$iTotalComp',style: const TextStyle(
                         fontFamily: 'Montserrat',
                         color: Color(0xff3f617d),
                         fontSize: 14.0,
                         fontWeight: FontWeight.bold),
                     ),
                   ],
                 ),
               ),
              Padding(
                padding: EdgeInsets.only(right: 20,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Resolved', style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xff3f617d),
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    const Text(':', style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xff3f617d),
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text('$iResolved',style: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xff3f617d),
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ],
          ),
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
                                            border: Border.all(color: Color(0xFF255899),
                                              // Outline border color
                                              width: 0.5, // Outline border width
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: const Center(
                                              child: Icon(Icons.ac_unit_rounded,
                                                  color: Color(0xFF255899),
                                                  size: 20)),
                                        ),
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
                                        ),
                                        const SizedBox(width: 0),
                                        Expanded(
                                          child: GestureDetector(
                                            // onTap: () {
                                            //   var fLatitude =
                                            //       item['fLatitude'] ?? '';
                                            //   var fLongitude =
                                            //       item['fLongitude'] ?? '';
                                            //   print('----462----${fLatitude}');
                                            //   print('-----463---${fLongitude}');
                                            //   if (fLatitude != null &&
                                            //       fLongitude != null) {
                                            //     generalfunction.launchGoogleMaps(fLatitude,fLongitude);
                                            //
                                            //   } else {
                                            //     displayToast(
                                            //         "Please check the location.");
                                            //   }
                                            // },
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              height: 40,
                                              // width: 40,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end, // Aligns the row to the right
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        var fLatitude = item['fLatitude'] ?? '';
                                                        var fLongitude = item['fLongitude'] ?? '';
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
                                                      child: const Image(image: AssetImage('assets/images/ic_google_maps.PNG'))),
                                                  SizedBox(width: 2),
                                                  GestureDetector(
                                                      onTap: (){
                                                        print('---Helo ----jpeg---');
                                                        iCompCode =   item['iCompCode'].toString() ?? '';
                                                        print('---506--$iCompCode');
                                                        _showBottomSheetHold(context,iCompCode);
                                                      },
                                                    child: const Padding(
                                                      padding: EdgeInsets.only(top: 5),
                                                      child: Image(image: AssetImage('assets/images/holo.jpeg')),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
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
                                        'Complaint NO',
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          const Icon(
                                            Icons.calendar_month,
                                            size: 10,
                                            color: Color(0xff3f617d),
                                          ),
                                          SizedBox(width: 5),
                                          const Text(
                                            'Pending Since :-',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF255899),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            item['sPendingFrom'] ?? '',
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xff3f617d),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15,top: 8),
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
                                                fontSize: 14.0,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(
                                            Icons.forward_sharp,
                                            color: Color(0xFF255899),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),

                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      color: Color(0xffe4e4e4),
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 0, right: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(height: 10, width: 1, color: Colors.grey),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        print('----341---');
                                                        var sBeforePhoto = "${item['sBeforePhoto']}";
                                                        print('----357---$sBeforePhoto');
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => ActionOnSchedultPointScreen(sBeforePhoto: sBeforePhoto),
                                                          ),
                                                        );
                                                      },
                                                      child: const Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Action',
                                                            style: TextStyle(
                                                                fontFamily: 'Montserrat',
                                                                color: Color(0xFF255899),
                                                                fontSize: 12.0,
                                                                fontWeight: FontWeight.normal
                                                            ),
                                                          ),
                                                          SizedBox(width: 2),
                                                          Icon(Icons.forward_sharp,
                                                              size: 15,
                                                              color: Color(0xFF255899)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(height: 10, width: 1, color: Colors.grey),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        print('---Complaint Transfer ---');
                                                        iCompCode =   item['iCompCode'].toString() ?? '';
                                                        print('---506--$iCompCode');
                                                        _showBottomSheetComplaintType(context,iCompCode);

                                                      },
                                                      child: const Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Complaint Transfer',
                                                            style: TextStyle(
                                                                fontFamily: 'Montserrat',
                                                                color: Color(0xFF255899),
                                                                fontSize: 12.0,
                                                                fontWeight: FontWeight.normal
                                                            ),
                                                          ),
                                                          SizedBox(width: 2),
                                                          Icon(Icons.forward_sharp,
                                                              size: 15,
                                                              color: Color(0xFF255899)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(height: 10, width: 1, color: Colors.grey),
                                                  Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        print('---Forward---');
                                                        iCompCode =   item['iCompCode'].toString() ?? '';
                                                        print('---506--$iCompCode');
                                                       // _showBottomSheetHold(context,iCompCode);
                                                        _showBottomSheet(context,iCompCode);
                                                      },
                                                      child: const Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Forward',
                                                            style: TextStyle(
                                                                fontFamily: 'Montserrat',
                                                                color: Color(0xFF255899),
                                                                fontSize: 12.0,
                                                                fontWeight: FontWeight.normal
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
  // show hold bottomSeet

  void _showBottomSheetHold(BuildContext context, String iCompCode) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey,
      builder: (BuildContext context) {
        return AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            height: 342,
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
                                  const Text('Hold Time',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFF707d83),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 50,
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
                                          text: 'Please choose a Hold',
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
                                      value: _dropDownHold,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _dropDownHold = newValue;
                                          print('---187---$_dropDownHold');
                                          //  _isShowChosenDistError = false;
                                          // Iterate the List
                                          bindHoldList.forEach((element) {
                                            if (element["sHoldDesc"] == _dropDownHold) {
                                              setState(() {
                                                selectedHoldValue = element['iHold'];
                                              });
                                              print('-----1021----$selectedHoldValue');
                                            }
                                          });
                                        });
                                      },
                                      items: bindHoldList.map((dynamic item) {
                                        return DropdownMenuItem(
                                          child: Text(item['sHoldDesc'].toString()),
                                          value: item["sHoldDesc"].toString(),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFf2f3f5),
                                borderRadius: BorderRadius.circular(10.0), // Border radius
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Click Photo',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.black54,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Please clock here to take a photo',
                                                  style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      color: Colors.redAccent,
                                                      fontSize: 10.0,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(width: 10),
                                                Icon(Icons.forward_sharp,size: 10,color: Colors.redAccent),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        // pickImage();
                                        pickImage();
                                        print('---------530-----');
                                        },
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 10,top: 5),
                                        child: Image(image: AssetImage('assets/images/ic_camera.PNG'),
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.fill,
                                        ),
                                        // child: Icon(
                                        //   Icons.camera,
                                        //   size: 24.0,
                                        //   color: Color(0xFF255899),
                                        // ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  image != null
                                      ? Stack(
                                    children: [
                                      GestureDetector(
                                        behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FullScreenPage(
                                                        child: image!,
                                                        dark: true,
                                                      )));
                                        },
                                        child: Container(
                                            color: Colors.lightGreenAccent,
                                            height: 100,
                                            width: 70,
                                            child: Image.file(
                                              image!,
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                      Positioned(
                                          bottom: 65,
                                          left: 35,
                                          child: IconButton(
                                            onPressed: () {
                                              image = null;
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.red,
                                              size: 30,
                                            ),
                                          ))
                                    ],
                                  ) :
                                  Text(
                                    "Photo is required.",
                                    style:
                                    TextStyle(color: Colors.red[700]),
                                  )
                                ]),

                            ElevatedButton(
                                onPressed: () async {
                                  /// TODO REMOVE COMMENT AND apply proper api below and handle api data
                                  // print('----clicked--xxxxxxxx--
                                //  var complaintCode =   item['iCompCode'].toString() ?? '';
                                  if (selectedHoldValue != null) {

                                    var complaintForwardResponse = await HoloComplaintRepo().holoComplaint(context,
                                        selectedHoldValue, uplodedImage!,iCompCode);
                                    print('-----1174--xx--$complaintForwardResponse');

                                      result1 = "${complaintForwardResponse['Result']}";
                                      msg1 = "${complaintForwardResponse['Msg']}";
                                     print('---1126---$result1');

                                     if(result1=="1"){
                                      // Navigator.pop(context);

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
                                child: const Text("Complaint Hold",
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
  // bottomSeet ComplaintType
  void _showBottomSheetComplaintType(BuildContext context,String iCompCode) {
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
                                  const Text('Complaints Type',
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
                                          text: 'Select JE ',
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
                                      value: _dropDownComplaintType,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _dropDownComplaintType = newValue;
                                          print('---187---$_dropDownComplaintType');
                                          //  _isShowChosenDistError = false;
                                          // Iterate the List
                                          bindPointTypeDropDown.forEach((element) {
                                            if (element["sPointTypeName"] == _dropDownComplaintType) {
                                              setState(() {
                                                selectedComplaintValue = element['iPointTypeCode'];
                                              });
                                              print('-----1021----$selectedComplaintValue');
                                            }
                                          });
                                        });
                                      },
                                      items: bindPointTypeDropDown.map((dynamic item) {
                                        return DropdownMenuItem(
                                          child: Text(item['sPointTypeName'].toString()),
                                          value: item["sPointTypeName"].toString(),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                                onPressed: () async {
                                  /// TODO REMOVE COMMENT AND apply proper api below and handle api data
                                  // print('----clicked--xxxxxxxx--');
                                  if (selectedComplaintValue != null) {

                                    var complaintForwardResponse = await ChangePointTypeRepo()
                                        .changePointType(context, selectedComplaintValue, iCompCode);

                                       print('-----1453----$complaintForwardResponse');

                                     result1 = "${complaintForwardResponse['Result']}";
                                     msg1 = "${complaintForwardResponse['Msg']}";
                                    print('---1468---xxx-----$result1');
                                    print('---1469---xxx-----$msg1');
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

// bottom screen
  void _showBottomSheet(BuildContext context,String iCompCode) {
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
                                  const Text('JE',
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
                                          text: 'Select JE ',
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
                                         // bindAjencyList = [];
                                          print('---187---$_dropDownAgency2');
                                          //  _isShowChosenDistError = false;
                                          // Iterate the List
                                          bindAjencyList.forEach((element) {
                                            if (element["sName"] == _dropDownAgency2) {
                                              setState(() {
                                                selectedHoldValue = element['iUserId'];
                                              });
                                              print('-----1021----$selectedHoldValue');
                                            }
                                          });
                                        });
                                      },
                                      items: bindAjencyList.map((dynamic item) {
                                        return DropdownMenuItem(
                                          child: Text(item['sName'].toString()),
                                          value: item["sName"].toString(),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                                onPressed: () async {
                                  /// TODO REMOVE COMMENT AND apply proper api below and handle api data
                                  // print('----clicked--xxxxxxxx--');
                                  if (selectedHoldValue != null) {
                                    var complaintForwardResponse = await ComplaintForwardRepo()
                                        .complaintForward(context,
                                        selectedHoldValue, iCompCode);

                                    result1 = "${complaintForwardResponse['Result']}";
                                     msg1 = "${complaintForwardResponse['Msg']}";
                                     print('---1468---xxx-----$result1');
                                    print('---1469---xxx-----$msg1');
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

