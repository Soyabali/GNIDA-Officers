import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noidaone/screens/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controllers/district_repo.dart';
import '../Controllers/markLocationRepo.dart';
import '../Controllers/postDailyActivityRepo.dart';
import '../Helpers/loader_helper.dart';
import '../resources/values_manager.dart';
import 'dart:async';
import 'flull_screen_image.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DailyActivitytScreen extends StatelessWidget {
  const DailyActivitytScreen({super.key});

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List stateList = [];
  List distList = [];
  List blockList = [];
  List marklocationList = [];
  double? lat, long;
  String? iUserId;
  var msg;
  var result;
  //File? image;
  //
  // Distic List
  updatedSector() async {
    distList = await DistRepo().getDistList();
    print(" -----xxxxx-  list Data--65---> $distList");
    setState(() {});
  }

  marklocationData() async {
    marklocationList = await MarkLocationRepo().getmarklocation();
    print(" -----xxxxx-  marklocationList--- Data--62---> $marklocationList");
    setState(() {});
  }
  var SectorData;
  var stateblank;
  final stateDropdownFocus = GlobalKey();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _activityDetails = TextEditingController();
  // focus
  FocusNode activityDetailfocus = FocusNode();
  FocusNode descriptionfocus = FocusNode();

  List? data;
  var _selectedStateId;
  var _dropDownValueDistric;
  var sectorresponse;
  String? sec;
  final distDropdownFocus = GlobalKey();
  File? _imageFile;
  var uplodedImage;
  final _formKey = GlobalKey<FormState>();

  // pick Image Codew
  Future pickImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    print('---Token----113--$sToken');

    try {
      final pickFileid = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 65);
      if (pickFileid != null) {
        _imageFile = File(pickFileid.path);
        setState(() {});
        print('Image File path Id Proof-------135----->$_imageFile');
        // multipartProdecudre();
        uploadImage(sToken!, _imageFile!);
      } else {
        print('no image selected');
      }
    } catch (e) {}
  }
  // uplode image code
  Future<void> uploadImage(String token, File imageFile) async {
    try {
      showLoader();
      // Create a multipart request
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://upegov.in/noidaoneapi/Api/PostImage/PostImage'));

      // Add headers
      request.headers['token'] = token;

      // Add the image file as a part of the request
      request.files.add(await http.MultipartFile.fromPath(
        'file', imageFile.path,
      ));

      // Send the request
      var streamedResponse = await request.send();

      // Get the response
      var response = await http.Response.fromStream(streamedResponse);

      // Parse the response JSON
      var responseData = json.decode(response.body);

      // Print the response data
      print(responseData);
      hideLoader();
      print('---------172---$responseData');
      uplodedImage = "${responseData['Data'][0]['sImagePath']}";
      print('----140---$uplodedImage');
    } catch (error) {
      showLoader();
      print('Error uploading image: $error');
    }
  }
  // Future<void> _getImageFromCamera() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? image = await _picker.pickImage(source: ImageSource.camera);
  //
  //   if (image != null) {
  //     setState(() {
  //       _imageFile = File(image.path);
  //     });
  //     print('----129---$_imageFile');
  //   }
  // }
   getUserIdFromSharedPreference() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     iUserId = prefs.getString('iUserId');
   }

  // InitState
  @override
  void initState() {
    // TODO: implement initState
    updatedSector();
    marklocationData();
    getUserIdFromSharedPreference();
    getLocation();
    super.initState();
    descriptionfocus = FocusNode();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    descriptionfocus.dispose();
  }
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

    setState(() {
       lat = position.latitude;
       long = position.longitude;

    });
    print('-----------141----$lat');
    print('-----------142----$long');
    // setState(() {
    // });
    debugPrint("Latitude: ----145--- $lat and Longitude: $long");
    debugPrint(position.toString());
  }

  // Todo bind sector code
  Widget _bindSector() {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),

      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: 42,
        color: Color(0xFFf2f3f5),

        child:ListView(
          scrollDirection: Axis.horizontal,
          children: [
            DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  hint: RichText(
                    text: const TextSpan(
                      text: "Please choose a Location",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal),
                      children: <TextSpan>[
                        TextSpan(
                            text: '',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ), // Not necessary for Option 1
                  value: _dropDownValueDistric,
                  // key: distDropdownFocus,
                  onChanged: (newValue) {
                    setState(() {
                      _dropDownValueDistric = newValue;
                      print('---233---$_dropDownValueDistric');
                      //  _isShowChosenDistError = false;
                      // Iterate the List
                      distList.forEach((element) {
                        if (element["sSectorName"] == _dropDownValueDistric) {
                          setState(() {
                            _selectedStateId = element['iSectorCode'];
                          });
                          print("Distic Name xxxxxxx.... $_dropDownValueDistric");
                          print("Block list Ali xxxxxxxxx.... $distList");
                        }
                      });
                    });
                  },
                  items: distList.map((dynamic item) {
                    return DropdownMenuItem(
                      child: Text(item['sSectorName'].toString()),
                      value: item["sSectorName"].toString(),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        )
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF255899),
        leading: GestureDetector(
            onTap: () {
              //Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back_ios),
            )),
        title: const Text(
          'Field Inspection',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 130, // Height of the container
              width: 200, // Width of the container
              child: Opacity(
                opacity: 0.9,
                child: Image.asset(
                  'assets/images/step3.jpg', // Replace 'image_name.png' with your asset image path
                  fit: BoxFit
                      .cover, // Adjust the image fit to cover the container
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                    color: Colors.white, // Background color of the container
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.grey.withOpacity(0.5), // Color of the shadow
                        spreadRadius: 5, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: Offset(0, 3), // Offset of the shadow
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Form(
                    key: _formKey,
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
                                'assets/images/favicon.png', // Replace with your image asset path
                                width: 14,
                                height: 14,
                              ),
                            ),
                            const Text('Fill the below details',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF707d83),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(left: 8, right: 2),
                                  child: const Icon(
                                    Icons.forward_sharp,
                                    size: 12,
                                    color: Colors.black54,
                                  )),
                              const Text('Sector',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF707d83),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        // _casteDropDownWithValidation(),
                        _bindSector(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(left: 8, right: 2),
                                  child: const Icon(
                                    Icons.forward_sharp,
                                    size: 12,
                                    color: Colors.black54,
                                  )),
                              const Text('Description',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF707d83),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Container(
                            height: 42,
                            color: Color(0xFFf2f3f5),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                               // focusNode: locationfocus,
                                controller: _activityDetails,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () =>
                                    FocusScope.of(context).nextFocus(),
                                decoration: const InputDecoration(
                                  // labelText: AppStrings.txtMobile,
                                  // border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: AppPadding.p10),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'Enter location';
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(left: 8, right: 2),
                                  child: const Icon(
                                    Icons.forward_sharp,
                                    size: 12,
                                    color: Colors.black54,
                                  )),
                              const Text('Upload Photo',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF707d83),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        //ContainerWithRow(),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFf2f3f5),
                            borderRadius:
                                BorderRadius.circular(10.0), // Border radius
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                            Icon(Icons.forward_sharp,
                                                size: 10,
                                                color: Colors.redAccent),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // pickImage();
                                    pickImage();
                                    print('---------530-----');
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 10, top: 5),
                                    child: Image(image: AssetImage('assets/images/ic_camera.PNG'),
                                      width: 35,
                                      height: 35,
                                      fit: BoxFit.fill,
                                    ),
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
                              _imageFile != null
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
                                                          child: _imageFile!,
                                                          dark: true,
                                                        )));
                                          },
                                          child: Container(
                                              color: Colors.lightGreenAccent,
                                              height: 100,
                                              width: 70,
                                              child: Image.file(
                                                _imageFile!,
                                                fit: BoxFit.fill,
                                              )),
                                        ),
                                        Positioned(
                                            bottom: 65,
                                            left: 35,
                                            child: IconButton(
                                              onPressed: () {
                                                _imageFile = null;
                                                setState(() {});
                                              },
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.red,
                                                size: 30,
                                              ),
                                            ))
                                      ],
                                    )
                                  : Text(
                                      "Photo is required.",
                                      style: TextStyle(color: Colors.red[700]),
                                    )
                            ]),
                        ElevatedButton(
                            onPressed: () async {
                             // getLocation();
                              var random = Random();
                              int randomNumber = random.nextInt(99999999 - 10000000) + 10000000;
                             //print('Random 8-digit number---770--: $randomNumber');
                              print('-------615---');
                              String activityDetaile = _activityDetails.text;
                              print('--iTranNo --$randomNumber');
                              print('--iSectorCode --$_selectedStateId');
                              print("-sRemarks--"+activityDetaile);
                              print('--sActivityPhoto --$uplodedImage');
                              print('--iPostedBy --$iUserId');
                              print('--fLatitude --$lat');
                              print('--fLongitude --$long');
                              double latitude = lat??0.0;
                              double longitude = long??0.0;
                               print('--fLatitude--604 --$latitude');
                               print('--fLongitude ---605---$longitude');
                               
                              if (_formKey.currentState!.validate() &&
                                  activityDetaile != null &&
                                  _selectedStateId != null &&
                                  _imageFile != null) {

                                print('---Api Call---');

                                var  postDailyActivityResponse =
                                await PostDailyActiviyRepo().postDailyActivity(
                                    context,
                                    randomNumber,
                                    _selectedStateId,
                                    activityDetaile,
                                    uplodedImage,
                                    iUserId,
                                    latitude,
                                    longitude);

                               print('-------625---$postDailyActivityResponse');
                               result = postDailyActivityResponse['Result'];
                               msg = postDailyActivityResponse['Msg'];

                              } else {
                                print('---Api Not Call---');
                                // here you should apply again if condition
                                if (_activityDetails.text.isEmpty) {
                                  activityDetailfocus.requestFocus();
                                }
                              }
                              /// Todo next Apply condition
                              if(result=="1"){
                                // success
                                print("----556----"+result);
                                print("----569---Success-");
                                displayToast(msg);
                               // Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HomePage()),
                                );
                              }else{
                                // failed
                                print("----573----"+result);
                                displayToast(msg);
                                print("----574---Faild-");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(
                                  0xFF255899), // Hex color code (FF for alpha, followed by RGB)
                            ),
                            child: const Text(
                              "Submit",
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
        ),
      ),
    );
  }
  // dialog toast code
  void displayToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
