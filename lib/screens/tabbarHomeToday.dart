import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controllers/userContributionRepo.dart';
import '../Controllers/usercontributionTodayRepo.dart';
import 'package:google_fonts/google_fonts.dart';

class TabTodayPage extends StatefulWidget {
  final Function(String, int, String, int, String, int) onDataReceived;

  const TabTodayPage({Key? key, required this.onDataReceived})
      : super(key: key);

  @override
  State<TabTodayPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabTodayPage> {

  var nameFirst, pointFirst, nameSecond, pointSecond, nameThird, pointThird;

   // fetch and call back function
  void fetchDataAndSendDataToParent() async {
    // Your data fetching code here
    // Once data is fetched, call the callback function
    widget.onDataReceived(
        nameFirst, pointFirst, nameSecond, pointSecond, nameThird, pointThird);
  }

  // var nameFirst;
  List<Map<String, dynamic>>? userContributionTodayList;

  userContributionResponse() async {
    userContributionTodayList =
        await UserContributionTodayRepo().userContributionTodat(context);
    print('--36---xxxx------$userContributionTodayList'); //sName
    //  print('--41---xxxx------$userContributionTodayList[0]['']');
    nameFirst = userContributionTodayList?[0]['sName'].toString();
    pointFirst = userContributionTodayList?[0]['iEarnedPoints'];
    nameSecond = userContributionTodayList?[1]['sName'].toString();
    pointSecond = userContributionTodayList?[1]['iEarnedPoints'];
    nameThird = userContributionTodayList?[2]['sName'].toString();
    pointThird = userContributionTodayList?[2]['iEarnedPoints'];
    print('---48----NameFirst----$nameFirst');
    // to store value in a SharedPreference
    if (nameFirst != '' &&
        pointFirst != null &&
        nameSecond != '' &&
        pointSecond != null &&
        nameThird != '' &&
        pointThird != null) {
      print('---51----callback fuction call');
      //  fetchDataAndSendDataToParent(nameFirst,pointFirst,nameSecond!,pointSecond,nameThird!,pointThird);
      fetchDataAndSendDataToParent();
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nameFirst', nameFirst!);
    prefs.setInt('pointFirst', pointFirst!);
    // if(nameFirst!=null){
    //   sendData(nameFirst);
    // }
    print('-----------44---xxxxxxxxxx-$nameFirst');
    print('-----------45---xxxxxxxxxx-$pointFirst');
    String dataToSend = 'Data from TodayClass';
    // Call the callback function to send data to homePage
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    userContributionResponse();
    fetchDataAndSendDataToParent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Container(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 5, bottom: 15),
                child: Container(
                  height: 430,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                   child: Padding(
                     padding: const EdgeInsets.only(bottom: 110),
                     child: ListView.builder(
                       itemCount: userContributionTodayList != null ? userContributionTodayList!.length - 3 : 0,
                       itemBuilder: (context, index) {
                         return Container(
                           color: Colors.white,
                           padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                           child: Container(
                             height: 48,
                            // color: Colors.white,
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(10), // rounded corners
                               border: Border.all(
                                 color: Colors.grey, // outline color
                                 width: 1, // outline width
                               ),
                             ),
                             padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: <Widget>
                               [
                                 Text(
                                   '${index + 4} .',
                                   style: GoogleFonts.lato(
                                     textStyle: const TextStyle(
                                       color: Color(0xFF707d83),
                                       fontSize: 14.0,
                                       letterSpacing: .5,
                                       fontWeight: FontWeight.normal,
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 8),
                                 const Icon(
                                   Icons.person,
                                   size: 20,
                                   color: Color(0xFF3375af),
                                 ),
                                 SizedBox(width: 8),
                                 Expanded(
                                   child: Text(
                                     userContributionTodayList?[index + 3]['sName'].toString() ?? '',
                                     overflow: TextOverflow.ellipsis,
                                     textAlign: TextAlign.start,
                                     style: GoogleFonts.lato(
                                       textStyle: const TextStyle(
                                         color: Color(0xFF707d83),
                                         fontSize: 14.0,
                                         letterSpacing: .5,
                                         fontWeight: FontWeight.normal,
                                       ),
                                     ),
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.only(right: 10),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children: [
                                       Text(
                                         userContributionTodayList?[index + 3]['iEarnedPoints'].toString() ?? '',
                                         style: GoogleFonts.lato(
                                           textStyle: const TextStyle(
                                             color: Color(0xFFad964a),
                                             fontSize: 14.0,
                                             letterSpacing: .5,
                                             fontWeight: FontWeight.normal,
                                           ),
                                         ),
                                       ),
                                       SizedBox(width: 8),
                                       Text(
                                         'Points',
                                         style: GoogleFonts.lato(
                                           textStyle: const TextStyle(
                                             color: Color(0xFFad964a),
                                             fontSize: 14.0,
                                             letterSpacing: .5,
                                             fontWeight: FontWeight.normal,
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         );
                       },
                     ),
                   ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
