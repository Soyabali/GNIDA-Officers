import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noidaone/Controllers/usercontributionMonthRepo.dart';


class TabPageMonth extends StatefulWidget {
  final Function(String,int,String,int,String,int) onDataReceived;
  const TabPageMonth({Key? key, required this.onDataReceived}) : super(key: key);

  @override
  State<TabPageMonth> createState() => _TabPageState();
}

class _TabPageState extends State<TabPageMonth> {

  // Example function where you might get some data
  void fetchDataAndSendDataToParent(String nameFirst,int pointFirst,String nameSecond,int pointSecond,
      String nameThird,int pointThird)
  {
    // Access the callback function through widget.onDataReceived
    widget.onDataReceived(nameFirst,pointFirst,nameSecond,pointSecond,nameThird,pointThird);
  }


  List<Map<String, dynamic>>? userContributionMonthList;

  userContributionResponse() async {
    userContributionMonthList = await UserContributionMontRepo().userContributionMonth(context);
    print('--29---xxxx------$userContributionMonthList');
    var nameFirst = userContributionMonthList?[0]['sName'].toString();
    var pointFirst = userContributionMonthList?[0]['iEarnedPoints'];
    var nameSecond = userContributionMonthList?[1]['sName'].toString();
    var pointSecond = userContributionMonthList?[1]['iEarnedPoints'];
    var nameThird = userContributionMonthList?[2]['sName'].toString();
    var pointThird = userContributionMonthList?[2]['iEarnedPoints'];
    if(nameFirst!='' && pointFirst!=null && nameSecond!='' && pointSecond!=null && nameThird!=''&& pointThird!=null){
      print('---51----callback fuction call');
      fetchDataAndSendDataToParent(nameFirst!,pointFirst,nameSecond!,pointSecond,nameThird!,pointThird);
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    userContributionResponse();
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
                 // height: 430,
                  height: 600,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 110),
                  child: ListView.builder(
                  itemCount: userContributionMonthList != null ? userContributionMonthList!.length - 3 : 0,
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
                                  userContributionMonthList?[index + 3]['sName'].toString() ?? '',
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
                                      userContributionMonthList?[index + 3]['iEarnedPoints'].toString() ?? '',
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
                  // child: ListView.builder(
                  //   itemCount: userContributionMonthList != null
                  //       ? userContributionMonthList!.length - 3
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
                  //                 userContributionMonthList?[index + 3]['sName'].toString() ?? '',
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
                  //                     userContributionMonthList?[index + 3]['iEarnedPoints'].toString() ?? '',
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
                  //   itemCount: userContributionMonthList != null
                  //       ? userContributionMonthList!.length - 3
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
                  //                   userContributionMonthList?[index + 3]['sName'].toString() ?? '',
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
                  //                       userContributionMonthList?[index + 3]['iEarnedPoints'].toString() ?? '',
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
          )

          // child: ListView(
          //   children: <Widget>[
          //     Padding(
          //         padding:
          //         const EdgeInsets.only(left: 15, right: 5, bottom: 15),
          //         child: Container(
          //           //height: MediaQuery.of(context).size.height,
          //           height: 430,
          //           // height: MediaQuery.of(context).size.height-140,
          //           width: double.infinity,
          //           decoration: BoxDecoration(
          //             // color: Color(0xFFf2f3f5), // Container background color
          //             borderRadius: BorderRadius.circular(20),
          //           ),
          //           child: ListView.builder(
          //               itemCount: userContributionMonthList != null
          //                   ? userContributionMonthList!.length - 3
          //                   : 0,
          //               itemBuilder: (context, index) {
          //                 return Container(
          //                     height: 66,
          //                     child: Padding(
          //                       padding:
          //                       const EdgeInsets.only(top: 8, bottom: 0),
          //                       child: Card(
          //                         child: Column(
          //                           children: [
          //                             Center(
          //                               child: Padding(
          //                                 padding: const EdgeInsets.only(
          //                                     left: 5, top: 15),
          //                                 child: Row(
          //                                   mainAxisAlignment: MainAxisAlignment.start,
          //                                   children: <Widget>[
          //                                     Text(
          //                                       '${index + 4}',
          //                                       style: GoogleFonts.lato(
          //                                         textStyle: const TextStyle(
          //                                           color: Color(0xFF707d83),
          //                                           fontSize: 14.0,
          //                                           letterSpacing: .5,
          //                                           fontWeight: FontWeight.normal,
          //                                         ),
          //                                       ),
          //                                     ),
          //                                     SizedBox(width: 8),
          //                                     const Icon(
          //                                       Icons.person,
          //                                       size: 20,
          //                                       color: Color(0xFF3375af),
          //                                     ),
          //                                     SizedBox(width: 8),
          //                                     // Flexible or Expanded widget for the name text
          //                                     Expanded(
          //                                       child: Text(
          //                                         userContributionMonthList?[index + 3]['sName'].toString() ?? '',
          //                                         overflow: TextOverflow.ellipsis,
          //                                         textAlign: TextAlign.start,
          //                                         style: GoogleFonts.lato(
          //                                           textStyle: const TextStyle(
          //                                             color: Color(0xFF707d83),
          //                                             fontSize: 14.0,
          //                                             letterSpacing: .5,
          //                                             fontWeight: FontWeight.normal,
          //                                           ),
          //                                         ),
          //                                       ),
          //                                     ),
          //                                    // Spacer(),
          //                                     Padding(
          //                                       padding: const EdgeInsets.only(right: 10),
          //                                       child: Row(
          //                                         mainAxisAlignment: MainAxisAlignment.end,
          //                                         children: [
          //                                           Text(
          //                                             userContributionMonthList?[index + 3]['iEarnedPoints'].toString() ?? '',
          //                                             style: GoogleFonts.lato(
          //                                               textStyle: const TextStyle(
          //                                                 color: Color(0xFFad964a),
          //                                                 fontSize: 14.0,
          //                                                 letterSpacing: .5,
          //                                                 fontWeight: FontWeight.normal,
          //                                               ),
          //                                             ),
          //                                           ),
          //                                           SizedBox(width: 8),
          //                                           Text(
          //                                             'Points',
          //                                             style: GoogleFonts.lato(
          //                                               textStyle: const TextStyle(
          //                                                 color: Color(0xFFad964a),
          //                                                 fontSize: 14.0,
          //                                                 letterSpacing: .5,
          //                                                 fontWeight: FontWeight.normal,
          //                                               ),
          //                                             ),
          //                                           ),
          //                                         ],
          //                                       ),
          //                                     ),
          //                                   ],
          //                                 )
          //                                 ,
          //                                 // child: Row(
          //                                 //   mainAxisAlignment:
          //                                 //       MainAxisAlignment.start,
          //                                 //   children: <Widget>[
          //                                 //     Text(
          //                                 //       '${index + 4}',
          //                                 //       style: GoogleFonts.lato(
          //                                 //         textStyle: const TextStyle(
          //                                 //             color: Color(0xFF707d83),
          //                                 //             fontSize: 14.0,
          //                                 //             letterSpacing: .5,
          //                                 //             fontWeight:
          //                                 //                 FontWeight.normal),
          //                                 //       ),
          //                                 //     ),
          //                                 //     SizedBox(width: 8),
          //                                 //     const Icon(
          //                                 //       Icons.person,
          //                                 //       size: 20,
          //                                 //       color: Color(0xFF3375af),
          //                                 //     ),
          //                                 //     SizedBox(width: 8),
          //                                 //     // textName
          //                                 //     Text(
          //                                 //       userContributionTodayList?[
          //                                 //                   index + 3]['sName']
          //                                 //               .toString() ??
          //                                 //           '',
          //                                 //       overflow: TextOverflow.clip,
          //                                 //       textAlign: TextAlign.start,
          //                                 //       style: GoogleFonts.lato(
          //                                 //         textStyle: const TextStyle(
          //                                 //             color: Color(0xFF707d83),
          //                                 //             fontSize: 14.0,
          //                                 //             letterSpacing: .5,
          //                                 //             fontWeight:
          //                                 //                 FontWeight.normal),
          //                                 //       ),
          //                                 //     ),
          //                                 //     Spacer(),
          //                                 //     Row(
          //                                 //       mainAxisAlignment:
          //                                 //           MainAxisAlignment.end,
          //                                 //       children: [
          //                                 //         Text(
          //                                 //           userContributionTodayList?[
          //                                 //                           index + 3][
          //                                 //                       'iEarnedPoints']
          //                                 //                   .toString() ??
          //                                 //               '',
          //                                 //           style: GoogleFonts.lato(
          //                                 //             textStyle:
          //                                 //                 const TextStyle(
          //                                 //                     color: Color(
          //                                 //                         0xFFad964a),
          //                                 //                     fontSize: 14.0,
          //                                 //                     letterSpacing: .5,
          //                                 //                     fontWeight:
          //                                 //                         FontWeight
          //                                 //                             .normal),
          //                                 //           ),
          //                                 //         ),
          //                                 //         SizedBox(width: 8),
          //                                 //         Text(
          //                                 //           'Points',
          //                                 //           style: GoogleFonts.lato(
          //                                 //             textStyle:
          //                                 //                 const TextStyle(
          //                                 //                     color: Color(
          //                                 //                         0xFFad964a),
          //                                 //                     fontSize: 14.0,
          //                                 //                     letterSpacing: .5,
          //                                 //                     fontWeight:
          //                                 //                         FontWeight
          //                                 //                             .normal),
          //                                 //           ),
          //                                 //         ),
          //                                 //       ],
          //                                 //     ),
          //                                 //   ],
          //                                 // ),
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ));
          //               }),
          //         ))
          //   ],
          // ),


          // child: ListView(
          //   children: <Widget>[
          //     SingleChildScrollView(
          //       child: Padding(
          //           padding: const EdgeInsets.only(left: 15, right: 5,bottom: 15),
          //           child: Container(
          //             //height: MediaQuery.of(context).size.height,
          //             height: 330,
          //             width: double.infinity,
          //             decoration: BoxDecoration(
          //               //color: Color(0xFFf2f3f5), // Container background color
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //             child: ListView.builder(
          //                 itemCount: userContributionMonthList != null ? userContributionMonthList!.length-3 : 0,
          //                 itemBuilder: (context, index) {
          //                   return Container(
          //                       height: 66,
          //                       child: Padding(
          //                         padding: const EdgeInsets.only(top: 8, bottom: 0),
          //                         child: Card(
          //                           child:  Column(
          //                             children: [
          //                               Center(
          //                                 child: Row(
          //                                   mainAxisAlignment: MainAxisAlignment.start,
          //                                   crossAxisAlignment: CrossAxisAlignment.start,
          //                                   children: <Widget>[
          //                                     Padding(
          //                                       padding: const EdgeInsets.only(left: 5,top: 15),
          //                                       child: Row(
          //                                         mainAxisAlignment: MainAxisAlignment.start,
          //                                         crossAxisAlignment: CrossAxisAlignment.start,
          //                                         children: [
          //                                           Text(
          //                                             '${index + 4}',
          //                                             style:GoogleFonts.lato(
          //                                               textStyle: const TextStyle(
          //                                                   color:Color(0xFF707d83),
          //                                                   fontSize: 14.0,
          //                                                   letterSpacing: .5,
          //                                                   fontWeight: FontWeight.normal
          //                                               ),
          //                                             )
          //                                             // style: const TextStyle(
          //                                             //   fontFamily: 'Montserrat',
          //                                             //   // color: Colors.white,
          //                                             //   color: Color(0xFF707d83),
          //                                             //   fontSize: 16.0,
          //                                             //   fontWeight: FontWeight.bold),
          //                                           ),
          //                                           // First TextView
          //                                           const SizedBox(width: 8),
          //                                           // icon
          //                                           const Icon(Icons.person, size: 20,
          //                                             color: Color(0xFF3375af),),
          //                                         ],
          //                                       ),
          //                                     ),
          //                                     const SizedBox(width: 8),
          //                                     Padding(
          //                                       padding: const EdgeInsets.only(top: 10),
          //                                       child: Column(
          //                                         crossAxisAlignment: CrossAxisAlignment.start,
          //                                         children: [
          //                                           Container(
          //                                             width: MediaQuery.of(context).size.width - 125,
          //                                             child:  Text(userContributionMonthList?[index + 3]['sName'].toString() ?? '',
          //                                               overflow: TextOverflow.clip,
          //                                               textAlign: TextAlign.start,
          //                                               style: GoogleFonts.lato(
          //                                                 textStyle: const TextStyle(
          //                                                     color:Color(0xFF707d83),
          //                                                     fontSize: 14.0,
          //                                                     letterSpacing: .5,
          //                                                     fontWeight: FontWeight.normal
          //                                                 ),
          //                                               ),
          //                                             ),
          //                                           ),
          //                                         ],
          //                                       ),
          //                                     ),
          //                                     //Spacer(),
          //                                     // To push the last Text to the rightmost
          //                                     Padding(
          //                                       padding: const EdgeInsets.only(right: 0,top: 10),
          //                                       child: Text(userContributionMonthList?[index +
          //                                           3]['iEarnedPoints'].toString() ??
          //                                           '',
          //                                           style:  GoogleFonts.lato(
          //                                             textStyle: const TextStyle(
          //                                                 color:Color(0xFFad964a),
          //                                                 fontSize: 14.0,
          //                                                 letterSpacing: .5,
          //                                                 fontWeight: FontWeight.normal
          //                                             ),
          //                                           ),),)
          //                                     // Last TextView
          //                                   ],
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                       ));
          //
          //
          //                 }
          //             ),
          //           )),
          //     )
          //   ],
          // ),
        ),
      ),
      // body: ListView(
      //   children: <Widget>[
      //     Padding(
      //         padding: const EdgeInsets.only(left: 15,right: 15),
      //         child: Container(
      //         //  height: MediaQuery.of(context).size.height,
      //           height: 330,
      //           width: double.infinity,
      //           decoration: BoxDecoration(
      //             color: Color(0xFFf2f3f5), // Container background color
      //             borderRadius: BorderRadius.circular(20),
      //           ),
      //           child:ListView.builder(
      //               itemCount: userContributionMonthList != null ? userContributionMonthList!.length - 3 : 0,
      //               itemBuilder: (context, index) {
      //                 return Container(
      //                   height: 60,
      //                   child: Padding(
      //                     padding: const EdgeInsets.only(top: 8,bottom: 0),
      //                     child: Card(
      //                       //elevation: 8,
      //                       child: Padding(
      //                         padding: EdgeInsets.only(left: 10.0, right: 10.0),
      //                         child: Row(
      //                           mainAxisAlignment: MainAxisAlignment.center,
      //                           children: <Widget>[
      //                             Text('${index+4}', style: const TextStyle(
      //                                 fontFamily: 'Montserrat',
      //                                 // color: Colors.white,
      //                                 color: Color(0xFF707d83),
      //                                 fontSize: 16.0,
      //                                 fontWeight: FontWeight.bold),),
      //                             // First TextView
      //                             const SizedBox(width: 8),
      //                             // icon
      //                             const Icon(Icons.person, size: 20, color: Color(0xFF3375af),),
      //                             // Admin icon
      //                             const SizedBox(width: 8),
      //                             Text(userContributionMonthList?[index+3]['sName'].toString() ?? '',
      //                               style: const TextStyle(
      //                                   fontFamily: 'Montserrat',
      //                                   color: Color(0xFF707d83),
      //                                   fontSize: 14.0,
      //                                   fontWeight: FontWeight.bold),),
      //                             // Second TextView
      //                             Spacer(),
      //                             // To push the last Text to the rightmost
      //                             Text(userContributionMonthList?[index+3]['iEarnedPoints'].toString() ??
      //                                 '',
      //                                 style: const TextStyle(
      //                                     fontFamily: 'Montserrat',
      //                                     color: Color(0xFFad964a),
      //                                     //color: Colors.white,
      //                                     fontSize: 16.0,
      //                                     fontWeight: FontWeight.bold)),
      //                             // Last TextView
      //                           ],
      //                         ),
      //                       ),
      //
      //                     ),
      //                   ),
      //                 );
      //               }
      //           ),
      //         ))
      //   ],
      // ),
    );
  }
}


