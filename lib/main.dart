import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:noidaone/resources/app_strings.dart';
import 'package:noidaone/screens/splacescreen.dart';
import 'package:provider/provider.dart';

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
          theme: ThemeData(
            primarySwatch: Colors.blue,
            //
          ),
          initialRoute: AppStrings.routeToSplash,
          home: Splace(),
          builder: EasyLoading.init(),
        );
  }
}
