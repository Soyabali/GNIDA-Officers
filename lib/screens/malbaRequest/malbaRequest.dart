import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Controllers/GetCitizenMalbaRequestRepo.dart';
import '../../components/components.dart';
import '../generalFunction.dart';
import '../gnidaofficers/gnoidadashboard.dart';
import '../viewimage.dart';
import 'actionOnMalbaRequest.dart';

class MalbaRequestHome extends StatefulWidget {
  const MalbaRequestHome({Key? key}) : super(key: key);

  @override
  State<MalbaRequestHome> createState() => _SchedulePointScreenState();
}

class _SchedulePointScreenState extends State<MalbaRequestHome> {
  var variableName;
  var variableName2;
  List<Map<String, dynamic>>? internalComplaintList;
  List<Map<String, dynamic>> _filteredData = [];
  List bindAjencyList = [];
  List userAjencyList = [];
  var iAgencyCode;
  var agencyUserId;
  TextEditingController _searchController = TextEditingController();
  double? lat;
  double? long;
  GeneralFunction generalfunction = GeneralFunction();
  final distDropdownFocus = GlobalKey();
  var result,msg;

  // Get a api response
  intStatusComplaintResponse() async {
    internalComplaintList = await GetcitizenMalbaRequestRepo().getMalba(context);
    _filteredData = List<Map<String, dynamic>>.from(internalComplaintList ?? []);
    print('--65--$internalComplaintList');
    print('--66--$_filteredData');
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    intStatusComplaintResponse();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }


  // location
  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint("-------------Position-----------------");
    debugPrint(position.latitude.toString());

