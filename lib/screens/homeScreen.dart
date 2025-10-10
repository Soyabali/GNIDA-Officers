import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noidaone/screens/MarkPointScreen.dart';
import 'package:noidaone/screens/TabBarHomeMonth.dart';
import 'package:noidaone/screens/drywetsegregation.dart';
import 'package:noidaone/screens/generalFunction.dart';
import 'package:noidaone/screens/pendingcomplaint.dart';
import 'package:noidaone/screens/postComplaint.dart';
import 'package:noidaone/screens/scheduledpoint.dart';
import 'package:noidaone/screens/shopSurvey.dart';
import 'package:noidaone/screens/tabbarHome.dart';
import 'package:noidaone/screens/tabbarHomeToday.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controllers/userModuleRight.dart';
import 'complaintStatus.dart';
import 'dailyActivity.dart';

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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  String? sName, sContactNo;
  List userModuleRightList = [];
  List<Map<String, dynamic>>? userContributionList; // All
  List<Map<String, dynamic>>? userContributionTodayList; // today
  List<Map<String, dynamic>>? userContributionMonthList; // Month
  TabController? tabController;
  GeneralFunction generalFunction = GeneralFunction();
  //var nameFirst, pointFirst, nameSecond, pointSecond, nameThird, pointThird;
  String nameFirst = ""; // Variables to hold data from tabs
  int pointFirst = 0;
  String nameSecond = "";
  int pointSecond = 0;
  String nameThird = "";
  int pointThird = 0;
  // call back function
  String dataFromScreenB = '';

  usermoduleright() async {
    userModuleRightList = await UserModuleRightRepo().usermoduleright();
    //print(" ----83----xxxxx-> $userModuleRightList");
    debugPrint("----83----xxxxx-> $userModuleRightList", wrapWidth: 1024);
    // print(" ----84--> ${userModuleRightList.length}");
    // print(" ----85--> $userModuleRightList['sActivityName']");
    setState(() {});
  }
   TofetchvalueFromTab(String nameFirst,int pointFirst,String nameSecond,int pointSecond,
      String nameThird,int pointThird)
  {
    setState(() {
      this.nameFirst = nameFirst;
      this.pointFirst = pointFirst;
      this.nameSecond = nameSecond;
      this.pointSecond = pointSecond;
      this.nameThird = nameThird;
      this.pointThird = pointThird;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 3);
    usermoduleright();
    getlocalvalue();
   // tabController?.addListener(_handleTabSelection);
    print('------------159--------xxx--------');
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
      print("------177---$sName");
      print("------178---$sContactNo");
    });
    setState(() {
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
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
            Text('Pop Screen Disabled.'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: generalFunction.appbarFunction("GNIDA Officers"),
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
                                color: Color(0xFF3375af), // Container background color
                                // color: Colors.grey,
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(0), // Adjust this value as per your preference
                                  right: Radius.circular(0), // Adjust this value as per your preference
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
                        top: 45,
                        left: 15,
                        right: 15,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/firsttrophy.png',
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.fill,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '1.',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Flexible(
                                          child: Text(
                                            '$nameFirst',
                                            style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
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
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        const Text(
                                          'Points',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
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
                                      width: 55,
                                      height: 55,
                                      fit: BoxFit.fill,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '2.',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Flexible(
                                          child: Text(
                                            '$nameSecond',
                                            style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
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
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        const Text(
                                          'Points',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
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
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.fill,
                                    ),
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
                                        SizedBox(width: 2),
                                        Flexible(
                                          child: Text(
                                            '$nameThird',
                                            style: const TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.white,
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
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
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        const Text(
                                          'Points',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.white,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
              // bottom ListView
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  height: MediaQuery.of(context).size.height - 400.0,
                 color: Colors.white,
                 // height: 250,
                  child: TabBarView(
                      controller: tabController,
                      children: <Widget>[
                        //new FoodList(),
                        // new TabBarHomeToday(),
                        TabTodayPage(onDataReceived: (nameFirst,pointFirst,nameSecond,pointSecond,nameThird,pointThird) {
                          // Handle data received from AllTab here
                          TofetchvalueFromTab(nameFirst,pointFirst,nameSecond,pointSecond,nameThird,pointThird);

                          print('---518--TodayNameFirst---$nameFirst');
                          print('---519--TodayPointFirst---$pointFirst');
                          print('---520--TodayNameSecond---$nameSecond');
                          print('---521--TodayPointSecond---$pointSecond');
                          print('---522--TodayNameThird---$nameThird');
                          print('---523--TodayPointThird---$pointThird');
                        }),
                        TabPageMonth(onDataReceived: (nameFirst,pointFirst,nameSecond,pointSecond,nameThird,pointThird){
                      TofetchvalueFromTab(nameFirst,pointFirst,nameSecond,pointSecond,nameThird,pointThird);

                      print('---526--MonthNameFirst---$nameFirst');
                      print('---527--MonthPointFirst---$pointFirst');
                      print('---528--MonthNameSecond---$nameSecond');
                      print('---529--MonthPointSecond---$pointSecond');
                      print('---530--MonthNameThird---$nameThird');
                      print('---531--MonthPointThird---$pointThird');
                     }),
                        TabPage(onDataReceived: (nameFirst,pointFirst,nameSecond,pointSecond,nameThird,pointThird){
                          TofetchvalueFromTab(nameFirst,pointFirst,nameSecond,pointSecond,nameThird,pointThird);

                          print('---534--AllFirst---$nameFirst');
                          print('---535--AllPointFirst---$pointFirst');
                          print('---536--AllNameSecond---$nameSecond');
                          print('---537--AllPointSecond---$pointSecond');
                          print('---538--AllNameThird---$nameThird');
                          print('---539--AllPointThird---$pointThird');
                       }),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 0),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 0),
                child: Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: userModuleRightList.length,
                    itemBuilder: (context, index) {
                      var activity = userModuleRightList[index];
                      var sActivityName = activity['sActivityName'];

                      return InkWell(
                        onTap: () {
                          var activatecode = '${userModuleRightList[index]['iActivityCode']}';
                          if (activatecode == "1") {

                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MarkPointScreen()));

                          } else if (activatecode == "6") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ScheduledPointScreen()));
                          } else if (activatecode == "3") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PendingComplaintScreen()));
                          } else if (activatecode == "2") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const PostComplaintScreen()));
                          } else if (activatecode == "7") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DailyActivitytScreen()));
                          } else if (activatecode == "4") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DryWetSegregationScreen()));
                          } else if (activatecode == "5") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ComplaintStatusScreen()));
                          } else if (activatecode == "8") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ShopSurvey()));
                          }
                        },
                        child: Container(
                          width: 100,
                          height: 90,
                          margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8, top: 0),
                          decoration: BoxDecoration(
                            //color: Color(0xff81afea),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF81AFEA), // Your base color
                                Color(0xFF2E6DD8), // Matching darker blue
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.network(
                                  '${activity['iImgIcon']}',
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(height: 2),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      sActivityName,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis, // adds "..." if too long
                                      maxLines: 2,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          // mobile back button code

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
