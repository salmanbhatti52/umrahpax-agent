import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:umrahcar/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:searchfield/searchfield.dart';
import 'package:umrahcar/widgets/upcoming_list.dart';

import '../../../models/ge_bookings_pending_by_id_model.dart';
import '../../../models/get_booking_list_model.dart';
import '../../../service/rest_api_serivice.dart';
import '../../../utils/const.dart';
import '../../../widgets/navbar.dart';
import '../../homepage_screen.dart';
import '../../tracking_process/track_screen.dart';
import '../../tracking_process/track_screen_pending.dart';

class UpcomingPage extends StatefulWidget {
  const UpcomingPage({super.key});

  @override
  State<UpcomingPage> createState() => _UpcomingPageState();
}

class _UpcomingPageState extends State<UpcomingPage> {
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();

  List<String> suggestions = [
    // 'apple',
    // 'apple red',
    // 'ball',
    // 'call green',
    // 'cat',
    // 'cat blue',
  ];

  bool isFocused = false;
  GetBookingListModel getBookingUpcomingResponse = GetBookingListModel();
  getBookingListUpcoming() async {
    print("userIdId $userId");
    var mapData = {"users_agents_id": userId.toString()};
    getBookingUpcomingResponse =
        await DioClient().getBookingupcoming(mapData, context);
    print("response id: ${getBookingUpcomingResponse.data}");

    setState(() {});
  }

  GetBookingListModel getBookingUpcomingResponseForSearch =
      GetBookingListModel();
  getBookingListOngoingSearch(String? searchText) async {
    print("userIdId $userId");
    getBookingUpcomingResponseForSearch.data = [];
    var mapData = {
      "users_agents_id": userId.toString(),
      "bookings_id": searchText
    };
    getBookingUpcomingResponseForSearch =
        await DioClient().getBookingupcoming(mapData, context);
    print("response id: ${getBookingUpcomingResponseForSearch.data}");
    setState(() {
      getBookingUpcomingResponse.data = [];
    });
  }

  GetBookingPendingById getBookingPendingById = GetBookingPendingById();
  getBookingListPending(String? bookingId) async {
    print("bookingId $bookingId");
    var mapData = {"bookings_id": bookingId};
    getBookingPendingById =
        await DioClient().getBookingPendingById(mapData, context);
    print("response data: ${getBookingUpcomingResponse.data}");
    setState(() {});
  }

