import 'package:flutter/material.dart';

class ScheduledPointScreen extends StatelessWidget {
  const ScheduledPointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
      appBar: AppBar(title: Text('ScheduledPointScreen'),),
      body: const Center(
        child: Text('ScheduledPointScreen',style: TextStyle(fontSize: 20,color: Colors.black),),
      ),
    );
  }
}

