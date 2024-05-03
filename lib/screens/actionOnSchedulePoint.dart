import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:noidaone/screens/scheduledpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/DrywetSegregationSubmitRepo.dart';
import '../Controllers/actionOnSchedulePointRepo.dart';
import '../Controllers/district_repo.dart';
import '../resources/values_manager.dart';
import 'flull_screen_image.dart';
import 'homeScreen.dart';

class ActionOnSchedultPointScreen extends StatefulWidget {
  final sBeforePhoto;
  final iTaskCode;
  double? lat;
  double? long;
  ActionOnSchedultPointScreen({super.key,this.sBeforePhoto, this.iTaskCode, this.lat, this.long});

  @override
  State<ActionOnSchedultPointScreen> createState() => _ActionOnSchedultPointScreenState();
}

class _ActionOnSchedultPointScreenState extends State<ActionOnSchedultPointScreen> {

  String? _chosenValue;
  final _formKey = GlobalKey<FormState>();
  var sectorresponse;
  String? sec;
  List distList = [];
  double? lat, long;
  var _dropDownValueDistric;
  final distDropdownFocus = GlobalKey();
  //--
  TextEditingController _locationController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();
  // focus
  FocusNode locationfocus = FocusNode();
  FocusNode remarkfocus = FocusNode();
  File? _imageFile;

  // Sector Api get response
  updatedSector() async {
    distList = await DistRepo().getDistList();
    print(" -----xxxxx-  list Data--53---> $distList");
    setState(() {});
  }


  // //location
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
    print('-----------79----$lat');
    print('-----------80----$long');
    // setState(() {
    // });
    debugPrint("Latitude: ----1056--- $lat and Longitude: $long");
    debugPrint(position.toString());
  }

  // pick images
  Future<void> _getImageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);

      });
      print('----129---$_imageFile');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // updatedSector();
    getLocation();
    print('------106----${widget.sBeforePhoto}');
    print('------107----${widget.iTaskCode}');
    print('------111----${widget.lat}');
    print('------112----${widget.long}');


  }
  // toast
  void displayToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
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
              Navigator.pop(context);
              //Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //         const HomePage()));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back_ios,color: Colors.white),
            )),
        title: const Text(
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
                'assets/images/step3.jpg', // Replace 'image_name.png' with your asset image path
                fit:
                BoxFit.cover, // Adjust the image fit to cover the container
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
                            margin: EdgeInsets.only(left: 0,right: 10,top: 10),
                            child: Image.asset(
                              'assets/images/ic_expense.png', // Replace with your image asset path
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
                                margin: EdgeInsets.only(left: 0,right: 2),
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
                      padding: const EdgeInsets.only(left: 0,right: 0),
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        child: Image.network(
                          '${widget.sBeforePhoto}', // Replace this URL with your image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5,top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(left: 0,right: 2),
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
                        padding: const EdgeInsets.only(bottom: 5,top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(left: 0,right: 2),
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
                                  _getImageFromCamera();
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
                            ) :
                            Text(
                              "Photo is required.",
                              style:
                              TextStyle(color: Colors.red[700]),
                            )
                          ]),

                      ElevatedButton(
                          onPressed: () async {
                              // get a location
                           getLocation();
                            // current date
                            DateTime currentDate = DateTime.now();
                         var  todayDate = DateFormat('dd/MMM/yyyy HH:mm')
                                .format(currentDate);
                            print('Formatted Date--672--: $todayDate');


                            var remarks = _remarkController.text;
                            //print('-505---$location');
                            print('--506--$remarks');
                            print('--508---Image-$_imageFile');

                            if(_formKey.currentState!.validate()
                                && remarks!=null && _imageFile!=null && lat!=null && long!=null){

                                var iTaskCode = '${widget.iTaskCode}';

                              print('---ita---$iTaskCode');
                               print('---_imageFile--$_imageFile');
                               print('---lat--$lat');
                               print('---long--$long');
                               print('---iTaskCode--${widget.iTaskCode}');
                               print('---todayDate--${todayDate}');
                              //  Todo call Api
                              // print('----Call Api----');
                              /// TODO REMOVE COMMENT AND APPLY right api
                              var  actiononSchedulepointresponse = await ActionOnScheduleRepo()
                                    .actionOnSchedulePoint(context, remarks!,
                                _imageFile,lat,long,todayDate,iTaskCode);
                              /// TODO REMOVE THIS API

                              print('---475--------$actiononSchedulepointresponse');
                            var  result = "${actiononSchedulepointresponse['Result']}";
                            var  mag = "${actiononSchedulepointresponse['Msg']}";
                            if(result=="1"){
                              displayToast(mag);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HomePage()));
                            }else{
                              displayToast(mag);
                            }
                            print('---484----$result');
                              print('---485-----$mag');
                            }else{
                              displayToast("Please pick image");
                              print('----Not Call Api----');
                            }
                            /// TODO Apply logic behage of api response
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF255899), // Hex color code (FF for alpha, followed by RGB)
                          ),
                          child: const Text("Submit",style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

