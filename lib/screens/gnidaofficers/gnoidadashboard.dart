import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import '../../components/components.dart';
import '../generalFunction.dart';
import 'package:gif/gif.dart';

class GnoidaOfficersHome extends StatefulWidget {
  const GnoidaOfficersHome({super.key});

  @override
  State<GnoidaOfficersHome> createState() => _GnoidaOfficersHomeState();
}

class _GnoidaOfficersHomeState extends State<GnoidaOfficersHome> with TickerProviderStateMixin {

  GeneralFunction generalFunction = GeneralFunction();
  late GifController controller;

  // create a function to draw a ui
  Widget buildFancyStack() {
    return SizedBox(
      height: 355, // full stack height
      child: Stack(
        children: [
          // First Part (Main Container)
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 0, top: 5),
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
            right: 20,  // 👈 increased from 10 → 20
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
                              'Profile',
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
                              'Attendance',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget buildFancyStack() {
  //   return SizedBox(
  //     height: 330, // full stack height
  //     child: Stack(
  //       children: [
  //         // First Part (Main Container)
  //         Padding(
  //           padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
  //           child: Container(
  //             height: 280,
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(8),
  //               border: Border.all(
  //                 color: Colors.grey.shade300,
  //                 width: 2,
  //               ),
  //             ),
  //             child: Column(
  //               children: [
  //                 SizedBox(
  //                   height: 220, // GIF height
  //                   child: ClipRRect(
  //                     borderRadius: const BorderRadius.only(
  //                       topLeft: Radius.circular(12),
  //                       topRight: Radius.circular(12),
  //                     ),
  //                     child: Image.asset(
  //                       'assets/images/home_page_gif.gif',
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(height: 50),
  //               ],
  //             ),
  //           ),
  //         ),
  //
  //         // Second Part (Inner Container)
  //         Positioned(
  //           top: 200,
  //           left: 20, // 👈 more inner padding
  //           right: 20, // 👈 more inner padding
  //           child: Container(
  //             height: 120,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(16),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black.withOpacity(0.2),
  //                   blurRadius: 8,
  //                   offset: const Offset(0, 4),
  //                 ),
  //               ],
  //             ),
  //             child: Row(
  //               children: [
  //                 // First small card
  //                 Expanded(
  //                   child: Container(
  //                     margin: const EdgeInsets.all(8),
  //                     decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(6),
  //                       border: Border.all(
  //                         color: Colors.grey.shade300,
  //                         width: 1,
  //                       ),
  //                     ),
  //                     child: Center(
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Image.asset(
  //                             'assets/images/ic_served_points.png',
  //                             height: 60,
  //                             width: 60,
  //                             fit: BoxFit.cover,
  //                           ),
  //                           const SizedBox(height: 5),
  //                           const Text(
  //                             'Profile',
  //                             style: TextStyle(
  //                               fontFamily: 'Montserrat',
  //                               fontSize: 12.0,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //
  //                 // Second small card
  //                 Expanded(
  //                   child: Container(
  //                     margin: const EdgeInsets.all(8),
  //                     decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(6),
  //                       border: Border.all(
  //                         color: Colors.grey.shade300,
  //                         width: 1,
  //                       ),
  //                     ),
  //                     child: Center(
  //                       child: Column(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Image.asset(
  //                             'assets/images/ic_create_points.png',
  //                             height: 60,
  //                             width: 60,
  //                             fit: BoxFit.cover,
  //                           ),
  //                           const SizedBox(height: 5),
  //                           const Text(
  //                             'Attendance',
  //                             style: TextStyle(
  //                               fontFamily: 'Montserrat',
  //                               fontSize: 12.0,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }



  // Widget buildFancyStack() {
  //   return SizedBox(
  //     height: 330, // full stack height
  //     child: Stack(
  //       children: [
  //         // First Part (Main Container)
  //         Padding(
  //           padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
  //           child: Container(
  //             height: 280, // full box height
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(8),
  //               border: Border.all(
  //                 color: Colors.grey.shade300,
  //                 width: 2,
  //               ),
  //             ),
  //             child: Column(
  //               children: [
  //                 SizedBox(
  //                   height: 220, // GIF height
  //                   child: ClipRRect(
  //                     borderRadius: const BorderRadius.only(
  //                       topLeft: Radius.circular(12),
  //                       topRight: Radius.circular(12),
  //                     ),
  //                     child: Image.asset(
  //                       'assets/images/home_page_gif.gif',
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 50, // white space at bottom
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         // Second Part (Positioned Container)
  //         Positioned(
  //           top: 200,
  //           left: 10,  // 👈 match first container padding
  //           right: 10, // 👈 match first container padding
  //           child: Container(
  //             height: 120,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(16),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black.withOpacity(0.2),
  //                   blurRadius: 8,
  //                   offset: const Offset(0, 4),
  //                 ),
  //               ],
  //             ),
  //             child: SizedBox(
  //               height: 100, // Row height
  //               child: Row(
  //                 children: [
  //                   // First small card
  //                   Expanded(
  //                     child: Container(
  //                       margin: const EdgeInsets.all(8),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(6),
  //                         border: Border.all(color: Colors.grey.shade300, width: 1),
  //                       ),
  //                       child: Center(
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Image.asset(
  //                               'assets/images/ic_served_points.png',
  //                               height: 60,
  //                               width: 60,
  //                               fit: BoxFit.cover,
  //                             ),
  //                             const SizedBox(height: 5),
  //                             const Text(
  //                               'Profile',
  //                               style: TextStyle(
  //                                 fontFamily: 'Montserrat',
  //                                 fontSize: 12.0,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //
  //                   // Second small card
  //                   Expanded(
  //                     child: Container(
  //                       margin: const EdgeInsets.all(8),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(6),
  //                         border: Border.all(color: Colors.grey.shade300, width: 1),
  //                       ),
  //                       child: Center(
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Image.asset(
  //                               'assets/images/ic_create_points.png',
  //                               height: 60,
  //                               width: 60,
  //                               fit: BoxFit.cover,
  //                             ),
  //                             const SizedBox(height: 5),
  //                             const Text(
  //                               'Attendance',
  //                               style: TextStyle(
  //                                 fontFamily: 'Montserrat',
  //                                 fontSize: 12.0,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );

    // return SizedBox(
    //   height: 330,// 330
    //   //width: 300, // optional, you can make it full width with double.infinity
    //   child: Stack(
    //     children: [
    //       // firstPart 280
    //       Padding(
    //         padding: const EdgeInsets.only(left: 10, right: 10,top: 10),
    //         child: Container(
    //           height: 280, // full box height
    //           decoration: BoxDecoration(
    //             color: Colors.white, // background (so radius is visible)
    //             borderRadius: BorderRadius.circular(8), // 👈 border radius
    //             border: Border.all(
    //               color: Colors.grey.shade300, // 👈 light gray border
    //               width: 2,
    //             ),
    //           ),
    //           child: Column(
    //             children: [
    //               SizedBox(
    //                 height: 220, // GIF height
    //                 child: ClipRRect(
    //                   borderRadius: const BorderRadius.only(
    //                     topLeft: Radius.circular(12),
    //                     topRight: Radius.circular(12),
    //
    //                   ), // apply radius to top only
    //                   child: Image.asset(
    //                     'assets/images/home_page_gif.gif',
    //                     fit: BoxFit.cover,
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 50, // white space at bottom
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //
    //
    //
    //       // Second container (fancy colored box)
    //       Positioned(
    //         top: 200,
    //         left: 15,
    //         right: 15,
    //         child: Container(
    //           height: 120,
    //           decoration: BoxDecoration(
    //             // color: Colors.white, // 🎨 any color you like
    //             borderRadius: BorderRadius.circular(16),
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.black.withOpacity(0.2),
    //                 blurRadius: 8,
    //                 offset: const Offset(0, 4),
    //               ),
    //             ],
    //           ),
    //           child:  SizedBox(
    //             height: 100, // Row height
    //             child: Row(
    //               children: [
    //                 // First Container
    //                 Expanded(
    //                   child: Container(
    //                     margin: const EdgeInsets.all(8), // spacing
    //                     decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       borderRadius: BorderRadius.circular(6),
    //                       border: Border.all(color: Colors.grey.shade300, width: 1),
    //                     ),
    //                     child: Center(
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           crossAxisAlignment: CrossAxisAlignment.center,
    //                           children: [
    //                             Image.asset('assets/images/ic_served_points.png',
    //                               height: 60,
    //                               width: 60,
    //                               fit: BoxFit.cover,
    //                             ),
    //                             SizedBox(height: 5),
    //                             const Text('Profile',
    //                               style: const TextStyle(
    //                                   fontFamily: 'Montserrat',
    //                                   // color: Colors.white,
    //                                   fontSize: 12.0,
    //                                   fontWeight: FontWeight.bold),
    //                             ),
    //                           ],
    //                         )
    //                     ),
    //                   ),
    //                 ),
    //
    //                 // Second Container
    //                 Expanded(
    //                   child: Container(
    //                     margin: const EdgeInsets.all(8),
    //                     decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       borderRadius: BorderRadius.circular(6),
    //                       border: Border.all(color: Colors.grey.shade300, width: 1),
    //                     ),
    //                     child:Center(
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           crossAxisAlignment: CrossAxisAlignment.center,
    //                           children: [
    //                             Image.asset('assets/images/ic_create_points.png',
    //                               height: 60,
    //                               width: 60,
    //                               fit: BoxFit.cover,
    //                             ),
    //                             SizedBox(height: 5),
    //                             const Text('Attendance',
    //                               style: TextStyle(
    //                                   fontFamily: 'Montserrat',
    //                                   // color: Colors.white,
    //                                   fontSize: 12.0,
    //                                   fontWeight: FontWeight.bold),
    //                             )
    //                           ],
    //                         )
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //
    //       ),
    //
    //     ],
    //   ),
    // );
  //}

  // Widget buildFancyStack() {
  //   return SizedBox(
  //     height: 330,// 330
  //     //width: 300, // optional, you can make it full width with double.infinity
  //     child: Stack(
  //       children: [
  //         // firstPart 280
  //         Padding(
  //           padding: const EdgeInsets.only(left: 10, right: 10),
  //           child: SizedBox(
  //             height: 280, // full box height
  //             child: Column(
  //               children: [
  //                 SizedBox(
  //                   height: 230, // GIF height
  //                   child: Image.asset(
  //                     'assets/images/home_page_gif.gif',
  //                     fit: BoxFit.cover,
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   height: 50, // white space at bottom
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //
  //         // Second container (fancy colored box)
  //         Positioned(
  //           top: 200,
  //           left: 15,
  //           right: 15,
  //           child: Container(
  //             height: 120,
  //             decoration: BoxDecoration(
  //               // color: Colors.white, // 🎨 any color you like
  //               borderRadius: BorderRadius.circular(16),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black.withOpacity(0.2),
  //                   blurRadius: 8,
  //                   offset: const Offset(0, 4),
  //                 ),
  //               ],
  //             ),
  //             child:  SizedBox(
  //               height: 100, // Row height
  //               child: Row(
  //                 children: [
  //                   // First Container
  //                   Expanded(
  //                     child: Container(
  //                       margin: const EdgeInsets.all(8), // spacing
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(6),
  //                         border: Border.all(color: Colors.grey.shade300, width: 1),
  //                       ),
  //                       child: Center(
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             crossAxisAlignment: CrossAxisAlignment.center,
  //                             children: [
  //                               Image.asset('assets/images/ic_served_points.png',
  //                                 height: 60,
  //                                 width: 60,
  //                                 fit: BoxFit.cover,
  //                               ),
  //                               SizedBox(height: 5),
  //                               const Text('Profile',
  //                                 style: const TextStyle(
  //                                     fontFamily: 'Montserrat',
  //                                     // color: Colors.white,
  //                                     fontSize: 12.0,
  //                                     fontWeight: FontWeight.bold),
  //                               ),
  //                             ],
  //                           )
  //                       ),
  //                     ),
  //                   ),
  //
  //                   // Second Container
  //                   Expanded(
  //                     child: Container(
  //                       margin: const EdgeInsets.all(8),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(6),
  //                         border: Border.all(color: Colors.grey.shade300, width: 1),
  //                       ),
  //                       child:Center(
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             crossAxisAlignment: CrossAxisAlignment.center,
  //                             children: [
  //                               Image.asset('assets/images/ic_create_points.png',
  //                                 height: 60,
  //                                 width: 60,
  //                                 fit: BoxFit.cover,
  //                               ),
  //                               SizedBox(height: 5),
  //                               const Text('Attendance',
  //                                 style: TextStyle(
  //                                     fontFamily: 'Montserrat',
  //                                     // color: Colors.white,
  //                                     fontSize: 12.0,
  //                                     fontWeight: FontWeight.bold),
  //                               )
  //                             ],
  //                           )
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //
  //         ),
  //
  //       ],
  //     ),
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState
    controller = GifController(vsync: this);
    controller.repeat(period: const Duration(seconds: 2));
    // controller = GifController(vsync: this);
    // controller.repeat(min: 0, max: 29, period: const Duration(seconds: 2));
    super.initState();
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
      // appBar
      //appBar: generalFunction.appbarFunction("GNIDA Officers"),
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
        drawer: generalFunction.drawerFunction(context,'Soyab','9871950881'),
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
            height: 140,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                 itemCount: 6,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(right: 6,left: 6), // spacing between cards
                    child: bottomListCard(index),
                  );
                }),
          ),
          SizedBox(height: 10),
        ],
      )
    );
  }
}

