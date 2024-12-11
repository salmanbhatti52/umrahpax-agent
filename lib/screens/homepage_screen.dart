import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umrahcar/service/rest_api_serivice.dart';
import 'package:umrahcar/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar/widgets/navbar.dart';
import 'package:umrahcar/widgets/top_boxes.dart';
import 'package:umrahcar/widgets/homepage_get_booking_list.dart';

var userId;
var profileName;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getLocalData();
    // TODO: implement initState
    super.initState();
  }

  var getBookingResponse;
  var getProfileResponse;
  getLocalData() async {
    final sharedPref = await SharedPreferences.getInstance();
    var uid = sharedPref.getString('userId');
    userId = uid;
    print("uiduid: $uid");
    print("uiduid: $userId");
    getBookingList();
    getAgentWidgetData();
    getProfile();
  }

  getBookingList() async {
    print("userIdId $userId");
    var mapData = {"users_agents_id": userId.toString()};
    getBookingResponse = await DioClient().getBookingList(mapData, context);
    print("response id: ${getBookingResponse.data}");
    setState(() {});
  }

  var getAgentsWidgetData;

  getAgentWidgetData() async {
    print("userIdId $userId");
    var mapData = {"users_agents_id": userId.toString()};
    getAgentsWidgetData =
        await DioClient().getAgentsWidgetsData(mapData, context);
    print("response id: ${getAgentsWidgetData.data}");
    setState(() {});
  }

  getProfile() async {
    print("userIdId $userId");
    var mapData = {"users_agents_id": userId.toString()};
    getProfileResponse = await DioClient().getProfile(mapData, context);
    if (getProfileResponse.data != null) {
      print("getProfileResponse name: ${getProfileResponse.data.name}");
    }
    profileName = getProfileResponse.data.name;
    print("my name: ${getProfileResponse.data.name}");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: mainColor,
      body: getProfileResponse != null
          ? Container(
              color: ConstantColor.primaryColor,
              child: Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    width: size.width,
                    height: size.height * 0.158,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60, left: 20),
                          child: CircleAvatar(
                            radius: 35,
                            child: Image.asset(
                              'assets/images/profile.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.02),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (getProfileResponse != null)
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    '${getProfileResponse.data!.name}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              SizedBox(height: size.height * 0.002),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/white-location-icon.svg'),
                                  SizedBox(width: size.width * 0.01),
                                  if (getProfileResponse != null)
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        '${getProfileResponse.data!.address!} ${getProfileResponse.data!.city!}, ${getProfileResponse.data!.state!} ${getProfileResponse.data!.country!}',
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6, left: 35),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: Colors.black.withOpacity(0.15),
                              ),
                            ),
                            child: Container(
                              decoration: const ShapeDecoration(
                                color: ConstantColor.primaryColor,
                                shape: OvalBorder(),
                              ),
                              child: SvgPicture.asset(
                                  'assets/images/notification-icon.svg'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.03),
                          if (getAgentsWidgetData != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NavBar(
                                                  indexNmbr: 1,
                                                )));
                                    setState(() {});
                                  },
                                  child: box(
                                      'assets/images/white-bookings-icon.svg',
                                      '${getAgentsWidgetData.data.bookingsPending}',
                                      'Pending Bookings',
                                      context),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NavBar(
                                                  indexNmbr: 1,
                                                )));
                                    setState(() {});
                                  },
                                  child: box(
                                      'assets/images/white-bookings-icon.svg',
                                      '${getAgentsWidgetData.data.bookingsAll}',
                                      'All Bookings',
                                      context),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NavBar(
                                                  indexNmbr: 1,
                                                )));
                                    setState(() {});
                                  },
                                  child: box(
                                      'assets/images/white-bookings-icon.svg',
                                      '${getAgentsWidgetData.data.bookingsCompleted}',
                                      'Completed Trips',
                                      context),
                                ),
                              ],
                            ),
                          SizedBox(height: size.height * 0.01),
                          if (getAgentsWidgetData != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => NavBar(
                                                    indexNmbr: 3,
                                                  )));
                                      setState(() {});
                                    },
                                    child: noimagebox(
                                        '${getAgentsWidgetData.data.bookingsTotalDeposit}',
                                        'Balance',
                                        context)),
                                // InkWell(
                                //     onTap: () {
                                //       Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (context) => NavBar(
                                //                     indexNmbr: 3,
                                //                   )));
                                //       setState(() {});
                                //     },
                                //     child: noimageredbox(
                                //         '${getAgentsWidgetData.data.bookingsTotalReamining}',
                                //         'Remaining',
                                //         context)),
                                nobox(context), nobox(context),
                              ],
                            ),
                          SizedBox(height: size.height * 0.03),
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Bookings',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) => const BookingsPage(),
                                //         ));
                                //   },
                                //   child: const Text(
                                //     'See all',
                                //     textAlign: TextAlign.right,
                                //     style: TextStyle(
                                //       color: Color(0xFF79BF42),
                                //       fontFamily: 'Montserrat-Regular',
                                //       fontWeight: FontWeight.w500,
                                //       fontSize: 12,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Container(
                              color: Colors.transparent,
                              height: size.height * 0.421,
                              child: Padding(
                                padding: const EdgeInsets.only(),
                                child: getBookingResponse != null
                                    ? RefreshIndicator(
                                        color: secondaryColor,
                                        onRefresh: () async {
                                          getBookingList();
                                          setState(() {});
                                        },
                                        child: homeList(
                                            context, getBookingResponse))
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          right: 10,
                                          bottom: 10,
                                        ),
                                        child: Center(
                                            child: SvgPicture.asset(
                                          'assets/images1/noBooking.svg',
                                          width: 150,
                                          height: 150,
                                        )),
                                      ),
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height / 1,
              child: const Center(
                child: CircularProgressIndicator(
                  color: ConstantColor.primaryColor,
                ),
              ),
            ),
    );
  }
}
