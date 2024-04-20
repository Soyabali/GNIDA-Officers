import 'package:flutter/material.dart';
import 'package:noidaone/screens/homeScreen.dart';
import '../resources/app_strings.dart';
import '../resources/component.dart';
import '../resources/values_manager.dart';

class MarkPointScreen extends StatelessWidget {
  const MarkPointScreen({super.key});

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
  String? _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF255899),
        leading: GestureDetector(
            onTap: () {
              //Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      const HomePage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back_ios),
            )),
        title: const Text(
          'Mark Points',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 130, // Height of the container
              width: 200, // Width of the container
              child: Opacity(
                opacity: 0.9,
                child: Image.asset(
                  'assets/images/step3.jpg', // Replace 'image_name.png' with your asset image path
                  fit:
                      BoxFit.cover, // Adjust the image fit to cover the container
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                    color: Colors.white, // Background color of the container
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Color of the shadow
                        spreadRadius: 5, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: Offset(0, 3), // Offset of the shadow
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 0,right: 10,top: 10),
                            child: Image.asset(
                              'assets/images/favicon.png', // Replace with your image asset path
                              width: 14,
                              height: 14,
                            ),
                          ),
                          const Text(
                            'Fill the below details',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Color(0xFF707d83),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold)
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(left: 8,right: 2,bottom: 2),
                                child: const Icon(
                                  Icons.forward_sharp,
                                  size: 12,
                                  color: Colors.black54,
                                )),
                            const Text(
                              'Point Type',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF707d83),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)
                            ),
                          ],
                        ),
                      ),
                      _casteDropDownWithValidation(),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(left: 8,right: 2),
                                child: const Icon(
                                  Icons.forward_sharp,
                                  size: 12,
                                  color: Colors.black54,
                                )),
                            const Text(
                                'Sector',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF707d83),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)
                            ),
                          ],
                        ),
                      ),
                      _casteDropDownWithValidation(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5,top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(left: 8,right: 2),
                                child: const Icon(
                                  Icons.forward_sharp,
                                  size: 12,
                                  color: Colors.black54,
                                )),
                            const Text(
                                'Location',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF707d83),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0),
                        child: Container(
                          height: 42,
                          color: Color(0xFFf2f3f5),
                          child: TextFormField(
                            //controller: _phoneNumberController,
                            // keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              // labelText: AppStrings.txtMobile,
                             // border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: AppPadding.p10),
                              //prefixIcon: Icon(Icons.phone,color:Color(0xFF255899),),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5,top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(left: 8,right: 2),
                                child: const Icon(
                                  Icons.forward_sharp,
                                  size: 12,
                                  color: Colors.black54,
                                )),
                            const Text(
                                'Description',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF707d83),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0),
                        child: Container(
                          height: 42,
                        //  color: Colors.black12,
                          color: Color(0xFFf2f3f5),
                          child: TextFormField(
                            //controller: _phoneNumberController,
                            // keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              // labelText: AppStrings.txtMobile,
                            //  border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: AppPadding.p10),
                              //prefixIcon: Icon(Icons.phone,color:Color(0xFF255899),),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5,top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(left: 8,right: 2),
                                child: const Icon(
                                  Icons.forward_sharp,
                                  size: 12,
                                  color: Colors.black54,
                                )),
                            const Text(
                              'Upload Photo',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF707d83),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold)
                            ),
                          ],
                        ),
                      ),
                      ContainerWithRow(),
        
                      ElevatedButton(onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF255899), // Hex color code (FF for alpha, followed by RGB)
                          ),
                          child: const Text("Submit",style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Container code with two widget one is Colume and another is icon

  // dropdown widget
  // caste dropdown with a validation
  Widget _casteDropDownWithValidation() {
    return Container(
      height: 45,
      //color: Color(0xFFD3D3D3),
        color: Color(0xFFf2f3f5),

      child: DropdownButtonFormField<String>(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        value: _chosenValue,
        //  key: casteDropdownFocus,
        hint: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: RichText(
            text: const TextSpan(
              text: 'Select Point Type',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
              children: <TextSpan>[
                TextSpan(
                    text: '',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        onChanged: (salutation) {
          setState(() {
            _chosenValue = salutation;
            //  _isShowChosenValueError = false;
            print('CAST GENERATE XXXXXX $_chosenValue');
          });
        },
        items: ['General', 'OBC', 'SC', 'ST']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
