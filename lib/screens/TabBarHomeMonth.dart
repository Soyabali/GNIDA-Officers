import 'package:flutter/material.dart';
import 'package:noidaone/Controllers/usercontributionMonthRepo.dart';
import '../Controllers/userContributionRepo.dart';

class TabBarHomeMonth extends StatelessWidget {
  const TabBarHomeMonth({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabPageMonth(),
    );
  }
}
class TabPageMonth extends StatefulWidget {
  const TabPageMonth({Key? key}) : super(key: key);

  @override
  State<TabPageMonth> createState() => _TabPageState();
}

class _TabPageState extends State<TabPageMonth> {

  List<Map<String, dynamic>>? userContributionMonthList;

  userContributionResponse() async {
    userContributionMonthList = await UserContributionMontRepo().userContributionMonth(context);
    print('--30---xxxx------$userContributionMonthList');
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    userContributionResponse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Container(
              //  height: MediaQuery.of(context).size.height,
                height: 330,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFf2f3f5), // Container background color
                  borderRadius: BorderRadius.circular(20),
                ),
                child:ListView.builder(
                    itemCount: userContributionMonthList != null ? userContributionMonthList!.length - 3 : 0,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8,bottom: 0),
                          child: Card(
                            elevation: 8,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('${index+4}', style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      // color: Colors.white,
                                      color: Color(0xFF707d83),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),),
                                  // First TextView
                                  const SizedBox(width: 8),
                                  // icon
                                  const Icon(Icons.person, size: 20, color: Color(0xFF3375af),),
                                  // Admin icon
                                  const SizedBox(width: 8),
                                  Text(userContributionMonthList?[index+3]['sName'].toString() ?? '',
                                    style: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF707d83),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),),
                                  // Second TextView
                                  Spacer(),
                                  // To push the last Text to the rightmost
                                  Text(userContributionMonthList?[index+3]['iEarnedPoints'].toString() ??
                                      '',
                                      style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Color(0xFFad964a),
                                          //color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold)),
                                  // Last TextView
                                ],
                              ),
                            ),

                          ),
                        ),
                      );
                    }
                ),
              ))
        ],
      ),
    );
  }
}


