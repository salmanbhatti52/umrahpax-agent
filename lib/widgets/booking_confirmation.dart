import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:umrahcar/utils/colors.dart';
import 'package:umrahcar/widgets/button.dart';

Widget bookingConfirmation(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Dialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40),
    ),
    insetPadding: const EdgeInsets.only(left: 20, right: 20),
    child: SizedBox(
      height: size.height * 0.85,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          children: [
            const Text(
              'Booking Confirmation',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Image.asset('assets/images/confirmation-icon.png',
              width: 140,
              height: 150,
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/small-grey-location-icon.svg'),
                  SizedBox(width: size.width * 0.02),
                  const Text(
                    'Pickup Location',
                    style: TextStyle(
                      color: Color(0xFF929292),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                     fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.01),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                '2972 Westheimer Rd. Santa Ana, Illinois 85486 ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/small-grey-location-icon.svg'),
                  SizedBox(width: size.width * 0.02),
                  const Text(
                    'Drop Off Location',
                    style: TextStyle(
                      color: Color(0xFF929292),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                       fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.01),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                '2972 Westheimer Rd. Santa Ana, Illinois 85486 ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                   fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(height: size.height * 0.04),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Date',
                    style: TextStyle(
                      color: Color(0xFF929292),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                       fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    '22-09-2022',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat-Regular',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Vehicle Name',
                    style: TextStyle(
                      color: Color(0xFF929292),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    'BMW S10 Series',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Fare Amount',
                    style: TextStyle(
                      color: Color(0xFF929292),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                       fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    '200 SAR',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
             Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Total Fare',
                    style: TextStyle(
                      color: Color(0xFF929292),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                       fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    '600 SAR',
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                       fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.06),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: dialogButton('OK', context),
            ),
          ],
        ),
      ),
    ),
  );
}
