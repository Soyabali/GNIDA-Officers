import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/myPointRepo.dart';
import 'changePassword.dart';
import 'generalFunction.dart';
import 'homeScreen.dart';
import 'loginScreen_2.dart';
import 'notification.dart';

class Mypoint extends StatelessWidget {
  const Mypoint({super.key});

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
      home: MyPointPage(),
    );
  }
}

class MyPointPage extends StatefulWidget {
  const MyPointPage({super.key});

  @override
  State<MyPointPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyPointPage> {
  List<Map<String, dynamic>>? myPoinList;
  var totalPoint;

  String? sName, sContactNo;
  GeneralFunction generalFunction = GeneralFunction();
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 150,
          color: Colors.white,
          child: GestureDetector(
            onTap: () {
              print('---------');
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Logout",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xff3f617d),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Do you want to logout?",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xff3f617d),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 30,
                          width: 90,
                          child: ElevatedButton(
                            onPressed: () async {
                              // Fetch info from a local database and remove that info
                              SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              prefs.remove("iUserId");
                              prefs.remove("sName");
                              prefs.remove("sContactNo");
                              prefs.remove("sDesgName");
                              prefs.remove("iDesgCode");
                              prefs.remove("iDeptCode");
                              prefs.remove("iUserTypeCode");
                              prefs.remove("sToken");
                              prefs.remove("dLastLoginAt");
                              //Return String
                              // String? sName = prefs.getString('sName');
                              //print('---745--$sName');
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //         const LoginScreen_2()));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen_2()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xFF255899),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Adjust as needed
                              ), // Text color
                            ),
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 30,
                          width: 90,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Adjust as needed
                              ), // Text color
                            ),
                            child: const Text(
                              'No',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
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

  // GET REPO FUNCTION
  getMyPointResponse() async {
    myPoinList = await MyPointTypeRepo().mypointType(context);
    totalPoint = myPoinList?[0]['iTotal'].toString();
    setState(() {
    });
  }
  getlocalvalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      String? nameFirst = prefs.getString('nameFirst') ?? "";
      int? pointFirst = prefs.getInt('pointFirst');
      sName = prefs.getString('sName') ?? "";
      sContactNo = prefs.getString('sContactNo') ?? "";
      print("------146---$nameFirst");
      print("------1147---$pointFirst");
      print("------148---$sName");
      print("------1149---$sContactNo");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getMyPointResponse();
    getlocalvalue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF255899),
          title: const Text(
            'My Points',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        // Drawer
        drawer: generalFunction.drawerFunction(context,'$sName','$sContactNo'),
        body: ListView(
          children: <Widget>
          [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              elevation: 10,
              color: Colors.white,
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 0.2), // Outline border
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              child: Container(
                 color: Colors.white,
                child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2, // Flex factor 1/3
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          textAlign: TextAlign.justify,
                                          text: const TextSpan(
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Colors.grey,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.normal),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      "Hi,Thanks for your contribution towards smarter Noida! Based on your activities on"),
                                              TextSpan(
                                                text: " Noida One App",
                                                style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.blue,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                              TextSpan(
                                                  text:
                                                      ' You have been rewarded with the following points as \n'
                                                      'described below. Wish you luck to archieve more exciting rewards .'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 1, // Flex factor 2/3
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'assets/images/step4.jpg', // Replace with your asset image path
                                          width: double
                                              .infinity, // Take full width of column
                                          height:
                                              100, // Adjust image height as needed
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                             Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Points :',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '$totalPoint',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
              ),
            ),
          ),
          SizedBox(height: 10),

          Container(
          height: 150,
            child: ListView.separated(
                itemCount: myPoinList != null ? myPoinList!.length : 0,
                separatorBuilder: (BuildContext context, int index) {
                // Return the separator widget here
                return Divider(); // Example separator, you can customize this
                },
                itemBuilder: (context, index) {
            return
            Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFf2f3f5), // Container background color
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Card(
                    elevation: 8,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('${index+1}',style: TextStyle(
                              fontFamily: 'Montserrat',
                              // color: Colors.white,
                              color: Color(0xFF707d83),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),),
                          // First TextView
                          SizedBox(width: 8),
                          // icon
                          Icon(Icons.calendar_month,size: 20,color: Color(0xFF3375af),), // Admin icon
                          SizedBox(width: 8),
                          Text(myPoinList?[index]['dMonth'].toString() ?? '',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF707d83),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),), // Second TextView
                          Spacer(), // To push the last Text to the rightmost
                          Text(myPoinList?[index]['iEarnedPoint'].toString() ?? '',
                             style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFFad964a),
                              //color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold)),
                          // Last TextView
                        ],
                      ),
                    ),
                  ),
                ),
              );



    }
    )
          )
    ],
        ));
  }
}
