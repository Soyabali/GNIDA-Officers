import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noidaone/screens/homeScreen.dart';
import '../Controllers/district_repo.dart';
import '../resources/values_manager.dart';
import 'flull_screen_image.dart';

class DryWetSegregationScreen extends StatelessWidget {
  const DryWetSegregationScreen({super.key});

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
  final _formKey = GlobalKey<FormState>();
  var sectorresponse;
  String? sec;
  List distList = [];
  var _dropDownValueDistric;
  final distDropdownFocus = GlobalKey();
  //--
  TextEditingController _locationController = TextEditingController();
  TextEditingController _remarkController = TextEditingController();
  // focus
  FocusNode locationfocus = FocusNode();
  FocusNode remarkfocus = FocusNode();
  File? _imageFile;

  // Sector Api get response
  updatedSector() async {
    distList = await DistRepo().getDistList();
    print(" -----xxxxx-  list Data--53---> $distList");
    setState(() {});
  }

  // pick images
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
  // bind sector in DropDownWidget
  Widget _bindSector() {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: 42,
        color: Color(0xFFf2f3f5),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
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
                        //print("Block list Ali xxxxxxxxx.... $blockList");
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
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatedSector();
  }

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
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back_ios),
            )),
        title: const Text(
          'Dry / Wet Segregation',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
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
                                'Remarks',
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: TextFormField(
                              focusNode: remarkfocus,
                              controller: _remarkController,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () =>
                                  FocusScope.of(context).nextFocus(),
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

                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFf2f3f5),
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
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 10,top: 5),
                                  child: Image(image: AssetImage('assets/images/ic_camera.PNG'),
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.fill,
                                  ),
                                  // child: Icon(
                                  //   Icons.camera,
                                  //   size: 24.0,
                                  //   color: Color(0xFF255899),
                                  // ),
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
                                      icon: const Icon(
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
                            var location = _locationController.text;
                            var remarks = _remarkController.text;
                            print('-505---$location');
                            print('--506--$remarks');
                            print('--507----DropDown-$_dropDownValueDistric');
                            print('--508---Image-$_imageFile');

                            if(_formKey.currentState!.validate() && location != null
                            && remarks!=null && _dropDownValueDistric!=null && _imageFile!=null){
                              /// Todo call Api
                              print('----Call Api----');
                              /// TODO REMOVE COMMENT AND APPLY right api
                            // var  loginMap = await DrywetSegregationSumitRepo()
                            //       .drywetsegregation(context, location!, remarks!,
                            //   _dropDownValueDistric,_imageFile);
                            }else{
                              print('----Not Call Api----');
                              if(_locationController.text.isEmpty){
                                locationfocus.requestFocus();
                                /// TODO APPLY FOCUS CONDITION ON TextFormField
                              }else if(_remarkController.text.isEmpty){
                                remarkfocus.requestFocus();
                              }
                            }
                            /// TODO Apply logic behage of api response
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
    );
  }
}

