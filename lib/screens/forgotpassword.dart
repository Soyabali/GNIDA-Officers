import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:noidaone/screens/otpverification.dart';
import 'package:oktoast/oktoast.dart';
import '../Controllers/forgotpasswordrepo.dart';
import '../resources/app_strings.dart';
import '../resources/values_manager.dart';
import 'changePassword.dart';
import 'homeScreen.dart';
import 'loginScreen_2.dart';
import 'mypoint.dart';
import 'notification.dart';

class ForgotPassword extends StatelessWidget {

  const ForgotPassword({super.key});

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

  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // Forgot Password
      appBar: AppBar(
        backgroundColor: Color(0xFF255899),
        leading: GestureDetector(
            onTap: () {
              //Navigator.of(context).pop();

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen_2()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back_ios),
            )),
        title: const Text(
          'Forgot Password',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      // drawer

      body: ListView(
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
                        'Initializing Recovery !',
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
                        height: 250,
                        decoration: BoxDecoration(
                          // Set container color
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20), // Set border radius
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 10.0),
                              Center(
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      // border: Border.all(color: Colors.black),
                                      // Just for visualization
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white
                                              .withOpacity(0.5), // Set shadow color
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Icon(Icons.phone,size: 35,color: Color(0xFF255899),),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: AppPadding.p15, right: AppPadding.p15),
                                        // PHONE NUMBER TextField
                                        child: TextFormField(
                                          autofocus: true,
                                          controller: _phoneNumberController,
                                          keyboardType: TextInputType.phone,
                                          decoration: const InputDecoration(
                                            labelText: AppStrings.txtMobile,
                                            labelStyle: TextStyle(
                                                color: Color(0xFFd97c51)
                                            ),
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(
                                              vertical: AppPadding.p10,
                                              horizontal: AppPadding.p10, // Add horizontal padding
                                            ),
                                            prefixIcon: Icon(
                                              Icons.mobile_friendly_sharp,
                                              color: Color(0xFF255899),
                                            ),
                                          ),
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10), // Limit to 10 digits
                                            //FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Only allow digits
                                          ],
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
                                      InkWell(
                                        onTap: () async {
                                          var phone = _phoneNumberController.text;
                                          if(_formKey.currentState!.validate() && phone!=null){
                                            /// Call Api

                                            var loginMap = await ForgotPassWordRepo().
                                            forgotpassword(context, phone!);

                                            var result =  "${loginMap['Result']}";
                                            var msg =  "${loginMap['Msg']}";
                                            print('----$result');
                                            // nested condition
                                            if(result=="1"){
                                              print('----209------$phone');
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => OtpPage(phone:phone)),
                                              );
                                              displayToast(msg);
                                            }else{
                                              print('----216------$phone');
                                              displayToast(msg);
                                            }

                                          }else{
                                            displayToast("Please enter mobile Number");
                                          }
                                          },
                                        child: Container(
                                          width: double
                                              .infinity, // Make container fill the width of its parent
                                          height: 45,
                                          padding: EdgeInsets.all(5.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF255899), // Background color using HEX value
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Rounded corners
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'Submit',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  )),

                            ],
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
    );
  }
  //TOAST
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
    //     fontSize: 16.0
    // );

  }
}
