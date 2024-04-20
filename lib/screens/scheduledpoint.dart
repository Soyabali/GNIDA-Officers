import 'package:flutter/material.dart';
import 'homeScreen.dart';

class ScheduledPointScreen extends StatelessWidget {
  const ScheduledPointScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white, // Change the color of the drawer icon here
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SchedulePointScreen(),
    );
  }
}

class SchedulePointScreen extends StatefulWidget {
  const SchedulePointScreen({Key? key}) : super(key: key);

  @override
  State<SchedulePointScreen> createState() => _SchedulePointScreenState();
}

class _SchedulePointScreenState extends State<SchedulePointScreen> {
  var variableName;
  var variableName2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF255899),
        leading: GestureDetector(
            onTap: () {
              //Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back_ios),
            )),
        title: const Text(
          'Scheduled Point',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
            children: <Widget>[

              const Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: SearchBar(),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
                    child: Card(
                      elevation: 1,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.grey, // Outline border color
                              width: 0.2, // Outline border width
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // MyListTile(),
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 30.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15.0),
                                          border: Border.all(
                                            color:Color(0xFF255899), // Outline border color
                                            width: 0.5, // Outline border width
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "1.",
                                            style:TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF255899),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    SizedBox(width: 5),
                                    const Column(
                                      children: <Widget>[
                                        Text(
                                          'C&D Waste',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xff3f617d),
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Point Name',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xff3f617d),
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: Container(
                                  height: 0.5,
                                  color: Color(0xff3f617d),
                                ),
                              ),
                              SizedBox(height: 5),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.forward,
                                    size: 10,
                                    color: Color(0xff3f617d),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Sector',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF255899),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Sector-1',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xff3f617d),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.forward, size: 10,
                                      color:  Color(0xff3f617d)),
                                  SizedBox(width: 5),
                                  Text(
                                    'Location',
                                    style:  TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF255899),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Near underground Car Parking',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xff3f617d),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // e4e4e4
                              Container(
                                color: Color(0xffe4e4e4),
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'View Image',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF255899),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(
                                            Icons.forward_sharp,
                                            color: Color(0xFF255899),
                                          )
                                        ],
                                      ),
                                      Container(height: 10, width: 1, color: Colors.grey),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Action',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF255899),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(
                                            Icons.forward_sharp,
                                            color: Color(0xFF255899),
                                          ),
                                        ],
                                      ),
                                      Container(height: 10, width: 1, color: Colors.grey),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('Navigate',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF255899),
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold)),
                                          // SizedBox(width: 5),
                                          //Icon(Icons.forward_sharp,color: Color(0xFF255899))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 10),
                    child: Card(
                      elevation: 1,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: Colors.grey, // Outline border color
                              width: 0.2, // Outline border width
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // MyListTile(),
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        width: 30.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15.0),
                                          border: Border.all(
                                            color:Color(0xFF255899), // Outline border color
                                            width: 0.5, // Outline border width
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "1.",
                                            style:TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF255899),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    SizedBox(width: 5),
                                    const Column(
                                      children: <Widget>[
                                        Text(
                                          'C&D Waste',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xff3f617d),
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Point Name',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Color(0xff3f617d),
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15),
                                child: Container(
                                  height: 0.5,
                                  color: Color(0xff3f617d),
                                ),
                              ),
                              SizedBox(height: 5),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.forward,
                                    size: 10,
                                    color: Color(0xff3f617d),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Sector',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF255899),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Sector-1',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xff3f617d),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(Icons.forward, size: 10,
                                      color:  Color(0xff3f617d)),
                                  SizedBox(width: 5),
                                  Text(
                                    'Location',
                                    style:  TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF255899),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  'Near underground Car Parking',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xff3f617d),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),
                              // e4e4e4
                              Container(
                                color: Color(0xffe4e4e4),
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'View Image',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF255899),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(
                                            Icons.forward_sharp,
                                            color: Color(0xFF255899),
                                          )
                                        ],
                                      ),
                                      Container(height: 10, width: 1, color: Colors.grey),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Action',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF255899),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(
                                            Icons.forward_sharp,
                                            color: Color(0xFF255899),
                                          ),
                                        ],
                                      ),
                                      Container(height: 10, width: 1, color: Colors.grey),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('Navigate',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF255899),
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold)),
                                          // SizedBox(width: 5),
                                          //Icon(Icons.forward_sharp,color: Color(0xFF255899))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              
          
            ],
          ),
      );


  }
}

// ListTile CLASS
class MyListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              color: Colors.grey, // Outline border color
              width: 0.5, // Outline border width
            ),
            color: Colors.white,
          ),
          child: const Center(
            child: Text(
              "1.",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          )),
      title: const Text(
        'C&D Waste',
        style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold),
      ),
      subtitle: const Text(
        'Point Name',
        style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.black54,
            fontSize: 14.0,
            fontWeight: FontWeight.bold),
      ),
      onTap: () {
        // Handle onTap
      },
    );
  }
}

// Searchbar
class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Colors.grey, // Outline border color
            width: 0.2, // Outline border width
          ),
          color: Colors.white,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Colors.black54,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter Keywords',
                  hintStyle:  TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xFF707d83),
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
