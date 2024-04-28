import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noidaone/screens/viewimage.dart';
import '../Controllers/pendingInternalComplaintRepo.dart';
import 'actionOnSchedulePoint.dart';
import 'homeScreen.dart';

class PendingComplaintScreen extends StatelessWidget {
  const PendingComplaintScreen({Key? key}) : super(key: key);

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
      home: SchedulePointScreen(),
    );
  }
}

class SchedulePointScreen extends StatefulWidget {
  const SchedulePointScreen({Key? key}) : super(key: key);

  @override
  State<SchedulePointScreen> createState() => _SchedulePointScreenState();
}

class _SchedulePointScreenState extends State<SchedulePointScreen> {
  var variableName;
  var variableName2;
  List<Map<String, dynamic>>? pendingInternalComplaintList;
  List<Map<String, dynamic>> _filteredData = [];
  TextEditingController _searchController = TextEditingController();

  // Get a api response
  pendingInternalComplaintResponse() async {
    pendingInternalComplaintList = await PendingInternalComplaintRepo().pendingInternalComplaint(context);
    _filteredData = List<Map<String, dynamic>>.from(pendingInternalComplaintList ?? []);

    print('--44--$pendingInternalComplaintList');
    print('--45--$_filteredData');
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    pendingInternalComplaintResponse();
    _searchController.addListener(_search);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }
  void _search() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredData = pendingInternalComplaintList?.where((item) {
        String location = item['sLocation'].toLowerCase();
        String pointType = item['sPointTypeName'].toLowerCase();
        String sector = item['sSectorName'].toLowerCase();
        return location.contains(query) ||
            pointType.contains(query) ||
            sector.contains(query);
      }).toList() ??
          [];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF255899),
        leading: GestureDetector(
            onTap: () {
              //Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back_ios),
            )),
        title: const Text(
          'Pending Complaint',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: Colors.grey, // Outline border color
                    width: 0.2, // Outline border width
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _searchController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Enter Keywords',
                          hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xFF707d83),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // scroll item after search bar
          Expanded(
            child: ListView.builder(
              itemCount: _filteredData.length ?? 0,
              itemBuilder: (context, index) {
              Map<String, dynamic> item = _filteredData[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8,right: 8),
                  child: Container(
                    child: Column(
                      children: [
                        Card(
                          elevation: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                color: Colors.grey, // Outline border color
                                width: 0.2, // Outline border width
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          width: 30.0,
                                          height: 30.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                            border: Border.all(
                                              color: Color(
                                                  0xFF255899), // Outline border color
                                              width:
                                              0.5, // Outline border width
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: const Center(
                                            child: Icon(Icons.ac_unit_rounded,color:Color(0xFF255899),size: 20)
                                          )),
                                      SizedBox(width: 5),
                                       Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(item['sPointTypeName'] ??'',
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xff3f617d),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Text(
                                            'Point Name',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xff3f617d),
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Container(
                                      height: 0.5,
                                      color: Color(0xff3f617d),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.forward,
                                        size: 10,
                                        color: Color(0xff3f617d),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Sector',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF255899),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(item['sSectorName'] ??'',
                                      style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xff3f617d),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.forward,
                                        size: 10,
                                        color: Color(0xff3f617d),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Posted At',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF255899),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                   Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      item['dPostedOn'] ??'',
                                      style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xff3f617d),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(Icons.forward,
                                          size: 10, color: Color(0xff3f617d)),
                                      SizedBox(width: 5),
                                      Text(
                                        'Location',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF255899),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                   Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      item['sLocation'] ??'',
                                      style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xff3f617d),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(Icons.forward,
                                          size: 10, color: Color(0xff3f617d)),
                                      SizedBox(width: 5),
                                      Text(
                                        'Description',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF255899),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                   Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      item['sDescription'] ??'',
                                      style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xff3f617d),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      const Icon(
                                        Icons.calendar_month,
                                        size: 10,
                                        color: Color(0xff3f617d),
                                      ),
                                      SizedBox(width: 5),
                                      const Text(
                                        'Pending Since :-',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF255899),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(item['sPendingFrom'] ??'',
                                        style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xff3f617d),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    color: Color(0xffe4e4e4),
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: (){
                                                var sBeforePhoto = "${item['sBeforePhoto']}";
                                                print('---$sBeforePhoto');

                                                if (sBeforePhoto != null) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ImageScreen(
                                                                  sBeforePhoto:
                                                                  sBeforePhoto)));
                                                } else {
                                                  // toast
                                                }
                                              },
                                              child: const Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'View Image',
                                                    style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        color: Color(0xFF255899),
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Icon(
                                                    Icons.forward_sharp,
                                                    color: Color(0xFF255899),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                              height: 10,
                                              width: 1,
                                              color: Colors.grey),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: (){
                                                print('----341---');
                                                var sBeforePhoto = "${item['sBeforePhoto']}";
                                                print('----357---$sBeforePhoto');
                                                //
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => ActionOnSchedultPointScreen(sBeforePhoto:sBeforePhoto)),
                                                );
                                              },
                                              child: const Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Action',
                                                    style: TextStyle(
                                                        fontFamily: 'Montserrat',
                                                        color: Color(0xFF255899),
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Icon(
                                                    Icons.forward_sharp,
                                                    color: Color(0xFF255899),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                              height: 10,
                                              width: 1,
                                              color: Colors.grey),
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: GestureDetector(
                                              onTap: (){
                                                print('----Navigate---');
                                              },
                                              child: const Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Text('Navigate',
                                                      style: TextStyle(
                                                          fontFamily: 'Montserrat',
                                                          color: Color(0xFF255899),
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                  // SizedBox(width: 5),
                                                  //Icon(Icons.forward_sharp,color: Color(0xFF255899))
                                                ],
                                              ),
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
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

// ListTile CLASS
class MyListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              color: Colors.grey, // Outline border color
              width: 0.5, // Outline border width
            ),
            color: Colors.white,
          ),
          child: const Center(
            child: Text(
              "1.",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          )),
      title: const Text(
        'C&D Waste',
        style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold),
      ),
      subtitle: const Text(
        'Point Name',
        style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black54,
            fontSize: 14.0,
            fontWeight: FontWeight.bold),
      ),
      onTap: () {
        // Handle onTap
      },
    );
  }
}

