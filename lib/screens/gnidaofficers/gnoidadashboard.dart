import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:noidaone/screens/dailyActivity.dart' hide MyHomePage;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controllers/supervisorbottomlist.dart';
import '../../components/components.dart';
import '../generalFunction.dart';
import 'package:gif/gif.dart';
import '../gnidabeautification/gnidabeautification.dart';
import '../malbaRequest/malbaRequest.dart';
import '../potholeDetection.dart';
import '../shopSurvey.dart' hide MyHomePage;

class GnoidaOfficersHome extends StatefulWidget {

  const GnoidaOfficersHome({super.key});

  @override
  State<GnoidaOfficersHome> createState() => _GnoidaOfficersHomeState();
}

class _GnoidaOfficersHomeState extends State<GnoidaOfficersHome> with TickerProviderStateMixin {

  GeneralFunction generalFunction = GeneralFunction();
  late GifController controller;
  var sName,sContactNo;

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
                        //  patholeDectionForm// patholeDectionForm

                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => patholeDectionForm(name: "Pothole Dection", iCategoryCode: null,),
                          ),
                        );

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
                                'Pothole Dection',
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
  List userModuleRightList = [];

  @override
  void initState() {
    // TODO: implement initState
    controller = GifController(vsync: this);
    controller.repeat(period: const Duration(seconds: 2));
    usermoduleright();
    getValueFromSharedPreference();
    super.initState();
  }
  // supervisorBottomList
  usermoduleright() async {
    userModuleRightList = await SuperVisorBottomListRepo().usermoduleright();
    debugPrint("----719----xxxxx-> $userModuleRightList", wrapWidth: 1024);
    setState(() {});
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
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
          listTile(context),
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

                        var iActivityCode = activity['iActivityCode'];
                        print("-------AAA -----$iActivityCode");
                        if(iActivityCode==5){
                          print('----$iActivityCode');

                        }else if(iActivityCode==6){
                          //  MyHomePage
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DailyActivitytScreenHome()));

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const DailyActivitytScreen()));

                          print('----$iActivityCode');
                        }else if(iActivityCode==7){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ShopSurveyHome()));
                          print('----$iActivityCode');
                        }else if(iActivityCode==8){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const GnidaBeautificationHome()));
                          print('----$iActivityCode');
                        }else if(iActivityCode==9){
                          //  MalbaRequest
                          print('----$iActivityCode');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MalbaRequestHome()));
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
          SizedBox(height: 10),
        ],
      )
    );
  }
}

