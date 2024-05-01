import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/changepasswordrepo.dart';
import 'homeScreen.dart';
import 'loginScreen_2.dart';
import 'logout.dart';
import 'mypoint.dart';
import 'notification.dart';

class ChangePassWord extends StatelessWidget {
  const ChangePassWord({super.key});

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
  // Controller
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  // Focus
  FocusNode oldPasswordfocus = FocusNode();
  FocusNode newPasswordfocus = FocusNode();
  FocusNode confirmPasswordfocus = FocusNode();
  // formkey
  final _formKey = GlobalKey<FormState>();

  // bool _isObscured = true;
  bool _isObscuredoldPassword = true;
  bool _isObscuredNewPassword = true;
  bool _isObscuredConfirmPassword = true;
  var msg;
  var result;
  var loginMap;
  var  changePasswordRepo;
  String? sName, sContactNo;

  @override
  void initState() {
    // TODO: implement initState
    getlocalvalue();
    super.initState();
    oldPasswordfocus = FocusNode();
    newPasswordfocus = FocusNode();
    confirmPasswordfocus = FocusNode();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    oldPasswordfocus.dispose();
    newPasswordfocus.dispose();
    confirmPasswordfocus.dispose();
    super.dispose();

  }
  getlocalvalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sName = prefs.getString('sName') ?? "";
      sContactNo = prefs.getString('sContactNo') ?? "";
      print("------148---$sName");
      print("------1149---$sContactNo");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Color(0xFF255899),
        title: const Text(
          'Change PassWord',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      // drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/citysimpe.png'), // Replace with your asset image path
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person,
                      size: 50,
                      color: Color(0xff3f617d),
                    ),
                    Text(
                      '${sName}',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xff3f617d),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.call,
                          size: 18,
                          color: Color(0xff3f617d),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${sContactNo}',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: SingleChildScrollView(
                // Wrap with SingleChildScrollView to make it scrollable
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                        // Add your navigation or action logic here
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/home_nw.png', // Replace with your asset image path
                            width: 25, // Adjust image width as needed
                            height: 25, // Adjust image height as needed
                          ),
                          SizedBox(width: 10),
                          const Text(
                            'Home',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Mypoint()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/my_wallet.png', // Replace with your asset image path
                            width: 25, // Adjust image width as needed
                            height: 25, // Adjust image height as needed
                          ),
                          SizedBox(width: 10),
                          const Text(
                            'My Points',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChangePassWord()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/change_password_nw.png', // Replace with your asset image path
                            width: 25, // Adjust image width as needed
                            height: 25, // Adjust image height as needed
                          ),
                          SizedBox(width: 10),
                          const Text(
                            'Change Password',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/notification.png', // Replace with your asset image path
                            width: 25, // Adjust image width as needed
                            height: 25, // Adjust image height as needed
                          ),
                          SizedBox(width: 10),
                          const Text(
                            'Notification',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogoutScreen()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/logout_new.png', // Replace with your asset image path
                            width: 25, // Adjust image width as needed
                            height: 25, // Adjust image height as needed
                          ),
                          SizedBox(width: 10),
                          const Text(
                            'Logout',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 280),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 100,
                        child: Text(
                          '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
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
                  height: 400,
                  decoration: BoxDecoration(
                    // Set container color
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20), // Set border radius
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          Center(
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: 80,
                                width: 80,
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
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/change_password_nw.png'), // Set AssetImage
                                        fit: BoxFit
                                            .cover, // Adjust the image fit as needed
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // form
                          GestureDetector(
                            onTap: (){
                              FocusScope.of(context).unfocus();
                            },
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          autofocus: true,
                                          obscureText: _isObscuredoldPassword,
                                          controller: _oldPasswordController,
                                          focusNode: oldPasswordfocus,
                                          textInputAction: TextInputAction.next,
                                          onEditingComplete: () =>
                                              FocusScope.of(context).nextFocus(),
                                          decoration: InputDecoration(
                                            labelText: 'Old Password',
                                            labelStyle: TextStyle(color: Color(0xFFd97c51)),
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide(color:Color(0xFF255899))
                                            ),
                                            contentPadding:
                                            EdgeInsets.symmetric(vertical: 10.0),
                                            prefixIcon:
                                            Icon(Icons.lock,size: 20, color: Color(0xFF255899)),
                                            suffixIcon: IconButton(
                                              icon: Icon(_isObscuredoldPassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                              onPressed: () {
                                                setState(() {
                                                  _isObscuredoldPassword = !_isObscuredoldPassword;
                                                });
                                              },
                                            ),
                                          ),
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter Old Password';
                                            }
                                            if (value.length < 1 ) {
                                              return 'Enter Old Password';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          obscureText: _isObscuredNewPassword,
                                          controller: _newPasswordController,
                                          focusNode: newPasswordfocus,
                                          textInputAction: TextInputAction.next,
                                          onEditingComplete: () =>
                                              FocusScope.of(context).nextFocus(),
                                          decoration: InputDecoration(
                                            labelText: 'New Password',
                                            labelStyle: const TextStyle(color: Color(0xFFd97c51)),
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide(color:Color(0xFF255899))
                                            ),
                                            contentPadding:
                                            EdgeInsets.symmetric(vertical: 10.0),
                                            prefixIcon:
                                            Icon(Icons.lock,size: 20, color: Color(0xFF255899)),
                                            suffixIcon: IconButton(
                                              icon: Icon(_isObscuredNewPassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                              onPressed: () {
                                                setState(() {
                                                  _isObscuredNewPassword = !_isObscuredNewPassword;
                                                });
                                              },
                                            ),
                                          ),
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter new Password';
                                            }
                                            if (value.length < 1) {
                                              return 'Enter new Password';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 10),
                                        TextFormField(
                                          obscureText: _isObscuredConfirmPassword,
                                          controller: _confirmPasswordController,
                                          focusNode: confirmPasswordfocus,
                                          textInputAction: TextInputAction.next,
                                          onEditingComplete: () =>
                                              FocusScope.of(context).nextFocus(),
                                          decoration: InputDecoration(
                                            labelText: 'Confirm Password',
                                            labelStyle: const TextStyle(color: Color(0xFFd97c51)),
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide(color:Color(0xFF255899))
                                            ),
                                            contentPadding:
                                            EdgeInsets.symmetric(vertical: 10.0),
                                            prefixIcon:
                                            Icon(Icons.lock,size: 20, color: Color(0xFF255899)),
                                            suffixIcon: IconButton(
                                              icon: Icon(_isObscuredConfirmPassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                              onPressed: () {
                                                setState(() {
                                                  _isObscuredConfirmPassword = !_isObscuredConfirmPassword;
                                                });
                                              },
                                            ),
                                          ),
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Confirm Password';
                                            }
                                            if (value.length < 1 ) {
                                              return 'Confirm Password';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: 10),
                                        // login
                                        InkWell(
                                          onTap: ()async {
                                            print('--------------');
                                            var oldpassword = _oldPasswordController.text;
                                            var newpassword = _newPasswordController.text;
                                            var confirmpassword = _confirmPasswordController.text;
                                            print('----495--$oldpassword');
                                            print('----496--$newpassword');
                                            print('----497--$confirmpassword');
                                    
                                            if(_formKey.currentState!.validate() && oldpassword != null && newpassword != null && confirmpassword!=null){
                                              print('-----497--Call Api-');
                                              changePasswordRepo = await ChangePasswordRepo().changePassword(context, oldpassword!, newpassword!);

                                              //print('-----546---$changePasswordRepo');

                                              result = "${changePasswordRepo['Result']}";
                                              msg = "${changePasswordRepo['Msg']}";

                                            }else {
                                              if(_oldPasswordController.text.isEmpty){
                                                oldPasswordfocus.requestFocus();
                                              }else if(_newPasswordController.text.isEmpty){
                                                newPasswordfocus.requestFocus();
                                              }else if(_confirmPasswordController.text.isEmpty){
                                                confirmPasswordfocus.requestFocus();
                                              }
                                            }
                                           // print('-----499---Not-Call Api-');
                                            if(result=="1"){
                                              var sToken = "${changePasswordRepo['Data'][0]['sToken']}";
                                              print('---565--token---$sToken');
                                              // store token
                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                              prefs.setString('sToken',sToken);

                                              displayToast(msg);
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => LoginScreen_2()));

                                            }else{
                                              print('----573---To display error msg---');
                                              displayToast(msg);
                                            }
                                            },
                                          child: Container(
                                            width: double.infinity, // Make container fill the width of its parent
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
                                    ),
                                  ),
                            ),
                              ),
                        ],
                      ),
                    ),
                  ),

              ],
            ),
          )
        ],
      ),
    );
  }
  // dialog
  void displayToast(String msg){
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
}
