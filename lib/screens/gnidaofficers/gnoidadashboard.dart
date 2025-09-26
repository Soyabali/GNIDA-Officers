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

  @override
  void initState() {
    // TODO: implement initState
    controller = GifController(vsync: this);
    controller.repeat(min: 0, max: 29, period: const Duration(seconds: 2));
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
          buildFancyStack(),
          listTile(),
          SizedBox(height: 5),
          Padding(
             padding: const EdgeInsets.only(left: 10),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/images/three_line.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.cover,
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