// Searchbar
// class SearchBar extends StatelessWidget {
//   const SearchBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.0),
//           border: Border.all(
//             color: Colors.grey, // Outline border color
//             width: 0.2, // Outline border width
//           ),
//           color: Colors.white,
//         ),
//         child: Row(
//           children: [
//             const Icon(
//               Icons.search,
//               color: Colors.black54,
//             ),
//             const SizedBox(width: 10.0),
//             Expanded(
//               child: TextFormField(
//                 controller: _searchController,
//                 autofocus: true,
//                 decoration: const InputDecoration(
//                   hintText: 'Enter Keywords',
//                   hintStyle: TextStyle(
//                       fontFamily: 'Montserrat',
//                       color: Color(0xFF707d83),
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.bold),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'homeScreen.dart';
//
// class PendingComplaintScreen extends StatelessWidget {
//   const PendingComplaintScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         appBarTheme: const AppBarTheme(
//           iconTheme: IconThemeData(
//             color: Colors.white, // Change the color of the drawer icon here
//           ),
//         ),
//       ),
//       debugShowCheckedModeBanner: false,
//       home: SchedulePointScreen(),
//     );
//   }
// }
//
// class SchedulePointScreen extends StatefulWidget {
//   const SchedulePointScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SchedulePointScreen> createState() => _SchedulePointScreenState();
// }
//
// class _SchedulePointScreenState extends State<SchedulePointScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Color(0xFF255899),
//         leading: GestureDetector(
//             onTap: () {
//               //Navigator.pop(context);
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => const HomePage()));
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Icon(Icons.arrow_back_ios),
//             )),
//         title: const Text(
//           'Pending Complaint',
//           style: TextStyle(
//               fontFamily: 'Montserrat',
//               color: Colors.white,
//               fontSize: 18.0,
//               fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             const Center(
//               child: Padding(
//                 padding: EdgeInsets.only(left: 15, right: 15),
//                 child: SearchBar(),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
//               child: Card(
//                 elevation: 1,
//                 child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5.0),
//                       border: Border.all(
//                         color: Colors.grey, // Outline border color
//                         width: 0.2, // Outline border width
//                       ),
//                       color: Colors.white,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         // MyListTile(),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8, top: 8),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: <Widget>[
//                               Container(
//                                   width: 30.0,
//                                   height: 30.0,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15.0),
//                                     border: Border.all(
//                                       color:Color(0xFF255899), // Outline border color
//                                       width: 0.5, // Outline border width
//                                     ),
//                                     color: Colors.white,
//                                   ),
//                                   child: const Center(
//                                     child:  Icon(Icons.ac_unit_rounded,color:Color(0xFF255899),size: 20)
//                                   )),
//                               SizedBox(width: 5),
//                               const Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text(
//                                     'Garbage Vulnerable Points (GVP)',
//                                     style: TextStyle(
//                                         fontFamily: 'Montserrat',
//                                         color: Color(0xff3f617d),
//                                         fontSize: 14.0,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   Text(
//                                     'Point Name',
//                                     style: TextStyle(
//                                         fontFamily: 'Montserrat',
//                                         color: Color(0xff3f617d),
//                                         fontSize: 12.0,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15, right: 15),
//                           child: Container(
//                             height: 0.5,
//                             color: Color(0xff3f617d),
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Icon(
//                               Icons.forward,
//                               size: 10,
//                               color: Color(0xff3f617d),
//                             ),
//                             SizedBox(width: 5),
//                             Text(
//                               'Sector',
//                               style: TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   color: Color(0xFF255899),
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 15),
//                           child: Text(
//                             'Sector-50',
//                             style: TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 color: Color(0xff3f617d),
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Icon(
//                               Icons.forward,
//                               size: 10,
//                               color: Color(0xff3f617d),
//                             ),
//                             SizedBox(width: 5),
//                             Text(
//                               'Posted At',
//                               style: TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   color: Color(0xFF255899),
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 15),
//                           child: Text(
//                             '16/Apr/2024 1240',
//                             style: TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 color: Color(0xff3f617d),
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Icon(Icons.forward, size: 10,
//                                 color:  Color(0xff3f617d)),
//                             SizedBox(width: 5),
//                             Text(
//                               'Location',
//                               style:  TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   color: Color(0xFF255899),
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 15),
//                           child: Text(
//                             'F Block Twin Tower',
//                             style: TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 color: Color(0xff3f617d),
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Icon(Icons.forward, size: 10,
//                                 color:  Color(0xff3f617d)),
//                             SizedBox(width: 5),
//                             Text(
//                               'Description',
//                               style:  TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   color: Color(0xFF255899),
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 15),
//                           child: Text(
//                             'Garbage is Gadering',
//                             style: TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 color: Color(0xff3f617d),
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         const Row(
//                           children: <Widget>[
//                            Icon(Icons.edit_calendar_outlined,
//                              color:Color(0xff3f617d),
//                              size: 20,
//                            ),
//                             SizedBox(width: 10),
//                             Text('Pending Since :-',style:TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 color: Color(0xFF255899),
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.bold),),
//
//                             Text('2 Min',style:TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 color: Color(0xff3f617d),
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.bold),),
//
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         // e4e4e4
//                         Container(
//                           color: Color(0xffe4e4e4),
//                           height: 40,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10, right: 10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 const Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'View Image',
//                                       style: TextStyle(
//                                           fontFamily: 'Montserrat',
//                                           color: Color(0xFF255899),
//                                           fontSize: 14.0,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(width: 5),
//                                     Icon(
//                                       Icons.forward_sharp,
//                                       color: Color(0xFF255899),
//                                     )
//                                   ],
//                                 ),
//                                 Container(height: 10, width: 1, color: Colors.grey),
//                                 const Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Action',
//                                       style: TextStyle(
//                                           fontFamily: 'Montserrat',
//                                           color: Color(0xFF255899),
//                                           fontSize: 14.0,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(width: 5),
//                                     Icon(
//                                       Icons.forward_sharp,
//                                       color: Color(0xFF255899),
//                                     ),
//                                   ],
//                                 ),
//                                 Container(height: 10, width: 1, color: Colors.grey),
//                                 const Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text('Navigate',
//                                         style: TextStyle(
//                                             fontFamily: 'Montserrat',
//                                             color: Color(0xFF255899),
//                                             fontSize: 14.0,
//                                             fontWeight: FontWeight.bold)),
//                                     // SizedBox(width: 5),
//                                     //Icon(Icons.forward_sharp,color: Color(0xFF255899))
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     )),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
//               child: Card(
//                 elevation: 1,
//                 child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5.0),
//                       border: Border.all(
//                         color: Colors.grey, // Outline border color
//                         width: 0.2, // Outline border width
//                       ),
//                       color: Colors.white,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         // MyListTile(),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8, top: 8),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: <Widget>[
//                               Container(
//                                   width: 30.0,
//                                   height: 30.0,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(15.0),
//                                     border: Border.all(
//                                       color:Color(0xFF255899), // Outline border color
//                                       width: 0.5, // Outline border width
//                                     ),
//                                     color: Colors.white,
//                                   ),
//                                   child: const Center(
//                                       child:  Icon(Icons.ac_unit_rounded,color:Color(0xFF255899),size: 20)
//                                   )),
//                               SizedBox(width: 5),
//                               const Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text(
//                                     'Garbage Vulnerable Points (GVP)',
//                                     style: TextStyle(
//                                         fontFamily: 'Montserrat',
//                                         color: Color(0xff3f617d),
//                                         fontSize: 14.0,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   Text(
//                                     'Point Name',
//                                     style: TextStyle(
//                                         fontFamily: 'Montserrat',
//                                         color: Color(0xff3f617d),
//                                         fontSize: 12.0,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 15, right: 15),
//                           child: Container(
//                             height: 0.5,
//                             color: Color(0xff3f617d),
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Icon(
//                               Icons.forward,
//                               size: 10,
//                               color: Color(0xff3f617d),
//                             ),
//                             SizedBox(width: 5),
//                             Text(
//                               'Sector',
//                               style: TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   color: Color(0xFF255899),
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 15),
//                           child: Text(
//                             'Sector-50',
//                             style: TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 color: Color(0xff3f617d),
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Icon(
//                               Icons.forward,
//                               size: 10,
//                               color: Color(0xff3f617d),
//                             ),
//                             SizedBox(width: 5),
//                             Text(
//                               'Posted At',
//                               style: TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   color: Color(0xFF255899),
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 15),
//                           child: Text(
//                             '16/Apr/2024 1240',
//                             style: TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 color: Color(0xff3f617d),
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Icon(Icons.forward, size: 10,
//                                 color:  Color(0xff3f617d)),
//                             SizedBox(width: 5),
//                             Text(
//                               'Location',
//                               style:  TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   color: Color(0xFF255899),
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 15),
//                           child: Text(
//                             'F Block Twin Tower',
//                             style: TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 color: Color(0xff3f617d),
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Icon(Icons.forward, size: 10,
//                                 color:  Color(0xff3f617d)),
//                             SizedBox(width: 5),
//                             Text(
//                               'Description',
//                               style:  TextStyle(
//                                   fontFamily: 'Montserrat',
//                                   color: Color(0xFF255899),
//                                   fontSize: 14.0,
//                                   fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 15),
//                           child: Text(
//                             'Garbage is Gadering',
//                             style: TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 color: Color(0xff3f617d),
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         const Row(
//                           children: <Widget>[
//                             Icon(Icons.edit_calendar_outlined,
//                               color:Color(0xff3f617d),
//                               size: 20,
//                             ),
//                             SizedBox(width: 10),
//                             Text('Pending Since :-',style:TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 color: Color(0xFF255899),
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.bold),),
//
//                             Text('2 Min',style:TextStyle(
//                                 fontFamily: 'Montserrat',
//                                 color: Color(0xff3f617d),
//                                 fontSize: 14.0,
//                                 fontWeight: FontWeight.bold),),
//
//                           ],
//                         ),
//                         const SizedBox(height: 10),
//                         // e4e4e4
//                         Container(
//                           color: Color(0xffe4e4e4),
//                           height: 40,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10, right: 10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 const Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'View Image',
//                                       style: TextStyle(
//                                           fontFamily: 'Montserrat',
//                                           color: Color(0xFF255899),
//                                           fontSize: 14.0,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(width: 5),
//                                     Icon(
//                                       Icons.forward_sharp,
//                                       color: Color(0xFF255899),
//                                     )
//                                   ],
//                                 ),
//                                 Container(height: 10, width: 1, color: Colors.grey),
//                                 const Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Action',
//                                       style: TextStyle(
//                                           fontFamily: 'Montserrat',
//                                           color: Color(0xFF255899),
//                                           fontSize: 14.0,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(width: 5),
//                                     Icon(
//                                       Icons.forward_sharp,
//                                       color: Color(0xFF255899),
//                                     ),
//                                   ],
//                                 ),
//                                 Container(height: 10, width: 1, color: Colors.grey),
//                                 const Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text('Navigate',
//                                         style: TextStyle(
//                                             fontFamily: 'Montserrat',
//                                             color: Color(0xFF255899),
//                                             fontSize: 14.0,
//                                             fontWeight: FontWeight.bold)),
//                                     // SizedBox(width: 5),
//                                     //Icon(Icons.forward_sharp,color: Color(0xFF255899))
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     )),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ListTile CLASS
// class MyListTile extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Container(
//           width: 50.0,
//           height: 50.0,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(25.0),
//             border: Border.all(
//               color: Colors.grey, // Outline border color
//               width: 0.5, // Outline border width
//             ),
//             color: Colors.white,
//           ),
//           child: const Center(
//             child: Text(
//               "1.",
//               style: TextStyle(color: Colors.black, fontSize: 20),
//             ),
//           )),
//       title: const Text(
//         'C&D Waste',
//         style: TextStyle(
//             fontFamily: 'Montserrat',
//             color: Colors.black,
//             fontSize: 16.0,
//             fontWeight: FontWeight.bold),
//       ),
//       subtitle: const Text(
//         'Point Name',
//         style: TextStyle(
//             fontFamily: 'Montserrat',
//             color: Colors.black54,
//             fontSize: 14.0,
//             fontWeight: FontWeight.bold),
//       ),
//       onTap: () {
//         // Handle onTap
//       },
//     );
//   }
// }
//
// // Searchbar
// class SearchBar extends StatelessWidget {
//   const SearchBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.0),
//           border: Border.all(
//             color: Colors.grey, // Outline border color
//             width: 0.2, // Outline border width
//           ),
//           color: Colors.white,
//         ),
//         child: Row(
//           children: [
//             const Icon(
//               Icons.search,
//               color: Colors.black54,
//             ),
//             const SizedBox(width: 10.0),
//             Expanded(
//               child: TextFormField(
//                 decoration: const InputDecoration(
//                   hintText: 'Enter Keywords',
//                   hintStyle:  TextStyle(
//                       fontFamily: 'Montserrat',
//                       color: Color(0xFF707d83),
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.bold),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // import 'package:flutter/material.dart';
// // import 'homeScreen.dart';
// //
// // class PendingComplaintScreen extends StatelessWidget {
// //
// //   const PendingComplaintScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       theme: ThemeData(
// //         appBarTheme: const AppBarTheme(
// //           iconTheme: IconThemeData(
// //             color: Colors.white, // Change the color of the drawer icon here
// //           ),
// //         ),
// //       ),
// //       debugShowCheckedModeBanner: false,
// //       home: SchedulePointScreen(),
// //     );
// //   }
// // }
// //
// // class SchedulePointScreen extends StatefulWidget {
// //   const SchedulePointScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<SchedulePointScreen> createState() => _SchedulePointScreenState();
// // }
// //
// // class _SchedulePointScreenState extends State<SchedulePointScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Color(0xFF255899),
// //         leading: GestureDetector(
// //             onTap: () {
// //               //Navigator.pop(context);
// //               Navigator.push(context,
// //                   MaterialPageRoute(builder: (context) => const HomePage()));
// //             },
// //             child: Icon(Icons.arrow_back_ios)),
// //         title: const Text(
// //           'Pending Complaint.',
// //           style: TextStyle(
// //               fontFamily: 'Montserrat',
// //               color: Colors.white,
// //               fontSize: 18.0,
// //               fontWeight: FontWeight.bold),
// //         ),
// //       ),
// //       body: ListView(
// //         children: <Widget>[
// //           const Center(
// //             child: Padding(
// //               padding: EdgeInsets.only(left: 15, right: 15),
// //               child: SearchBar(),
// //             ),
// //           ),
// //           const SizedBox(height: 5),
// //           Padding(
// //             padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
// //             child: Card(
// //               elevation: 5,
// //               child: Container(
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(5.0),
// //                     border: Border.all(
// //                       color: Colors.grey, // Outline border color
// //                       width: 0.5, // Outline border width
// //                     ),
// //                     color: Colors.white,
// //                   ),
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.start,
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: <Widget>[
// //                       // MyListTile(),
// //                       Padding(
// //                         padding: const EdgeInsets.only(left: 8, top: 8),
// //                         child: Row(
// //                           mainAxisAlignment: MainAxisAlignment.start,
// //                           children: <Widget>[
// //                             Container(
// //                                 width: 50.0,
// //                                 height: 50.0,
// //                                 decoration: BoxDecoration(
// //                                   borderRadius: BorderRadius.circular(25.0),
// //                                   border: Border.all(
// //                                     color: Colors.grey, // Outline border color
// //                                     width: 0.5, // Outline border width
// //                                   ),
// //                                   color: Colors.white,
// //                                 ),
// //                                 child: const Center(
// //                                   child: Icon(Icons.ac_unit,
// //                                       color: Colors.black54),
// //                                 )),
// //                             SizedBox(width: 5),
// //                             const Column(
// //                               crossAxisAlignment: CrossAxisAlignment.start,
// //                               children: <Widget>[
// //                                 Text(
// //                                   'Garbage Vulnerable Points (GVP)',
// //                                   style: TextStyle(
// //                                       fontFamily: 'Montserrat',
// //                                       color: Colors.black,
// //                                       fontSize: 14.0,
// //                                       fontWeight: FontWeight.bold),
// //                                 ),
// //                                 Text(
// //                                   'Point Name',
// //                                   style: TextStyle(
// //                                       fontFamily: 'Montserrat',
// //                                       color: Colors.black54,
// //                                       fontSize: 14.0,
// //                                       fontWeight: FontWeight.normal),
// //                                 ),
// //                               ],
// //                             )
// //                           ],
// //                         ),
// //                       ),
// //                       const SizedBox(height: 10),
// //                       Padding(
// //                         padding: const EdgeInsets.only(left: 10),
// //                         child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.start,
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: <Widget>[
// //                             Padding(
// //                               padding: const EdgeInsets.only(left: 15, right: 15),
// //                               child: Container(
// //                                 height: 0.5,
// //                                 color: Colors.grey,
// //                               ),
// //                             ),
// //                             SizedBox(height: 5),
// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.start,
// //                               children: <Widget>[
// //                                 //Icon(Icons.forward, size: 16,color:  Colors.black87,),
// //                                 Container(
// //                                   height: 10,
// //                                   width: 10,
// //                                   // color: Colors.black54,
// //                                   decoration: BoxDecoration(
// //                                     color: Colors.black, // Container background color
// //                                     borderRadius:
// //                                     BorderRadius.circular(5.0), // Border radius
// //                                   ),
// //                                 ),
// //                                 SizedBox(width: 5),
// //                                 const Text(
// //                                   'Sector',
// //                                   style: TextStyle(
// //                                       fontFamily: 'Montserrat',
// //                                       color: Colors.black87,
// //                                       fontSize: 16.0,
// //                                       fontWeight: FontWeight.bold),
// //                                 )
// //                               ],
// //                             ),
// //                             const Padding(
// //                               padding: EdgeInsets.only(left: 20),
// //                               child: Text(
// //                                 'Sector-50',
// //                                 style: TextStyle(
// //                                     fontFamily: 'Montserrat',
// //                                     color: Colors.black54,
// //                                     fontSize: 14.0,
// //                                     fontWeight: FontWeight.bold),
// //                               ),
// //                             ),
// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.start,
// //                               children: <Widget>[
// //                                 Container(
// //                                   height: 10,
// //                                   width: 10,
// //                                   // color: Colors.black54,
// //                                   decoration: BoxDecoration(
// //                                     color: Colors.black, // Container background color
// //                                     borderRadius:
// //                                     BorderRadius.circular(5.0), // Border radius
// //                                   ),
// //                                 ),
// //                                 SizedBox(width: 5),
// //                                 const Text(
// //                                   'Posted At',
// //                                   style: TextStyle(
// //                                       fontFamily: 'Montserrat',
// //                                       color: Colors.black87,
// //                                       fontSize: 16.0,
// //                                       fontWeight: FontWeight.bold),
// //                                 )
// //                               ],
// //                             ),
// //                             const Padding(
// //                               padding: EdgeInsets.only(left: 20),
// //                               child: Text(
// //                                 '16/Apr/2024/ 12.50',
// //                                 style: TextStyle(
// //                                     fontFamily: 'Montserrat',
// //                                     color: Colors.black54,
// //                                     fontSize: 16.0,
// //                                     fontWeight: FontWeight.normal),
// //                               ),
// //                             ),
// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.start,
// //                               children: <Widget>[
// //                                 Container(
// //                                   height: 10,
// //                                   width: 10,
// //                                   // color: Colors.black54,
// //                                   decoration: BoxDecoration(
// //                                     color: Colors.black, // Container background color
// //                                     borderRadius:
// //                                     BorderRadius.circular(5.0), // Border radius
// //                                   ),
// //                                 ),
// //                                 SizedBox(width: 5),
// //                                 const Text(
// //                                   'Location',
// //                                   style: TextStyle(
// //                                       fontFamily: 'Montserrat',
// //                                       color: Colors.black87,
// //                                       fontSize: 16.0,
// //                                       fontWeight: FontWeight.bold),
// //                                 )
// //                               ],
// //                             ),
// //                             const Padding(
// //                               padding: EdgeInsets.only(left: 20),
// //                               child: Text(
// //                                 'F Block Twin Tower',
// //                                 style: TextStyle(
// //                                     fontFamily: 'Montserrat',
// //                                     color: Colors.black54,
// //                                     fontSize: 16.0,
// //                                     fontWeight: FontWeight.normal),
// //                               ),
// //                             ),
// //                             const Padding(
// //                               padding: EdgeInsets.only(left: 20),
// //                               child: Text(
// //                                 '16/Apr/2024/ 12.50',
// //                                 style: TextStyle(
// //                                     fontFamily: 'Montserrat',
// //                                     color: Colors.black54,
// //                                     fontSize: 16.0,
// //                                     fontWeight: FontWeight.normal),
// //                               ),
// //                             ),
// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.start,
// //                               children: <Widget>[
// //                                 Container(
// //                                   height: 10,
// //                                   width: 10,
// //                                   // color: Colors.black54,
// //                                   decoration: BoxDecoration(
// //                                     color: Colors.black, // Container background color
// //                                     borderRadius:
// //                                     BorderRadius.circular(5.0), // Border radius
// //                                   ),
// //                                 ),
// //                                 SizedBox(width: 5),
// //                                 const Text(
// //                                   'Description',
// //                                   style: TextStyle(
// //                                       fontFamily: 'Montserrat',
// //                                       color: Colors.black87,
// //                                       fontSize: 16.0,
// //                                       fontWeight: FontWeight.bold),
// //                                 )
// //                               ],
// //                             ),
// //                             const Padding(
// //                               padding: EdgeInsets.only(left: 20),
// //                               child: Text(
// //                                 'Garbage is nearby Noida 59',
// //                                 style: TextStyle(
// //                                     fontFamily: 'Montserrat',
// //                                     color: Colors.black54,
// //                                     fontSize: 16.0,
// //                                     fontWeight: FontWeight.normal),
// //                               ),
// //                             ),
// //                             Padding(
// //                               padding: const EdgeInsets.only(left: 15,right: 15),
// //                               child: Card(
// //                                 child: Container(
// //                                   decoration: BoxDecoration(
// //                                     borderRadius: BorderRadius.circular(5.0),
// //                                     border: Border.all(
// //                                       color: Colors.grey, // Outline border color
// //                                       width: 0.1, // Outline border width
// //                                     ),
// //                                     color: Colors.white,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                             const Row(
// //                               mainAxisAlignment: MainAxisAlignment.start,
// //                               children: <Widget>[
// //                                 Icon(Icons.edit_calendar_outlined),
// //                                 SizedBox(width: 5),
// //                                 Text('Pending Since :-'),
// //                                 SizedBox(width: 5),
// //                                 Text('2 Min'),
// //                               ],
// //                             ),
// //                             Padding(
// //                               padding: const EdgeInsets.only(left: 10, right: 10),
// //                               child: Row(
// //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                 children: <Widget>[
// //                                   const Row(
// //                                     mainAxisAlignment: MainAxisAlignment.start,
// //                                     children: [
// //                                       Text(
// //                                         'View Image',
// //                                         style: TextStyle(
// //                                             fontFamily: 'Montserrat',
// //                                             color: Color(0xFF255899),
// //                                             fontSize: 14.0,
// //                                             fontWeight: FontWeight.bold),
// //                                       ),
// //                                       SizedBox(width: 5),
// //                                       Icon(
// //                                         Icons.forward_sharp,
// //                                         color: Color(0xFF255899),
// //                                       )
// //                                     ],
// //                                   ),
// //                                   Container(height: 10, width: 1, color: Colors.grey),
// //                                   const Row(
// //                                     mainAxisAlignment: MainAxisAlignment.start,
// //                                     children: [
// //                                       Text(
// //                                         'Action',
// //                                         style: TextStyle(
// //                                             fontFamily: 'Montserrat',
// //                                             color: Color(0xFF255899),
// //                                             fontSize: 14.0,
// //                                             fontWeight: FontWeight.bold),
// //                                       ),
// //                                       SizedBox(width: 5),
// //                                       Icon(
// //                                         Icons.forward_sharp,
// //                                         color: Color(0xFF255899),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   Container(height: 10, width: 1, color: Colors.grey),
// //                                   const Row(
// //                                     mainAxisAlignment: MainAxisAlignment.start,
// //                                     children: [
// //                                       Text('Navigate',
// //                                           style: TextStyle(
// //                                               fontFamily: 'Montserrat',
// //                                               color: Color(0xFF255899),
// //                                               fontSize: 14.0,
// //                                               fontWeight: FontWeight.bold)),
// //                                       // SizedBox(width: 5),
// //                                       //Icon(Icons.forward_sharp,color: Color(0xFF255899))
// //                                     ],
// //                                   ),
// //                                 ],
// //                               ),
// //                             )
// //
// //                           ],
// //                         ),
// //                       )
// //
// //
// //                     ],
// //                   )),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// // // ListTile CLASS
// // class MyListTile extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return ListTile(
// //       leading: Container(
// //           width: 50.0,
// //           height: 50.0,
// //           decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(25.0),
// //             border: Border.all(
// //               color: Colors.grey, // Outline border color
// //               width: 0.5, // Outline border width
// //             ),
// //             color: Colors.white,
// //           ),
// //           child: const Center(
// //             child: Text(
// //               "1.",
// //               style: TextStyle(color: Colors.black, fontSize: 20),
// //             ),
// //           )),
// //       title: const Text(
// //         'C&D Waste',
// //         style: TextStyle(
// //             fontFamily: 'Montserrat',
// //             color: Colors.black,
// //             fontSize: 16.0,
// //             fontWeight: FontWeight.bold),
// //       ),
// //       subtitle: const Text(
// //         'Point Name',
// //         style: TextStyle(
// //             fontFamily: 'Montserrat',
// //             color: Colors.black54,
// //             fontSize: 14.0,
// //             fontWeight: FontWeight.bold),
// //       ),
// //       onTap: () {
// //         // Handle onTap
// //       },
// //     );
// //   }
// // }
// //
// // // Searchbar
// // class SearchBar extends StatelessWidget {
// //   const SearchBar({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       elevation: 5,
// //       child: Container(
// //         padding: EdgeInsets.symmetric(horizontal: 10.0),
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(5.0),
// //           border: Border.all(
// //             color: Colors.grey, // Outline border color
// //             width: 1.0, // Outline border width
// //           ),
// //           color: Colors.white,
// //         ),
// //         child: const Row(
// //           children: [
// //             Icon(Icons.search, color: Colors.black54),
// //             SizedBox(width: 10.0),
// //             Expanded(
// //               child: TextField(
// //                 decoration: InputDecoration(
// //                   hintText: 'Enter Keywords',
// //                   border: InputBorder.none,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
