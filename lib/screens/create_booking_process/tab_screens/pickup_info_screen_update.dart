// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:umrahcar/models/get_all_system_data_model.dart';
import 'package:umrahcar/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar/widgets/button.dart';

import '../../../models/get_booking_list_model.dart';
import '../../../models/get_drop_off_location_model.dart';
import '../../../models/get_hotels_data.dart';
import '../../../service/rest_api_serivice.dart';

class TouristInfoPageUpdate extends StatefulWidget {
  final TabController? tabController;
  String? bookingId;
  final Function(
      {String visaType,
      String serviceType,
      String pickupLocation,
      String? pickupHotel,
      String dropOffLocation,
      String? dropOffHotel,
      String pickUpData,
      int? routesDropOffId,
      int? routesPickUpId,
      int? tabbarIndex,
      String pickUpTime}) onDataReceived;
  TouristInfoPageUpdate(
      {super.key,
      this.tabController,
      required this.onDataReceived,
      this.bookingId});

  @override
  State<TouristInfoPageUpdate> createState() => _TouristInfoPageUpdateState();
}

class _TouristInfoPageUpdateState extends State<TouristInfoPageUpdate> {
  TextEditingController pickUpController = TextEditingController();
  TextEditingController dropOffController = TextEditingController();
  final GlobalKey<FormState> pickUpInfoFormKey = GlobalKey<FormState>();
  String? pickupDate;
  String? pickupTime;
  String? selectedVisa;
  String? selectedPickupLocation;
  String? selectedPickUp;
  String? selectedDropOff;
  String? serviceType;
  String? currentDate;
  String? currentTime;
  String? selectedHotel;
  List<String>? getHotelsData = [];
  String? selectedDropOffLocation;
  List<String>? getDropOffLocation = [];
  String? selectedDropOffHotel;
  List<String>? getDropOffHotel = [];
  int routesPickupId = 0;
  int routesDropOffId = 0;
  String? visaId;
  String hintValue = "Drop off Hotel";
  late List<String> visaTypeItems = [];
  late List<String> visaTypeId = [];
  late List<String> pickupLocationData = [];
  late List<String> pickVehicleData = [];
  late List<String> serviceTypeData = [];
  String? updatevisaTypeId;

  GetHotelsData? getDropOffHotelId;
  GetHotelsData? getHotelIdList;
  String? pickUpHotelId;
  String? dropOffHotelId;

  getHotelsDataList({String? area}) async {
    final result = area!.split(' ').take(1).join(' ');
    print(result);

    var mapData = {"data_type": "get_pickup_hotels", "hotel_name": result};
    var response = await DioClient().getHotelsData(mapData, context);
    print("data of hotels: $response");
    getHotelIdList = response;

    if (response != null) {
      for (int i = 0; i < response.data!.length; i++) {
        getHotelsData!.add(response.data![i].name!);
        print("getHotelData: $getHotelsData");
        setState(() {});
      }
    }
  }

  getDropOffHotelsDataList({String? area}) async {
    print("area: ${area}");
    print("list: $getDropOffHotel");
    final result = area!.split(' ').take(1).join(' ');
    print(result);
    if (result == "Madinah" || result == "Makkah") {
      var mapData = {"data_type": "get_dropoff_hotels", "hotel_name": result};
      var response = await DioClient().getDropOffHotelData(mapData, context);
      print("data of dropoff hotels: $response");
      getDropOffHotelId = response;
      if (response != null) {
        for (int i = 0; i < response.data!.length; i++) {
          hintValue = "Drop off Location";
          getDropOffHotel!.add(response.data![i].name!);
          print("getDropOffHotel: $getDropOffHotel");
          setState(() {});
        }
      }
    } else {
      hintValue = "No need to select DropOff Location";
      getDropOffHotel = [];
      selectedDropOffHotel = null;
      setState(() {});
    }
  }

  GetDropOffLocation _getDropOffLocation = GetDropOffLocation();
  getDropOffDataList({int? routeId}) async {
    print("route: $routeId");

    var mapData = {
      "data_type": "get_dropoff_locations",
      "routes_pickup_id": "$routeId"
    };
    _getDropOffLocation = await DioClient().getDropOffData(mapData, context);
    print("data of dropoff hotels: $_getDropOffLocation");
    if (_getDropOffLocation != null) {
      for (int i = 0; i < _getDropOffLocation.data!.length; i++) {
        getDropOffLocation!.add(_getDropOffLocation.data![i].name!);

        print("getDropOffLocation: $getDropOffLocation");
        setState(() {});
      }
    }
  }

