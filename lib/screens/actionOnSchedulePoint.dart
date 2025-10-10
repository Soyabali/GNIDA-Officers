import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controllers/actionOnSchedulePointRepo.dart';
import '../Controllers/baseurl.dart';
import '../Controllers/district_repo.dart';
import '../Helpers/loader_helper.dart';
import '../resources/values_manager.dart';
import 'flull_screen_image.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ActionOnSchedultPointScreen extends StatefulWidget {

  final sBeforePhoto, iTaskCode;

  ActionOnSchedultPointScreen(
      {super.key, this.sBeforePhoto, this.iTaskCode, double? lat, double? long});


  @override
  State<ActionOnSchedultPointScreen> createState() =>
      _ActionOnSchedultPointScreenState();
}

class _ActionOnSchedultPointScreenState
    extends State<ActionOnSchedultPointScreen> {

  final _formKey = GlobalKey<FormState>();
  var sectorresponse;
  String? sec;
  List distList = [];
  double? lat, long;
  final distDropdownFocus = GlobalKey();
  File? image;
  var uplodedImage;
  TextEditingController _remarkController = TextEditingController();

  // focus
  FocusNode locationfocus = FocusNode();
  FocusNode remarkfocus = FocusNode();
  File? _imageFile;
  var result;

  var mag;

  // Sector Api get response
  updatedSector() async {
    distList = await DistRepo().getDistList();
    print(" -----xxxxx-  list Data--53---> $distList");
    setState(() {});
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

    print('-----------105----$lat');
    print('-----------106----$long');
    // setState(() {
    // });
    debugPrint("Latitude: ----1056--- $lat and Longitude: $long");
    debugPrint(position.toString());
  }

  // pick images
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

  // uplode images
  // image code
  Future<void> uploadImage(String token, File imageFile) async {
    try {
      showLoader();
      var baseURL = BaseRepo().baseurl;
      var endPoint = "PostImage/PostImage";
      var postImageApi = "$baseURL$endPoint";
      // Create a multipart request
      var request = http.MultipartRequest(
          'POST',
          Uri.parse('$postImageApi'));
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
      print('----145---$uplodedImage');
    } catch (error) {
      showLoader();
      print('Error uploading image: $error');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // updatedSector();
    getLocation();
  }

  // toast
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            },
            child:const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back_ios),
            )),
        title:const Text(
          'Action on Scheduled Point',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: <Widget>[
        Container(
        height: 130, // Height of the container
        width: 200, // Width of the container
        child: Opacity(
          opacity: 0.9,
          child: Image.asset(
            'assets/images/step3.jpg',
            // Replace 'image_name.png' with your asset image path
            fit:
            BoxFit.cover, // Adjust the image fit to cover the container
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width - 30,
          decoration: BoxDecoration(
              color: Colors.white, // Background color of the container
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Color of the shadow
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
                      margin: EdgeInsets.only(left: 0, right: 10, top: 10),
                      child: Image.asset('assets/images/ic_expense.png',
                        // Replace with your image asset path
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                          'Fill the below details',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF707d83),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 0, right: 2),
                          child: const Icon(
                            Icons.forward_sharp,
                            size: 12,
                            color: Colors.black54,
                          )),
                      const Text(
                          'Reference photo',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF707d83),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    child: Image.network(
                      '${widget.sBeforePhoto}',
                      // Replace this URL with your image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 0, right: 2),
                          child: const Icon(
                            Icons.forward_sharp,
                            size: 12,
                            color: Colors.black54,
                          )),
                      const Text(
                          'Remarks',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF707d83),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0),
                  child: Container(
                    height: 42,
                    //  color: Colors.black12,
                    color: Color(0xFFf2f3f5),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextFormField(
                        focusNode: remarkfocus,
                        controller: _remarkController,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                        decoration: const InputDecoration(
                          // labelText: AppStrings.txtMobile,
                          //  border: OutlineInputBorder(),
                          contentPadding:
                          EdgeInsets.symmetric(vertical: AppPadding.p10),
                          //prefixIcon: Icon(Icons.phone,color:Color(0xFF255899),),
                        ),
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
                          margin: EdgeInsets.only(left: 0, right: 2),
                          child: const Icon(
                            Icons.forward_sharp,
                            size: 12,
                            color: Colors.black54,
                          )),
                      const Text(
                          'Upload Photo',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF707d83),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold)
                      ),
                    ],
                  ),
                ),

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
                                      'Please click here to take a photo',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.redAccent,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.forward_sharp, size: 10,
                                        color: Colors.redAccent),
                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            pickImage();
                            // _getImageFromCamera();
                            print('---------530-----');
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 10, top: 5),
                            child: Image(image: AssetImage(
                                'assets/images/ic_camera.PNG'),
                              width: 40,
                              height: 40,
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
                                            child: _imageFile!,
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
                        "",
                        style:
                        TextStyle(color: Colors.red[700]),
                      )
                    ]),

                ElevatedButton(
                  onPressed: () async {
                    // current date
                    DateTime currentDate = DateTime.now();
                    var todayDate = DateFormat('dd/MMM/yyyy HH:mm').format(
                        currentDate);
                    print('Formatted Date--672--: $todayDate');
                    var remarks = _remarkController.text;
                    print('--506--$remarks');
                    print('--508---Image-$_imageFile');

                    if (_formKey.currentState!.validate()
                        && remarks != null && uplodedImage != null &&
                        lat != null && long != null) {
                      print('---_imageFile--$uplodedImage');
                      print('---lat--$lat');
                      print('---long--$long');
                      print('---todayDate--${todayDate}');
                      //  Todo call Api
                      // print('----Call Api----');
                      /// TODO REMOVE COMMENT AND APPLY right api

                      var actiononSchedulepointresponse = await ActionOnScheduleRepo()
                          .actionOnSchedulePoint(
                          context,
                          remarks!,
                          uplodedImage,
                          lat,
                          long,
                          todayDate,
                          "${widget.iTaskCode}");

                      /// TODO REMOVE THIS API
                      print('---475--------$actiononSchedulepointresponse');
                      result = "${actiononSchedulepointresponse['Result']}";
                      mag = "${actiononSchedulepointresponse['Msg']}";
                      print('----579---$result');
                      print('----580---$mag');
                    } else {
                      if (remarks == null || remarks == '') {
                        displayToast("Please Enter remarks");
                      }
                      if (_imageFile == null || remarks == '') {
                        displayToast("Please click Photo");
                      }
                    }
                    if (result == "1") {
                          displayToast(mag);
                          Navigator.pop(context);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => const HomePage()));

                    }else{
                      displayToast(mag);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD31F76), // Hex color code (FF for alpha, followed by RGB)
                  ),

                    child: const Text("Submit", style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),))
            ],
          ),
        ),
      ),
    ),)
    ,
    ]
    ,
    )
    ,
    );
  }
}

