import 'package:flutter/material.dart';
import 'package:umrahcar/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:umrahcar/screens/tracking_process/tarcking/reached_screen.dart';

import '../../../models/get_booking_list_model.dart';

class PickUpPage extends StatefulWidget {
  GetBookingData? getBookingData;
  PickUpPage({super.key, this.getBookingData});

  @override
  State<PickUpPage> createState() => _PickUpPageState();
}

class _PickUpPageState extends State<PickUpPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        color: Colors.transparent,
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/pickup-map.png',
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReachedPage(),
                      ));
                },
                child: Container(
                  width: size.width,
                  height: size.height * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFF000000).withOpacity(0.15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.03),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'On the Way',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                 fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '12 Km Away',
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          const Text(
                            'Moving towards the Pickup Point',
                            style: TextStyle(
                              color: Color(0xFF565656),
                              fontSize: 12,
                             fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/green-location-icon.svg',
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(width: size.width * 0.04),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Pickup Location',
                                    style: TextStyle(
                                      color: Color(0xFF565656),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.005),
                                  SizedBox(
                                    width: size.width * 0.7,
                                    child: const AutoSizeText(
                                      '2972 Westheimer Rd. Santa Ana, Illinois 85486 ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                       fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                      minFontSize: 12,
                                      maxFontSize: 12,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.03),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset('assets/images/back-icon.svg')),
            ),
          ],
        ),
      ),
    );
  }
}