  GetAllSystemData getAllSystemData = GetAllSystemData();
  getSystemAllData() async {
    getAllSystemData = await DioClient().getSystemAllData(context);
    if (getAllSystemData != null) {
      getPickUpLocationData();
      getServiceTypeData();
      getVisaTypeListData();

      print("GETSystemAllData: ${getAllSystemData.data}");
      setState(() {});
    }
  }

  getVisaTypeListData() {
    visaTypeItems.clear();

    if (getAllSystemData!.data != null) {
      for (int i = 0; i < getAllSystemData!.data!.visaTypes!.length; i++) {
        visaTypeItems.add(getAllSystemData!.data!.visaTypes![i].name!);
        print("visa items= $visaTypeItems");
        print("updatevisaTypeId $updatevisaTypeId");
        if (updatevisaTypeId != null) {
          print("getSystemAllData(); ${updatevisaTypeId}");
          if (updatevisaTypeId ==
              getAllSystemData!.data!.visaTypes![i].visaTypesId) {
            selectedVisa = getAllSystemData!.data!.visaTypes![i].name;
            print("selectedVisa(); $selectedVisa");
          }
        }
      }
    }
  }

  getPickUpLocationData() {
    pickupLocationData.clear();

    if (getAllSystemData!.data! != null) {
      for (int i = 0; i < getAllSystemData!.data!.routesPickup!.length; i++) {
        pickupLocationData.add(getAllSystemData!.data!.routesPickup![i].name!);
        print("route items= $pickupLocationData");
        setState(() {});
      }
    }
  }

  getServiceTypeData() {
    serviceTypeData.clear();
    if (getAllSystemData!.data! != null) {
      for (int i = 0; i < getAllSystemData!.data!.serviceType!.length; i++) {
        serviceTypeData.add(getAllSystemData!.data!.serviceType![i]);
        print("Service Type items= $serviceTypeData");
      }
    }
  }

  GetBookingListModel getBookingByidResponse = GetBookingListModel();
  getBookingListByIdUpcoming() async {
    print("bookingId ${widget.bookingId}");
    var mapData = {"bookings_id": widget.bookingId};
    getBookingByidResponse = await DioClient().getBookingById(mapData, context);
    if (getBookingByidResponse != null) {
      for (int i = 0; i < getBookingByidResponse.data!.length; i++) {
        print("Get Booking by  id: ${getBookingByidResponse.data![i].name}");
        serviceType = getBookingByidResponse.data![i].serviceType;
        selectedPickupLocation =
            getBookingByidResponse.data![i].routes!.pickup!.name;
        getDropOffDataList(
            routeId: int.parse(getBookingByidResponse
                .data![i].routes!.pickup!.routesPickupId!));
        selectedDropOff = getBookingByidResponse.data![i].routes!.dropoff!.name;
        if (getBookingByidResponse.data![i].pickupHotel != null)
          selectedHotel = getBookingByidResponse.data![i].pickupHotel!.name;
        if (getBookingByidResponse.data![i].pickupHotel != null)
          pickUpHotelId = getBookingByidResponse.data![i].pickupHotel!.hotelsId;
        if (getBookingByidResponse.data![i].dropoffHotel != null)
          selectedDropOffHotel =
              getBookingByidResponse.data![i].dropoffHotel!.name;
        if (getBookingByidResponse.data![i].dropoffHotel != null)
          dropOffHotelId =
              getBookingByidResponse.data![i].dropoffHotel!.hotelsId;
        pickupDate = getBookingByidResponse.data![i].bookingDate;
        pickupTime = getBookingByidResponse.data![i].bookingTime;
        visaId = getBookingByidResponse.data![i].visaTypesId;
        routesPickupId =
            int.parse(getBookingByidResponse.data![i].routes!.routesPickupId!);
        routesDropOffId =
            int.parse(getBookingByidResponse.data![i].routes!.routesDropoffId!);
        updatevisaTypeId = getBookingByidResponse.data![i].visaTypesId;
        print("visaTypesId: ${getBookingByidResponse.data![i].visaTypesId}");
        print("updatevisaTypeId1: $updatevisaTypeId");
        print("selectedHotel: $selectedHotel");
        print("selectedDropOffHotel: $selectedDropOffHotel");
        setState(() {
          getSystemAllData();
        });
      }
    }
  }

