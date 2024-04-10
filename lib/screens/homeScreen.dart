import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noidaone/screens/foodlist.dart';
import 'package:noidaone/screens/tabbarHome.dart';

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

class _MyHomePageState extends State<MyHomePage>with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync:  this, length: 3);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF255899),
        title: Text(
          'Noida One',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      // drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Add your item 1 action here
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Add your item 2 action here
              },
            ),
          ],
        ),
      ),
      // body
      body: ListView(
        children:<Widget>[
          // stack
          Container(
            height: 300,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/top_contributor_header.png'), // Provide your image path here
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      //color: Color(0xFF255899),
                      decoration: BoxDecoration(
                          color: Color(0xFF255899), // Container background color
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(25), // Adjust this value as per your preference
                          right: Radius.circular(25), // Adjust this value as per your preference
                        ),
                      ),

                      child: TabBar(
                        controller:  tabController,
                        indicatorColor: Color(0xFFFE8A7E),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorWeight: 4.0,
                        isScrollable: true,
                        labelColor: Color(0xFF440206),
                        unselectedLabelColor: Color(0xFF440206),
                        tabs: <Widget>[
                          Tab(
                            child: Text(
                              'Today',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Month',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'All Time',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 80,
                    left: 15,
                    right: 15,
                    child: Container(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                         Column(
                           children: <Widget>[
                             Image.asset(
                               'assets/images/trophy.png', // Asset image path
                               width: 100,
                               height: 100,
                             ),
                             SizedBox(height: 0), // Add some space between the image and text
                             Text(
                               '1. Krishna tomar',
                               style: TextStyle(
                                   fontFamily: 'Montserrat',
                                   color: Colors.white,
                                   fontSize: 14.0,
                                   fontWeight: FontWeight.normal),
                             ),
                             SizedBox(height: 0),
                             Text(
                               '2 Points',
                               style: TextStyle(
                                   fontFamily: 'Montserrat',
                                   color: Colors.white,
                                   fontSize: 14.0,
                                   fontWeight: FontWeight.normal),
                             ),
                           ],
                         ),
                         Column(
                           children: <Widget>[
                             Image.asset(
                               'assets/images/trophy.png', // Asset image path
                               width: 80,
                               height: 80,
                             ),
                             SizedBox(height: 0), // Add some space between the image and text
                             Text(
                               '1. Krishna tomar',
                               style: TextStyle(
                                   fontFamily: 'Montserrat',
                                   color: Colors.white,
                                   fontSize: 14.0,
                                   fontWeight: FontWeight.normal),
                             ),
                             SizedBox(height: 0),
                             Text(
                               '2 Points',
                               style: TextStyle(
                                   fontFamily: 'Montserrat',
                                   color: Colors.white,
                                   fontSize: 14.0,
                                   fontWeight: FontWeight.normal),
                             ),
                           ],
                         ),
                         Column(
                           children: <Widget>[
                             Image.asset(
                               'assets/images/trophy.png', // Asset image path
                               width: 60,
                               height: 60,
                             ),
                             SizedBox(height: 0), // Add some space between the image and text
                             Text(
                               '1. Krishna tomar',
                               style: TextStyle(
                                   fontFamily: 'Montserrat',
                                   color: Colors.white,
                                   fontSize: 14.0,
                                   fontWeight: FontWeight.normal),
                             ),
                             SizedBox(height: 0),
                             Text(
                               '2 Points',
                               style: TextStyle(
                                   fontFamily: 'Montserrat',
                                   color: Colors.white,
                                   fontSize: 14.0,
                                   fontWeight: FontWeight.normal),
                             ),
                           ],
                         ),
                       ],
                     ),
                ))
              ],
            ),
          ),
          Container(
            height: 225,
            //height: MediaQuery.of(context).size.height - 450.0,
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
                //new FoodList(),
                new TabBarHome(),
                new TabBarHome(),
                new TabBarHome(),
              ],
            ),
          ),
          SizedBox(height: 10),
          //FoodList()
          // Container(
          //   child: ListView(
          //     children: <Widget>
          //     [
          //       _buildFoodCard(
          //           'assets/images/barger2.png', 'Strawberry Cream Waffles', 7.0, 273, false),
          //       _buildFoodCard('assets/images/barger3.png', 'Croissant blue berry fruit', 18.0, 241, true),
          //       _buildFoodCard('assets/images/barger2.png', 'Strawberry Cream Waffles', 18.0, 1546, true)
          //     ],scrollDirection: Axis.horizontal
          //   ),
          // )



        ],
      ),
    );
  }
  // take a class function
  _buildFoodCard(String imgPath, String foodName, double price, int calCount,
      bool hasMilk) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0, left: 10.0, bottom: 10.0),
      child: Container(
        height: 100.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 3.0,
                  spreadRadius: 3.0
              )
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                  child: Image.asset(imgPath,
                    fit: BoxFit.cover,
                    height: 100.0,
                    width: 100.0,
                  ),
                ),
                Positioned(
                    top: 92.0,
                    left: 60.0,
                    child: hasMilk ? Container(
                      height: 15.0,
                      width: 55.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color(0xFFF75A4C),
                            style: BorderStyle.solid,
                            width: 0.25
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'with milk',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 10.0,
                              color: Color(0xFFF75A4C)
                          ),
                        ),
                      ),
                    ) : Container()
                )
              ],
            ),
            Container(
              width: 125.0,
              padding: EdgeInsets.only(left: 4.0),
              child: Text(foodName,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Color(0xFF440206),
                    fontSize: 15.0
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Text('\$' + price.toString(),
                style: TextStyle(

                    fontFamily: 'Montserrat',
                    color: Color(0xFFF75A4C)
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.account_box, color: Color(0xFFF75A4C), size: 15.0),
                    SizedBox(width: 5.0),
                    Text(calCount.toString() + 'cal',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          color: Colors.grey
                      ),
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
