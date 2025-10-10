import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:noidaone/Controllers/BindCitizenWardRepo.dart';
import 'package:oktoast/oktoast.dart' show ToastPosition, showToast;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controllers/PotholeDetailsRepo.dart';
import '../Controllers/baseurl.dart';
import '../Controllers/bindSubCategoryRepo.dart';
import '../Controllers/district_repo.dart';
import '../Helpers/loader_helper.dart';
import '../resources/app_text_style.dart';
import '../resources/values_manager.dart';
import 'dart:math';
import 'flull_screen_image.dart';

class patholeDectionForm extends StatefulWidget {

  var name, iCategoryCode;
  patholeDectionForm({super.key, required this.name, required this.iCategoryCode});

  @override
  State<patholeDectionForm> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<patholeDectionForm> with WidgetsBindingObserver {

  List stateList = [];
  List<dynamic> subCategoryList = [];
  List<dynamic> wardList = [];
  List<dynamic> bindreimouList = [];
  List blockList = [];
  List shopTypeList = [];
  List distList = [];
  var result2, msg2;

  bindSubCategory(String subCategoryCode) async {
    subCategoryList = (await BindSubCategoryRepo().bindSubCategory(context,subCategoryCode))!;
    print(" -----xxxxx-  subCategoryList--43---> $subCategoryList");
    setState(() {});
  }

  bindWard() async {
    wardList = await BindCitizenWardRepo().bindCityZenWard();
    print(" -----xxxxx-  wardList--53---> $wardList");
    setState(() {});
  }

  updatedSector() async {
    distList = await DistRepo().getDistList();
    print(" -----xxxxx-  list Data--59---> $distList");
    setState(() {});
  }

  var msg;
  var result;
  var SectorData;
  var stateblank;
  final stateDropdownFocus = GlobalKey();

  TextEditingController _addressController = TextEditingController();
  TextEditingController _landmarkController = TextEditingController();
  TextEditingController _mentionController = TextEditingController();

  String? todayDate;
  String? consumableList;
  int count = 0;
  List? data;
  List? listCon;

  //var _dropDownSector;
  var dropDownSubCategory;
  var _dropDownWardValue;
  var sectorresponse;
  String? sec;
  final distDropdownFocus = GlobalKey();
  final subCategoryFocus = GlobalKey();
  final wardFocus = GlobalKey();
  var _selectedWardId2;
  final _formKey = GlobalKey<FormState>();
  var iUserTypeCode;
  var userId;
  var slat;
  var slong;
  File? image;
  var uplodedImage;
  double? lat, long;
  bool _isLoading = false;
  var categoryType;
  var iCategoryCodeList;
  var locationAddress;
  List<Map<String, dynamic>> firstFormCombinedList = [];
  var potholeResponseBody;

  // online location
  // pick image from a Camera

  Future pickImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    image=null;
    print('---Token----107--$sToken');
    try {
      final pickFileid = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 65);
      if (pickFileid != null) {
        image = File(pickFileid.path);
        setState(() {});
        print('Image File path Id Proof-------167----->$image');
        // multipartProdecudre();
        uploadImage(sToken!, image!);
      } else {
        print('no image selected');
      }
    } catch (e) {}
  }
  // pickGallery
  Future pickGallery() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    image=null;
    print('---Token----107--$sToken');
    try {
      final pickFileid = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 65);
      if (pickFileid != null) {
        image = File(pickFileid.path);
        setState(() {});
        print('Image File path Id Proof-------167----->$image');
        // multipartProdecudre();
        uploadImage(sToken!, image!);
      } else {
        print('no image selected');
      }
    } catch (e) {}
  }
  // location
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
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        hideLoader();
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      hideLoader();
      return Future.error('Location permissions are permanently denied.');
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Convert latitude and longitude to an address
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    // List<Placemark> placemarks = await placemarkFromCoordinates(27.2034949538412,78.0057668059695);
    Placemark place = placemarks[0]; // Extract relevant details
    // String address = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    String address = "${place.street}, ${place.subLocality},${place.locality},${place.administrativeArea},${place.postalCode},${place.country}";

    // Update state with location and address
    setState(() {
      lat = position.latitude;
      long = position.longitude;
      locationAddress = address; // Store the converted address
    });
    print('-------142----Address--$locationAddress');
    print('-------143--lat----$lat');
    print('-------144--long----$long');
    print('-------street------${place.street}');
    print('-------locality------${place.locality}');
    print('-------administrationArea------${place.administrativeArea}');
    print('-------country------${place.country}');
    hideLoader();
  }

  // generateRandomNumber

  String generateRandom20DigitNumber() {
    final Random random = Random();
    String randomNumber = '';

    for (int i = 0; i < 10; i++) {
      randomNumber += random.nextInt(12).toString();
    }
    return randomNumber;
  }

  Future<void> uploadImage(String token, File imageFile) async {

    print("--------225---tolen---$token");
    print("--------226---imageFile---$imageFile");
    // http://125.21.67.106:5000/detect
    var baseURL = BaseRepo().baseurl;
    var endPoint = "PostImage/PostImage";
    var uploadImageApi = "$baseURL$endPoint";
    try {
      showLoader();
      // Create a multipart request
      var request = http.MultipartRequest(
        'POST', Uri.parse('$uploadImageApi'),
      );
      // Add headers
      //request.headers['token'] = '04605D46-74B1-4766-9976-921EE7E700A6';
      request.headers['token'] = token;
      //  request.headers['sFolder'] = 'CompImage';
      // Add the image file as a part of the request
      request.files.add(await http.MultipartFile.fromPath('sImagePath',imageFile.path,
      ));
      // Send the request
      var streamedResponse = await request.send();
      // Get the response
      var response = await http.Response.fromStream(streamedResponse);
      // Parse the response JSON
      var responseData = json.decode(response.body); // No explicit type casting
      print("---------248-----$responseData");
      if (responseData is Map<String, dynamic>) {
        // Check for specific keys in the response
        uplodedImage = responseData['Data'][0]['sImagePath'];
        print("-----240----$uplodedImage");
        //uere to uplode pothole detections api to calll a response
        if(uplodedImage!=null){
          detectFromApiUrl(uplodedImage);
        }

        print('Uploaded Image--------201---->>.--: $uplodedImage');
      } else {
        print('Unexpected response format: $responseData');
      }
      hideLoader();
    } catch (error) {
      hideLoader();
      print('Error uploading image: $error');
    }
  }
  // uplodeimagePothole
  Future<void> detectFromApiUrl(String apiUrl) async {
    try {
      print("---257---$apiUrl");

      // Step 1: Download image from apiUrl
      var imageResponse = await http.get(Uri.parse(apiUrl));

      if (imageResponse.statusCode == 200) {
        // Save to temporary file
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/temp_image.jpg');
        await file.writeAsBytes(imageResponse.bodyBytes);

        // Step 2: Create Multipart request with file
        var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://125.21.67.106:5000/detect'),
        );
        request.files.add(await http.MultipartFile.fromPath('image', file.path));

        // Step 3: Send request
        var response = await request.send();

        if (response.statusCode == 200) {

          potholeResponseBody = await response.stream.bytesToString();
          print("✅ Detection Response: $potholeResponseBody");
        } else {
          print("❌ Error: ${response.reasonPhrase}");
          print("${response.statusCode}");
        }
      } else {
        print("❌ Failed to download image from apiUrl");
      }
    } catch (e) {
      print("⚠️ Exception: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // updatedSector();
    WidgetsBinding.instance.addObserver(this);
    //getLocation();
    getLocation();
    var subCategoryCode = "${widget.iCategoryCode}";
    categoryType = "${widget.name}";
    iCategoryCodeList = "${widget.iCategoryCode}";
    print("---------240-------$subCategoryCode");
    bindSubCategory(subCategoryCode);
    bindWard();
    updatedSector();
    generateRandom20DigitNumber();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    _addressController.dispose();
    _landmarkController.dispose();
    _mentionController.dispose();
    FocusScope.of(context).unfocus();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App resumed from background, check location again
      //getLocation();
    }
  }
  // bind Ward
  Widget _bindWard() {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          height: 42,
          color: Color(0xFFf2f3f5),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton(
                isDense: true,
                // Reduces the vertical size of the button
                isExpanded: true,
                // Allows the DropdownButton to take full width
                dropdownColor: Colors.white,
                // Set dropdown list background color
                onTap: () {
                  FocusScope.of(context).unfocus(); // Dismiss keyboard
                },
                hint: RichText(
                  text: TextSpan(
                    text: "Select Ward",
                    style: AppTextStyle.font14OpenSansRegularBlack45TextStyle,
                  ),
                ),
                value: _dropDownWardValue,
                onChanged: (newValue) {
                  setState(() {
                    _dropDownWardValue = newValue;
                    distList.forEach((element) {
                      if (element["sSectorName"] == _dropDownWardValue) {
                        _selectedWardId2 = element['iSectorCode'];
                      }
                    });
                    print("----wardCode---$_selectedWardId2");
                  });
                },
                items: distList.map((dynamic item) {
                  return DropdownMenuItem(
                    value: item["sSectorName"].toString(),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item['sSectorName'].toString(),
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.font14OpenSansRegularBlack45TextStyle,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
  /// Algo.  First of all create repo, secodn get repo data in the main page after that apply list data on  dropdown.
  // function call

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color(0xFF8b2355),
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            backgroundColor: const Color(0xFFD31F76),
              leading: GestureDetector(
                onTap: () {
                   Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            title: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                'Pothole Dection',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Montserrat',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.white, // 👈 sets drawer icon color to white
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 10),
                    child: SizedBox(
                      height: 200, // Height of the container
                      width: MediaQuery.of(context).size.width-200,
                      // width: 200, // Width of the container
                      //step3.jpg
                      child: Image.asset(
                        'assets/images/step1.jpg',
                        // Replace 'image_name.png' with your asset image path
                        fit: BoxFit.fill, // Adjust the image fit to cover the container
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 30,
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
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    // 'assets/images/favicon.png',
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 0, right: 10, top: 10),
                                      child: Image.asset(
                                        'assets/images/ic_expense.png',
                                        // Replace with your image asset path
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text('Fill the below details',
                                          style: AppTextStyle
                                              .font16OpenSansRegularBlackTextStyle),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                // WARD
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    // Align items vertically
                                    children: <Widget>[
                                     // CircleWithSpacing(),
                                      // Space between the circle and text
                                      Text('Sector',
                                        style: AppTextStyle
                                            .font14OpenSansRegularBlack45TextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                _bindWard(),
                                SizedBox(height: 10),
                                // uplode Photo
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    // Align items vertically
                                    children: <Widget>[
                                     // CircleWithSpacing(),
                                      // Space between the circle and text
                                      Text('Uplode Photo',
                                        style: AppTextStyle
                                            .font14OpenSansRegularBlack45TextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5),
                                //----Card
                                Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    height: 85,
                                    color: Colors.white,
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Column Section
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Click Photo",
                                                style: AppTextStyle.font14OpenSansRegularBlack45TextStyle),
                                            SizedBox(height: 5),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            // First Container: Camera
                                            GestureDetector(
                                              onTap:(){
                                               print('-----camra-----');
                                               pickImage();
                                               },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.camera_alt, color: Colors.blue),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      "Photo",
                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5),

                                            // Second Container: Gallery
                                            GestureDetector(
                                              onTap: (){
                                                print("----Gallery----");
                                                pickGallery();
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.photo, color: Colors.green),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      "Gallery",
                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      image != null
                                          ? Stack(
                                        children: [
                                          GestureDetector(
                                            behavior:
                                            HitTestBehavior.translucent,
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
                                                color:
                                                Colors.lightGreenAccent,
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
                                      )
                                          : Text(
                                        "",
                                        style: TextStyle(
                                            color: Colors.red[700]),
                                      )
                                    ]),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () async {

                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    // Contact No
                                    String? sContactNo = prefs.getString('sContactNo');
                                    // random number
                                    String random12DigitNumber = generateRandom20DigitNumber();
                                    var location = _addressController.text.trim();
                                    var complaintDescription = _landmarkController.text.trim();
                                    // Check Form Validation
                                    final isFormValid = _formKey.currentState!.validate();
                                    print("Form Validation: $isFormValid");
                                    _isLoading ? CircularProgressIndicator() : "";

                                    if(_formKey.currentState!.validate() && _selectedWardId2 != null)
                                    {

                                      print("----call Api-----");
                                      print("--Sector : $_selectedWardId2");
                                      print("----UserId : $sContactNo");
                                      print("-----TranNo----$random12DigitNumber");
                                      print("-----PotholeImage----: ");
                                      print("-----Latitude----: $lat");
                                      print("-----Longitude----: $long");
                                      print("-----PotholLocation ---$locationAddress");
                                      print("-----Json --- : ");


                                      var  potholeResponse = await PothoLedetailsRepo().photoledetail(
                                          context,
                                          _selectedWardId2,
                                          sContactNo,
                                          random12DigitNumber,
                                          uplodedImage,
                                          lat,
                                          long,
                                          locationAddress,
                                          potholeResponseBody

                                      );

                                      print('----761---$potholeResponse');
                                      result = potholeResponse['Result'];
                                      msg = potholeResponse['Msg'];
                                      print("----737---$msg");

                                      if(result=="1"){
                                        displayToast(msg);
                                        Navigator.pop(context);
                                      }else{
                                        displayToast(msg);
                                      }

                                    }else{
                                      // displayToast(msg);
                                      // Navigator.pop(context);
                                      // if(result=="1"){
                                      //   displayToast(msg);
                                      //    Navigator.pop(context);
                                      // }else{
                                      //   displayToast(msg);
                                      // }


                                      print("----Not call Api----");
                                      // to apply condtion and check if any value is not selected then give a toast
                                      if(_selectedWardId2==null) {
                                        displayToast("Please Select Sector");
                                        return;
                                      }else if(location.isEmpty){
                                        displayToast("Please Enter Location");
                                        return;
                                      }else if(complaintDescription.isEmpty){
                                        displayToast("Please Enter Description");
                                        return;
                                      }else if(uplodedImage.isEmpty()){
                                        displayToast("Please Pic image");
                                        return;
                                      }
                                    }
                                    if(result=="1"){
                                     // displayToast(msg);
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => OnlineComplaint()),
                                      // );
                                    }else{
                                     // displayToast(msg);
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    // Make container fill the width of its parent
                                    height: AppSize.s45,
                                    padding: EdgeInsets.all(AppPadding.p5),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF255898),
                                      // Background color using HEX value
                                      borderRadius: BorderRadius.circular(
                                          AppMargin.m10), // Rounded corners
                                    ),
                                    //  #00b3c7
                                    child: Center(
                                      child: Text(
                                        "Submit",
                                        style: AppTextStyle
                                            .font16OpenSansRegularWhiteTextStyle,
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
          ),
        ),
      ),
    );
  }
  void displayToast(String msg){
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

// location

}
// location
