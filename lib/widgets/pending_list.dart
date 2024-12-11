import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar/models/get_booking_list_model.dart';
import 'package:umrahcar/screens/tracking_process/track_screen.dart';
import 'package:umrahcar/utils/colors.dart';

import '../utils/const.dart';

Widget onPendingList(
    BuildContext context, GetBookingListModel getBookingPendingData) {
  var size = MediaQuery.of(context).size;
  return getBookingPendingData.data != null
      ? ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: getBookingPendingData.data!.length,
          itemBuilder: (BuildContext context, int index) {
            var reverselist = getBookingPendingData.data!.reversed.toList();
            var getData = reverselist[index];
            print("status g: ${getBookingPendingData.data![index].status}");
            return getData.status == "Pending"
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, right: 8, bottom: 8, left: 8),
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
                                SizedBox(width: size.width * 0.005),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.4,
                                      child: Text(
                                        getData.name!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.005),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "booking id: ${getData.bookingsId}",
                                          style: const TextStyle(
                                            color: Color(0xFF565656),
                                            fontSize: 8,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.05),
                                        SvgPicture.asset(
                                            'assets/images/small-black-location-icon.svg'),
                                        SizedBox(width: size.width * 0.01),
                                        Text(
                                          "${getData.routes!.pickup!.name}",
                                          style: const TextStyle(
                                            color: Color(0xFF565656),
                                            fontSize: 8,
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
                                              padding: const EdgeInsets.only(
                                                  right: 2),
                                              child: getData.vehicles!.length <
                                                      4
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                            'assets/images/small-black-car-icon.svg'),
                                                        SizedBox(
                                                            width: size.width *
                                                                0.01),
                                                        Text(
                                                          '${getData.vehicles![i].vehiclesName!.name}',
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFF565656),
                                                            fontSize: 7,
                                                            fontFamily:
                                                                'Poppins',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom: 4),
                                                            child: SvgPicture.asset(
                                                                'assets/images/small-black-car-icon.svg'),
                                                          ),
                                                          Text(
                                                            '${getData.vehicles![i].vehiclesName!.name}',
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF565656),
                                                              fontSize: 7,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images/small-black-bookings-icon.svg'),
                                        SizedBox(width: size.width * 0.01),
                                        Text(
                                          '${getData.pickupTime} ${getData.pickupDate}',
                                          style: const TextStyle(
                                            color: Color(0xFF565656),
                                            fontSize: 8,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: size.width * 0.005),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => TrackPage(
                                                  getBookingData: getData),
                                            ));
                                      },
                                      child: Text(
                                        'Track',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: buttonColor,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.02),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox();
          },
        )
      : const SizedBox(
          // height: 300,
          // width: 300,
          child: Center(child: Text("No Pending Booking")),
        );
}

List myList = [
  MyList("assets/images/list-image-1.png", "Albert Flores"),
  MyList("assets/images/list-image-2.png", "Floyd Miles"),
  MyList("assets/images/list-image-3.png", "Arlene McCoy"),
  MyList("assets/images/list-image-4.png", "Robert Fox"),
  MyList("assets/images/list-image-1.png", "Albert Flores"),
  MyList("assets/images/list-image-2.png", "Floyd Miles"),
  MyList("assets/images/list-image-3.png", "Arlene McCoy"),
  MyList("assets/images/list-image-4.png", "Robert Fox"),
];

class MyList {
  String? image;
  String? title;

  MyList(this.image, this.title);
}
