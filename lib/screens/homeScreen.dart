import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:noidaone/screens/MarkPointScreen.dart';
import 'package:noidaone/screens/TabBarHomeMonth.dart';
import 'package:noidaone/screens/drywetsegregation.dart';
import 'package:noidaone/screens/generalFunction.dart';
import 'package:noidaone/screens/pendingcomplaint.dart';
import 'package:noidaone/screens/postComplaint.dart';
import 'package:noidaone/screens/scheduledpoint.dart';
import 'package:noidaone/screens/tabbarHome.dart';
import 'package:noidaone/screens/tabbarHomeToday.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controllers/userContributionRepo.dart';
import '../Controllers/userModuleRight.dart';
import '../Controllers/usercontributionMonthRepo.dart';
import '../Controllers/usercontributionTodayRepo.dart';
import '../resources/app_text_style.dart';
import 'changePassword.dart';
import 'complaintStatus.dart';
import 'dailyActivity.dart';
import 'loginScreen_2.dart';
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
  void sendData(String data) {
  }

  String? sName, sContactNo;
  List userModuleRightList = [];
  List<Map<String, dynamic>>? userContributionList; // All
  List<Map<String, dynamic>>? userContributionTodayList; // today
  List<Map<String, dynamic>>? userContributionMonthList; // Month
  TabController? tabController;
  GeneralFunction generalFunction = GeneralFunction();
  var nameFirst, pointFirst, nameSecond, pointSecond, nameThird, pointThird;
  // tabcontroller logic
  void _handleTabSelection() {
    setState(() {
      // You can fetch data based on the selected tab index here
      int tabIndex = tabController!.index;
      // print('Selected tab index:----95-- $tabIndex');
      fetchDataBasedOnTab(tabIndex);
    });
  }

  Future<void> fetchDataBasedOnTab(int tabIndex) async {
    // Implement your data fetching logic based on the tab index
    // For example:
    if (tabIndex == 0) {
      // Today
      userContributionTodayList =
          await UserContributionTodayRepo().userContributionTodat(context);
      nameFirst = userContributionList?[0]['sName'].toString();
      pointFirst = userContributionList?[0]['iEarnedPoints'].toString();
      nameSecond = userContributionList?[1]['sName'].toString();
      pointSecond = userContributionList?[1]['iEarnedPoints'].toString();
      nameThird = userContributionList?[2]['sName'].toString();
      pointThird = userContributionList?[2]['iEarnedPoints'].toString();
      print('-----116--$nameFirst');

      setState(() {});

      // Fetch data for tab 1
      //print('----111--tabIndex--$userContributionTodayList');
    } else if (tabIndex == 1) {
      userContributionMonthList =
          await UserContributionMontRepo().userContributionMonth(context);
      nameFirst = userContributionMonthList?[0]['sName'].toString();
      pointFirst = userContributionMonthList?[0]['iEarnedPoints'].toString();
      nameSecond = userContributionMonthList?[1]['sName'].toString();
      pointSecond = userContributionMonthList?[1]['iEarnedPoints'].toString();
      nameThird = userContributionMonthList?[2]['sName'].toString();
      pointThird = userContributionMonthList?[2]['iEarnedPoints'].toString();
      print('-----131--$nameFirst');

      setState(() {});
      // print('----114--tabIndex--$userContributionMonthList');
      // Fetch data for tab 2
    } else if (tabIndex == 2) {
      userContributionList =
          await UserContributionRepo().userContribution(context);
      nameFirst = userContributionList?[0]['sName'].toString();
      pointFirst = userContributionList?[0]['iEarnedPoints'].toString();
      nameSecond = userContributionList?[1]['sName'].toString();
      pointSecond = userContributionList?[1]['iEarnedPoints'].toString();
      nameThird = userContributionList?[2]['sName'].toString();
      pointThird = userContributionList?[2]['iEarnedPoints'].toString();
      print('-----145--$nameFirst');
      setState(() {});

      // Fetch data for tab 3
    }
  }

  userContributionResponse() async {
    userContributionList =
        await UserContributionTodayRepo().userContributionTodat(context);
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

  usermoduleright() async {
    userModuleRightList = await UserModuleRightRepo().usermoduleright();
    print(" ----83----xxxxx-> $userModuleRightList");
    // print(" ----84--> ${userModuleRightList.length}");
    // print(" ----85--> $userModuleRightList['sActivityName']");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 3);
    usermoduleright();
    userContributionResponse();
    getlocalvalue();
    tabController?.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    tabController?.dispose(); // Dispose of the tab controller when done
    super.dispose();
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //userContributionResponse();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    //  userContributionResponse();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return WillPopScope(
      onWillPop: () async => false,
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
        drawer: generalFunction.drawerFunction(context,'$sName','$sContactNo'),
        // body
        body: Column(
          children: <Widget>[
            // stack
            Expanded(
              child: Container(
                height: 220,
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 220,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/top_contributor_header.png'), // Provide your image path here
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
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
                              color: Color(
                                  0xFF3375af), // Container background color
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
                              labelPadding:
                                  EdgeInsets.symmetric(horizontal: 0.0),
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
                        top: 45,
                        left: 15,
                        right: 15,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                           // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/firsttrophy.png',
                                      width: 80, // Adjust the width of the image
                                      height: 80, // Adjust the height of the image
                                      fit: BoxFit.fill,
                                    ), // Asset image for column 1
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '1.',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                   // Text widget 1
                                        Flexible(
                                          child: Text(
                                            '$nameFirst',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ), // Text widget 2
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$pointFirst',
                                          style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(width: 2), // Text widget 1
                                        const Text(
                                          'Point',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ), // Text widget 2
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/firsttrophy.png',
                                      width: 65, // Adjust the width of the image
                                      height: 65, // Adjust the height of the image
                                      fit: BoxFit.fill,
                                    ), // Asset image for column 1
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '2.',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(width: 0), // Text widget 1
                                        Flexible(
                                          child: Text(
                                            '$nameSecond',
                                            style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ), // Text widget 2
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$pointSecond',
                                          style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(width: 2), // Text widget 1
                                        const Text(
                                          'Point',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ), // Text widget 2
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/firsttrophy.png',
                                      width: 50, // Adjust the width of the image
                                      height: 50, // Adjust the height of the image
                                      fit: BoxFit.fill,
                                    ), // Asset image for column 1
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '3.',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(width: 2), // Text widget 1
                                        Flexible(
                                          child: Text(
                                            '$nameThird',
                                            style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ), // Text widget 2
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$pointThird',
                                          style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(width: 2), // Text widget 1
                                        const Text(
                                          'Point',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ), // Text widget 2
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                height: MediaQuery.of(context).size.height - 400.0,
               // height: 250,
                child: TabBarView(
                    controller: tabController,
                    children: <Widget>[
                      //new FoodList(),
                      // new TabBarHomeToday(),
                      new TabBarHomeToday(sendData: sendData),
                      new TabBarHomeMonth(),
                      new TabBarHome(),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 0),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 0),
              child: Container(
                height: 100,
                child: Container(
                    // color: Colors.grey,
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: userModuleRightList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              var activatecode =
                                  '${userModuleRightList[index]['iActivityCode']}';
                              if (activatecode == "1") {
                                // print('---Mark---');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MarkPointScreen()));
                              } else if (activatecode == "6") {
                                //print('---Scheduled \n Points---');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ScheduledPointScreen()));
                              } else if (activatecode == "3") {
                                // print('---Pending \n Complaint---');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PendingComplaintScreen()));
                              } else if (activatecode == "2") {
                                print('---Post \n Complaint---');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PostComplaintScreen()));
                              } else if (activatecode == "7") {
                                print('---Daily \n Activity---');
                                //  DailyActivitytScreen
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DailyActivitytScreen()));
                              } else if (activatecode == "4") {
                                // Dry/Wet \n Segregation
                                print('---Dry/Wet \n Segregation---');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DryWetSegregationScreen()));
                              }
                              else if(activatecode =="5"){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const ComplaintStatusScreen()));
                              }
                            },
                            child: Container(
                              width: 91,
                              height: 80,
                              margin: const EdgeInsets.only(
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
                                      'assets/images/ic_mark_point.PNG', // Replace with your asset image path
                                      width: 30, // Adjust image width as needed
                                      height:
                                          30, // Adjust image height as needed
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
                        })),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // widget  tab
  Widget _buildTab(String text, BuildContext context) {
    return Container(
      height: 30,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      decoration: const BoxDecoration(
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
          style: const TextStyle(
              fontFamily: 'Montserrat',
              // color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
