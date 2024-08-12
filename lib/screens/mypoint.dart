import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controllers/myPointRepo.dart';
import '../resources/app_text_style.dart';
import 'generalFunction.dart';

class Mypoint extends StatelessWidget {
  const Mypoint({super.key});

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
      home: MyPointPage(),
    );
  }
}

class MyPointPage extends StatefulWidget {
  const MyPointPage({super.key});

  @override
  State<MyPointPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyPointPage> {
  List<Map<String, dynamic>>? myPoinList;
  var totalPoint;
  String? sName, sContactNo;
  GeneralFunction generalFunction = GeneralFunction();

  // GET REPO FUNCTION
  getMyPointResponse() async {
    myPoinList = await MyPointTypeRepo().mypointType(context);
    print('-----45---$myPoinList');
    totalPoint = myPoinList?[0]['iTotal'].toString();
    setState(() {});
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
  void initState() {
    // TODO: implement initState
    getMyPointResponse();
    getlocalvalue();
    super.initState();
  }
  //OnWillPopScope
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
  //
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: Colors.white,
            appBar: generalFunction.appbarFunction("My Points"),
          // appBar: AppBar(
          //   backgroundColor: Color(0xFF255899),
          //   title: const Text(
          //     'My Points',
          //     style: TextStyle(
          //         fontFamily: 'Montserrat',
          //         color: Colors.white,
          //         fontSize: 18.0,
          //         fontWeight: FontWeight.bold),
          //   ),
          // ),
          // Drawer
          drawer: generalFunction.drawerFunction(context, '$sName', '$sContactNo'),

          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 10,
                  color: Colors.white,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white, width: 0.2),
                    // Outline border
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2, // Flex factor 1/3
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.justify,
                                      text: const TextSpan(
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.grey,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  "Hi,Thanks for your contribution towards smarter Noida! Based on your activities on"),
                                          TextSpan(
                                            text: " Noida One App",
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Colors.blue,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          TextSpan(
                                              text:
                                                  ' You have been rewarded with the following points as \n'
                                                  'described below. Wish you luck to archieve more exciting rewards .'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 1, // Flex factor 2/3
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/images/step4.jpg',
                                      // Replace with your asset image path
                                      width: double.infinity, // Take full width of column
                                      height: 100, // Adjust image height as needed
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Points :',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Text('${totalPoint ?? 0}',
                                style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height,
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
                             child: ListView.builder(
                               itemCount: myPoinList != null ? myPoinList!.length : 0,
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
                                           '${index + 1} ',
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
                                           Icons.calendar_month,
                                           size: 20,
                                           color: Color(0xFF3375af),
                                         ),
                                         SizedBox(width: 8),
                                         Expanded(
                                           child: Text(
                                             myPoinList?[index]['dMonth'].toString() ?? '',
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
                                                 myPoinList?[index]['iEarnedPoint'].toString() ?? '',
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
                             // child: ListView.builder(
                             //   itemCount: userContributionList != null
                             //       ? userContributionList!.length - 3
                             //       : 0,
                             //   itemBuilder: (context, index) {
                             //     return Card(
                             //       shape: RoundedRectangleBorder(
                             //         borderRadius: BorderRadius.circular(15.0),
                             //         side: BorderSide(color: Colors.grey.shade300, width: 1),
                             //       ),
                             //       elevation: 2,
                             //       color: Colors.white,
                             //       child: Container(
                             //         height: 48,
                             //         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                             //         child: Row(
                             //           mainAxisAlignment: MainAxisAlignment.start,
                             //           children: <Widget>[
                             //             Text(
                             //               '${index + 4} .',
                             //               style: GoogleFonts.lato(
                             //                 textStyle: const TextStyle(
                             //                   color: Color(0xFF707d83),
                             //                   fontSize: 14.0,
                             //                   letterSpacing: .5,
                             //                   fontWeight: FontWeight.normal,
                             //                 ),
                             //               ),
                             //             ),
                             //             SizedBox(width: 8),
                             //             const Icon(
                             //               Icons.person,
                             //               size: 20,
                             //               color: Color(0xFF3375af),
                             //             ),
                             //             SizedBox(width: 8),
                             //             Expanded(
                             //               child: Text(
                             //                 userContributionList?[index + 3]['sName'].toString() ?? '',
                             //                 overflow: TextOverflow.ellipsis,
                             //                 textAlign: TextAlign.start,
                             //                 style: GoogleFonts.lato(
                             //                   textStyle: const TextStyle(
                             //                     color: Color(0xFF707d83),
                             //                     fontSize: 14.0,
                             //                     letterSpacing: .5,
                             //                     fontWeight: FontWeight.normal,
                             //                   ),
                             //                 ),
                             //               ),
                             //             ),
                             //             Padding(
                             //               padding: const EdgeInsets.only(right: 10),
                             //               child: Row(
                             //                 mainAxisAlignment: MainAxisAlignment.end,
                             //                 children: [
                             //                   Text(
                             //                     userContributionList?[index + 3]['iEarnedPoints'].toString() ?? '',
                             //                     style: GoogleFonts.lato(
                             //                       textStyle: const TextStyle(
                             //                         color: Color(0xFFad964a),
                             //                         fontSize: 14.0,
                             //                         letterSpacing: .5,
                             //                         fontWeight: FontWeight.normal,
                             //                       ),
                             //                     ),
                             //                   ),
                             //                   SizedBox(width: 8),
                             //                   Text(
                             //                     'Points',
                             //                     style: GoogleFonts.lato(
                             //                       textStyle: const TextStyle(
                             //                         color: Color(0xFFad964a),
                             //                         fontSize: 14.0,
                             //                         letterSpacing: .5,
                             //                         fontWeight: FontWeight.normal,
                             //                       ),
                             //                     ),
                             //                   ),
                             //                 ],
                             //               ),
                             //             ),
                             //           ],
                             //         ),
                             //       ),
                             //     );
                             //   },
                             // ),


                             // child: ListView.builder(
                             //   itemCount: userContributionList != null
                             //       ? userContributionList!.length - 3
                             //       : 0,
                             //   itemBuilder: (context, index) {
                             //     return Padding(
                             //       padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                             //       child: Card(
                             //         shape: RoundedRectangleBorder(
                             //           borderRadius: BorderRadius.circular(15.0),
                             //           side: BorderSide(color: Colors.grey.shade300, width: 1),
                             //         ),
                             //         elevation: 2,
                             //         color: Colors.white,
                             //         child: Container(
                             //           height: 48,
                             //           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                             //           child: Row(
                             //             mainAxisAlignment: MainAxisAlignment.start,
                             //             children: <Widget>[
                             //               Text(
                             //                 '${index + 4} .',
                             //                 style: GoogleFonts.lato(
                             //                   textStyle: const TextStyle(
                             //                     color: Color(0xFF707d83),
                             //                     fontSize: 14.0,
                             //                     letterSpacing: .5,
                             //                     fontWeight: FontWeight.normal,
                             //                   ),
                             //                 ),
                             //               ),
                             //               SizedBox(width: 8),
                             //               const Icon(
                             //                 Icons.person,
                             //                 size: 20,
                             //                 color: Color(0xFF3375af),
                             //               ),
                             //               SizedBox(width: 8),
                             //               Expanded(
                             //                 child: Text(
                             //                   userContributionList?[index + 3]['sName'].toString() ?? '',
                             //                   overflow: TextOverflow.ellipsis,
                             //                   textAlign: TextAlign.start,
                             //                   style: GoogleFonts.lato(
                             //                     textStyle: const TextStyle(
                             //                       color: Color(0xFF707d83),
                             //                       fontSize: 14.0,
                             //                       letterSpacing: .5,
                             //                       fontWeight: FontWeight.normal,
                             //                     ),
                             //                   ),
                             //                 ),
                             //               ),
                             //               Padding(
                             //                 padding: const EdgeInsets.only(right: 10),
                             //                 child: Row(
                             //                   mainAxisAlignment: MainAxisAlignment.end,
                             //                   children: [
                             //                     Text(
                             //                       userContributionList?[index + 3]['iEarnedPoints'].toString() ?? '',
                             //                       style: GoogleFonts.lato(
                             //                         textStyle: const TextStyle(
                             //                           color: Color(0xFFad964a),
                             //                           fontSize: 14.0,
                             //                           letterSpacing: .5,
                             //                           fontWeight: FontWeight.normal,
                             //                         ),
                             //                       ),
                             //                     ),
                             //                     SizedBox(width: 8),
                             //                     Text(
                             //                       'Points',
                             //                       style: GoogleFonts.lato(
                             //                         textStyle: const TextStyle(
                             //                           color: Color(0xFFad964a),
                             //                           fontSize: 14.0,
                             //                           letterSpacing: .5,
                             //                           fontWeight: FontWeight.normal,
                             //                         ),
                             //                       ),
                             //                     ),
                             //                   ],
                             //                 ),
                             //               ),
                             //             ],
                             //           ),
                             //         ),
                             //       ),
                             //     );
                             //   },
                             // ),
                           ),
                         ),
                       ],
                     ),
                //     child: ListView(
                //   children: <Widget>[
                //     Padding(
                //       padding:
                //           const EdgeInsets.only(left: 15, right: 5, bottom: 15),
                //       child: Container(
                //         height: 430,
                //         width: double.infinity,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(20),
                //         ),
                //         child: ListView.builder(
                //           itemCount: myPoinList != null ? myPoinList!.length : 0,
                //           itemBuilder: (context, index) {
                //             return Card(
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(15.0),
                //                 side: BorderSide(color: Colors.grey.shade300, width: 1),
                //               ),
                //               elevation: 2,
                //               color: Colors.white,
                //               child: Container(
                //                 height: 48,
                //                 padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                //                 child: Row(
                //                   mainAxisAlignment: MainAxisAlignment.start,
                //                   children: <Widget>[
                //                     Text(
                //                       '${index + 1} .',
                //                       style: GoogleFonts.lato(
                //                         textStyle: const TextStyle(
                //                           color: Color(0xFF707d83),
                //                           fontSize: 14.0,
                //                           letterSpacing: .5,
                //                           fontWeight: FontWeight.normal,
                //                         ),
                //                       ),
                //                     ),
                //                     SizedBox(width: 8),
                //                     const Icon(
                //                       Icons.calendar_month,
                //                       size: 20,
                //                       color: Color(0xFF3375af),
                //                     ),
                //                     SizedBox(width: 8),
                //                     Expanded(
                //                       child: Text(
                //                         myPoinList?[index]['dMonth'].toString() ?? '',
                //                         overflow: TextOverflow.ellipsis,
                //                         textAlign: TextAlign.start,
                //                         style: GoogleFonts.lato(
                //                           textStyle: const TextStyle(
                //                             color: Color(0xFF707d83),
                //                             fontSize: 14.0,
                //                             letterSpacing: .5,
                //                             fontWeight: FontWeight.normal,
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                     Padding(
                //                       padding: const EdgeInsets.only(right: 10),
                //                       child: Row(
                //                         mainAxisAlignment: MainAxisAlignment.end,
                //                         children: [
                //                           Text(
                //                             myPoinList?[index]['iEarnedPoint'].toString() ?? '',
                //                             style: GoogleFonts.lato(
                //                               textStyle: const TextStyle(
                //                                 color: Color(0xFFad964a),
                //                                 fontSize: 14.0,
                //                                 letterSpacing: .5,
                //                                 fontWeight: FontWeight.normal,
                //                               ),
                //                             ),
                //                           ),
                //                           SizedBox(width: 8),
                //                           Text(
                //                             'Points',
                //                             style: GoogleFonts.lato(
                //                               textStyle: const TextStyle(
                //                                 color: Color(0xFFad964a),
                //                                 fontSize: 14.0,
                //                                 letterSpacing: .5,
                //                                 fontWeight: FontWeight.normal,
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //
                //
                //         // child: ListView.builder(
                //         //   itemCount: myPoinList != null ? myPoinList!.length : 0,
                //         //   itemBuilder: (context, index) {
                //         //     return Padding(
                //         //       padding: const EdgeInsets.symmetric(
                //         //           vertical: 4.0, horizontal: 8.0),
                //         //       child: Card(
                //         //         shape: RoundedRectangleBorder(
                //         //           borderRadius: BorderRadius.circular(15.0),
                //         //           side: BorderSide(
                //         //               color: Colors.grey.shade300, width: 1),
                //         //         ),
                //         //         elevation: 2,
                //         //         color: Colors.white,
                //         //         child: Container(
                //         //           height: 48,
                //         //           padding: const EdgeInsets.symmetric(
                //         //               vertical: 8.0, horizontal: 10.0),
                //         //           child: Row(
                //         //             mainAxisAlignment: MainAxisAlignment.start,
                //         //             children: <Widget>[
                //         //               Text(
                //         //                 '${index+1} .',
                //         //                 style: GoogleFonts.lato(
                //         //                   textStyle: const TextStyle(
                //         //                     color: Color(0xFF707d83),
                //         //                     fontSize: 14.0,
                //         //                     letterSpacing: .5,
                //         //                     fontWeight: FontWeight.normal,
                //         //                   ),
                //         //                 ),
                //         //               ),
                //         //               SizedBox(width: 8),
                //         //               const Icon(
                //         //                 Icons.calendar_month,
                //         //                 size: 20,
                //         //                 color: Color(0xFF3375af),
                //         //               ),
                //         //               SizedBox(width: 8),
                //         //               Expanded(
                //         //                 child: Text(
                //         //                   myPoinList?[index]['dMonth'].toString() ?? '',
                //         //                   overflow: TextOverflow.ellipsis,
                //         //                   textAlign: TextAlign.start,
                //         //                   style: GoogleFonts.lato(
                //         //                     textStyle: const TextStyle(
                //         //                       color: Color(0xFF707d83),
                //         //                       fontSize: 14.0,
                //         //                       letterSpacing: .5,
                //         //                       fontWeight: FontWeight.normal,
                //         //                     ),
                //         //                   ),
                //         //                 ),
                //         //               ),
                //         //               Padding(
                //         //                 padding: const EdgeInsets.only(right: 10),
                //         //                 child: Row(
                //         //                   mainAxisAlignment:
                //         //                       MainAxisAlignment.end,
                //         //                   children: [
                //         //                     Text(
                //         //                       myPoinList?[index]['iEarnedPoint'].toString() ?? '',
                //         //                       style: GoogleFonts.lato(
                //         //                         textStyle: const TextStyle(
                //         //                           color: Color(0xFFad964a),
                //         //                           fontSize: 14.0,
                //         //                           letterSpacing: .5,
                //         //                           fontWeight: FontWeight.normal,
                //         //                         ),
                //         //                       ),
                //         //                     ),
                //         //                     SizedBox(width: 8),
                //         //                     Text(
                //         //                       'Points',
                //         //                       style: GoogleFonts.lato(
                //         //                         textStyle: const TextStyle(
                //         //                           color: Color(0xFFad964a),
                //         //                           fontSize: 14.0,
                //         //                           letterSpacing: .5,
                //         //                           fontWeight: FontWeight.normal,
                //         //                         ),
                //         //                       ),
                //         //                     ),
                //         //                   ],
                //         //                 ),
                //         //               ),
                //         //             ],
                //         //           ),
                //         //         ),
                //         //       ),
                //         //     );
                //         //   },
                //         // ),
                //       ),
                //     ),
                //   ],
                // )
                ),
              )
            ],
          )


      ),
    );
  }
}
