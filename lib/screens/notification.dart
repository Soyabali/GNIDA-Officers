import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noidaone/Controllers/notificationRepo.dart';
import 'changePassword.dart';
import 'homeScreen.dart';
import 'logout.dart';
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
  getnotificationResponse() async {
    // notificationList = NotificationRepo().
    notificationList = await NotificationRepo().notification(context);
    print('------39----$notificationList');
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getnotificationResponse();
    super.initState();
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
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
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
                        'ABHISHEK (Supervisor)',
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
                            '987195xxxx',
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
        body: ListView(
          children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
            child: Container(
             // height: MediaQuery.of(context).size.height,
              height: 300,
              child: ListView.separated(
                  itemCount: notificationList != null ? notificationList!.length : 0,
                  separatorBuilder: (BuildContext context, int index) {
                    // Return the separator widget here
                    return Divider(); // Example separator, you can customize this
                  },
                  itemBuilder: (context, index) {
                    return
                      Container(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Icons.notification_important, size: 30, color: Color(
                                0xFF255899),),
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
                              Text(
                                notificationList?[index]['sNotification'].toString() ?? '',
                                style: const TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        color: Color(0xff3f617d),
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.bold),
                                                  ),
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
              ),
                      );
                  }
              ),
            ),
          )

  ]

    )
    );

  }
}