    lat = position.latitude;
    long = position.longitude;
    print('-----------105----$lat');
    print('-----------106----$long');
    // setState(() {
    // });
    debugPrint("Latitude: ----1056--- $lat and Longitude: $long");
    debugPrint(position.toString());
  }
  //
  void displayToast(String msg) {
    showToast(
      msg,
      duration: const Duration(seconds: 1),
      position: ToastPosition.center,
      backgroundColor: Colors.red,
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    );
    // Fluttertoast.showToast(
    //     msg: msg,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.red,
    //     textColor: Colors.white,
    //     fontSize: 16.0);
  }
  // makePhoneCall
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (!await launchUrl(launchUri)) {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFD31F76),
          leading: GestureDetector(
              onTap: () {
                //Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const GnoidaOfficersHome()));
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_back_ios),
              )),
          title: const Text(
            'Malba Request Status',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          iconTheme:  Theme.of(context).iconTheme.copyWith(color: Colors.white
        )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // scroll item after search bar
            Expanded(
              child: ListView.builder(
                itemCount: _filteredData.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> item = _filteredData[index];

                  return Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Card(
                            elevation: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                  color: Colors.white, // Outline border color
                                  width: 0.2, // Outline border width
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8, right: 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 30.0,
                                            height: 30.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(15.0),
                                              border: Border.all(
                                                color: Colors.grey,
                                                // Outline border color
                                                width:
                                                0.5, // Outline border width
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                                child: Text('${index +1}',style:const TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black45,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w600),)

                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                item['sReqNo'] ?? '',
                                                style: const TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              const Text(
                                                'Request Number',
                                                style:const TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.black45,
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 0),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                var fLatitude = item['fLatitude'] ?? '';
                                                var fLongitude = item['fLongitude'] ?? '';
                                                print('----462----${fLatitude}');
                                                print('-----463---${fLongitude}');
                                                // getLocation();
                                                if (fLatitude != null &&
                                                    fLongitude != null) {
                                                  generalfunction.launchGoogleMaps(fLatitude,fLongitude);

                                                } else {
                                                  displayToast("Please check the location.");
                                                }
                                              },
                                              child: Container(
                                                alignment: Alignment.centerRight,
                                                height: 40,
                                                width: 40,
                                                child: const Image(
                                                    image: AssetImage(
                                                        'assets/images/ic_google_maps.PNG')),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Container(
                                        height: 0.5,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        circle10(),
                                        SizedBox(width: 5),
                                        const Text(
                                          'Waste Type',
                                          style:const TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        item['sGRT'] ?? '',
                                        style:const TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.black45,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                     SizedBox(height: 10),
                                     Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        circle10(),
                                        SizedBox(width: 5),
                                        const Text(
                                          'Garbage Request Type',
                                          style:const TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        item['sWasteType'] ?? '',
                                        style:const TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.black45,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        circle10(),
                                        SizedBox(width: 5),
                                        const Text(
                                          'Contact Detail',
                                          style:const TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    // Contact Details
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(
                                            item['sUserName'] + " "+ item['sContactNo'],
                                            style:const TextStyle(
                                                fontFamily: 'Montserrat',
                                                color: Colors.black45,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            var phoneNumber =  item['sContactNo'];
                                            print('Call-----');
                                            _makePhoneCall(phoneNumber);

                                            },
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.call,
                                            color: Colors.green,
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),


                                    SizedBox(height: 10),
                                     Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        circle10(),
                                        SizedBox(width: 5),
                                        const Text(
                                          'Address',
                                          style:const TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        item['sAddress'] ?? '',
                                        style:const TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.black45,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        circle10(),
                                        SizedBox(width: 5),
                                        const Text(
                                          'Landmark',
                                          style:const TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        item['sMohalla'] ?? '',
                                        style:const TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.black45,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        circle10(),
                                        SizedBox(width: 5),
                                        const Text(
                                          'Remarks',
                                          style:const TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        item['sUserRemarks'] ?? '',
                                        style:const TextStyle(
                                            fontFamily: 'Montserrat',
                                            color: Colors.black45,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    const Divider(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 10),
                                    /// todo here take a row and go on
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.file_copy,
                                        color: Colors.green,
                                          size: 20,
                                        ),
                                        SizedBox(width: 10),
                                        const Text('Posted At : ',
                                          style:TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.green,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600),

                                        ),
                                        SizedBox(width: 10),// dRequestTime
                                        Text(item['dRequestTime'] ?? '',
                                          style:const TextStyle(
                                              fontFamily: 'Montserrat',
                                              color: Colors.green,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600),

                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Container(
                                            height: 25,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(20), // 👈 makes it capsule shaped
                                            ),
                                            alignment: Alignment.center, // centers the text
                                            child:Text(
                                                item['sStatus'] ?? '',
                                              style: TextStyle(color: Colors.white, fontSize: 12),
                                            ),
                                          ),
                                        )

                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Colors.white, Colors.grey, Colors.white],
                                          stops: [0.0, 0.5, 1.0],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          // Left Column
                                          Expanded(
                                            child: InkWell(
                                              onTap:(){
                                               print("Left Button ");
                                    },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      var images = item['sImage_1'];
                                                      // sReqNo
                                                      var sReqNo = item['sReqNo'];
                                                      // print(images);
                                                      //ImageScreen(sBeforePhoto: images);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ActionOnMalbaRequest(sBeforePhoto: images,sReqNo:sReqNo)));
                                                    },
                                                    child: const Text("Action"),
                                                  ),
                                                  const Icon(Icons.arrow_forward_ios, size: 16),
                                                ],
                                              ),
                                            ),
                                          ),

                                          // Divider in Middle
                                          Container(
                                            width: 1,
                                            height: 40,
                                            color: Colors.grey,
                                          ),

                                          // Right Column
                                          Expanded(
                                            child: InkWell(
                                              onTap: (){
                                                // print('Right Button');
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      var images = item['sImage_1'];
                                                     // print(images);
                                                      //ImageScreen(sBeforePhoto: images);
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ImageScreen(sBeforePhoto: images))); // ✅ Passing image URL
                                                    },
                                                    child: const Text("View Image"),
                                                  ),
                                                  const Icon(Icons.arrow_forward_ios, size: 16),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )

                                    ),
                                    SizedBox(height: 10)





                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
