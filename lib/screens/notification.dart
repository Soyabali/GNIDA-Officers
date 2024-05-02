import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noidaone/Controllers/notificationRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'changePassword.dart';
import 'homeScreen.dart';
import 'loginScreen_2.dart';
import 'mypoint.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

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
  List<Map<String, dynamic>>? notificationList;
  String? sName, sContactNo;
  getnotificationResponse() async {
    // notificationList = NotificationRepo().
    notificationList = await NotificationRepo().notification(context);
    print('------39----$notificationList');
    setState(() {
    });
  }
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

  @override
  void initState() {
    // TODO: implement initState
    getlocalvalue();
    getnotificationResponse();
    super.initState();
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF255899),
          title: const Text(
            'Notification',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        // drawer
        drawer: Drawer(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
               DrawerHeader(
                    decoration: const BoxDecoration(
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
                            _showBottomSheet(context);

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => LogoutScreen()),
                            // );
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
                            child: const Text(
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
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
                child: Container(
                  height: MediaQuery.of(context).size.height,
            
                  child: ListView.separated(
                      itemCount: notificationList != null ? notificationList!.length : 0,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(); // Example separator, you can customize this
                      },
                      itemBuilder: (context, index) {
                        return  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  child: Icon(
                                    Icons.notification_important, size: 30, color: Color(
                                      0xFF255899),),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(notificationList?[index]['sTitle'].toString() ?? '',
                                    style: const TextStyle(
                                                          fontFamily: 'Montserrat',
                                                          color: Color(0xff3f617d),
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                  SizedBox(height: 2),
                                  Container(
                                    width: MediaQuery.of(context).size.width - 32,
                                    child: Text(
                                      notificationList?[index]['sNotification'].toString() ?? '',
                                      overflow: TextOverflow.clip,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xff3f617d),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(notificationList?[index]['dRecivedAt'].toString() ?? '',
                                    style: const TextStyle(
                                                          fontFamily: 'Montserrat',
                                                          color: Color(0xff3f617d),
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.bold),
                                                    )
                                ],
                              )
                            ],
                          ),
                        ],
                      )
                        );
                      }
                  ),
                ),
              )
            
              ]
            ),
          ),
        )
    );

  }
}
