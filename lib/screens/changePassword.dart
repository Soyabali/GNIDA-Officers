import 'package:flutter/material.dart';

class ChangePassWord extends StatelessWidget {
  const ChangePassWord({super.key});

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
      appBar: AppBar(title: Text('ChangePassWord'),),
      body: Center(
        child: Text('ChangePassWord',style: TextStyle(fontSize: 20,color: Colors.black),),
      ),
    );
  }
}

