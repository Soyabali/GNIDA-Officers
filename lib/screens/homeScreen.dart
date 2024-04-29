import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noidaone/screens/MarkPointScreen.dart';
import 'package:noidaone/screens/TabBarHomeMonth.dart';
import 'package:noidaone/screens/drywetsegregation.dart';
import 'package:noidaone/screens/foodlist.dart';
import 'package:noidaone/screens/pendingcomplaint.dart';
import 'package:noidaone/screens/postComplaint.dart';
import 'package:noidaone/screens/scheduledpoint.dart';
import 'package:noidaone/screens/tabbarHome.dart';
import 'package:noidaone/screens/tabbarHomeToday.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controllers/userContributionRepo.dart';
import '../Controllers/userModuleRight.dart';
import '../resources/app_text_style.dart';
import 'changePassword.dart';
import 'dailyActivity.dart';
import 'forgotpassword.dart';
import 'loginScreen_2.dart';
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
  List userModuleRightList = [];
  List<Map<String, dynamic>>? userContributionList;
  TabController? tabController;
  var nameFirst,pointFirst,nameSecond,pointSecond,nameThird,pointThird;
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?',style: AppTextStyle
            .font14OpenSansRegularBlackTextStyle,),
        content: new Text('Do you want to exit app',style: AppTextStyle
            .font14OpenSansRegularBlackTextStyle,),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () {
              //  goToHomePage();
              // exit the app
              exit(0);
            }, //Navigator.of(context).pop(true), // <-- SEE HERE
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  userContributionResponse() async {
    userContributionList = await UserContributionRepo().userContribution(context);
   // userContributionList?[index]['sName'].toString() ?? '',userContributionList?[index]['sName'].toString() ?? '',
      nameFirst = userContributionList?[0]['sName'].toString();
     pointFirst = userContributionList?[0]['iEarnedPoints'].toString();
     nameSecond = userContributionList?[1]['sName'].toString();
     pointSecond = userContributionList?[1]['iEarnedPoints'].toString();
     nameThird = userContributionList?[2]['sName'].toString();
     pointThird = userContributionList?[2]['iEarnedPoints'].toString();
    print('----88----xxx-$nameFirst');
    print('----89-----xxx-$pointFirst');

    print('--30---xxxx------$userContributionList');
    setState(() {});
  }

  usermoduleright() async
  {
    userModuleRightList = await UserModuleRightRepo().usermoduleright();
    print(" ----83--> $userModuleRightList");
    print(" ----84--> ${userModuleRightList.length}");
    print(" ----85--> $userModuleRightList['sActivityName']");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 3);
    usermoduleright();
    userContributionResponse();
  }

  @override
  Widget build(BuildContext context) {

    return  WillPopScope(
      onWillPop: ()async =>false,
      child: Scaffold(
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
                      ],
                    ),
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
                      decoration: const BoxDecoration(
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
                            height: 35,
                            width: MediaQuery.of(context).size.width - 30,
                            //color: Color(0xFF255899),
                            decoration: const BoxDecoration(
                              color:
                                  Color(0xFF3375af), // Container background color
                              // color: Colors.grey,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(
                                    0), // Adjust this value as per your preference
                                right: Radius.circular(
                                    0), // Adjust this value as per your preference
                              ),
                            ),

                            child: TabBar(
                              controller: tabController,
                              indicatorColor: Colors.white,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorWeight: 0.9,
                              labelPadding: EdgeInsets.symmetric(horizontal: 0.0),
                              unselectedLabelColor: Colors.white,
                              labelColor: Colors.black,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 0,
                                  )),
                              tabs: <Widget>[
                                _buildTab('Today', context),
                                _buildTab('Month', context),
                                _buildTab('All Time', context),
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
                                  ), // Add some space between the image and text
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                       Text(
                                        '1.',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal),
                                      ),
                                       SizedBox(width: 5),
                                       Text(
                                        '$nameFirst',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '$pointFirst',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Point',
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
                              Column(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/trophy.png', // Asset image path
                                    width: 90,
                                    height: 90,
                                  ), // Add some space between the image and text
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '2.',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '$nameSecond',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '$pointSecond',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Point',
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
                              Column(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/trophy.png', // Asset image path
                                    width: 90,
                                    height: 90,
                                  ), // Add some space between the image and text
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '3.',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '$nameThird',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '$pointThird',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Point',
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

                              // Column(
                              //   children: <Widget>[
                              //     Image.asset(
                              //       'assets/images/trophy.png', // Asset image path
                              //       width: 70,
                              //       height: 70,
                              //     ),
                              //     SizedBox(
                              //         height:
                              //             0), // Add some space between the image and text
                              //     const Text(
                              //       '2. Lokesh',
                              //       style: TextStyle(
                              //           fontFamily: 'Montserrat',
                              //           color: Colors.white,
                              //           fontSize: 12.0,
                              //           fontWeight: FontWeight.normal),
                              //     ),
                              //     const SizedBox(height: 0),
                              //     const Text(
                              //       '2 Points',
                              //       style: TextStyle(
                              //           fontFamily: 'Montserrat',
                              //           color: Colors.white,
                              //           fontSize: 12.0,
                              //           fontWeight: FontWeight.normal),
                              //     ),
                              //   ],
                              // ),
                              // Column(
                              //   children: <Widget>[
                              //     Image.asset(
                              //       'assets/images/trophy.png', // Asset image path
                              //       width: 55,
                              //       height: 55,
                              //     ),
                              //     const SizedBox(
                              //         height:
                              //             0), // Add some space between the image and text
                              //     const Text(
                              //       '3. Husain',
                              //       style: TextStyle(
                              //           fontFamily: 'Montserrat',
                              //           color: Colors.white,
                              //           fontSize: 12.0,
                              //           fontWeight: FontWeight.normal),
                              //     ),
                              //     SizedBox(height: 0),
                              //     const Text(
                              //       '3 Points',
                              //       style: TextStyle(
                              //           fontFamily: 'Montserrat',
                              //           color: Colors.white,
                              //           fontSize: 12.0,
                              //           fontWeight: FontWeight.normal),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Container(
                  height: 200,
                  //height: MediaQuery.of(context).size.height - 450.0,
                  child: TabBarView(
                    controller: tabController,
                    children: <Widget>[
                      //new FoodList(),
                     // new TabBarHomeToday(),
                      new TabBarHomeToday(),
                      new TabBarHomeMonth(),
                      new TabBarHome(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Card(
                  elevation: 10,
                  child: Container(
                      // color: Colors.grey,
                      height: 100,
                      child: ListView.builder(
                       scrollDirection: Axis.horizontal,
                        itemCount: userModuleRightList.length,
                        itemBuilder: (context,index){
                         return
                            InkWell(
                              onTap: () {
                                var activatecode = '${userModuleRightList[index]['iActivityCode']}';
                                if(activatecode=="1"){
                                 // print('---Mark---');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MarkPointScreen()));

                                }else if(activatecode=="6"){
                                  //print('---Scheduled \n Points---');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ScheduledPointScreen()));

                                }else if(activatecode=="3"){
                                 // print('---Pending \n Complaint---');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const PendingComplaintScreen()));

                                }else if(activatecode=="2"){
                                  print('---Post \n Complaint---');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const PostComplaintScreen()));

                                }else if(activatecode=="7"){
                                  print('---Daily \n Activity---');
                                  //  DailyActivitytScreen
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const DailyActivitytScreen()));
                                }else if(activatecode=="4"){
                                  // Dry/Wet \n Segregation
                                  print('---Dry/Wet \n Segregation---');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const DryWetSegregationScreen()));
                                }
                              },
                              child: Container(
                                width: 91,
                                height: 80,
                                margin: EdgeInsets.only(
                                    left: 8, right: 8, bottom: 8, top: 8),
                                decoration: BoxDecoration(
                                  color: Color(0xff81afea),
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust the value for more or less rounded corners
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/images/post_complaint.png', // Replace with your asset image path
                                        width: 30, // Adjust image width as needed
                                        height: 30, // Adjust image height as needed
                                      ),
                                      SizedBox(height: 2),
                                      Center(
                                           child: Text(
                                            '${userModuleRightList[index]['sActivityName']}',
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Colors.white,
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold),
                                                                                 ),
                                         ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                       }
                       )

                  ),
                ),
              )
            ],
          ),
        ),
    );
  }

  // bottom screen
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(

          height: 200,
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
                  SizedBox(height: 5),
                  const Text(
                    "Do you want to logout?",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xff3f617d),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 30,
                          width: 90,
                          child: ElevatedButton(
                            onPressed: ()  async {
                              // Fetch info from a local database and remove that info
                              SharedPreferences prefs = await SharedPreferences.getInstance();
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const LoginScreen_2()));

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
                              child: Text(
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

  // widget  tab
  Widget _buildTab(String text, BuildContext context) {
    return Container(
      height: 30,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        // color: Theme.of(context).primaryColor,
        //color: Colors.green,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontFamily: 'Montserrat',
              // color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
