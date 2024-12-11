import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget walletList(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return ListView.builder(
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: myList.length,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(myList[index].image),
              ),
              SizedBox(width: size.width * 0.005),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    myList[index].title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          'assets/images/small-black-location-icon.svg'),
                      SizedBox(width: size.width * 0.01),
                      const Text(
                        'Makkah Hottle Aziziz',
                        style: TextStyle(
                          color: Color(0xFF565656),
                          fontSize: 8,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/small-black-car-icon.svg'),
                      SizedBox(width: size.width * 0.01),
                      const Text(
                        'Sedan',
                        style: TextStyle(
                          color: Color(0xFF565656),
                          fontSize: 8,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                          'assets/images/small-black-bookings-icon.svg'),
                      SizedBox(width: size.width * 0.01),
                      const Text(
                        '12:00 am on 2-12-2022',
                        style: TextStyle(
                          color: Color(0xFF565656),
                          fontSize: 8,
                         fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: size.width * 0.15),
              Text(
                myList[index].status,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  color: Color(0xFFFF0000),
                  fontSize: 12,
                   fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
        ],
      );
    },
  );
}

List myList = [
  MyList("assets/images/list-image-1.png", "Albert Flores", "-200 SAR"),
  MyList("assets/images/list-image-2.png", "Floyd Miles", "-200 SAR"),
  MyList("assets/images/list-image-3.png", "Arlene McCoy", "-200 SAR"),
  MyList("assets/images/list-image-4.png", "Robert Fox", "-200 SAR"),
  MyList("assets/images/list-image-1.png", "Albert Flores", "-200 SAR"),
  MyList("assets/images/list-image-2.png", "Floyd Miles", "-200 SAR"),
  MyList("assets/images/list-image-3.png", "Arlene McCoy", "-200 SAR"),
  MyList("assets/images/list-image-4.png", "Robert Fox", "-200 SAR"),
];

class MyList {
  String? image;
  String? title;
  String? status;

  MyList(this.image, this.title, this.status);
}
