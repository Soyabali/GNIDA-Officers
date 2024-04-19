import 'package:flutter/material.dart';

class Mypoint extends StatelessWidget {
  const Mypoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      appBar: AppBar(title: Text('MyPoint'),),
      body: Center(
        child: Text('MyPoint',style: TextStyle(fontSize: 20,color: Colors.black),),
      ),
    );
  }
}

