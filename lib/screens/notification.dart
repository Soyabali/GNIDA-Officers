import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noidaone/Controllers/notificationRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generalFunction.dart';


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

  List<Map<String, dynamic>>? notificationList;
  String? sName, sContactNo;
  GeneralFunction generalFunction = GeneralFunction();

  getnotificationResponse() async {
    notificationList = await NotificationRepo().notification(context);
    print('------44----$notificationList');
    setState(() {
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getlocalvalue();
    getnotificationResponse();
    super.initState();
  }
  getlocalvalue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sName = prefs.getString('sName') ?? "";
      sContactNo = prefs.getString('sContactNo') ?? "";
      print("------148---$sName");
      print("------1149---$sContactNo");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: generalFunction.appbarFunction("Notification"),
        // drawer
        drawer: generalFunction.drawerFunction(context,'$sName','$sContactNo'),

        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: ListView.separated(
            itemCount: notificationList != null ? notificationList!.length : 0,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(); // Customize this as needed
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(
                      Icons.notification_important,
                      size: 30,
                      color: Color(0xFF255899),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            notificationList?[index]['sTitle'].toString() ?? '',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            notificationList?[index]['sNotification'].toString() ?? '',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              color: Color(0xff3f617d),
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                size: 18,
                                color: Color(0xff3f617d),
                              ),
                              SizedBox(width: 5),
                              Text(
                                notificationList?[index]['dRecivedAt'].toString() ?? '',
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xff3f617d),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
    );

  }
}