  @override
  void initState() {
    getBookingListUpcoming();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: mainColor,
        body: Column(
          children: [
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ButtonTheme(
                alignedDropdown: true,
                child: SearchField(
                  controller: searchController,
                  inputType: TextInputType.text,
                  marginColor: mainColor,
                  suggestionsDecoration: SuggestionDecoration(
                    color: mainColor,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 5, bottom: 5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFF000000).withOpacity(0.15),
                    ),
                  ),
                  offset: const Offset(0, 46),
                  suggestionItemDecoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFFFFFFF),
                    ),
                  ),
                  searchInputDecoration: InputDecoration(
                    prefixIcon: SvgPicture.asset(
                      'assets/images/search-icon.svg',
                      width: 25,
                      height: 25,
                      fit: BoxFit.scaleDown,
                    ),
                    suffixIcon: isFocused == true
                        ? GestureDetector(
                            onTap: () {
                              isFocused = false;
                              searchController.clear();
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.close,
                              size: 20,
                              color: Color(0xFF565656),
                            ),
                            // SvgPicture.asset(
                            //   'assets/images/close-icon.svg',
                            //   width: 10,
                            //   height: 10,
                            //   fit: BoxFit.scaleDown,
                            // ),
                          )
                        : null,
                    hintText: "Search",
                    hintStyle: const TextStyle(
                      color: Color(0xFF929292),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: const Color(0xFF000000).withOpacity(0.15),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: const Color(0xFF000000).withOpacity(0.15),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  itemHeight: 40,
                  maxSuggestionsInViewPort: 4,
                  onSearchTextChanged: (value) {
                    setState(() {
                      isFocused = true;
                      if (value.isNotEmpty) {
                        getBookingListOngoingSearch(value);
                      } else {
                        getBookingListUpcoming();
                      }
                    });
                    return null;
                  },
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Please enter a search term';
                  //   }
                  //   return null;
                  // },
                  // scrollbarAlwaysVisible: false,
                  scrollbarDecoration: ScrollbarDecoration(
                    thumbVisibility: false,
                  ),
                  suggestionState: Suggestion.hidden,
                  suggestions: suggestions
                      .map((e) => SearchFieldListItem<String>(e))
                      .toList(),
                  suggestionStyle: const TextStyle(
                    color: Color(0xFF929292),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                  searchStyle: const TextStyle(
                    color: Color(0xFF929292),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            getBookingUpcomingResponseForSearch.data == null &&
                        searchController.text.isEmpty ||
                    searchController.text == ""
                ? Container(
                    color: Colors.transparent,
                    height: size.height * 0.6,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        getBookingListUpcoming();
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: getBookingUpcomingResponse.data != null
                            ? ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    getBookingUpcomingResponse.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var getData =
                                      getBookingUpcomingResponse.data![index];

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    TrackPage(
                                                                      getBookingData:
                                                                          getData,
                                                                    )));
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            right: 8,
                                                            bottom: 8,
                                                            left: 8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            spreadRadius: 2,
                                                            blurRadius: 5,
                                                            offset:
                                                                const Offset(
                                                                    0, 3),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          width: 90,
                                                          height: 90,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Image.network(
                                                              "$imageUrl${getData.routes!.vehicles!.featureImage}"),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: size.width * 0.005),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    TrackPage(
                                                                      getBookingData:
                                                                          getData,
                                                                    )));
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        getData.name!,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: size.height *
                                                              0.005),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "booking id: ${getData.bookingsId}",
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF565656),
                                                              fontSize: 8,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.05),
                                                          SvgPicture.asset(
                                                              'assets/images/small-black-location-icon.svg'),
                                                          SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.01),
                                                          Text(
                                                            "${getData.routes!.pickup!.name}",
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF565656),
                                                              fontSize: 8,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: size.height *
                                                              0.005),
                                                      SizedBox(
                                                        width: 180,
                                                        child: Row(
                                                          children: [
                                                            for (int i = 0;
                                                                i <
                                                                    getData
                                                                        .vehicles!
                                                                        .length;
                                                                i++)
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            2),
                                                                child: getData
                                                                            .vehicles!
                                                                            .length <
                                                                        4
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
                                                                            style:
                                                                                const TextStyle(
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
                                                                                  Icons.attach_money, // This is the currency icon
                                                                                  size: 10,
                                                                                  color: Color(0xFF565656),
                                                                                ),
                                                                                Text(
                                                                                  "credit",
                                                                                  style: TextStyle(
                                                                                    color: Color(0xFF565656),
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'Poppins',
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          if (getData.cashReceiveFromCustomer !=
                                                                              "0")
                                                                            Row(
                                                                              children: [
                                                                                const Icon(
                                                                                  Icons.attach_money, // This is the currency icon
                                                                                  size: 10,
                                                                                  color: Color(0xFF565656),
                                                                                ),
                                                                                Text(
                                                                                  "${getData.cashReceiveFromCustomer}",
                                                                                  style: const TextStyle(
                                                                                    color: Color(0xFF565656),
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'Poppins',
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                        ],
                                                                      )
                                                                    : Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                                5),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(bottom: 4),
                                                                              child: SvgPicture.asset('assets/images1/small-black-car-icon.svg'),
                                                                            ),
                                                                            Text(
                                                                              '${getData.vehicles![i].vehiclesName!.name}',
                                                                              style: const TextStyle(
                                                                                color: Color(0xFF565656),
                                                                                fontSize: 10,
                                                                                fontFamily: 'Poppins',
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: size.height *
                                                              0.005),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SvgPicture.asset(
                                                              'assets/images1/small-black-bookings-icon.svg'),
                                                          SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.01),
                                                          Text(
                                                            '${_formatDate(getData.pickupDate!)} ${_formatTime(getData.pickupTime!)}',
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF565656),
                                                              fontSize: 10,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      getData.pendingUpdate ==
                                                              "No"
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: 8,
                                                              ),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) => NavBar(
                                                                            indexNmbr:
                                                                                2,
                                                                            updateBooking:
                                                                                true,
                                                                            bookingId:
                                                                                getData.bookingsId),
                                                                      ));
                                                                },
                                                                child:
                                                                    const Row(
                                                                  children: [
                                                                    Text(
                                                                      'Update Booking',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ConstantColor
                                                                            .primaryColor,
                                                                        fontSize:
                                                                            10,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : Row(
                                                              children: [
                                                                InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      await getBookingListPending(
                                                                          getData
                                                                              .bookingsId);

                                                                      if (getBookingPendingById
                                                                              .data !=
                                                                          null) {
                                                                        print(
                                                                            "hello next");
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => TrackPagePending(getBookingData: getBookingPendingById.data![0]),
                                                                            ));
                                                                      }
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "Check Update",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xFF565656),
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    )),
                                                              ],
                                                            )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: size.height * 0.02),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const SizedBox(
                                height: 300,
                                width: 300,
                                child:
                                    Center(child: Text("No upcoming Booking")),
                              ),
                      ),
                    ),
                  )
                : Container(
                    color: Colors.transparent,
                    height: size.height * 0.6,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        getBookingListUpcoming();
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: getBookingUpcomingResponse.data != null
                            ? ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    getBookingUpcomingResponse.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var getData =
                                      getBookingUpcomingResponse.data![index];

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    TrackPage(
                                                                      getBookingData:
                                                                          getData,
                                                                    )));
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            right: 8,
                                                            bottom: 8,
                                                            left: 8),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                            spreadRadius: 2,
                                                            blurRadius: 5,
                                                            offset:
                                                                const Offset(
                                                                    0, 3),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          width: 90,
                                                          height: 90,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Image.network(
                                                              "$imageUrl${getData.routes!.vehicles!.featureImage}"),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: size.width * 0.005),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    TrackPage(
                                                                      getBookingData:
                                                                          getData,
                                                                    )));
                                                  },
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        getData.name!,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: size.height *
                                                              0.005),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "booking id: ${getData.bookingsId}",
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF565656),
                                                              fontSize: 8,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.05),
                                                          SvgPicture.asset(
                                                              'assets/images/small-black-location-icon.svg'),
                                                          SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.01),
                                                          Text(
                                                            "${getData.routes!.pickup!.name}",
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF565656),
                                                              fontSize: 8,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: size.height *
                                                              0.005),
                                                      SizedBox(
                                                        width: 180,
                                                        child: Row(
                                                          children: [
                                                            for (int i = 0;
                                                                i <
                                                                    getData
                                                                        .vehicles!
                                                                        .length;
                                                                i++)
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            2),
                                                                child: getData
                                                                            .vehicles!
                                                                            .length <
                                                                        4
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
                                                                            style:
                                                                                const TextStyle(
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
                                                                                  Icons.attach_money, // This is the currency icon
                                                                                  size: 10,
                                                                                  color: Color(0xFF565656),
                                                                                ),
                                                                                Text(
                                                                                  "credit",
                                                                                  style: TextStyle(
                                                                                    color: Color(0xFF565656),
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'Poppins',
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          if (getData.cashReceiveFromCustomer !=
                                                                              "0")
                                                                            Row(
                                                                              children: [
                                                                                const Icon(
                                                                                  Icons.attach_money, // This is the currency icon
                                                                                  size: 10,
                                                                                  color: Color(0xFF565656),
                                                                                ),
                                                                                Text(
                                                                                  "${getData.cashReceiveFromCustomer}",
                                                                                  style: const TextStyle(
                                                                                    color: Color(0xFF565656),
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'Poppins',
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                        ],
                                                                      )
                                                                    : Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            right:
                                                                                5),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(bottom: 4),
                                                                              child: SvgPicture.asset('assets/images1/small-black-car-icon.svg'),
                                                                            ),
                                                                            Text(
                                                                              '${getData.vehicles![i].vehiclesName!.name}',
                                                                              style: const TextStyle(
                                                                                color: Color(0xFF565656),
                                                                                fontSize: 10,
                                                                                fontFamily: 'Poppins',
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: size.height *
                                                              0.005),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SvgPicture.asset(
                                                              'assets/images1/small-black-bookings-icon.svg'),
                                                          SizedBox(
                                                              width:
                                                                  size.width *
                                                                      0.01),
                                                          Text(
                                                            '${_formatDate(getData.pickupDate!)} ${_formatTime(getData.pickupTime!)}',
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFF565656),
                                                              fontSize: 10,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      getData.pendingUpdate ==
                                                              "No"
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: 8,
                                                              ),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) => NavBar(
                                                                            indexNmbr:
                                                                                2,
                                                                            updateBooking:
                                                                                true,
                                                                            bookingId:
                                                                                getData.bookingsId),
                                                                      ));
                                                                },
                                                                child:
                                                                    const Row(
                                                                  children: [
                                                                    Text(
                                                                      'Update Booking',
                                                                      style:
                                                                          TextStyle(
                                                                        color: ConstantColor
                                                                            .primaryColor,
                                                                        fontSize:
                                                                            10,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : Row(
                                                              children: [
                                                                InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      await getBookingListPending(
                                                                          getData
                                                                              .bookingsId);

                                                                      if (getBookingPendingById
                                                                              .data !=
                                                                          null) {
                                                                        print(
                                                                            "hello next");
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => TrackPagePending(getBookingData: getBookingPendingById.data![0]),
                                                                            ));
                                                                      }
                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "Check Update",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xFF565656),
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    )),
                                                              ],
                                                            )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: size.height * 0.02),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const SizedBox(
                                height: 300,
                                width: 300,
                                child:
                                    Center(child: Text("No upcoming Booking")),
                              ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  String _formatDate(String date) {
    final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
    return DateFormat('d MMM yyyy').format(parsedDate);
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        // Handle edit action
        break;
      case 1:
        // Handle delete action
        break;
    }
  }

  String _formatTime(String time) {
    final DateTime parsedTime = DateFormat('HH:mm:ss').parse(time);
    return DateFormat('h:mm a').format(parsedTime);
  }
}
