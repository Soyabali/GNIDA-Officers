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
       print('--36---xxxx------$userContributionTodayList'); //sName
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
         body: Padding(
           padding: const EdgeInsets.only(bottom: 0),
           child: Container(
             child: ListView(
               children: <Widget>[
                 Padding(
                     padding: const EdgeInsets.only(left: 15, right: 5,bottom: 15),
                     child: Container(
                       //height: MediaQuery.of(context).size.height,
                       height: 330,
                       width: double.infinity,
                       decoration: BoxDecoration(
                         color: Color(0xFFf2f3f5), // Container background color
                         borderRadius: BorderRadius.circular(20),
                       ),
                       child: ListView.builder(
                          itemCount: userContributionTodayList != null ? userContributionTodayList!.length-3 : 0,
                           itemBuilder: (context, index) {
                             return Container(
                               height: 66,
                               child: Padding(
                                 padding: const EdgeInsets.only(top: 8, bottom: 0),
                                 child: Card(
                                   child:  Column(
                                       children: [
                                         Center(
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             children: <Widget>[
                                               Padding(
                                                 padding: const EdgeInsets.only(left: 5,top: 15),
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   children: [
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
                                                   ],
                                                 ),
                                               ),
                                               const SizedBox(width: 8),
                                               Padding(
                                                 padding: const EdgeInsets.only(top: 10),
                                                 child: Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     Container(
                                                        width: MediaQuery.of(context).size.width - 125,
                                                       child:  Text(userContributionTodayList?[index + 3]['sName'].toString() ?? '',
                                                         overflow: TextOverflow.clip,
                                                         textAlign: TextAlign.start,
                                                         style: const TextStyle(
                                                             fontFamily: 'Montserrat',
                                                             color: Color(0xFF707d83),
                                                             fontSize: 14.0,
                                                             fontWeight: FontWeight.bold),),
                                                     ),
                                                   ],
                                                 ),
                                               ),
                                               //Spacer(),
                                               // To push the last Text to the rightmost
                                               Padding(
                                                 padding: const EdgeInsets.only(right: 0,top: 10),
                                                 child: Text(userContributionTodayList?[index +
                                                     3]['iEarnedPoints'].toString() ??
                                                     '',
                                                     style: const TextStyle(
                                                         fontFamily: 'Montserrat',
                                                         color: Color(0xFFad964a),
                                                         //color: Colors.white,
                                                         fontSize: 16.0,
                                                         fontWeight: FontWeight.bold)),
                                               ),
                                               // Last TextView
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ));


                           }
                       ),
                     ))
               ],
             ),
           ),
         ),
       );
     }
   }


