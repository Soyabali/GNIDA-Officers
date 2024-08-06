import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controllers/login_repo.dart';
import '../resources/app_strings.dart';
import '../resources/app_text_style.dart';
import '../resources/assets_manager.dart';
import '../resources/values_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'forgotpassword.dart';
import 'generalFunction.dart';
import 'homeScreen.dart';
import 'homepagesecod.dart';

class LoginScreen_2 extends StatelessWidget {
  const LoginScreen_2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isObscured = true;
  var loginProvider;

  // focus
  FocusNode phoneNumberfocus = FocusNode();
  FocusNode passWordfocus = FocusNode();

  bool passwordVisible = false;
  // Visible and Unvisble value
  int selectedId = 0;
  var msg;
  var result;
  var loginMap;
  double? lat, long;
  GeneralFunction generalFunction = GeneralFunction();

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
  void initState() {
    // TODO: implement initState
    super.initState();
   // getLocation();
   Future.delayed(const Duration(milliseconds: 100), () {
     requestLocationPermission();
     setState(() {
       // Here you can write your code for open new view
     });
   });
  }
  // request location permission
  // location Permission
  Future<void> requestLocationPermission() async {

    final status = await Permission.locationWhenInUse.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  void clearText() {
    _phoneNumberController.clear();
    passwordController.clear();
  }
  // bottomSheet
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: 200,
            color: Colors.white,

          child: GestureDetector(
            onTap: (){
              print('---------');
            },
            child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Center(child: Padding(
                            padding: EdgeInsets.all(0.0),
                            child: Icon(Icons.close,size: 25,color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Can't Login?",style:AppTextStyle.font18OpenSansboldAppBasicTextStyle),
                    SizedBox(height: 10),
                    Center(
                  child: ElevatedButton(
                    onPressed: () {
                      /// After implement attion this comment is remove and OtpVerfication is hide
                      // Add your button onPressed logic here
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) =>
                      const ForgotPassword()));

                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Adjust as needed
                      ), // Text color
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'Forgot Password',style:TextStyle(
                        fontSize: 16,
                        color: Colors.white
                      )),
                      ),
                    ),
                  ),
                  ],
                ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    // mention all widget here
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(AppMargin.m10),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(ImageAssets.roundcircle), // Replace with your image asset path
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: AppSize.s50,
                          height: AppSize.s50,
                          child: Image.asset(
                            ImageAssets.noidaauthoritylogo, // Replace with your image asset path
                            width: AppSize.s50,
                            height: AppSize.s50,
                          ),
                        ),
                        Expanded(child: Container()),
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Image.asset(
                            ImageAssets.favicon, // Replace with your image asset path
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: AppSize.s145,
                      width: AppSize.s145,
                      margin: const EdgeInsets.all(AppMargin.m20),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            ImageAssets.roundcircle,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppMargin.m16),
                        child: Center(
                          child: Image.asset(
                            ImageAssets.loginIcon, // Replace with your image asset path
                            width: AppSize.s145,
                            height: AppSize.s145,
                            fit: BoxFit.contain, // Adjust as needed
                          ),
                        ),
                      ),
                    ),
                    Center(
                        child: Text(AppStrings.txtLogin,
                            style:
                                AppTextStyle.font18OpenSansboldAppBasicTextStyle),
                      ),

                    /// Todo here we mention main code for a login ui.
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: AppPadding.p15, right: AppPadding.p15),
                              // PHONE NUMBER TextField
                              child: TextFormField(
                                focusNode: phoneNumberfocus,
                                controller: _phoneNumberController,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10), // Limit to 10 digits
                                  //FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Only allow digits
                                ],
                                decoration: const InputDecoration(
                                  labelText: AppStrings.txtMobile,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: AppPadding.p10,
                                    horizontal: AppPadding.p10, // Add horizontal padding
                                  ),

                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Color(0xFF255899),
                                  ),
                                  // errorBorder
                                  // errorBorder: OutlineInputBorder(
                                  //     borderSide: BorderSide(color: Colors.green, width: 0.5))
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter mobile number';
                                  }
                                  if (value.length > 1 && value.length < 10) {
                                    return 'Enter 10 digit mobile number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: AppPadding.p15, right: AppPadding.p15),
                              // passWord TextFormField
                              child: TextFormField(
                                obscureText: _isObscured,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: AppStrings.txtpassword,
                                  border: const OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: AppPadding.p10,
                                    horizontal: AppPadding.p10, // Add horizontal padding
                                  ),
                                  prefixIcon: const Icon(Icons.lock,
                                      color: Color(0xFF255899)),
                                  suffixIcon: IconButton(
                                    icon: Icon(_isObscured
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isObscured = !_isObscured;
                                      });
                                    },
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter password';
                                  }
                                  if (value.length < 1) {
                                    return 'Please enter Valid Name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            /// LoginButton code and onclik Operation
                            InkWell(
                              onTap: () async {
                                getLocation();
                                 var phone = _phoneNumberController.text;
                                 var password = passwordController.text;

                                 if(_formKey.currentState!.validate() && phone != null && password != null){
                                   // Call Api
                                           loginMap = await LoginRepo1()
                                          .authenticate(context, phone!, password!);


                                           print('---358----$loginMap');
                                           result = "${loginMap['Result']}";
                                           msg = "${loginMap['Msg']}";
                                           print('---361----$result');
                                           print('---362----$msg');
                                 }else{
                                   if(_phoneNumberController.text.isEmpty){
                                     phoneNumberfocus.requestFocus();
                                   }else if(passwordController.text.isEmpty){
                                     passWordfocus.requestFocus();
                                   }
                                 } // condition to fetch a response form a api
                                if(result=="1"){
                                    var iUserId = "${loginMap['Data'][0]['iUserId']}";
                                    var sName =
                                        "${loginMap['Data'][0]['sName']}";
                                    var sContactNo =
                                        "${loginMap['Data'][0]['sContactNo']}";
                                    var sDesgName =
                                        "${loginMap['Data'][0]['sDesgName']}";
                                    var iDesgCode =
                                        "${loginMap['Data'][0]['iDesgCode']}";
                                    var iDeptCode =
                                        "${loginMap['Data'][0]['iDeptCode']}";
                                    var iUserTypeCode =
                                        "${loginMap['Data'][0]['iUserTypeCode']}";
                                    var sToken =
                                        "${loginMap['Data'][0]['sToken']}";
                                    var dLastLoginAt =
                                        "${loginMap['Data'][0]['dLastLoginAt']}";
                                    var iAgencyCode =
                                        "${loginMap['Data'][0]['iAgencyCode']}";

                                    // To store value in  a SharedPreference

                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString('iUserId',iUserId);
                                    prefs.setString('sName',sName);
                                    prefs.setString('sContactNo',sContactNo);
                                    prefs.setString('sDesgName',sDesgName);
                                    prefs.setString('iDesgCode',iDesgCode);
                                    prefs.setString('iDeptCode',iDeptCode);
                                    prefs.setString('iUserTypeCode',iUserTypeCode);
                                    prefs.setString('sToken',sToken);
                                    prefs.setString('dLastLoginAt',dLastLoginAt);
                                    prefs.setString('iAgencyCode',iAgencyCode);
                                   // prefs.setDouble('lat',lat!);
                                    //prefs.setDouble('long',long!);
                                    String? stringName = prefs.getString('sName');
                                    String? stringContact = prefs.getString('sContactNo');
                                     iAgencyCode = prefs.getString('iAgencyCode').toString();
                                    print('---464-----stringContact--$stringName');
                                    print('---465----stringContact----$stringContact');
                                    print('---473----iAgencyCode----$iAgencyCode');
                                    if(iAgencyCode =="1"){
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => HomePage()),
                                      );
                                     // print('----570---To go with $iAgencyCode---');
                                    }else{
                                      // HomeScreen_2
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => HomeScreen_2()),
                                      );
                                    //  print('----572---To go with $iAgencyCode---');

                                    }
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => HomePage()),
                                    // );

                                }else{
                                  print('----373---To display error msg---');
                                  displayToast(msg);

                                }
                                },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 10),
                                child: Container(
                                  width: double
                                      .infinity, // Make container fill the width of its parent
                                  height: AppSize.s45,
                                  padding: EdgeInsets.all(AppPadding.p5),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF255899), // Background color using HEX value
                                    borderRadius: BorderRadius.circular(
                                        AppMargin.m10), // Rounded corners
                                  ),
                                  child: const Center(
                                    child: Text(
                                      AppStrings.txtLogin,
                                      style: TextStyle(
                                          fontSize: AppSize.s16,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(context);
                              },
                              child: const ListTile(
                                title: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    AppStrings.txtForgetPassword,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF255899),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            Opacity(
                              opacity: AppSize.s0_5,
                              child: Container(
                                width: double.infinity, // Set width as needed
                                height: 168, // Set height as needed
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage(ImageAssets.loginBottomnw), // Replace with your asset image path
                                    fit: BoxFit.cover, // You can adjust the fit as needed
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      AppPadding.p10), // Optional: border radius
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(
                                          AppSize.s0_5), // Shadow color
                                      spreadRadius: AppSize.s5, // Spread radius
                                      blurRadius: AppSize.s7, // Blur radius
                                      offset: Offset(0, 3), // Offset
                                    ),
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
              ))),
    );
  }
  // toast code
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
