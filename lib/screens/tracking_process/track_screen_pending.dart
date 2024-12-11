import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:umrahcar/models/get_booking_list_model.dart';
import 'package:umrahcar/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar/widgets/button.dart';
import 'package:umrahcar/screens/tracking_process/tarcking/pickup_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/ge_bookings_pending_by_id_model.dart';
import 'dart:ui' as ui;

import '../../models/get_all_system_data_model.dart';
import '../../models/get_driver_profile.dart';
import '../../service/rest_api_serivice.dart';

class TrackPagePending extends StatefulWidget {
  GetBookingData1 getBookingData;
  TrackPagePending({super.key, required this.getBookingData});

  @override
  State<TrackPagePending> createState() => _TrackPagePendingState();
}

class _TrackPagePendingState extends State<TrackPagePending> {
  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  showSnackbar({error, context}) {
    final snackBar = SnackBar(
      content: Text(error),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController? _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat!, long!), zoom: 17),
        ),
      );
    });
  }

  double? lat;
  double? long;
  @override
  var icon;
  BitmapDescriptor? markerIcon;
  void addCustomIcon() async {
    icon = await getBitmapDescriptorFromAssetBytes(
        "assets/images/location.png", 50);
    setState(() {});
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
      String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }

  Timer? timer;
  GetAllSystemData getAllSystemData = GetAllSystemData();

  getSystemAllData() async {
    getAllSystemData = await DioClient().getSystemAllData(context);
    if (getAllSystemData != null) {
      print("GETSystemAllData: ${getAllSystemData.data}");
      setState(() {
        getSettingsData();
      });
    }
  }

  late List<Setting> pickSettingsData = [];
  int timerCount = 3;
  getSettingsData() {
    if (getAllSystemData!.data! != null) {
      for (int i = 0; i < getAllSystemData!.data!.settings!.length; i++) {
        pickSettingsData.add(getAllSystemData!.data!.settings![i]);
        print("Setting time= $pickSettingsData");
      }

      for (int i = 0; i < pickSettingsData.length; i++) {
        if (pickSettingsData[i].type == "map_refresh_time") {
          timerCount = int.parse(pickSettingsData[i].description!);

          print("timer refresh: ${timerCount}");
          // getProfile();
          // timer =
          //     Timer.periodic( Duration(minutes: timerCount), (timer) => getProfile());
          setState(() {});
        } else if (pickSettingsData[i].type == "lattitude") {
          lat = double.parse(pickSettingsData[i].description!);
          print("timer lat: ${timerCount}");
        } else if (pickSettingsData[i].type == "longitude") {
          long = double.parse(pickSettingsData[i].description!);
          print("timer long: ${timerCount}");
        }
      }
    }
  }

  void initState() {
    getSystemAllData();

    addCustomIcon();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  // GetDriverProfile getProfileResponse = GetDriverProfile();
  // getProfile() async {
  //   print("userIdId ${widget.getBookingData!.vehicles![0].usersDriversId}");
  //
  //   getProfileResponse = await DioClient().getProfileDriver(
  //       widget.getBookingData!.vehicles![0].usersDriversId, context);
  //   if (getProfileResponse.data != null) {
  //     print(
  //         "getProfileResponse name: ${getProfileResponse.data!.userData!.name}");
  //     long = double.parse(getProfileResponse.data!.userData!.longitude!);
  //     lat = double.parse(getProfileResponse.data!.userData!.lattitude!);
  //     setState(() {});
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print("latlat: ${lat}");
    print("long: ${long}");
    return Scaffold(
      backgroundColor: mainColor,
      body: long != null
          ? Container(
              color: Colors.transparent,
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height / 2.28,
                    child: GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: _initialcameraposition),
                      mapType: MapType.normal,
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: false,
                      markers: {
                        Marker(
                            markerId: MarkerId('Pakistan'),
                            position: LatLng(lat!, long!),
                            draggable: true,
                            icon: icon != null
                                ? icon!
                                : BitmapDescriptor.defaultMarker)
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: size.width,
                      height: size.height * 0.56,
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
                                children: [
                                  const Text(
                                    'Bookings Details',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '(Booking Id ${widget.getBookingData!.bookingsId})',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.02),
                              const Text(
                                'Pickup Location',
                                style: TextStyle(
                                  color: Color(0xFF929292),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              Text(
                                '${widget.getBookingData!.routes!.pickup!.name} (${widget.getBookingData!.routes!.pickup!.type})',
                                style: const TextStyle(
                                  color: Color(0xFF565656),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              const Text(
                                'Drop off Location',
                                style: TextStyle(
                                  color: Color(0xFF929292),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              Text(
                                '${widget.getBookingData!.routes!.dropoff!.name} (${widget.getBookingData!.routes!.dropoff!.type})',
                                style: const TextStyle(
                                  color: Color(0xFF565656),
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: size.height * 0.025),
                              Row(
                                children: [
                                  for (int i = 0;
                                      i <
                                          widget
                                              .getBookingData!.vehicles!.length;
                                      i++)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 7),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/fast-car-icon.svg',
                                            width: 10,
                                            height: 10,
                                          ),
                                          SizedBox(width: size.width * 0.01),
                                          Text(
                                            '${widget.getBookingData!.vehicles![i]!.vehiclesName!.name}',
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
                                ],
                              ),
                              SizedBox(height: size.height * 0.02),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/small-black-bookings-icon.svg',
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(width: size.width * 0.032),
                                      Text(
                                        '${widget.getBookingData!.flightDate}',
                                        style: const TextStyle(
                                          color: Color(0xFF565656),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: size.width * 0.14),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/clock-icon.svg',
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(width: size.width * 0.032),
                                      Text(
                                        '${widget.getBookingData!.pickupTime}',
                                        style: const TextStyle(
                                          color: Color(0xFF565656),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(height: size.height * 0.02),
                              Divider(
                                color: const Color(0xFF929292).withOpacity(0.3),
                                thickness: 1,
                              ),
                              SizedBox(height: size.height * 0.02),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        child: Image.asset(
                                          'assets/images/user-profile.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.032),
                                      SizedBox(
                                        width: size.width * 0.275,
                                        child: Text(
                                          '${widget.getBookingData!.name}',
                                          style: TextStyle(
                                            color: Color(0xFF565656),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: size.width * 0.115),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/passenger-icon.svg',
                                        width: 20,
                                        height: 20,
                                      ),
                                      SizedBox(width: size.width * 0.045),
                                      SizedBox(
                                        width: size.width * 0.275,
                                        child: Text(
                                          '(${widget.getBookingData!.noOfPassengers} Passengers)',
                                          style: const TextStyle(
                                            color: Color(0xFF565656),
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
                              SizedBox(height: size.height * 0.02),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images/contact-icon.svg'),
                                      SizedBox(width: size.width * 0.032),
                                      SizedBox(
                                        width: size.width * 0.275,
                                        child: Text(
                                          '${widget.getBookingData!.contact}',
                                          style: const TextStyle(
                                            color: Color(0xFF565656),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: size.width * 0.14),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/images/whatsapp-icon.svg'),
                                      SizedBox(width: size.width * 0.032),
                                      SizedBox(
                                        width: size.width * 0.275,
                                        child: Text(
                                          '${widget.getBookingData!.whatsapp}',
                                          style: const TextStyle(
                                            color: Color(0xFF565656),
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
                              SizedBox(height: size.height * 0.02),
                              Divider(
                                color: const Color(0xFF929292).withOpacity(0.3),
                                thickness: 1,
                              ),
                              if (widget.getBookingData!.bookedFare != "0")
                                SizedBox(height: size.height * 0.01),
                              if (widget.getBookingData!.bookedFare != "0")
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Booked Fare',
                                      style: TextStyle(
                                        color: Color(0xFF929292),
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.03),
                                    widget.getBookingData!.paymentType ==
                                            "credit"
                                        ? const Text(
                                            'credit',
                                            style: TextStyle(
                                              color: Color(0xFF565656),
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        : Text(
                                            '${widget.getBookingData!.bookedFare}',
                                            style: const TextStyle(
                                              color: Color(0xFF565656),
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                  ],
                                ),
                              if (widget.getBookingData!
                                      .cashReceiveFromCustomer !=
                                  "0")
                                SizedBox(height: size.height * 0.02),
                              if (widget.getBookingData!
                                      .cashReceiveFromCustomer !=
                                  "0")
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Cash Receive From Customer',
                                      style: TextStyle(
                                        color: Color(0xFF929292),
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.02),
                                    Text(
                                      'credit (${widget.getBookingData!.cashReceiveFromCustomer})',
                                      style: const TextStyle(
                                        color: Color(0xFF565656),
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),

                              SizedBox(height: size.height * 0.03),
                              // if (widget.getBookingData!.vehicles![0]
                              //     .vehiclesDrivers !=
                              //     null)
                              //   GestureDetector(
                              //     onTap: () {
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //             builder: (context) => PickUpPage(
                              //                 getBookingData:
                              //                 widget.getBookingData),
                              //           ));
                              //     },
                              //     child: button('Track', context),
                              //   ),
                              SizedBox(height: size.height * 0.02),
                            ],
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
                      child: SvgPicture.asset('assets/images/back-icon.svg'),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 175, top: 30),
                  child: CircularProgressIndicator(
                    color: ConstantColor.primaryColor,
                  ),
                ),
              ],
            ),
    );
  }
}
