import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {

  final sBeforePhoto;

  const ImageScreen({super.key,required this.sBeforePhoto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        backgroundColor: const Color(0xFFD31F76),
    leading: GestureDetector(
    onTap: () {
    Navigator.pop(context);
    // Navigator.push(context,
    // MaterialPageRoute(builder: (context) => const GnoidaOfficersHome()));
    },
    child: const Padding(
    padding: EdgeInsets.all(8.0),
    child: Icon(Icons.arrow_back_ios),
    )),
    title: const Text(
    'ImageView',
    style: TextStyle(
    fontFamily: 'Montserrat',
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.bold),

    ),
    ),
      body: Stack(
        children: [
          sBeforePhoto != null && sBeforePhoto.isNotEmpty
              ? Image.network(
            sBeforePhoto,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Text(
                  "No Image",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              );
            },
          )
              : const Center(
            child: Text(
              "No Image",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),

          // Close button
          Positioned(
            top: 50.0,
            right: 20.0,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),

      // body: Stack(
      //   children: [
      //     // Network image
      //     Image.network(
      //       '$sBeforePhoto',
      //       fit: BoxFit.cover, // Adjust this to fit your image size
      //       width: double.infinity,
      //       height: double.infinity,
      //     ),
      //     // Close button
      //     Positioned(
      //       top: 50.0,
      //       right: 20.0,
      //       child: IconButton(
      //         icon: Icon(Icons.close, color: Colors.red),
      //         onPressed: () {
      //           Navigator.pop(context); // Close the screen
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}


