import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noidaone/screens/MarkPointScreen.dart';
import 'package:noidaone/screens/drywetsegregation.dart';
import 'package:noidaone/screens/foodlist.dart';
import 'package:noidaone/screens/pendingcomplaint.dart';
import 'package:noidaone/screens/scheduledpoint.dart';
import 'package:noidaone/screens/tabbarHome.dart';

import 'changePassword.dart';
import 'logout.dart';
import 'mypoint.dart';
import 'notification.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF255899),
        title: const Text(
          'Noida One',
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
                      size: 32,
                      color: Color(0xFF707d83),
                    ),
                    Text(
                      'ABHISHEK (Supervisor)',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF707d83),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.call,
                          size: 18,
                          color: Color(0xFF707d83),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '987195xxxx',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF707d83),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      print('Row clicked!---');
                      Navigator.pop(context);

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
                        SizedBox(width: 5),
                        const Text(
                          'Home',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF707d83),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Mypoint()),
                      );
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Mypoint()),
                      // );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/my_wallet.png', // Replace with your asset image path
                          width: 25, // Adjust image width as needed
                          height: 25, // Adjust image height as needed
                        ),
                        SizedBox(width: 5),
                        const Text(
                          'MyPoints',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF707d83),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChangePassWord()),
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
                        SizedBox(width: 5),
                        Text(
                          'Change Password',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF707d83),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NotificationPage()),
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
                        SizedBox(width: 5),
                        const Text(
                          'Notification',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF707d83),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogoutScreen()),
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
                        SizedBox(width: 5),
                        Text(
                          'Logout',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF707d83),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // body
      body: ListView(
        children: <Widget>[
          // stack
          Container(
            height: 300,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/top_contributor_header.png'), // Provide your image path here
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width - 30,
                        //color: Color(0xFF255899),
                        decoration: const BoxDecoration(
                          color:
                              Color(0xFF003c7c), // Container background color
                          // color: Colors.grey,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(
                                25), // Adjust this value as per your preference
                            right: Radius.circular(
                                25), // Adjust this value as per your preference
                          ),
                        ),
                        child: TabBar(
                          controller: tabController,
                          indicatorColor: Color(0xFFFE8A7E),
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorWeight: 0.0,
                          //isScrollable: true,
                          labelColor: Color(0xFF440206),
                          unselectedLabelColor: Color(0xFF440206),
                          indicator: const BoxDecoration(
                            color: Color(
                                0xFFFFFFFF), // Background color of the selected tab
                          ),
                          tabs: <Widget>[
                            Container(
                              child: Tab(
                                child: Text(
                                  'Today',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              child: Tab(
                                child: Text(
                                  'Month',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                              child: Tab(
                                child: Text(
                                  'All Time',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 80,
                    left: 15,
                    right: 15,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/trophy.png', // Asset image path
                                width: 90,
                                height: 90,
                              ),
                              SizedBox(
                                  height:
                                      0), // Add some space between the image and text
                              const Text(
                                '1. Krishna tomar',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(height: 0),
                              const Text(
                                '2 Points',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/trophy.png', // Asset image path
                                width: 70,
                                height: 70,
                              ),
                              SizedBox(
                                  height:
                                      0), // Add some space between the image and text
                              const Text(
                                '1. Lokesh',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(height: 0),
                              const Text(
                                '2 Points',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/trophy.png', // Asset image path
                                width: 55,
                                height: 55,
                              ),
                              const SizedBox(
                                  height:
                                      0), // Add some space between the image and text
                              const Text(
                                '3. Husain',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(height: 0),
                              const Text(
                                '3 Points',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
          Container(
            height: 225,
            //height: MediaQuery.of(context).size.height - 450.0,
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                //new FoodList(),
                new TabBarHome(),
                new TabBarHome(),
                new TabBarHome(),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Container(
                // color: Colors.grey,
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        print('----Marks----');
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MarkPointScreen()));
                      },
                      child: Container(
                        width: 91,
                        height: 80,
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xff81afea),
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the value for more or less rounded corners
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/post_complaint.png', // Replace with your asset image path
                              width: 40, // Adjust image width as needed
                              height: 40, // Adjust image height as needed
                            ),
                            SizedBox(height: 2),
                            const Text(
                              'Marks Points',
                              style: TextStyle(
                                fontSize: 10, // Adjust text size as needed
                                fontWeight: FontWeight
                                    .bold, // Adjust text weight as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print('----333----');
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ScheduledPointScreen()));
                      },
                      child: Container(
                        width: 91,
                        height: 80,
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xff81afea),
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the value for more or less rounded corners
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/schedule_point.png', // Replace with your asset image path
                              width: 40, // Adjust image width as needed
                              height: 40, // Adjust image height as needed
                            ),
                            SizedBox(height: 2),
                            const Text(
                              'Scheduled Points',
                              style: TextStyle(
                                fontSize: 10, // Adjust text size as needed
                                fontWeight: FontWeight
                                    .bold, // Adjust text weight as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print('----369----');
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PendingComplaintScreen()));
                      },
                      child: Container(
                        width: 91,
                        height: 80,
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xff81afea),
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the value for more or less rounded corners
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/complaint_status.png', // Replace with your asset image path
                              width: 40, // Adjust image width as needed
                              height: 40, // Adjust image height as needed
                            ),
                            SizedBox(height: 2),
                            const Text(
                              'Pending Complaint',
                              style: TextStyle(
                                fontSize: 10, // Adjust text size as needed
                                fontWeight: FontWeight
                                    .bold, // Adjust text weight as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DryWetSegregationScreen()));
                      },
                      child: Container(
                        width: 91,
                        height: 80,
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xff81afea),
                          borderRadius: BorderRadius.circular(
                              10), // Adjust the value for more or less rounded corners
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/complaint_status.png', // Replace with your asset image path
                              width: 40, // Adjust image width as needed
                              height: 40, // Adjust image height as needed
                            ),
                            SizedBox(height: 2),
                            const Text(
                              'Dry/Wet Segregation',
                              style: TextStyle(
                                fontSize: 10, // Adjust text size as needed
                                fontWeight: FontWeight
                                    .bold, // Adjust text weight as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
