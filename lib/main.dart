import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:noidaone/screens/homeScreen.dart';
import 'package:noidaone/screens/homepagesecod.dart';
import 'package:noidaone/screens/splacescreen.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {

  runApp(
    const OKToast(
      child: MyApp(), // or your root widget
    ),
  );
  configLoading();
}
 var result;
configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      // MultiProvider(
      //   providers: [
      //     // ListenableProvider<LoginProvider>(create: (_) => LoginProvider()),
      //     // ChangeNotifierProvider<LoginProvider>(
      //     //     create: (_) => LoginProvider()),
      //
      //     // ChangeNotifierProvider<UserListProvider>(
      //     //     create: (_) => UserListProvider()),
      //     //      ChangeNotifierProvider<CompleteListProvider>(
      //     //     create: (_) => CompleteListProvider()),
      //     //      ChangeNotifierProvider<PendingListProvider>(
      //     //     create: (_) => PendingListProvider()),
      //     //        ChangeNotifierProvider<ProfileProvider>(
      //     //     create: (_) => ProfileProvider()),
      //   ],

        //ReportDownlodeProvider
         MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: getApplicationTheme(),
           theme: ThemeData(
             drawerTheme: const DrawerThemeData(
               backgroundColor: Colors.white, // all drawers white by default
             ),
           ),
          home: Splace(),
          // home: goNext(context),
          // theme: getApplicationTheme(),
          builder: EasyLoading.init(),
        );
  }
  //
  goNext(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var iAgencyCode = prefs.getString('iAgencyCode').toString();
    if(iAgencyCode=="1"){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }else if(iAgencyCode=="5"){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen_2()),
      );
    }else{
      Splace();
    }

  }
}
