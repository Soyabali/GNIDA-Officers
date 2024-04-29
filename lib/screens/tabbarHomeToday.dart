import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controllers/userContributionRepo.dart';
import '../Controllers/usercontributionTodayRepo.dart';

class TabBarHomeToday extends StatelessWidget {

  final Function(String) sendData;
  const TabBarHomeToday({super.key, required this.sendData});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabTodayPage(),
    );
  }
}

class TabTodayPage extends StatefulWidget {
  const TabTodayPage({Key? key}) : super(key: key);

  @override
  State<TabTodayPage> createState() => _TabPageState();
}

 class _TabPageState extends State<TabTodayPage> {

  var nameFirst;
     List<Map<String, dynamic>>? userContributionTodayList;

     userContributionResponse() async {
       userContributionTodayList =
       await UserContributionTodayRepo().userContributionTodat(context);
       print('--41---xxxx------$userContributionTodayList'); //sName
       //  print('--41---xxxx------$userContributionTodayList[0]['']');
       var nameFirst = userContributionTodayList?[0]['sName'].toString();
       var pointFirst = userContributionTodayList?[0]['iEarnedPoints'];
       // to store value in a SharedPreference

       SharedPreferences prefs = await SharedPreferences.getInstance();
       prefs.setString('nameFirst',nameFirst!);
       prefs.setInt('pointFirst',pointFirst!);
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
       super.initState();
      // sendData("Suaib Ali");
     }

     @override
     Widget build(BuildContext context) {
       return Scaffold(

         body: ListView(
           children: <Widget>[
             Padding(
                 padding: const EdgeInsets.only(left: 15, right: 15),
                 child: Container(
                   height: MediaQuery.of(context).size.height,
                   width: double.infinity,
                   decoration: BoxDecoration(
                     color: Color(0xFFf2f3f5), // Container background color
                     borderRadius: BorderRadius.circular(20),
                   ),
                   child: ListView.builder(
                       itemCount: userContributionTodayList != null ? userContributionTodayList!.length - 3 : 0,
                       itemBuilder: (context, index) {
                         return Container(
                           height: 60,
                           child: Padding(
                             padding: const EdgeInsets.only(top: 8, bottom: 0),
                             child: Card(
                               elevation: 8,
                               child: Padding(
                                 padding: EdgeInsets.only(
                                     left: 10.0, right: 10.0),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: <Widget>[
                                     Text(
                                       '${index + 4}', style: const TextStyle(
                                         fontFamily: 'Montserrat',
                                         // color: Colors.white,
                                         color: Color(0xFF707d83),
                                         fontSize: 16.0,
                                         fontWeight: FontWeight.bold),),
                                     // First TextView
                                     const SizedBox(width: 8),
                                     // icon
                                     const Icon(Icons.person, size: 20,
                                       color: Color(0xFF3375af),),
                                     // Admin icon
                                     const SizedBox(width: 8),
                                     Text(userContributionTodayList?[index + 3]['sName'].toString() ?? '',
                                       style: const TextStyle(
                                           fontFamily: 'Montserrat',
                                           color: Color(0xFF707d83),
                                           fontSize: 14.0,
                                           fontWeight: FontWeight.bold),),
                                     // Second TextView
                                     Spacer(),
                                     // To push the last Text to the rightmost
                                     Text(userContributionTodayList?[index +
                                         3]['iEarnedPoints'].toString() ??
                                         '',
                                         style: const TextStyle(
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
                   ),
                 ))
           ],
         ),
       );
     }
   }


