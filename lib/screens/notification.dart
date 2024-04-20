import 'package:flutter/material.dart';

import 'changePassword.dart';
import 'homeScreen.dart';
import 'logout.dart';
import 'mypoint.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

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
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF255899),
        title: const Text(
          'Notification',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 18.0,
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
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/citysimpe.png'), // Replace with your asset image path
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.person,
                      size: 50,
                      color: Color(0xff3f617d),
                    ),
                    Text(
                      'ABHISHEK (Supervisor)',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xff3f617d),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.call,
                          size: 18,
                          color: Color(0xff3f617d),
                        ),
                        SizedBox(width: 5),
                        Text(
                          '987195xxxx',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: SingleChildScrollView(
                // Wrap with SingleChildScrollView to make it scrollable
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                        // Add your navigation or action logic here
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/home_nw.png', // Replace with your asset image path
                            width: 25, // Adjust image width as needed
                            height: 25, // Adjust image height as needed
                          ),
                          SizedBox(width: 10),
                          const Text(
                            'Home',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Mypoint()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/my_wallet.png', // Replace with your asset image path
                            width: 25, // Adjust image width as needed
                            height: 25, // Adjust image height as needed
                          ),
                          SizedBox(width: 10),
                          const Text(
                            'My Points',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChangePassWord()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/change_password_nw.png', // Replace with your asset image path
                            width: 25, // Adjust image width as needed
                            height: 25, // Adjust image height as needed
                          ),
                          SizedBox(width: 10),
                          const Text(
                            'Change Password',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/notification.png', // Replace with your asset image path
                            width: 25, // Adjust image width as needed
                            height: 25, // Adjust image height as needed
                          ),
                          SizedBox(width: 10),
                          const Text(
                            'Notification',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogoutScreen()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/logout_new.png', // Replace with your asset image path
                            width: 25, // Adjust image width as needed
                            height: 25, // Adjust image height as needed
                          ),
                          SizedBox(width: 10),
                          const Text(
                            'Logout',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 280),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 100,
                        child: Text(
                          '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
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
      ),
      body: ListView(
        children: <Widget>[
           Padding(
             padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
             child: Container(
               decoration: BoxDecoration(
                 color: Colors.white, // Grey color
                 borderRadius: BorderRadius.circular(10),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.grey.withOpacity(0.5), // Set shadow color
                     spreadRadius: 5,
                     blurRadius: 7,
                     offset: Offset(0, 3), // changes position of shadow
                   ),
                 ],
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: [
                   //Icon(Icons.notification_important,size: 20,color: Colors.blue),
                   Padding(
                     padding: const EdgeInsets.only(left: 10),
                     child: Container(
                       width: 30,
                       height: 30,
                       decoration: BoxDecoration(
                         color: Color(0xFFD3D3D3),
                         borderRadius: BorderRadius.circular(15), // Set border radius
                         boxShadow: [
                           BoxShadow(
                             color: Colors.grey.withOpacity(0.5), // Set shadow color
                             spreadRadius: 5,
                             blurRadius: 7,
                             offset: Offset(0, 3), // changes position of shadow
                           ),
                         ],
                       ),
                       child: Icon(Icons.notification_important,size: 30,color: Color(0xFF255899)),
                     ),
                   ),
                   SizedBox(width: 5),
                   const Padding(
                     padding: EdgeInsets.only(bottom: 4),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Text('Complaint',
                           style: TextStyle(
                               fontFamily: 'Montserrat',
                               color: Color(0xff3f617d),
                               fontSize: 14.0,
                               fontWeight: FontWeight.bold),),
                         Text('A new complaint of C&D Waste has been received.',
                           style: TextStyle(
                               fontFamily: 'Montserrat',
                               color: Color(0xff3f617d),
                               fontSize: 10.0,
                               fontWeight: FontWeight.bold),
                         ),
                         SizedBox(height: 5),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Icon(Icons.date_range,size: 20,color: Colors.black),
                             SizedBox(width: 5),
                             Text('15/Apr/2024 09:28:27',
                               style: TextStyle(
                                   fontFamily: 'Montserrat',
                                   color: Colors.black,
                                   fontSize: 10.0,
                                   fontWeight: FontWeight.bold),
                             ),
                           ],
                         )
                       ],
                     ),
                   )
                 ],
               ),
             ),
           ),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 15),

            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Grey color
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Set shadow color
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Icon(Icons.notification_important,size: 20,color: Colors.blue),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(0xFFD3D3D3),
                        borderRadius: BorderRadius.circular(15), // Set border radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Set shadow color
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Icon(Icons.notification_important,size: 30,color: Color(0xFF255899)),
                    ),
                  ),
                  SizedBox(width: 5),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Complaint',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),),
                        Text('A new complaint of C&D Waste has been received.',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.date_range,size: 20,color: Colors.black),
                            SizedBox(width: 5),
                            Text('15/Apr/2024 09:28:27',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 15),

            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Grey color
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Set shadow color
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Icon(Icons.notification_important,size: 20,color: Colors.blue),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(0xFFD3D3D3),
                        borderRadius: BorderRadius.circular(15), // Set border radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Set shadow color
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Icon(Icons.notification_important,size: 30,color: Color(0xFF255899)),
                    ),
                  ),
                  SizedBox(width: 5),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Complaint',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),),
                        Text('A new complaint of C&D Waste has been received.',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.date_range,size: 20,color: Colors.black),
                            SizedBox(width: 5),
                            Text('15/Apr/2024 09:28:27',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 15),

            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Grey color
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Set shadow color
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Icon(Icons.notification_important,size: 20,color: Colors.blue),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(0xFFD3D3D3),
                        borderRadius: BorderRadius.circular(15), // Set border radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Set shadow color
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Icon(Icons.notification_important,size: 30,color: Color(0xFF255899)),
                    ),
                  ),
                  SizedBox(width: 5),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Complaint',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),),
                        Text('A new complaint of C&D Waste has been received.',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.date_range,size: 20,color: Colors.black),
                            SizedBox(width: 5),
                            Text('15/Apr/2024 09:28:27',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}

