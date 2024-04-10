import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabBarHome extends StatelessWidget {
  const TabBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabPage(),
    );
  }
}
class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Container(
              height: 50,
              width: double.infinity,
              //color: Color(0xFF255899),
              decoration: BoxDecoration(
                color: Color(0xFFD3D3D3), // Container background color
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(25), // Adjust this value as per your preference
                  right: Radius.circular(25), // Adjust this value as per your preference
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('4 ',style: TextStyle(
                        fontFamily: 'Montserrat',
                       // color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),),
                    // First TextView
                    SizedBox(width: 15),
                    Icon(Icons.supervised_user_circle,size: 20), // Admin icon
                    SizedBox(width: 15),
                    Text('RAVI YADAV'), // Second TextView
                    Spacer(), // To push the last Text to the rightmost
                    Text('2 point',style: TextStyle(
                          fontFamily: 'Montserrat',
                          //color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                     // Last TextView
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Container(
              height: 50,
              width: double.infinity,
              //color: Color(0xFF255899),
              decoration: BoxDecoration(
                color: Color(0xFFD3D3D3), // Container background color
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(25), // Adjust this value as per your preference
                  right: Radius.circular(25), // Adjust this value as per your preference
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('4 ',style: TextStyle(
                        fontFamily: 'Montserrat',
                        // color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),),
                    // First TextView
                    SizedBox(width: 15),
                    Icon(Icons.supervised_user_circle,size: 20), // Admin icon
                    SizedBox(width: 15),
                    Text('RAVI YADAV'), // Second TextView
                    Spacer(), // To push the last Text to the rightmost
                    Text('2 point',style: TextStyle(
                        fontFamily: 'Montserrat',
                        //color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold)),
                    // Last TextView
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Container(
              height: 50,
              width: double.infinity,
              //color: Color(0xFF255899),
              decoration: BoxDecoration(
                color: Color(0xFFD3D3D3), // Container background color
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(25), // Adjust this value as per your preference
                  right: Radius.circular(25), // Adjust this value as per your preference
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('4 ',style: TextStyle(
                        fontFamily: 'Montserrat',
                        // color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),),
                    // First TextView
                    SizedBox(width: 15),
                    Icon(Icons.supervised_user_circle,size: 20), // Admin icon
                    SizedBox(width: 15),
                    Text('RAVI YADAV'), // Second TextView
                    Spacer(), // To push the last Text to the rightmost
                    Text('2 point',style: TextStyle(
                        fontFamily: 'Montserrat',
                        //color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold)),
                    // Last TextView
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


