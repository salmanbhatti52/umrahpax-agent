import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:umrahcar/models/get_booking_list_model.dart';
import 'package:umrahcar/screens/tracking_process/track_screen.dart';
import 'package:umrahcar/screens/tracking_process/track_completed_screen.dart';
import 'package:umrahcar/screens/tracking_process/track_upcoming_screen.dart';
import 'package:umrahcar/utils/colors.dart';
import 'package:umrahcar/utils/const.dart';

Widget homeList(BuildContext context, GetBookingListModel getBookingListModel) {
  var size = MediaQuery.of(context).size;
  print("data bookibg: ${getBookingListModel.data}");
  return ListView.builder(
    physics: const AlwaysScrollableScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: getBookingListModel.data!.length,
    itemBuilder: (BuildContext context, int index) {
      var reverselist = getBookingListModel.data!.reversed.toList();
      var getData = reverselist[index];
      return Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.grey.withOpacity(0.5),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrackPage(getBookingData: getData),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 10,
              right: 10,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, right: 8, bottom: 8, left: 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                    "$imageUrl${getData.routes!.vehicles!.featureImage}"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.007),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getData.name!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "booking id: ${getData.bookingsId}",
                                  style: const TextStyle(
                                    color: Color(0xFF565656),
                                    fontSize: 10,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: size.width * 0.02),
                                SvgPicture.asset(
                                    'assets/images1/small-black-location-icon.svg'),
                                SizedBox(width: size.width * 0.01),
                                Text(
                                  "${getData.routes!.pickup!.name}",
                                  style: const TextStyle(
                                    color: Color(0xFF565656),
                                    fontSize: 10,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.005),
                            SizedBox(
                              width: 180,
                              child: Row(
                                children: [
                                  for (int i = 0;
                                      i < getData.vehicles!.length;
                                      i++)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 2),
                                      child: getData.vehicles!.length < 4
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/images1/small-black-car-icon.svg'),
                                                SizedBox(
                                                    width: size.width * 0.01),
                                                Text(
                                                  '${getData.vehicles![i].vehiclesName!.name}',
                                                  style: const TextStyle(
                                                    color: Color(0xFF565656),
                                                    fontSize: 10,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: size.width * 0.01),
                                                if (getData.paymentType ==
                                                    "credit")
                                                  const Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .attach_money, // This is the currency icon
                                                        size: 10,
                                                        color:
                                                            Color(0xFF565656),
                                                      ),
                                                      Text(
                                                        "credit",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF565656),
                                                          fontSize: 10,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                if (getData
                                                        .cashReceiveFromCustomer !=
                                                    "0")
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .attach_money, // This is the currency icon
                                                        size: 10,
                                                        color:
                                                            Color(0xFF565656),
                                                      ),
                                                      Text(
                                                        "${getData.cashReceiveFromCustomer}",
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFF565656),
                                                          fontSize: 10,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ],
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 4),
                                                    child: SvgPicture.asset(
                                                        'assets/images1/small-black-car-icon.svg'),
                                                  ),
                                                  Text(
                                                    '${getData.vehicles![i].vehiclesName!.name}',
                                                    style: const TextStyle(
                                                      color: Color(0xFF565656),
                                                      fontSize: 10,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.005),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    'assets/images1/small-black-bookings-icon.svg'),
                                SizedBox(width: size.width * 0.01),
                                Text(
                                  '${_formatDate(getData.pickupDate!)} ${_formatTime(getData.pickupTime!)}',
                                  style: const TextStyle(
                                    color: Color(0xFF565656),
                                    fontSize: 10,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.006),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TrackPage(getBookingData: getData),
                                    ));
                              },
                              child: SizedBox(
                                // width: 72,
                                // height: 18,

                                child: Text(
                                  getData.status!,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

String _formatDate(String date) {
  final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
  return DateFormat('d MMM yyyy').format(parsedDate);
}

String _formatTime(String time) {
  final DateTime parsedTime = DateFormat('HH:mm:ss').parse(time);
  return DateFormat('h:mm a').format(parsedTime);
}
// List myList = [
//   MyList("assets/images/list-image-1.png", "Albert Flores", "Track"),
//   MyList("assets/images/list-image-2.png", "Floyd Miles", "Upcoming"),
//   MyList("assets/images/list-image-3.png", "Arlene McCoy", "Completed"),
//   MyList("assets/images/list-image-4.png", "Robert Fox", "Upcoming"),
//   MyList("assets/images/list-image-1.png", "Albert Flores", "Track"),
//   MyList("assets/images/list-image-2.png", "Floyd Miles", "Upcoming"),
//   MyList("assets/images/list-image-3.png", "Arlene McCoy", "Completed"),
//   MyList("assets/images/list-image-4.png", "Robert Fox", "Upcoming"),
//   MyList("assets/images/list-image-1.png", "Albert Flores", "Track"),
//   MyList("assets/images/list-image-2.png", "Floyd Miles", "Upcoming"),
//   MyList("assets/images/list-image-3.png", "Arlene McCoy", "Completed"),
//   MyList("assets/images/list-image-4.png", "Robert Fox", "Upcoming"),
//   MyList("assets/images/list-image-1.png", "Albert Flores", "Track"),
//   MyList("assets/images/list-image-2.png", "Floyd Miles", "Upcoming"),
//   MyList("assets/images/list-image-3.png", "Arlene McCoy", "Completed"),
//   MyList("assets/images/list-image-4.png", "Robert Fox", "Upcoming"),
// ];
//
// class MyList {
//   String? image;
//   String? title;
//   String? status;
//
//   MyList(this.image, this.title, this.status);
// }
