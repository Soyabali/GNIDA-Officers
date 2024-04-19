import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noidaone/screens/homeScreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 25),
          Container(
            height: 75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/round_circle.png'), // Replace with your image asset path
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    'assets/images/noidaauthoritylogo.png', // Replace with your image asset path
                    width: 50,
                    height: 50,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Image.asset(
                      'assets/images/favicon.png', // Replace with your image asset path
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 0),
          Expanded(
            child: Center(
              child: Container(
                height: 145,
                width: 145,
                margin: EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/round_circle.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    'assets/images/login_icon.png', // Replace with your image asset path
                    width: 145,
                    height: 145,
                    fit: BoxFit.contain, // Adjust as needed
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 0),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Login',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Color(0xFF255899),
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                 border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                prefixIcon: Icon(Icons.phone,color:Color(0xFF255899),),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: TextFormField(
              obscureText: _isObscured,
              controller: _passWordController,
              decoration: InputDecoration(
                labelText: 'Password',
                 border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                prefixIcon: Icon(Icons.lock,color:Color(0xFF255899)),
                suffixIcon: IconButton(
                  icon:
                      Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: InkWell(
              onTap: (){
                print('--------------');
                Navigator.pushReplacement(context,
                                 MaterialPageRoute(builder:
                                     (context) => HomePage()
                                 )   // VisitListHome
                             );
              },
              child: Container(
                width: double.infinity, // Make container fill the width of its parent
                height: 45,
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Color(0xFF255899), // Background color using HEX value
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.only(left: 15, right: 15),
          //   child: ElevatedButton(
          //       style: ButtonStyle(
          //         backgroundColor: MaterialStateProperty.all<Color>(
          //           Color(0xFF255899), // Replace with your hexadecimal color code
          //         ),
          //         shape: MaterialStateProperty.all(
          //           RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(5.0),
          //             //side: BorderSide(color: Colors.red), // Set border color here
          //           ),
          //         ),
          //       ),
          //       onPressed: () {
          //          print('---------');
          //          Navigator.pushReplacement(context,
          //              MaterialPageRoute(builder:
          //                  (context) => HomePage()
          //              )   // VisitListHome
          //          );
          //       },
          //       child: Text('Login',
          //         style: TextStyle(
          //             fontFamily: 'Montserrat',
          //             color: Colors.white,
          //             fontSize: 18.0,
          //             fontWeight: FontWeight.bold),
          //       ),
          //       ),
          //   ),

          GestureDetector(
            onTap: () {
              print('----');
            },
            child: const ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Text('Forgot Password?',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF255899),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold)), // Replace with your TextView
              ),
            ),
          ),
          Opacity(
            opacity: 0.5,
            child: Container(
              width: double.infinity, // Set width as needed
              height: 200, // Set height as needed
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(
                      'assets/images/login_bottom_nw.png'), // Replace with your asset image path
                  fit: BoxFit.cover, // You can adjust the fit as needed
                ),
                borderRadius:
                    BorderRadius.circular(10), // Optional: border radius
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 5, // Spread radius
                    blurRadius: 7, // Blur radius
                    offset: Offset(0, 3), // Offset
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
