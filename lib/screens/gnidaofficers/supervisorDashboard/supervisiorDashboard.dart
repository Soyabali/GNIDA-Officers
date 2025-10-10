import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:gif/gif.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Controllers/supervisorbottomlist.dart';
import '../../MarkPointScreen.dart';
import '../../dailyActivity.dart';
import '../../generalFunction.dart';
import '../../gnidabeautification/gnidabeautification.dart';
import '../../pendingcomplaint.dart';
import '../../scheduledpoint.dart';
import '../../shopSurvey.dart';


class SupervisiorDashBoard extends StatefulWidget {


  const SupervisiorDashBoard({super.key});

  @override
  State<SupervisiorDashBoard> createState() => _GnoidaOfficersHomeState();
}

class _GnoidaOfficersHomeState extends State<SupervisiorDashBoard> with TickerProviderStateMixin {

  GeneralFunction generalFunction = GeneralFunction();
  late GifController controller;
  var sName,sContactNo;
  List userModuleRightList = [];

  // create a function to draw a ui
  Widget buildFancyStack() {
    return SizedBox(
      height: 355, // full stack height
      child: Stack(
        children: [
          // First Part (Main Container)
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 0, top: 10),
            child: Container(
              height: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 220,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.asset(
                        'assets/images/home_page_gif.gif',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),

          // Second Part (Inner Container)
          Positioned(
            top: 225,
            left: 20,   // 👈 increased from 10 → 20
            right: 20,  // 👈 increased from 10 → 20Zz
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // First small card
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/ic_served_points.png',
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Dashboard',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Second small card
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        print("---Pending Complaints---");
                        // PendingComplaintScreen
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const PendingComplaintScreen()));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.shade300, width: 1),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/ic_create_points.png',
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Pending Complaints',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
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
    );
  }
  // widget
  Widget listTile() {
    return Center(
      child: Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide( // 👈 outline border
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                leading: Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(5), // 👈 space between image and container border
                  decoration: BoxDecoration(
                    color: Colors.white, // background color
                    borderRadius: BorderRadius.circular(25), // circular container
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // slightly smaller for inner image
                    child: Image.asset(
                      'assets/images/attendancelist.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: const Text(
                  'Mark Points',
                  style:  const TextStyle(
                      fontFamily: 'Montserrat',
                      // color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.grey.shade400,
                ),
                onTap: () {
                  // Handle tap action
                 // debugPrint("Mark Point !");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MarkPointScreen()));

                  },
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left: 0,right: 0),
                child: Divider(
                  height: 1,
                  color: Colors.grey.shade300,
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                leading: Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.all(5), // 👈 space between image and container border
                  decoration: BoxDecoration(
                    color: Colors.white, // background color
                    borderRadius: BorderRadius.circular(25), // circular container
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // slightly smaller for inner image
                    child: Image.asset(
                      'assets/images/meeting.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: const Text(
                  'Scheduled Points',
                  style:  const TextStyle(
                      fontFamily: 'Montserrat',
                      // color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward_ios,
                  size: 20,
                  color: Colors.grey.shade400,
                ),
                onTap: () {
                  // Handle tap action
                 // debugPrint("-----Schedule Points-----");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ScheduledPointScreen()));

                },
              ),
            ],
          )
      ),
    );
  }
  Widget bottomListCard(int index){
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide( // 👈 outline border
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: SizedBox(
        height: 120,
        width: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image
            SizedBox(
              height: 80,
              width: 80,
              child: Image.asset(
                "assets/images/barger1.png", // replace with your image
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8), // spacing
            // Text
            const Text(
              "Profile",
              style:  const TextStyle(
                  fontFamily: 'Montserrat',
                  // color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

 void getValueFromSharedPreference() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   // iAgencyCode = prefs.getString('iUserTypeCode').toString();
   setState(() {
     sName = prefs.getString('sName').toString();
     sContactNo = prefs.getString('sContactNo').toString();
   });
   print("--Name : --: $sName");
   print("--ContactNo : --: $sContactNo");
 }
  @override
  void initState() {
    // TODO: implement initState
    controller = GifController(vsync: this);
    controller.repeat(period: const Duration(seconds: 2));
    getValueFromSharedPreference();
    usermoduleright();
    super.initState();
  }

  // supervisorBottomList
  usermoduleright() async {
    userModuleRightList = await SuperVisorBottomListRepo().usermoduleright();
    //print(" ----83----xxxxx-> $userModuleRightList");
    debugPrint("----358----xxxxx-> $userModuleRightList", wrapWidth: 1024);
    // print(" ----84--> ${userModuleRightList.length}");
    // print(" ----85--> $userModuleRightList['sActivityName']");
    setState(() {});
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xFF8b2355),
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          backgroundColor: const Color(0xFFD31F76),
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              'GNIDA Officers',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontFamily: 'Montserrat',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.white, // 👈 sets drawer icon color to white
          ),
        ),
        drawer: generalFunction.drawerFunction(context,'$sName','$sContactNo'),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15,left:10),
              child: buildFancyStack(),
            ),
            listTile(),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: Image.asset('assets/images/three_line.png',
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  const Text(
                    'Frequently used Activities',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD31F76), // 👈 custom hex color
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              height: 120, // container height (adjust as needed)
              child: InkWell(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: userModuleRightList.length,
                  itemBuilder: (context, index) {
                    var activity = userModuleRightList[index];
                    String sActivityName = activity['sActivityName'];

                    return Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: InkWell(
                        onTap: (){
                          print("--index ---- : ${userModuleRightList[index]}");
                          var iActivityCode = activity['iActivityCode'];
                          print(" 455 --- $iActivityCode");
                          var sActivityName = activity['sActivityName'];
                          print(sActivityName);
                          if(iActivityCode==6){

                            //  RandomInspection
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DailyActivitytScreenHome()));

                          }else if(iActivityCode==7){
                            // shop Survey
                           // Navigator.push(context, MaterialPageRoute(builder: (context) => const ShopSurvey()));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ShopSurveyHome()));

                          }else if(iActivityCode==8){
                            print("----Gnida Beautification-----");
                           // DnidaBeautification
                           // Navigator.push(context, MaterialPageRoute(builder: (context) => const GnidaBeautification()));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const GnidaBeautificationHome()));
                          }else{
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3 - 16, // 👈 ensures 3 per screen
                          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  '${activity['iImgIcon']}',
                                  width: 30,
                                  height: 30,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  sActivityName,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        )
    );
  }
}

