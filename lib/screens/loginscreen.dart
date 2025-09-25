import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noidaone/resources/assets_manager.dart';
import 'package:noidaone/resources/values_manager.dart';
import 'package:noidaone/screens/homeScreen.dart';
import '../resources/app_strings.dart';
import '../resources/app_text_style.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  bool _isObscured = true;
  bool _isObscured2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

                  mainAxisAlignment: MainAxisAlignment.start,
            //      crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 22,),
                          SizedBox(
                            height: AppSize.s75,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(AppMargin.m10),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(ImageAssets.roundcircle), // Replace with your image asset path
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  width: AppSize.s50,
                                  height: AppSize.s50,
                                  child: Image.asset(
                                    ImageAssets.noidaauthoritylogo, // Replace with your image asset path
                                    width: AppSize.s50,
                                    height: AppSize.s50,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: AppPadding.p10),
                                  child: Container(
                                    margin: EdgeInsets.all(AppMargin.m10),
                                    child: Image.asset(
                                      ImageAssets.favicon, // Replace with your image asset path
                                      width: AppSize.s50,
                                      height: AppSize.s50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Container(
                                height: AppSize.s145,
                                width: AppSize.s145,
                                margin: const EdgeInsets.all(AppMargin.m20),
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(ImageAssets.roundcircle,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(AppMargin.m16),
                                  child: Image.asset(ImageAssets.loginIcon, // Replace with your image asset path
                                    width: AppSize.s145,
                                    height: AppSize.s145,
                                    fit: BoxFit.contain, // Adjust as needed
                                  ),
                                ),
                              ),
                            ),
                          ),

                           Padding(
                            padding: EdgeInsets.only(left: AppPadding.p15),
                            child: Text(
                                AppStrings.txtLogin,
                                style: AppTextStyle.font18OpenSansboldAppBasicTextStyle
                            ),
                           ),

                          const SizedBox(height: AppSize.s20),
                          // mobile field
                          Padding(
                            padding: const EdgeInsets.only(left: AppPadding.p15,right: AppPadding.p15),
                            child: TextFormField(
                              controller: _phoneNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: AppStrings.txtMobile,
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: AppPadding.p10),
                                prefixIcon: Icon(Icons.phone,color:Color(0xFF255899),),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSize.s10),
                          // passWord
                          Padding(
                            padding: const EdgeInsets.only(left: AppPadding.p10,right: AppPadding.p10),
                            child: TextFormField(
                              obscureText: _isObscured,
                              controller: _passWordController,
                              decoration: InputDecoration(
                                labelText: AppStrings.txtpassword,
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
                                prefixIcon: const Icon(Icons.lock,color:Color(0xFF255899)),
                                suffixIcon: IconButton(
                                  icon:
                                  Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObscured = !_isObscured;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSize.s10),
                          // login
                          Padding(
                            padding: const EdgeInsets.only(left: AppPadding.p15,right: AppPadding.p15),
                            child: InkWell(
                              onTap: (){
                                print('--------------');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const HomePage()));
                                // Navigator.pushReplacement(context,
                                //                  MaterialPageRoute(builder:
                                //                      (context) => HomePage()
                                //                  )   // VisitListHome
                                //              );
                              },
                              child: Container(
                                width: double.infinity, // Make container fill the width of its parent
                                height: AppSize.s45,
                                padding: EdgeInsets.all(AppPadding.p5),
                                decoration: BoxDecoration(
                                  color: Color(0xFF255899), // Background color using HEX value
                                  borderRadius: BorderRadius.circular(AppMargin.m10), // Rounded corners
                                ),
                                child: const Center(
                                  child: Text(
                                    AppStrings.txtLogin,
                                    style: TextStyle(fontSize: AppSize.s16,
                                    color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // ForgotPass
                          GestureDetector(
                            onTap: () {
                              print('----');
                            },
                            child: const ListTile(
                              title: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  AppStrings.txtForgetPassword,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Color(0xFF255899),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600),
                              ),
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: AppSize.s0_5,
                            child: Container(
                              width: double.infinity, // Set width as needed
                              height: AppSize.s200, // Set height as needed
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage(
                                      ImageAssets.loginBottomnw), // Replace with your asset image path
                                  fit: BoxFit.cover, // You can adjust the fit as needed
                                ),
                                borderRadius:
                                BorderRadius.circular(AppPadding.p10), // Optional: border radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(AppSize.s0_5), // Shadow color
                                    spreadRadius: AppSize.s5, // Spread radius
                                    blurRadius: AppSize.s7, // Blur radius
                                    offset: Offset(0, 3), // Offset
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

      );

  }
}
