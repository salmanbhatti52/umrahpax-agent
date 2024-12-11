import 'package:flutter/material.dart';
import 'package:umrahcar/screens/create_booking_process/tab_screens/guest_info_screen_update.dart';
import 'package:umrahcar/screens/create_booking_process/tab_screens/other_info_screen_update.dart';
import 'package:umrahcar/screens/create_booking_process/tab_screens/pickup_info_screen_update.dart';
import 'package:umrahcar/utils/colors.dart';

class TabbarUpdateBookings extends StatefulWidget {
  String? bookingId;
  TabbarUpdateBookings({super.key, this.bookingId});

  @override
  State<TabbarUpdateBookings> createState() => _TabbarUpdateBookingsState();
}

abstract class TickerProvider {}

class _TabbarUpdateBookingsState extends State<TabbarUpdateBookings>
    with TickerProviderStateMixin {
  int currentIndex = 0;
  int? tabbarIndex;
  String? vehicleName1;
  String? visaType1;
  String? pickupLocation1;
  String? pickupHotel1;
  String? dropOffLocation1;
  String? dropOffHotel1;
  String? pickUpData1;
  String? pickUpTime1;
  String? serviceType1;
  int? routesDropOffId1;
  int? routesPickUpId1;
  String? routesId1;
  String? numberOfChilds1;
  String? numberOfAdults1;
  String? numberOfInfants1;
  String? extraInformation1;
  String? vehicleId1;
  String? vehicleId11;
  String? vehicleId22;
  String? vehicleId33;
  String? flightNmbr1;
  String? flightCompaniesId1;
  String? flightDetails1;
  String? flightCode1;
  String? totalFare1;
  String? totalNumberOfPassengers1;
  String? vid;
  String? vid1;
  String? vid2;
  String? vid3;
  String? selectedPaymentMethod1;
  String? cashFromGuest1;

  void onDataReceived(
      {int? tabbarIndex,
      String? visaType,
      String? pickupLocation,
      String? pickupHotel,
      String? dropOffLocation,
      String? dropOffHotel,
      String? pickUpData,
      String? pickUpTime,
      String? serviceType,
      int? routesDropOffId,
      int? routesPickUpId}) {
    setState(() {
      // print("get service type: $serviceType");
      // print("get visa type: $visaType");
      // print("get pickup location: $pickupLocation");
      // print("get  pickup hotel: $pickupHotel");
      // print("get dropoff location:: $dropOffLocation");
      // print("get dropoff hotel:: $dropOffHotel");
      // print("pick up date:: $pickUpData");
      // print("pick up time:: $pickUpTime");
      // print("get routes Pick Id:: $routesPickUpId");
      // print("get Drop Off Pick Id:: $routesDropOffId");
      // print("Index of Tabbar:: $tabbarIndex");
      serviceType1 = serviceType;
      visaType1 = visaType;
      pickupLocation1 = pickupLocation;
      pickupHotel1 = pickupHotel;
      dropOffLocation1 = dropOffLocation;
      dropOffHotel1 = dropOffHotel;
      pickUpData1 = pickUpData;
      pickUpTime1 = pickUpTime;
      routesPickUpId1 = routesPickUpId;
      routesDropOffId1 = routesDropOffId;
      currentIndex = tabbarIndex!;
      print("curent of Tabbar:: $currentIndex");
      setState(() {});
    });
  }

  void onDataReceivedSecondTab({
    int? tabbarIndex,
    String? visaType,
    String? pickupLocation,
    String? pickupHotel,
    String? dropOffLocation,
    String? dropOffHotel,
    String? pickUpData,
    String? pickUpTime,
    String? serviceType,
    int? routesDropOffId,
    int? routesPickUpId,
    String? routesId,
    String? numberOfChilds,
    String? numberOfAdults,
    String? numberOfInfants,
    String? extraInformation,
    String? vehicleId,
    String? vehicleId1,
    String? vehicleId2,
    String? vehicleId3,
    String? flightNmbr,
    String? flightCompaniesId,
    String? flightDetails,
    String? flightCode,
    String? totalFare,
    String? totalNumberOfPassengers,
    String? vehicleName,
    String? selectedPaymentMethod,
    String? cashFromGuest,
  }) {
    setState(() {
      // print("get service type: $serviceType");
      // print("get visa type: $visaType");
      // print("get pickup location: $pickupLocation");
      // print("get  pickup hotel: $pickupHotel");
      // print("get dropoff location:: $dropOffLocation");
      // print("get dropoff hotel:: $dropOffHotel");
      // print("pick up date:: $pickUpData");
      // print("pick up time:: $pickUpTime");
      // print("get routes Pick Id:: $routesPickUpId");
      // print("get Drop Off Pick Id:: $routesDropOffId");
      // print("Index of Tabbar:: $tabbarIndex");
      // print("flightCode: $flightCode");
      // print("routesId1:: $routesId");
      // print("numberOfChilds:: $numberOfChilds");
      // print("numberOfInfants: $numberOfInfants");
      // print("numberOfAdults:: $numberOfAdults");
      // print("extraInformation: $extraInformation");
      // print("vehicleId: $vehicleId");
      // print("vehicleId1: $vehicleId1");
      // print("vehicleId2: $vehicleId2");
      // print("vehicleId3: $vehicleId3");
      // print("flightNmbr: $flightNmbr");
      // print("flightCompaniesId: $flightCompaniesId");
      // print("flightDetails: $flightDetails");
      // print("flightNmbr: $flightNmbr");
      // print("totalFare: $totalFare");
      // print("totalNumberOfPassengers: $totalNumberOfPassengers");
      // print("totalFare: $totalFare");
      serviceType1 = serviceType;
      visaType1 = visaType;
      pickupLocation1 = pickupLocation;
      pickupHotel1 = pickupHotel;
      dropOffLocation1 = dropOffLocation;
      dropOffHotel1 = dropOffHotel;
      pickUpData1 = pickUpData;
      pickUpTime1 = pickUpTime;
      routesPickUpId1 = routesPickUpId;
      routesDropOffId1 = routesDropOffId;
      currentIndex = tabbarIndex!;
      flightCode1 = flightCode;
      routesId1 = routesId;
      numberOfChilds1 = numberOfChilds;
      numberOfAdults1 = numberOfAdults;
      numberOfInfants1 = numberOfInfants;
      extraInformation1 = extraInformation;
      flightNmbr1 = flightNmbr;
      flightCompaniesId1 = flightCompaniesId;
      flightDetails1 = flightDetails;
      totalFare1 = totalFare;
      vid = vehicleId;
      vid1 = vehicleId1;
      vid2 = vehicleId2;
      vid3 = vehicleId3;
      totalNumberOfPassengers1 = totalNumberOfPassengers;
      currentIndex = tabbarIndex;
      vehicleName1 = vehicleName;
      selectedPaymentMethod1 = selectedPaymentMethod;

      cashFromGuest1 = cashFromGuest;
      print("cashFromGuest1: $cashFromGuest1");
      print("cashFromGuest1: $cashFromGuest");

      print("vid: $vid");
      print("vid1: $vid1");
      print("vid2: $vid2");
      print("vid3: $vid3");
      setState(() {});
    });
  }

  @override
  void initState() {
    print("hello ${widget.bookingId}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController =
        TabController(length: 3, vsync: this, initialIndex: currentIndex);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.059,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  width: 1,
                  color: const Color(0xFF000000).withOpacity(0.15),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    color: ConstantColor.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onTap: (index) {
                    if (tabController.indexIsChanging) {
                      tabController.index = tabController.previousIndex;
                    } else {
                      return;
                    }
                  },
                  indicatorColor: ConstantColor.primaryColor,
                  isScrollable: false,
                  labelColor: Colors.white,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelColor: const Color(0xFF929292),
                  unselectedLabelStyle: const TextStyle(
                    color: Color(0xFF929292),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(text: "Tour Info"),
                    Tab(text: "Other Info"),
                    Tab(text: "Guest Info"),
                  ],
                ),
              )),
        ),
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.72,
          child: TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              TouristInfoPageUpdate(
                tabController: tabController,
                onDataReceived: onDataReceived,
                bookingId: widget.bookingId,
              ),
              OtherInfoPageUpdate(
                tabController: tabController,
                routesPickUpId: routesPickUpId1,
                routesDropOffId: routesDropOffId1,
                pickUpTime: pickUpTime1,
                pickupLocation: pickupLocation1,
                pickupHotel: pickupHotel1,
                pickUpData: pickUpData1,
                onDataReceived: onDataReceivedSecondTab,
                dropOffLocation: dropOffLocation1,
                dropOffHotel: dropOffHotel1,
                serviceType: serviceType1,
                visaType: visaType1,
                bookingId: widget.bookingId,
              ),
              GuestInfoPageUpdate(
                tabController: tabController,
                visaType1: visaType1,
                dropOffHotel1: dropOffHotel1,
                dropOffLocation1: dropOffLocation1,
                extraInformation1: extraInformation1,
                flightCode1: flightCode1,
                flightCompaniesId1: flightCompaniesId1,
                flightDetails1: flightDetails1,
                flightNmbr1: flightNmbr1,
                numberOfAdults1: numberOfAdults1,
                numberOfChilds1: numberOfChilds1,
                numberOfInfants1: numberOfInfants1,
                pickUpData1: pickUpData1,
                pickupHotel1: pickupHotel1,
                pickupLocation1: pickupLocation1,
                pickUpTime1: pickUpTime1,
                routesDropOffId1: routesDropOffId1,
                routesId1: routesId1,
                routesPickUpId1: routesPickUpId1,
                serviceType1: serviceType1,
                totalFare1: totalFare1,
                totalNumberOfPassengers1: totalNumberOfPassengers1,
                vehicleId: vid,
                vehicleId1: vid1,
                vehicleId2: vid2,
                vehicleId3: vid3,
                vehicleName: vehicleName1,
                selectedPaymentMethod: selectedPaymentMethod1,
                bookingId: widget.bookingId,
                cashFromGuest: cashFromGuest1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
