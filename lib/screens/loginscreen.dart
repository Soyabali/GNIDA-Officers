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
      body: ListView(
        children: <Widget>[
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
          SizedBox(height: 20),
          Expanded(
            child: Center(
              child: Container(
                height: 100,
                width: 100,
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
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain, // Adjust as needed
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Login',
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Color(0xFF255899),
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            controller: _phoneNumberController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: 'Mobile Number',
              // border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone,color:Color(0xFF255899),),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            obscureText: _isObscured,
            controller: _passWordController,
            decoration: InputDecoration(
              labelText: 'Password',
              // border: OutlineInputBorder(),
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
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: InkWell(
              onTap: (){

                  },
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF255899), // Replace with your hexadecimal color code
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      //side: BorderSide(color: Colors.red), // Set border color here
                    ),
                  ),
                ),
                onPressed: () {
                   print('---------');
                   Navigator.pushReplacement(context,
                       MaterialPageRoute(builder:
                           (context) => HomePage()
                       )   // VisitListHome
                   );
                },
                child: Text('Login',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
                ),
            ),
            ),
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
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold)), // Replace with your TextView
              ),
            ),
          ),
          Container(
            width: 150, // Set width as needed
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
        ],
      ),
    );
  }
}
