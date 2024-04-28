
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noidaone/screens/homeScreen.dart';
import '../Controllers/block_repo.dart';
import '../Controllers/district_repo.dart';
import '../Controllers/markLocationRepo.dart';
import '../Controllers/markpointSubmit.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'flull_screen_image.dart';


class DailyActivitytScreen extends StatelessWidget {
  const DailyActivitytScreen({super.key});

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
  List stateList = [];
  List distList = [];
  List blockList = [];
  List marklocationList = [];
  //File? image;

  //
  // Distic List
  updatedSector() async {
    distList = await DistRepo().getDistList();
    print(" -----xxxxx-  list Data--65---> $distList");
    setState(() {});
  }
  marklocationData() async {
    marklocationList = await MarkLocationRepo().getmarklocation();
    print(" -----xxxxx-  marklocationList--- Data--62---> $marklocationList");
    setState(() {});
  }


  String? _chosenValue;
  var msg;
  var result;
  var SectorData;
  var stateblank;
  final stateDropdownFocus = GlobalKey();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  // focus
  FocusNode locationfocus = FocusNode();
  FocusNode descriptionfocus = FocusNode();

  List? data;
  //List distList = [];
  var _selectedStateId;
  var _dropDownValueDistric;
  var _dropDownValueMarkLocation;
  var _dropDownValue;
  var sectorresponse;
  String? sec;
  final distDropdownFocus = GlobalKey();
  File? _imageFile;
  final _formKey = GlobalKey<FormState>();

  // pick Image Codew
  Future<void> _getImageFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);

      });
      print('----129---$_imageFile');
    }
  }
  // InitState
  @override
  void initState() {
    // TODO: implement initState
    updatedSector();
    marklocationData();
    super.initState();
    locationfocus = FocusNode();
    descriptionfocus = FocusNode();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    locationfocus.dispose();
    descriptionfocus.dispose();
  }
  // Todo bind sector code
  Widget _bindSector() {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: 42,
        color: Color(0xFFf2f3f5),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              hint: RichText(
                text: const TextSpan(
                  text: "Please choose a Sector",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
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
              ), // Not necessary for Option 1
              value: _dropDownValueDistric,
              key: distDropdownFocus,
              onChanged: (newValue) {
                setState(() {
                  _dropDownValueDistric = newValue;
                  print('---187---$_dropDownValueDistric');
                  //  _isShowChosenDistError = false;
                  // Iterate the List
                  distList.forEach((element) {
                    if (element["sSectorName"] == _dropDownValueDistric) {
                      setState(() {
                        // _selectedDisticId = element['id'];
                      });
                      // if (_selectedDisticId != null) {
                      //   updatedBlock();
                      // } else {
                      //   print('Please Select Distic name');
                      // }
                      // print("Distic Id value xxxxx.... $_selectedDisticId");
                      print("Distic Name xxxxxxx.... $_dropDownValueDistric");
                      print("Block list Ali xxxxxxxxx.... $blockList");
                    }
                  });
                });
              },
              items: distList.map((dynamic item) {
                return DropdownMenuItem(
                  child: Text(item['sSectorName'].toString()),
                  value: item["sSectorName"].toString(),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
  /// Todo same way you should bind point Type data.
  Widget _bindMarkLocation() {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: 42,
        color: Color(0xFFf2f3f5),

        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              hint: RichText(
                text: const TextSpan(
                  text: "Please choose a Sector",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
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
              ), // Not necessary for Option 1
              value: _dropDownValueMarkLocation,
              // key: distDropdownFocus,
              onChanged: (newValue) {
                setState(() {
                  _dropDownValueMarkLocation = newValue;
                  print('---233---$_dropDownValueMarkLocation');
                  //  _isShowChosenDistError = false;
                  // Iterate the List
                  marklocationList.forEach((element) {
                    if (element["sPointTypeName"] == _dropDownValueDistric) {
                      setState(() {
                        // _selectedDisticId = element['id'];
                      });
                      // if (_selectedDisticId != null) {
                      //   updatedBlock();
                      // } else {
                      //   print('Please Select Distic name');
                      // }
                      // print("Distic Id value xxxxx.... $_selectedDisticId");
                      print("Distic Name xxxxxxx.... $_dropDownValueDistric");
                      print("Block list Ali xxxxxxxxx.... $blockList");
                    }
                  });
                });
              },
              items: marklocationList.map((dynamic item) {
                return DropdownMenuItem(
                  child: Text(item['sPointTypeName'].toString()),
                  value: item["sPointTypeName"].toString(),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  /// Algo.  First of all create repo, secodn get repo data in the main page after that apply list data on  dropdown.

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
          'Daily Activity',
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
            SizedBox(
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
                  child: Form(
                    key: _formKey,
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
                        // _casteDropDownWithValidation(),
                        _bindSector(),
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
                                  'Activity Details',
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
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: TextFormField(
                                focusNode: locationfocus,
                                controller: _locationController,
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () =>
                                    FocusScope.of(context).nextFocus(),
                                decoration: const InputDecoration(
                                  // labelText: AppStrings.txtMobile,
                                  // border: OutlineInputBorder(),
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: AppPadding.p10),

                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return 'Enter location';
                                //   }
                                //   return null;
                                // },
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
                        //ContainerWithRow(),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFf2f3f5),
                            borderRadius: BorderRadius.circular(10.0), // Border radius
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          'Click Photo',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black54,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Please clock here to take a photo',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.redAccent,
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(width: 10),
                                            Icon(Icons.forward_sharp,size: 10,color: Colors.redAccent),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    // pickImage();
                                    _getImageFromCamera();
                                    print('---------530-----');

                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10,top: 5),
                                    child: Icon(
                                      Icons.camera,
                                      size: 24.0,
                                      color: Color(0xFF255899),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              _imageFile != null
                                  ? Stack(
                                children: [
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FullScreenPage(
                                                    child: _imageFile!,
                                                    dark: true,
                                                  )));
                                    },
                                    child: Container(
                                        color: Colors.lightGreenAccent,
                                        height: 100,
                                        width: 70,
                                        child: Image.file(
                                          _imageFile!,
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                  Positioned(
                                      bottom: 65,
                                      left: 35,
                                      child: IconButton(
                                        onPressed: () {
                                          _imageFile = null;
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                      ))
                                ],
                              ) :
                              Text(
                                "Photo is required.",
                                style:
                                TextStyle(color: Colors.red[700]),
                              )
                            ]),
                        ElevatedButton(
                            onPressed: () async {
                              print('-------615---');
                              var location = _locationController.text;
                              var description = _descriptionController.text;
                              print('--Location --$location');
                              print('--description --$description');
                              print('--pointType --$_chosenValue');
                              print('--sectorType --$_dropDownValueDistric');
                              print('--ImagePath --$_imageFile');
                              // apply condition
                              if(_formKey.currentState!.validate() && location != null
                                  && description != null && _chosenValue !=null && _dropDownValueDistric !=null
                                  && _imageFile!=null
                              ){
                                print('---Api Call---');

                                /// TODO REMOVE COMMENT AND apply proper api below and handle api data

                                // var markPointSubmitResponse = await MarkPointSubmitRepo()
                                //        .markpointsubmit(context, phone!, password!);

                              }else{
                                print('---Api Not Call---');
                                // here you should apply again if condition
                                if(_locationController.text.isEmpty){
                                  locationfocus.requestFocus();
                                }else if(_descriptionController.text.isEmpty){
                                  descriptionfocus.requestFocus();
                                }
                              }
                              /// Todo next Apply condition


                            },
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
