import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:noidaone/screens/loginScreen_2.dart';
import 'package:oktoast/oktoast.dart';
import '../Controllers/otpverificationrepo.dart';
import '../resources/values_manager.dart';


class OtpPage extends StatefulWidget {
  final phone;
  const OtpPage({super.key,required this.phone});

  @override
  State<OtpPage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<OtpPage> {

  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<TextEditingController>? controllers;
  List<FocusNode>? focusNodes;
  bool _isObscured = true;
  bool _isObscurednewpassword = true;
  FocusNode _newPasswordfocus = FocusNode();
  FocusNode _confirmpasswordfoucs = FocusNode();
  var otpverificationResponse;
  var result ;
  var msg ;

  void clearText() {
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('------71----${widget.phone}');
    _newPasswordfocus = FocusNode();
    _confirmpasswordfoucs = FocusNode();
    controllers = List.generate(4, (_) => TextEditingController());
    focusNodes = List.generate(4, (_) => FocusNode());
    focusNodes?[0].requestFocus();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _newPasswordfocus.dispose();
    _confirmpasswordfoucs.dispose();
    for (var controller in controllers!) {
      controller.dispose();
    }
    for (var node in focusNodes!) {
      node.dispose();
    }
    super.dispose();
  }
  // Toast msg
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
      backgroundColor: Colors.grey[200],
      // Forgot Password
      appBar: AppBar(
        backgroundColor: Color(0xFF255899),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () {
                // Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen_2()));
                print('----81----');
              },
              child: Icon(Icons.arrow_back_ios)),
        ),
        // OTP Verification
        title: const Text(
          'OTP Verification',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      // drawer
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Security Check',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xff3f617d),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Your password is safe with us.',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xff3f617d),
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 120.0),
                        Container(
                          //color: Colors.white,
                          height: 300,
                          decoration: BoxDecoration(
                            // Set container color
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(20), // Set border radius
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 10.0),
                                  Center(
                                    child: Card(
                                      elevation: 5,
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40),
                                          // border: Border.all(color: Colors.black),
                                          // Just for visualization
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white.withOpacity(0.5), // Set shadow color
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.phone,
                                          size: 35,
                                          color: Color(0xFF255899),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: List.generate(4, (index) {
                                        return SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5, top: 0),
                                            child: Center(
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                child: TextField(
                                                  controller: controllers?[index],
                                                  focusNode: focusNodes?[index],
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(1),
                                                  ],
                                                  onChanged: (value) {
                                                    if (value.isNotEmpty &&
                                                        index < 3) {
                                                      FocusScope.of(context)
                                                          .requestFocus(focusNodes?[
                                                              index + 1]);
                                                    } else if (value.isEmpty &&
                                                        index > 0) {
                                                      FocusScope.of(context)
                                                          .requestFocus(focusNodes?[
                                                              index - 1]);
                                                    }
                                                  },
                                                 // maxLength: 1,
                                                  textAlign: TextAlign.center,
                                                  keyboardType: TextInputType.number,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Form(
                                      key: _formKey,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: AppPadding.p15,
                                                  right: AppPadding.p15),
                                              // passWord TextFormField
                                              child: TextFormField(
                                                focusNode: _newPasswordfocus,
                                                obscureText: _isObscurednewpassword,
                                                controller: _newPasswordController,
                                                textInputAction:
                                                    TextInputAction.next,
                                                onEditingComplete: () =>
                                                    FocusScope.of(context)
                                                        .nextFocus(),
                                                decoration: InputDecoration(
                                                  labelText: "New Password",
                                                  labelStyle: const TextStyle(
                                                      color: Color(0xFFd97c51)),
                                                  border:
                                                      const OutlineInputBorder(),
                                                  contentPadding:
                                                      const EdgeInsets.symmetric(
                                                          vertical:
                                                          AppPadding.p10),
                                                  prefixIcon: const Icon(
                                                      Icons.lock,
                                                      color: Color(0xFF255899)),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(_isObscurednewpassword
                                                        ? Icons.visibility
                                                        : Icons.visibility_off),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isObscurednewpassword =
                                                            !_isObscurednewpassword;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                autovalidateMode: AutovalidateMode
                                                    .onUserInteraction,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'New password';
                                                  }
                                                  if (value.length < 1) {
                                                    return 'Please enter New password';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: AppPadding.p15,
                                                  right: AppPadding.p15),
                                              // passWord TextFormField
                                              child: TextFormField(
                                                focusNode: _confirmpasswordfoucs,
                                                obscureText: _isObscured,
                                                controller:
                                                    _confirmPasswordController,
                                                decoration: InputDecoration(
                                                  labelText: "Confirm Password",
                                                  labelStyle: const TextStyle(
                                                      color: Color(0xFFd97c51)),
                                                  border:
                                                      const OutlineInputBorder(),
                                                  contentPadding:
                                                      const EdgeInsets.symmetric(
                                                          vertical:
                                                              AppPadding.p10),
                                                  prefixIcon: const Icon(
                                                      Icons.lock,
                                                      color: Color(0xFF255899)),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(_isObscured
                                                        ? Icons.visibility
                                                        : Icons.visibility_off),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isObscured =
                                                            !_isObscured;
                                                      });
                                                    },
                                                  ),
                                                ),
                                                autovalidateMode: AutovalidateMode
                                                    .onUserInteraction,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Enter Confirm Password';
                                                  }
                                                  if (value.length < 1) {
                                                    return 'Please enter Confirm Password';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            InkWell(
                                              onTap: () async {

                                                String otp = '';
                                                for (var controller in controllers!)
                                                {
                                                  otp += controller.text;
                                                }
                                                // Now you have the OTP value in the 'otp' variable
                                                print('OTP---319: $otp');

                                                var newpassword = _newPasswordController.text;
                                                var confirmpassword = _confirmPasswordController.text;

                                                if (_formKey.currentState!
                                                        .validate() &&
                                                    otp != null &&
                                                    newpassword != null &&
                                                    confirmpassword != null)
                                                {
                                                  if(newpassword!=confirmpassword){
                                                    displayToast("Password does not match");
                                                  }else{
                                                    otpverificationResponse = await OtpVerificationRepo().otpverification(
                                                        context,
                                                        '${widget.phone}',
                                                        otp!,
                                                        confirmpassword);
                                                    print('---428----$otpverificationResponse');
                                                    result = "${otpverificationResponse['Result']}";
                                                    msg = "${otpverificationResponse['Msg']}";
                                                    print('---431----$result');
                                                    print('---432----$msg');
                                                  }
                                                 }else{
                                                  if(_newPasswordController.text.isEmpty){
                                                    _newPasswordfocus.requestFocus();
                                                  }else if(_confirmPasswordController.text.isEmpty){
                                                    _confirmpasswordfoucs.requestFocus();
                                                  }
                                                }// condition to fetch response and take a action behafe of action
                                                if(result=="1"){
                                                  Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const LoginScreen_2()),
                                                      );
                                                }else{
                                                  displayToast(msg);
                                                }
                                                },

                                              child: Container(
                                                width: double
                                                    .infinity, // Make container fill the width of its parent
                                                height: 45,
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                      0xFF255899), // Background color using HEX value
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0), // Rounded corners
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'Submit',
                                                    style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
