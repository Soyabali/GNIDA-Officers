import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {

  final sBeforePhoto;

  const ImageScreen({super.key,required this.sBeforePhoto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Network image
          Image.network(
            '$sBeforePhoto',
            fit: BoxFit.cover, // Adjust this to fit your image size
            width: double.infinity,
            height: double.infinity,
          ),
          // Close button
          Positioned(
            top: 50.0,
            right: 20.0,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.red),
              onPressed: () {
                Navigator.pop(context); // Close the screen
              },
            ),
          ),
        ],
      ),
    );
  }
}


