import 'package:flutter/material.dart';

import '../screens/complaintStatus.dart';
import '../screens/dailyActivity.dart';
import '../screens/postComplaint.dart';

Widget buildFancyStack() {
  return SizedBox(
    height: 360,

    //width: 300, // optional, you can make it full width with double.infinity
    child: Stack(
      children: [
        // First container with dummy image
        Padding(
          padding: const EdgeInsets.all(8.0),

          child:  SizedBox(
            height: 280,
            child: Image.asset(
              'assets/images/home_page_gif.gif', // your GIF asset path
              fit: BoxFit.cover,             // covers the container while keeping aspect ratio
            ),
          ),
        ),
        // Second container (fancy colored box)
        Positioned(
          top: 230,
          left: 20,
          right: 20,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              // color: Colors.white, // 🎨 any color you like
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child:  SizedBox(
              height: 100, // Row height
              child: Row(
                children: [
                  // First Container
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(8), // spacing
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                      ),
                      child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/ic_served_points.png',
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 5),
                              const Text('Profile',
                                style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    // color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                      ),
                    ),
                  ),

                  // Second Container
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey.shade300, width: 1),
                      ),
                      child:Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/ic_create_points.png',
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 5),
                              const Text('Attendance',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    // color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
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
  );
}
Widget listTile(BuildContext context){
  return Center(
    child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide( // 👈 outline border
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              leading: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(5), // 👈 space between image and container border
                decoration: BoxDecoration(
                  color: Colors.white, // background color
                  borderRadius: BorderRadius.circular(25), // circular container
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // slightly smaller for inner image
                  child: Image.asset(
                    'assets/images/attendancelist.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text(
                'Post Complaint',
                style:  const TextStyle(
                    fontFamily: 'Montserrat',
                    // color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
              size: 20,
                color: Colors.grey.shade400,
              ),
              // trailing:  Image.asset('assets/images/small_right_arrow.png',
              //   height: 20,
              //   width: 20,
              //   fit: BoxFit.cover,
              // ),
              onTap: () {
                // Handle tap action
                debugPrint("-------Post Complaint------");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostComplaintScreen()));
              },
            ),
            SizedBox(height: 5),
             Padding(
              padding: EdgeInsets.only(left: 0,right: 0),
              child: Divider(
                height: 1,
                color: Colors.grey.shade300,
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              leading: Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(5), // 👈 space between image and container border
                decoration: BoxDecoration(
                  color: Colors.white, // background color
                  borderRadius: BorderRadius.circular(25), // circular container
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // slightly smaller for inner image
                  child: Image.asset(
                    'assets/images/meeting.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text(
                'Complaint Status',
                style:  const TextStyle(
                    fontFamily: 'Montserrat',
                    // color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
              size: 20,
              color: Colors.grey.shade400,
            ),
              // trailing: Image.asset('assets/images/small_right_arrow.png',
              //   height: 20,
              //   width: 20,
              //   fit: BoxFit.cover,
              // ),
              onTap: () {
                // Handle tap action
                //debugPrint("Profile tapped!");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ComplaintStatusScreen()));
              },
            ),
          ],
        )
    ),
  );
}
Widget bottomListCard(int index){
  return Card(
    elevation: 4,
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide( // 👈 outline border
        color: Colors.grey.shade300,
        width: 1,
      ),
    ),
    child: SizedBox(
      height: 120,
      width: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          SizedBox(
            height: 80,
            width: 80,
            child: Image.asset(
              "assets/images/barger1.png", // replace with your image
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 8), // spacing
          // Text
          const Text(
            "Profile",
            style:  const TextStyle(
                fontFamily: 'Montserrat',
                // color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}