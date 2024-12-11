import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umrahcar/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar/widgets/button.dart';
import 'package:umrahcar/widgets/navbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:umrahcar/screens/signup_screen.dart';
import 'package:umrahcar/screens/forgot_password_screen.dart';

import '../models/login_model.dart';
import '../service/local_db.dart';
import '../service/rest_api_serivice.dart';
import '../utils/const.dart';
import 'homepage_screen.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String backImage = "assets/images/custom-car.png";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscure = true;

  DateTime? currentBackPressTime;

  String? validateEmail(String? value) {
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(value!);
    if (value.isEmpty) {
      return "Email field is required!";
    } else if (!emailValid) {
      return "Email field is not valid!";
    } else {
      return null;
    }
  }

  Future<bool> onExitApp() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Tap again to exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color(0xFF222124),
        textColor: Colors.white,
        fontSize: 16,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  void configOneSignel() {
    OneSignal.shared.setAppId(onesignalAppId);
  }

  @override
  void initState() {
    configOneSignel();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: onExitApp,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: mainColor,
          //   elevation: 0,
          // ),
          backgroundColor: mainColor,
          body: Container(
            decoration: const BoxDecoration(),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.04),
                      Container(
                        width: size.width,
                        height: size.height * 0.36,
                        decoration: const BoxDecoration(),
                        child: SvgPicture.asset(
                          'assets/app-icon.svg',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Welcome!\n',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: 'Login to your Account',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),

                      // SizedBox(height: size.height * 0.02),
                      // const Text(
                      //   '(For Agents)',
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     fontFamily: 'Montserrat-Regular',
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      SizedBox(height: size.height * 0.06),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            bool emailValid = RegExp(
                                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                .hasMatch(value!);
                            if (value.isEmpty) {
                              return "Email field is required!";
                            } else if (!emailValid) {
                              return "Email field is not valid!";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Color(0xFF6B7280),
                          ),
                          decoration: InputDecoration(
                            filled: false,
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              wordSpacing: 2,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            hintText: "Email",
                            hintStyle: const TextStyle(
                              color: Color(0xFF929292),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: SvgPicture.asset(
                              'assets/images/email-icon.svg',
                              width: 25,
                              height: 25,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: _obscure,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password field is required!';
                            } else if (value.length < 6) {
                              return "Password must be 6 Digits";
                            }
                            return null;
                          },
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Color(0xFF6B7280),
                          ),
                          decoration: InputDecoration(
                            filled: false,
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              wordSpacing: 2,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            hintText: "Password",
                            hintStyle: const TextStyle(
                              color: Color(0xFF929292),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: SvgPicture.asset(
                              'assets/images/password-icon.svg',
                              width: 25,
                              height: 25,
                              fit: BoxFit.scaleDown,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscure = !_obscure;
                                });
                              },
                              child: _obscure
                                  ? SvgPicture.asset(
                                      'assets/images/hide-password-icon.svg',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.scaleDown,
                                    )
                                  : SvgPicture.asset(
                                      'assets/images/show-password-icon.svg',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.scaleDown,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: ConstantColor.primaryColor,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.06),
                      GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              final status =
                                  await OneSignal.shared.getDeviceState();
                              String? onesignalId = status?.userId;

                              print("onesignalId: $onesignalId");
                              print("email: ${emailController.text}");
                              print("password: ${passwordController.text}");
                              var mapData = {
                                "onesignal_id": "$onesignalId",
                                "email": emailController.text,
                                "password": passwordController.text,
                              };
                              var response =
                                  await DioClient().login(mapData, context);
                              print(
                                  "response id: ${response.data!.userData!.email}");
                              print(
                                  "userId: ${response.data!.userData!.usersAgentsId}");
                              print(
                                  "oneSignalId: ${response.data!.userData!.onesignalId}");
                              print(
                                  "users_roles_id: ${response.data!.userData!.usersRolesId}");
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setString("userId",
                                  response.data!.userData!.usersAgentsId!);
                              await prefs.setString("oneSignalId",
                                  response.data!.userData!.onesignalId!);
                              await prefs.setString("usersRoleId",
                                  response.data!.userData!.usersRolesId!);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NavBar()));
                              // Navigator.of(context).pushAndRemoveUntil(
                              //     MaterialPageRoute(
                              //         builder: (context) => const HomePage()),
                              //         (Route<dynamic> route) => false);
                            }
                          },
                          child: button('Login', context)),
                      SizedBox(height: size.height * 0.06),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Expanded(
                      //       child: Divider(
                      //         color: const Color(0xFF929292).withOpacity(0.3),
                      //         thickness: 1,
                      //         indent: 20,
                      //         endIndent: 10,
                      //       ),
                      //     ),
                      //     const Text(
                      //       'OR',
                      //       style: TextStyle(
                      //         fontSize: 16,
                      //         fontFamily: 'Montserrat-Regular',
                      //         fontWeight: FontWeight.w500,
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Divider(
                      //         color: const Color(0xFF929292).withOpacity(0.3),
                      //         thickness: 1,
                      //         indent: 10,
                      //         endIndent: 20,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(height: size.height * 0.06),
                      // RichText(
                      //   overflow: TextOverflow.clip,
                      //   textAlign: TextAlign.center,
                      //   text: TextSpan(
                      //     text: "Don’t have an account? ",
                      //     style: const TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 16,
                      //       fontFamily: 'Montserrat-Regular',
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //     children: [
                      //       TextSpan(
                      //         recognizer: TapGestureRecognizer()
                      //           ..onTap = () {
                      //             // Handle the tap event, e.g., navigate to a new screen
                      //             Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: (context) => const SignUpPage(),
                      //               ),
                      //             );
                      //           },
                      //         text: 'Sign Up',
                      //         style: const TextStyle(
                      //           color: Color(0xFF79BF42),
                      //           fontFamily: 'Montserrat-Regular',
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.w600,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: size.height * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
