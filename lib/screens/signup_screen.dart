// ignore_for_file: avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:umrahcar/utils/colors.dart';
import 'package:umrahcar/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar/widgets/navbar.dart';
import 'package:umrahcar/screens/login_screen.dart';
// import 'package:country_picker_plus/country_picker_plus.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  // TextEditingController landLineNumberController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController whatsappNumberController = TextEditingController();
  // TextEditingController iataNumberController = TextEditingController();
  // TextEditingController localgovtNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;
  // String? pickCountry;
  // String? pickState;

  bool _obscure = true;
  bool _obscure1 = true;

  @override
  Widget build(BuildContext context) {
    // var fieldDecoration = const CPPFDecoration(
    //   hintStyle: TextStyle(
    //     color: Color(0xFF929292),
    //     fontSize: 12,
    //     fontFamily: 'Montserrat-Regular',
    //     fontWeight: FontWeight.w500,
    //   ),
    //   padding: EdgeInsets.only(top: 16),
    //   filled: false,
    //   border: InputBorder.none,
    //   focusedBorder: InputBorder.none,
    //   textStyle: TextStyle(
    //     fontWeight: FontWeight.w500,
    //     fontFamily: 'Montserrat-Regular',
    //     fontSize: 12,
    //     color: Color(0xFF6B7280),
    //   ),
    //   suffixIcon: Icons.keyboard_arrow_down,
    //   suffixColor: Color(0xFF565656),
    // );
    // final bottomSheetDecoration = CPPBSHDecoration(
    //   closeColor: Colors.white.withOpacity(0),
    //   itemDecoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(16),
    //   ),
    //   itemsPadding: const EdgeInsets.all(10),
    //   itemsSpace: const EdgeInsets.symmetric(vertical: 5),
    //   itemTextStyle: const TextStyle(
    //     color: Color(0xFF929292),
    //     fontSize: 14,
    //     fontFamily: 'Montserrat-Regular',
    //     fontWeight: FontWeight.w500,
    //   ),
    //   shape: RoundedRectangleBorder(
    //     side: BorderSide(
    //       width: 1,
    //       color: const Color(0xFF000000).withOpacity(0.15),
    //     ),
    //     borderRadius: const BorderRadius.only(
    //       topLeft: Radius.circular(20),
    //       topRight: Radius.circular(20),
    //     ),
    //   ),
    // );
    // final searchDecoration = CPPSFDecoration(
    //   height: 45,
    //   padding: const EdgeInsets.symmetric(
    //     vertical: 2,
    //     horizontal: 10,
    //   ),
    //   filled: false,
    //   margin: const EdgeInsets.symmetric(vertical: 8),
    //   hintStyle: const TextStyle(
    //     color: Color(0xFF929292),
    //     fontSize: 12,
    //     fontFamily: 'Montserrat-Regular',
    //     fontWeight: FontWeight.w500,
    //   ),
    //   searchIconColor: const Color(0xFF000000).withOpacity(0.15),
    //   textStyle: const TextStyle(
    //     fontWeight: FontWeight.w400,
    //     fontFamily: 'Montserrat-Regular',
    //     fontSize: 14,
    //     color: Color(0xFF929292),
    //   ),
    //   innerColor: Colors.white,
    //   border: OutlineInputBorder(
    //     borderRadius: const BorderRadius.all(Radius.circular(16)),
    //     borderSide: BorderSide(
    //       color: const Color(0xFF000000).withOpacity(0.15),
    //       width: 1,
    //     ),
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     borderRadius: const BorderRadius.all(Radius.circular(16)),
    //     borderSide: BorderSide(
    //       color: const Color(0xFF000000).withOpacity(0.15),
    //       width: 1,
    //     ),
    //   ),
    // );
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: mainColor,
        //   elevation: 0,
        // ),
        backgroundColor: mainColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.04),
              SvgPicture.asset('assets/images/umrah-car-logo-small.svg'),
              SizedBox(height: size.height * 0.04),
              const Text(
                'Sign Up to Your Account',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Montserrat-Regular',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.height * 0.06),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Name field is required!';
                  //   }
                  //   return null;
                  // },
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
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    hintText: "Concern Person Name",
                    hintStyle: const TextStyle(
                      color: Color(0xFF929292),
                      fontSize: 12,
 fontFamily: 'Poppins',
                       fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: SvgPicture.asset(
                      'assets/images/name-icon.svg',
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
                  controller: businessNameController,
                  keyboardType: TextInputType.text,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Business Name field is required!';
                  //   }
                  //   return null;
                  // },
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
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    hintText: "Business Name",
                    hintStyle: const TextStyle(
                      color: Color(0xFF929292),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: SvgPicture.asset(
                      'assets/images/business-name-icon.svg',
                      width: 25,
                      height: 25,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              // SizedBox(height: size.height * 0.02),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: TextFormField(
              //     controller: landLineNumberController,
              //     keyboardType: TextInputType.number,
              //     // validator: (value) {
              //     //   if (value == null || value.isEmpty) {
              //     //     return 'Landline Number field is required!';
              //     //   }
              //     //   return null;
              //     // },
              //     style: const TextStyle(
              //       fontWeight: FontWeight.w400,
              //       fontFamily: 'Montserrat-Regular',
              //       fontSize: 16,
              //       color: Color(0xFF6B7280),
              //     ),
              //     decoration: InputDecoration(
              //       filled: false,
              //       errorStyle: const TextStyle(
              //         color: Colors.red,
              //         fontSize: 14,
              //         fontWeight: FontWeight.bold,
              //         wordSpacing: 2,
              //       ),
              //       border: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(Radius.circular(16)),
              //         borderSide: BorderSide(
              //           color: const Color(0xFF000000).withOpacity(0.15),
              //           width: 1,
              //         ),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(Radius.circular(16)),
              //         borderSide: BorderSide(
              //           color: const Color(0xFF000000).withOpacity(0.15),
              //           width: 1,
              //         ),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(Radius.circular(16)),
              //         borderSide: BorderSide(
              //           color: const Color(0xFF000000).withOpacity(0.15),
              //           width: 1,
              //         ),
              //       ),
              //       errorBorder: const OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(16)),
              //         borderSide: BorderSide(
              //           color: Colors.red,
              //           width: 1,
              //         ),
              //       ),
              //       contentPadding: const EdgeInsets.symmetric(
              //           horizontal: 20, vertical: 10),
              //       hintText: "Landline Number",
              //       hintStyle: const TextStyle(
              //         color: Color(0xFF929292),
              //         fontSize: 12,
              //         fontFamily: 'Montserrat-Regular',
              //         fontWeight: FontWeight.w500,
              //       ),
              //       prefixIcon: SvgPicture.asset(
              //         'assets/images/landline-icon.svg',
              //         width: 25,
              //         height: 25,
              //         fit: BoxFit.scaleDown,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFF000000).withOpacity(0.15),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final code =
                              await countryPicker.showPicker(context: context);
                          setState(() {
                            countryCode = code;
                          });
                          print('countryCode: $countryCode');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            countryCode?.dialCode ?? "+966",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF929292),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        '|',
                        style: TextStyle(
                          color: Color(0xFF929292),
                          fontSize: 20,
                         fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        width: 240,
                        child: TextFormField(
                          controller: contactNumberController,
                          keyboardType: TextInputType.number,
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Contact Number field is required!';
                          //   }
                          //   return null;
                          // },
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
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            hintText: "Contact Number",
                            hintStyle: const TextStyle(
                              color: Color(0xFF929292),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: SvgPicture.asset(
                              'assets/images/contact-icon.svg',
                              width: 25,
                              height: 25,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: whatsappNumberController,
                  keyboardType: TextInputType.number,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Whatsapp Number field is required!';
                  //   }
                  //   return null;
                  // },
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
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    hintText: "Whatsapp Number",
                    hintStyle: const TextStyle(
                      color: Color(0xFF929292),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    prefixIcon: SvgPicture.asset(
                      'assets/images/whatsapp-icon.svg',
                      width: 25,
                      height: 25,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              // SizedBox(height: size.height * 0.02),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: TextFormField(
              //     controller: iataNumberController,
              //     keyboardType: TextInputType.text,
              //     // validator: (value) {
              //     //   if (value == null || value.isEmpty) {
              //     //     return 'IATA Number field is required!';
              //     //   }
              //     //   return null;
              //     // },
              //     style: const TextStyle(
              //       fontWeight: FontWeight.w400,
              //       fontFamily: 'Montserrat-Regular',
              //       fontSize: 16,
              //       color: Color(0xFF6B7280),
              //     ),
              //     decoration: InputDecoration(
              //       filled: false,
              //       errorStyle: const TextStyle(
              //         color: Colors.red,
              //         fontSize: 14,
              //         fontWeight: FontWeight.bold,
              //         wordSpacing: 2,
              //       ),
              //       border: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(Radius.circular(16)),
              //         borderSide: BorderSide(
              //           color: const Color(0xFF000000).withOpacity(0.15),
              //           width: 1,
              //         ),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(Radius.circular(16)),
              //         borderSide: BorderSide(
              //           color: const Color(0xFF000000).withOpacity(0.15),
              //           width: 1,
              //         ),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(Radius.circular(16)),
              //         borderSide: BorderSide(
              //           color: const Color(0xFF000000).withOpacity(0.15),
              //           width: 1,
              //         ),
              //       ),
              //       errorBorder: const OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(16)),
              //         borderSide: BorderSide(
              //           color: Colors.red,
              //           width: 1,
              //         ),
              //       ),
              //       contentPadding: const EdgeInsets.symmetric(
              //           horizontal: 20, vertical: 10),
              //       hintText: "IATA Number",
              //       hintStyle: const TextStyle(
              //         color: Color(0xFF929292),
              //         fontSize: 12,
              //         fontFamily: 'Montserrat-Regular',
              //         fontWeight: FontWeight.w500,
              //       ),
              //       prefixIcon: SvgPicture.asset(
              //         'assets/images/landline-icon.svg',
              //         width: 25,
              //         height: 25,
              //         fit: BoxFit.scaleDown,
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: size.height * 0.02),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: TextFormField(
              //     controller: localgovtNumberController,
              //     keyboardType: TextInputType.text,
              //     // validator: (value) {
              //     //   if (value == null || value.isEmpty) {
              //     //     return 'Local Govt License field is required!';
              //     //   }
              //     //   return null;
              //     // },
              //     style: const TextStyle(
              //       fontWeight: FontWeight.w400,
              //       fontFamily: 'Montserrat-Regular',
              //       fontSize: 16,
              //       color: Color(0xFF6B7280),
              //     ),
              //     decoration: InputDecoration(
              //       filled: false,
              //       errorStyle: const TextStyle(
              //         color: Colors.red,
              //         fontSize: 14,
              //         fontWeight: FontWeight.bold,
              //         wordSpacing: 2,
              //       ),
              //       border: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(Radius.circular(16)),
              //         borderSide: BorderSide(
              //           color: const Color(0xFF000000).withOpacity(0.15),
              //           width: 1,
              //         ),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(Radius.circular(16)),
              //         borderSide: BorderSide(
              //           color: const Color(0xFF000000).withOpacity(0.15),
              //           width: 1,
              //         ),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(Radius.circular(16)),
              //         borderSide: BorderSide(
              //           color: const Color(0xFF000000).withOpacity(0.15),
              //           width: 1,
              //         ),
              //       ),
              //       errorBorder: const OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(16)),
              //         borderSide: BorderSide(
              //           color: Colors.red,
              //           width: 1,
              //         ),
              //       ),
              //       contentPadding: const EdgeInsets.symmetric(
              //           horizontal: 20, vertical: 10),
              //       hintText: "Local Govt License",
              //       hintStyle: const TextStyle(
              //         color: Color(0xFF929292),
              //         fontSize: 12,
              //         fontFamily: 'Montserrat-Regular',
              //         fontWeight: FontWeight.w500,
              //       ),
              //       prefixIcon: SvgPicture.asset(
              //         'assets/images/local-gov-icon.svg',
              //         width: 25,
              //         height: 25,
              //         fit: BoxFit.scaleDown,
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Email field is required!';
                  //   }
                  //   return null;
                  // },
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
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
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
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Password field is required!';
                  //   }
                  //   return null;
                  // },
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
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
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
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: confirmPasswordController,
                  obscureText: _obscure1,
                  keyboardType: TextInputType.visiblePassword,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Confirm Password field is required!';
                  //   }
                  //   return null;
                  // },
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
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    hintText: "Confirm Password",
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
                          _obscure1 = !_obscure1;
                        });
                      },
                      child: _obscure1
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
              // SizedBox(height: size.height * 0.02),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: TextFormField(
              //     controller: addressController,
              //     keyboardType: TextInputType.streetAddress,
              //     // validator: (value) {
              //     //   if (value == null || value.isEmpty) {
              //     //     return 'Complete Address field is required!';
              //     //   }
              //     //   return null;
              //     // },
              //     style: const TextStyle(
              //       fontWeight: FontWeight.w400,
              //       fontFamily: 'Montserrat-Regular',
              //       fontSize: 16,
              //       color: Color(0xFF6B7280),
              //     ),
              //     decoration: InputDecoration(
              //       filled: false,
              //       errorStyle: const TextStyle(
              //         color: Colors.red,
              //         fontSize: 14,
              //         fontWeight: FontWeight.bold,
              //         wordSpacing: 2,
              //       ),
              //       border: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(Radius.circular(16)),
              //         borderSide: BorderSide(
              //           color: const Color(0xFF000000).withOpacity(0.15),
              //           width: 1,
              //         ),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(Radius.circular(16)),
              //         borderSide: BorderSide(
              //           color: const Color(0xFF000000).withOpacity(0.15),
              //           width: 1,
              //         ),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderRadius: const BorderRadius.all(Radius.circular(16)),
              //         borderSide: BorderSide(
              //           color: const Color(0xFF000000).withOpacity(0.15),
              //           width: 1,
              //         ),
              //       ),
              //       errorBorder: const OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(16)),
              //         borderSide: BorderSide(
              //           color: Colors.red,
              //           width: 1,
              //         ),
              //       ),
              //       contentPadding: const EdgeInsets.symmetric(
              //           horizontal: 20, vertical: 10),
              //       hintText: "Complete Address",
              //       hintStyle: const TextStyle(
              //         color: Color(0xFF929292),
              //         fontSize: 12,
              //         fontFamily: 'Montserrat-Regular',
              //         fontWeight: FontWeight.w500,
              //       ),
              //       prefixIcon: SvgPicture.asset(
              //         'assets/images/address-icon.svg',
              //         width: 25,
              //         height: 25,
              //         fit: BoxFit.scaleDown,
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: size.height * 0.02),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Container(
              //     height: size.height * 0.065,
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         width: 1,
              //         color: const Color(0xFF000000).withOpacity(0.15),
              //       ),
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 15),
              //       child: Row(
              //         children: [
              //           SvgPicture.asset(
              //             'assets/images/country-icon.svg',
              //             width: 20,
              //             height: 20,
              //             fit: BoxFit.scaleDown,
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(left: 15),
              //             child: SizedBox(
              //               width: 250,
              //               child: CountryPickerPlus.country(
              //                 isRequired: false,
              //                 searchHintText: "Search Country",
              //                 hintText: "Country Name",
              //                 bottomSheetDecoration: bottomSheetDecoration,
              //                 decoration: fieldDecoration,
              //                 searchDecoration: searchDecoration,
              //                 onSaved: (value) {
              //                   print('country: $value');
              //                 },
              //                 onSelected: (value) {
              //                   pickCountry = value;
              //                   print('country: $value');
              //                   setState(() {});
              //                 },
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: size.height * 0.02),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Container(
              //     height: size.height * 0.065,
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         width: 1,
              //         color: const Color(0xFF000000).withOpacity(0.15),
              //       ),
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 15),
              //       child: Row(
              //         children: [
              //           SvgPicture.asset(
              //             'assets/images/state-icon.svg',
              //             width: 23,
              //             height: 23,
              //             fit: BoxFit.scaleDown,
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(left: 15),
              //             child: SizedBox(
              //               width: 250,
              //               child: CountryPickerPlus.state(
              //                 country: '$pickCountry',
              //                 isRequired: false,
              //                 searchHintText: "Search State",
              //                 hintText: "State Name",
              //                 bottomSheetDecoration: bottomSheetDecoration,
              //                 decoration: fieldDecoration,
              //                 searchDecoration: searchDecoration,
              //                 onSaved: (value) {
              //                   print('state: $value');
              //                 },
              //                 onSelected: (value) {
              //                   pickState = value;
              //                   print('state: $value');
              //                   setState(() {});
              //                 },
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: size.height * 0.02),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Container(
              //     height: size.height * 0.065,
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         width: 1,
              //         color: const Color(0xFF000000).withOpacity(0.15),
              //       ),
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 15),
              //       child: Row(
              //         children: [
              //           SvgPicture.asset(
              //             'assets/images/city-icon.svg',
              //             width: 20,
              //             height: 20,
              //             fit: BoxFit.scaleDown,
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(left: 15),
              //             child: SizedBox(
              //               width: 250,
              //               child: CountryPickerPlus.city(
              //                 country: '$pickCountry',
              //                 state: '$pickState',
              //                 isRequired: false,
              //                 searchHintText: "Search City",
              //                 hintText: "City Name",
              //                 bottomSheetDecoration: bottomSheetDecoration,
              //                 decoration: fieldDecoration,
              //                 searchDecoration: searchDecoration,
              //                 onSaved: (value) {
              //                   print('city: $value');
              //                 },
              //                 onSelected: (value) {
              //                   print('city: $value');
              //                   setState(() {});
              //                 },
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: size.height * 0.03),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  NavBar(),
                        ));
                    // Navigator.of(context).pushAndRemoveUntil(
                    //     MaterialPageRoute(
                    //         builder: (context) => const HomePage()),
                    //     (Route<dynamic> route) => false);
                  },
                  child: button('Signup', context)),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      color: const Color(0xFF929292).withOpacity(0.3),
                      thickness: 1,
                      indent: 20,
                      endIndent: 10,
                    ),
                  ),
                  const Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: const Color(0xFF929292).withOpacity(0.3),
                      thickness: 1,
                      indent: 10,
                      endIndent: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              RichText(
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Already have an account? ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle the tap event, e.g., navigate to a new screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LogInPage(),
                            ),
                          );
                        },
                      text: 'Login',
                      style:  TextStyle(
                        color: buttonColor,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
