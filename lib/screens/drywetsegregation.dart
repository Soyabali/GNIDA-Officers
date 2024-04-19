import 'package:flutter/material.dart';

class DryWetSegregationScreen extends StatelessWidget {
  const DryWetSegregationScreen({super.key});

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
      appBar: AppBar(title: Text('DryWetSegregation'),),
      body: const Center(
        child: Text('DryWetSegregation',style: TextStyle(fontSize: 20,color: Colors.black),),
      ),
    );
  }
}

