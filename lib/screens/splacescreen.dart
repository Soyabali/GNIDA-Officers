import 'dart:async';
import 'package:flutter/material.dart';

import 'loginscreen.dart';

class Splace extends StatefulWidget {
  const Splace({Key? key}) : super(key: key);

  @override
  State<Splace> createState() => _SplaceState();
}

class _SplaceState extends State<Splace> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // login Screen
    Timer(Duration(seconds:1),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => LoginScreen()
            )   // VisitListHome
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplaceScreen(),
    );
  }
}

class SplaceScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 50),
            // Top bar with two images
            Container(
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                     margin: EdgeInsets.all(10.0),
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
            // Centered image
            Expanded(
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  margin: EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/round_circle.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child:  Padding(
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

          ],
        ),
      ),
    );
  }
}