  @override
  void initState() {
    getBookingListByIdUpcoming();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    currentTime = TimeOfDay.now().format(context);
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: mainColor,
        body: getAllSystemData.data != null
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  color: Colors.transparent,
                  height: size.height * 0.94,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.04),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          color: Colors.transparent,
                          width: size.width,
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                icon: SvgPicture.asset(
                                  'assets/images/dropdown-icon.svg',
                                  width: 10,
                                  height: 10,
                                  fit: BoxFit.scaleDown,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.15),
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.15),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.15),
                                      width: 1,
                                    ),
                                  ),
                                  prefixIcon: SvgPicture.asset(
                                    'assets/images/service-icon.svg',
                                    width: 10,
                                    height: 8,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  hintText: 'Service Type',
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF929292),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(16),
                                items: serviceTypeData!
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            color: Color(0xFF929292),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                value: serviceType,
                                onChanged: (value) {
                                  setState(() {
                                    serviceType = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          color: Colors.transparent,
                          width: size.width,
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                icon: SvgPicture.asset(
                                  'assets/images/dropdown-icon.svg',
                                  width: 10,
                                  height: 10,
                                  fit: BoxFit.scaleDown,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.15),
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.15),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.15),
                                      width: 1,
                                    ),
                                  ),
                                  prefixIcon: SvgPicture.asset(
                                    'assets/images/visa-icon.svg',
                                    width: 10,
                                    height: 10,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  hintText: 'Visa Type',
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF929292),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(16),
                                items: visaTypeItems!
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            color: Color(0xFF929292),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                value: selectedVisa,
                                onChanged: (value) {
                                  setState(() {
                                    selectedVisa = value;
                                    if (value != null) {
                                      for (int i = 0;
                                          i <
                                              getAllSystemData
                                                  .data!.visaTypes!.length;
                                          i++) {
                                        if (selectedVisa ==
                                            getAllSystemData
                                                .data!.visaTypes![i].name) {
                                          visaId = getAllSystemData
                                              .data!.visaTypes![i].visaTypesId;
                                          print("visa Id: ${visaId}");
                                        }
                                      }
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          color: Colors.transparent,
                          width: size.width,
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                icon: SvgPicture.asset(
                                  'assets/images/dropdown-icon.svg',
                                  width: 10,
                                  height: 10,
                                  fit: BoxFit.scaleDown,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.15),
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.15),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.15),
                                      width: 1,
                                    ),
                                  ),
                                  prefixIcon: SvgPicture.asset(
                                    'assets/images/address-icon.svg',
                                    width: 10,
                                    height: 10,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  hintText: 'Pickup Location',
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF929292),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(16),
                                items: pickupLocationData!
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            color: Color(0xFF929292),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                value: selectedPickupLocation,
                                onChanged: (value) {
                                  selectedPickupLocation = value;
                                  print("Location: $selectedPickupLocation");
                                  getDropOffLocation = [];
                                  selectedDropOff = null;
                                  selectedHotel = null;
                                  getHotelsData = [];
                                  if (value != null) {
                                    for (int i = 0;
                                        i <
                                            getAllSystemData
                                                .data!.routesPickup!.length;
                                        i++) {
                                      if (selectedPickupLocation ==
                                          getAllSystemData
                                              .data!.routesPickup![i].name) {
                                        routesPickupId = int.parse(
                                            getAllSystemData
                                                .data!
                                                .routesPickup![i]
                                                .routesPickupId!);
                                        print(
                                            "location length: $routesPickupId");

                                        getDropOffDataList(
                                            routeId: routesPickupId);

                                        if (selectedPickupLocation ==
                                                "Makkah Hotel" ||
                                            selectedPickupLocation ==
                                                "Madinah Hotel") {
                                          print(
                                              "selectedPickupLocation1 $selectedPickupLocation");
                                          getHotelsDataList(
                                              area: selectedPickupLocation);
                                        }
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          color: Colors.transparent,
                          width: size.width,
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                icon: SvgPicture.asset(
                                  'assets/images/dropdown-icon.svg',
                                  width: 10,
                                  height: 10,
                                  fit: BoxFit.scaleDown,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.15),
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.15),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.15),
                                      width: 1,
                                    ),
                                  ),
                                  prefixIcon: SvgPicture.asset(
                                    'assets/images/hotel-icon.svg',
                                    width: 10,
                                    height: 10,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  hintText: selectedPickupLocation != null &&
                                              selectedPickupLocation ==
                                                  "Jeddah Airport" ||
                                          selectedPickupLocation ==
                                              "Madinah Airport" ||
                                          selectedPickupLocation ==
                                              "Makkah Train Station" ||
                                          selectedPickupLocation ==
                                              "Madinah Train Station" ||
                                          selectedPickupLocation ==
                                              "Jeddah City"
                                      ? "No need to select Hotel"
                                      : selectedHotel != null
                                          ? selectedHotel
                                          : 'Pickup Hotel',
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF929292),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(16),
                                items: getHotelsData!
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Container(
                                          width: 230,
                                          child: Text(
                                            item,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Color(0xFF929292),
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                value: selectedHotel,
                                onChanged: selectedPickupLocation != null &&
                                            selectedPickupLocation ==
                                                "Jeddah Airport" ||
                                        selectedPickupLocation ==
                                            "Madinah Airport" ||
                                        selectedPickupLocation ==
                                            "Makkah Train Station" ||
                                        selectedPickupLocation ==
                                            "Madinah Train Station" ||
                                        selectedPickupLocation == "Jeddah City"
                                    ? null
                                    : (String? value) {
                                        setState(() {
                                          selectedHotel = value;
                                          print("Hotel: $selectedHotel");
                                          for (int i = 0;
                                              i < getHotelIdList!.data!.length;
                                              i++) {
                                            if (getHotelIdList!.data![i].name ==
                                                selectedHotel) {
                                              pickUpHotelId = getHotelIdList!
                                                  .data![i].hotelsId;
                                              print(
                                                  "hotel Id ${pickUpHotelId}");
                                            }
                                          }
                                        });
                                      },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          color: Colors.transparent,
                          width: size.width,
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                icon: SvgPicture.asset(
                                  'assets/images/dropdown-icon.svg',
                                  width: 10,
                                  height: 10,
                                  fit: BoxFit.scaleDown,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.15),
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.15),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16)),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF000000)
                                          .withOpacity(0.15),
                                      width: 1,
                                    ),
                                  ),
                                  prefixIcon: SvgPicture.asset(
                                    'assets/images/address-icon.svg',
                                    width: 10,
                                    height: 10,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  hintText: 'Drop off Location',
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF929292),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(16),
                                items: getDropOffLocation!
                                    .map(
                                      (item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            color: Color(0xFF929292),
                                            fontSize: 12,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                value: selectedDropOff,
                                onChanged: (value) {
                                  selectedDropOff = value;
                                  print("DropOFF:$selectedDropOff");
                                  getDropOffHotel = [];
                                  selectedDropOffHotel = null;
                                  if (selectedDropOff != null) {
                                    if (selectedDropOff == "Madinah Hotel" ||
                                        selectedDropOff == "Makkah Hotel" ||
                                        selectedDropOff == "Madinah Hotel ") {
                                      print(
                                          "selectedDropOff: $selectedDropOff");
                                      getDropOffHotelsDataList(
                                          area: selectedDropOff);
                                    }

                                    if (_getDropOffLocation.data != null) {
                                      for (int i = 0;
                                          i < _getDropOffLocation.data!.length;
                                          i++) {
                                        if (selectedDropOff ==
                                            _getDropOffLocation.data![i].name) {
                                          routesDropOffId = int.parse(
                                              _getDropOffLocation
                                                  .data![i].routesDropoffId!);
                                          print(
                                              "routes DropOffId: $routesDropOffId");
                                        }
                                      }
                                    }
                                    setState(() {});
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          color: Colors.transparent,
                          width: size.width,
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                  icon: SvgPicture.asset(
                                    'assets/images/dropdown-icon.svg',
                                    width: 10,
                                    height: 10,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      borderSide: BorderSide(
                                        color: const Color(0xFF000000)
                                            .withOpacity(0.15),
                                        width: 1,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      borderSide: BorderSide(
                                        color: const Color(0xFF000000)
                                            .withOpacity(0.15),
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      borderSide: BorderSide(
                                        color: const Color(0xFF000000)
                                            .withOpacity(0.15),
                                        width: 1,
                                      ),
                                    ),
                                    prefixIcon: SvgPicture.asset(
                                      'assets/images/hotel-icon.svg',
                                      width: 10,
                                      height: 10,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    hintText: selectedDropOff == null ||
                                            selectedDropOff ==
                                                "Madinah Hotel" ||
                                            selectedDropOff ==
                                                "Madinah Hotel " ||
                                            selectedDropOff == "Makkah Hotel"
                                        ? selectedDropOffHotel != null
                                            ? selectedDropOffHotel
                                            : hintValue
                                        : "No need to select Hotel",
                                    hintStyle: const TextStyle(
                                      color: Color(0xFF929292),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  items: getDropOffHotel!
                                      .map(
                                        (item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Container(
                                            width: 230,
                                            child: Text(
                                              item,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Color(0xFF929292),
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  value: selectedDropOffHotel,
                                  onChanged: (String? value) {
                                    print("hiii");
                                    setState(() {
                                      selectedDropOffHotel = value;
                                      for (int i = 0;
                                          i < getDropOffHotelId!.data!.length;
                                          i++) {
                                        if (getDropOffHotelId!.data![i].name ==
                                            selectedDropOffHotel) {
                                          dropOffHotelId = getDropOffHotelId!
                                              .data![i].hotelsId;
                                          print(
                                              "dropOffHotelId: ${dropOffHotelId}");
                                        }
                                      }
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Pickup Date',
                          style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        DateTime.now(), //get today's date
                                    firstDate: DateTime
                                        .now(), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2050));
                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                  pickupDate = DateFormat('yyyy-MM-dd').format(
                                      pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                  print(pickupDate);
                                }
                                setState(() {});
                              },
                              child: Text(
                                "Select Date:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        DateTime.now(), //get today's date
                                    firstDate: DateTime
                                        .now(), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2050));
                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                  pickupDate = DateFormat('yyyy-MM-dd').format(
                                      pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                  print(pickupDate);
                                }
                                setState(() {});
                              },
                              child: Center(
                                child: Text(
                                  pickupDate != null
                                      ? '$pickupDate'
                                      : "$currentDate",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: secondaryColor,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Pickup Time',
                          style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (pickedTime != null) {
                                  print(" Time: ${pickedTime.format(context)}");
                                  pickupTime = pickedTime.format(context);
                                  setState(() {}); //output 10:51 PM
                                } else {
                                  print("Time is not selected");
                                }
                              },
                              child: Text(
                                "Select Time:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (pickedTime != null) {
                                  print(" Time: ${pickedTime.format(context)}");
                                  pickupTime = pickedTime.format(context);
                                  setState(() {}); //output 10:51 PM
                                } else {
                                  print("Time is not selected");
                                }
                              },
                              child: Center(
                                child: Text(
                                  pickupTime != null
                                      ? pickupTime!
                                      : currentTime!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: secondaryColor,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      GestureDetector(
                          onTap: () {
                            // print("get service type: $serviceType");
                            // print("get visa type: $selectedVisa");
                            // print("get pickup location: $selectedPickupLocation");
                            // print("get  pickup hotel: $selectedHotel");
                            // print("get dropoff location:: $selectedDropOff");
                            // print("get dropoff hotel:: $selectedDropOffHotel");
                            // print("pick up date:: $pickupDate");
                            // print("pick up time:: $pickupTime");
                            //  print("get routes Pick Id:: $routesPickupId");
                            //  print("get Drop Off Pick Id:: $routesDropOffId");
                            // print("pick up time:: $pickupTime");
                            if (selectedVisa != null &&
                                serviceType != null &&
                                visaId != null &&
                                selectedDropOff != null &&
                                // selectedDropOffHotel != null &&
                                pickupTime != null &&
                                pickupDate != null &&
                                selectedPickupLocation != null &&
                                // selectedHotel != null &&
                                routesDropOffId != null &&
                                routesDropOffId != null) {
                              final newIndex = widget.tabController!.index + 1;
                              // widget.tabController!.animateTo(newIndex);
                              print('newIndex $newIndex');

                              widget.onDataReceived(
                                  visaType: visaId!,
                                  serviceType: serviceType!,
                                  dropOffHotel: dropOffHotelId,
                                  dropOffLocation: selectedDropOff!,
                                  pickUpData: pickupDate!,
                                  pickupHotel: pickUpHotelId,
                                  pickupLocation: selectedPickupLocation!,
                                  pickUpTime: pickupTime!,
                                  routesDropOffId: routesDropOffId,
                                  tabbarIndex: newIndex,
                                  routesPickUpId: routesPickupId);
                            } else if (selectedVisa == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Visa Type is Missing")));
                            } else if (serviceType == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Service Type is Missing")));
                            } else if (selectedDropOff == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Drop off Location is Missing")));
                            } else if (pickupTime == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Pick up Time is missing")));
                            } else if (pickupDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Pick up Date is missing")));
                            } else if (selectedPickupLocation == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Pick up Location is missing")));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("SomeThing is Missing")));
                            }
                          },
                          child: button('Next', context)),
                      SizedBox(height: size.height * 0.02),
                    ],
                  ),
                ),
              )
            : const Padding(
                padding: EdgeInsets.only(left: 175, top: 300),
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      color: ConstantColor.primaryColor,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
