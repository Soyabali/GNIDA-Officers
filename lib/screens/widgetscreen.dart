import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



Widget _buildTab(String text, BuildContext context) {
  return Container(
    height: 30,
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 0),
    decoration: BoxDecoration(
      // color: Theme.of(context).primaryColor,
      //color: Colors.green,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)
      ),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold),

      ),
    ),
  );
}