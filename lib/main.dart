import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:noidaone/resources/color_manager.dart';
import 'package:noidaone/resources/theme_manager.dart';
import 'package:noidaone/screens/homeScreen.dart';
import 'package:noidaone/screens/homepagesecod.dart';
import 'package:noidaone/screens/splacescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
  configLoading();
}

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
        primaryColor: ColorManager.primary,
        primaryColorLight: ColorManager.primaryOpacity70,
        primaryColorDark: ColorManager.darkPrimary,
        disabledColor: ColorManager.grey1,
        // ripple color
        splashColor: ColorManager.primaryOpacity70,
        // will be used incase of disabled button for example
        hintColor: ColorManager.grey
        ),

          // theme: ThemeData(
          //   primarySwatch: Colors.blue,
          //   //
          // ),
         // initialRoute: AppStrings.routeToSplash,
          home: Splace(),
          // home: goNext(context),
          // theme: getApplicationTheme(),
          builder: EasyLoading.init(),
        );
  }
  //
  goNext(BuildContext context) async{
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
