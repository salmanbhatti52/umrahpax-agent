// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umrahcar/screens/homepage_screen.dart';
import 'package:umrahcar/utils/colors.dart';
import 'package:umrahcar/widgets/button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:umrahcar/widgets/navbar.dart';

import '../../../models/get_booking_list_model.dart';
import '../../../service/rest_api_serivice.dart';
import '../../../widgets/booking_confirmation.dart';

class GuestInfoPageUpdate extends StatefulWidget {
  final TabController? tabController;
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
  String? vehicleId;
  String? vehicleId1;
  String? vehicleId2;
  String? vehicleId3;
  String? flightNmbr1;
  String? flightCompaniesId1;
  String? flightDetails1;
  String? flightCode1;
  String? totalFare1;
  String? totalNumberOfPassengers1;
  String? vehicleName;
  String? selectedPaymentMethod;
  String? bookingId;
  String? cashFromGuest;

   GuestInfoPageUpdate({super.key,this.cashFromGuest,this.bookingId,this.selectedPaymentMethod, this.vehicleName,this.tabController,this.pickupHotel1,this.vehicleId,this.flightCode1,this.dropOffHotel1,this.dropOffLocation1,this.extraInformation1,this.flightCompaniesId1,this.flightDetails1,this.flightNmbr1,this.numberOfAdults1,this.numberOfChilds1,this.numberOfInfants1,this.pickUpData1,this.pickupLocation1,this.pickUpTime1,this.routesDropOffId1,this.routesId1,this.routesPickUpId1,this.serviceType1,this.totalFare1,this.totalNumberOfPassengers1,this.vehicleId1,this.vehicleId2,this.vehicleId3,this.visaType1,});

  @override
  State<GuestInfoPageUpdate> createState() => _GuestInfoPageUpdateState();
}

class _GuestInfoPageUpdateState extends State<GuestInfoPageUpdate> {
  TextEditingController guestNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController whatsappNumberController = TextEditingController();
  final GlobalKey<FormState> guestInfoFormKey = GlobalKey<FormState>();
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;
  String? completeNumber="+";

  bool status = false;


  @override
  void initState() {
    // TODO: implement initState
    print("get service type: ${widget.serviceType1}");
    print("get visa type: ${widget.visaType1}");
    print("get pickup location: ${widget.pickupLocation1}");
    print("get  pickup hotel: ${widget.pickupHotel1}");
    print("get dropoff location:: ${widget.dropOffLocation1}");
    print("get dropoff hotel:: ${widget.dropOffHotel1}");
    print("pick up date:: ${widget.pickUpData1}");
    print("pick up time:: ${widget.pickUpTime1}");
    print("get routes Pick Id:: ${widget.routesPickUpId1}");
    print("get Drop Off Pick Id:: ${widget.routesDropOffId1}");
    print("Index of Tabbar:: ${widget.tabController}");
    print("flightCode: ${widget.flightCode1}");
    print("routesId1:: ${widget.routesId1}");
    print("numberOfChilds:: ${widget.numberOfChilds1}");
    print("numberOfInfants: ${widget.numberOfInfants1}");
    print("numberOfAdults:: ${widget.numberOfAdults1}");
    print("extraInformation: ${widget.extraInformation1}");
    print("vehicleId: ${widget.vehicleId}");
    print("vehicleId1: ${widget.vehicleId1}");
    print("vehicleId2: ${widget.vehicleId2}");
    print("vehicleId3: ${widget.vehicleId3}");
    print("flightNmbr: ${widget.flightNmbr1}");
    print("flightCompaniesId: ${widget.flightCompaniesId1}");
    print("flightDetails: ${widget.flightDetails1}");
    print("totalFare: ${widget.totalFare1}");
    print("totalNumberOfPassengers: ${widget.totalNumberOfPassengers1}");
    print("totalFare: ${widget.totalFare1}");
    print("visa type: ${widget.visaType1}");
    getBookingListByIdUpcoming();
    super.initState();
  }
  GetBookingListModel getBookingByidResponse = GetBookingListModel();
  getBookingListByIdUpcoming() async {
    print("bookingId ${widget.bookingId}");
    var mapData = {"bookings_id": widget.bookingId};
    getBookingByidResponse = await DioClient().getBookingById(mapData, context);
    for (int i = 0; i < getBookingByidResponse.data!.length; i++) {
      print("Get Booking by  id: ${getBookingByidResponse.data![i].name}");
      guestNameController.text = getBookingByidResponse.data![i].name!;
      contactNumberController.text = getBookingByidResponse.data![i].contact!;
      whatsappNumberController.text = getBookingByidResponse.data![i].whatsapp!;
      print("visaTypesId: ${getBookingByidResponse.data![i].visaTypesId}");
      setState(() {

      });
    }
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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: guestInfoFormKey,
            child: Container(
              color: Colors.transparent,
              height: size.height * 0.92,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: size.height * 0.02),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: guestNameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Guest Name field is required!';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                      ),
                      decoration: InputDecoration(
                        filled: false,
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        hintText: "Guest Name",
                        hintStyle: const TextStyle(
                          color: Color(0xFF929292),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: SvgPicture.asset(
                          'assets/images/name-icon.svg',
                          width: 25,
                          height: 25,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: contactNumberController,
                      // cursorColor: orangeColor,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Contact Number field is required!';
                        }
                        return null;
                      },
                      // onChanged: (value){
                      //   completeNumber="${countryCode?.dialCode}$value";
                      //   setState(() {
                      //
                      //   });
                      // },
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                      ),
                      decoration: InputDecoration(
                        filled: false,
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2,
                        ),

                        border: OutlineInputBorder(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(14)),
                          borderSide: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        hintText: "Contact Number",
                        hintStyle: const TextStyle(
                          color: Color(0xFF929292),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: GestureDetector(
                          onTap: () async {
                            final code =
                            await countryPicker.showPicker(context: context);
                            setState(() {
                              countryCode = code;
                            });
                            print('countryCode: ${countryCode!.dialCode}');
                            print('countryName: ${countryCode!.name}');
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [


                              // Padding(
                              //   padding: const EdgeInsets.only(left: 10),
                              //   child: Text(
                              //     countryCode?.dialCode ?? "+234",
                              //     textAlign: TextAlign.center,
                              //     style: const TextStyle(
                              //       color: Colors.black54,
                              //       fontSize: 12,
                              //       fontFamily: 'Inter-Light',
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(width: size.width * 0.02),
                              // const Text(
                              //   '|',
                              //   style: TextStyle(
                              //     color: Colors.black54,
                              //     fontSize: 12,
                              //     fontFamily: 'Inter-SemiBold',
                              //   ),
                              // ),
                              // SizedBox(width: size.width * 0.02),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: SvgPicture.asset(
                                  'assets/images/contact-icon.svg',
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: whatsappNumberController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Whatsapp Number field is required!';
                        }
                        return null;
                      },
                      onChanged: (value){

                      },
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                      ),
                      decoration: InputDecoration(
                        filled: false,
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2,
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: const Color(0xFF000000).withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        hintText: "Whatsapp Number",
                        hintStyle: const TextStyle(
                          color: Color(0xFF929292),
                          fontSize: 12,
                        fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: SvgPicture.asset(
                          'assets/images/whatsapp-icon.svg',
                          width: 25,
                          height: 25,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Same as contact',
                          style: TextStyle(
                            color: Color(0xFF565656),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        FlutterSwitch(
                          width: 45,
                          height: 25,
                          activeColor: buttonColor,
                          inactiveColor: const Color(0xFF565656).withOpacity(0.2),
                          toggleSize: 25,
                          value: status,
                          borderRadius: 50,
                          padding: 2,
                          onToggle: (val) {
                            setState(() {
                              status = val;
                              if(status==true){
                                completeNumber=contactNumberController.text;

                                whatsappNumberController.text=completeNumber!;

                              }
                              else{
                                whatsappNumberController.text="";

                              }

                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.2),
                  GestureDetector(
                    onTap: () {
                      if(guestInfoFormKey.currentState!.validate()){
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => Dialog(
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
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       children: [
                                         Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 10),
                                          child: Text(
                                            '${widget.pickupLocation1}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                             fontFamily: 'Poppins',
                                            ),
                                          ),
                                    ),
                                       ],
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                         Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 10),
                                          child: Text(
                                            '${widget.dropOffLocation1}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                             fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: size.height * 0.04),
                                     Padding(
                                      padding: const EdgeInsets.only(left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Date',
                                            style: TextStyle(
                                              color: Color(0xFF929292),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                             fontFamily: 'Poppins',
                                            ),
                                          ),
                                          Text(
                                            '${widget.pickUpData1}',
                                            style: const TextStyle(
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
                                            'Vehicle Name',
                                            style: TextStyle(
                                              color: Color(0xFF929292),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                             fontFamily: 'Poppins',
                                            ),
                                          ),
                                          Text(
                                            '${widget.vehicleName}',
                                            style: const TextStyle(
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
                                            '${widget.totalFare1}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                             fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(height: size.height * 0.02),
                                    // const Padding(
                                    //   padding: EdgeInsets.only(left: 10, right: 10),
                                    //   child: Row(
                                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //     crossAxisAlignment: CrossAxisAlignment.center,
                                    //     children: [
                                    //       Text(
                                    //         'Total Fare',
                                    //         style: TextStyle(
                                    //           color: Color(0xFF929292),
                                    //           fontSize: 15,
                                    //           fontWeight: FontWeight.w500,
                                    //           fontFamily: 'Montserrat-Regular',
                                    //         ),
                                    //       ),
                                    //       Text(
                                    //         '600 SAR',
                                    //         style: TextStyle(
                                    //           color: Color(0xFF79BF42),
                                    //           fontSize: 15,
                                    //           fontWeight: FontWeight.w600,
                                    //           fontFamily: 'Montserrat-Regular',
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    SizedBox(height: size.height * 0.06),
                                    GestureDetector(
                                      onTap: () async{
                                        print("uidZ: $userId");
                                        var mapData={
                                          "bookings_id":"${widget.bookingId}",
                                          "source": "TEST API",
                                          "users_agents_id":userId.toString(),
                                          "routes_id":"${widget.routesId1}",
                                          "pickup_location":"${widget.routesPickUpId1}",
                                          "dropoff_location":"${widget.routesDropOffId1}",
                                          "service_type":"${widget.serviceType1}",
                                          "visa_types_id":"${widget.visaType1}",
                                          "name":guestNameController.text,
                                          "contact":contactNumberController.text,
                                          "whatsapp":whatsappNumberController.text,
                                          "payment_type":widget.selectedPaymentMethod,
                                          if(widget.selectedPaymentMethod=="cash")   "cash_from_guest": "${widget.cashFromGuest}",

                                          "pickup_date":widget.pickUpData1,
                                          "pickup_time":widget.pickUpTime1,
                                          "no_of_childs":widget.numberOfChilds1,
                                          "no_of_infants":widget.numberOfInfants1,
                                          "no_of_adults":widget.numberOfAdults1,
                                          "no_of_passengers":widget.totalNumberOfPassengers1,
                                        if (widget.extraInformation1!.isNotEmpty)"extra_information" : widget.extraInformation1 else "extra_information" : "hiii",
                                          "vehicle":{
                                            "0":widget.vehicleId,
                                            if(widget.vehicleId1 !="null")  "1":widget.vehicleId1,
                                            if(widget.vehicleId2 !="null")  "2":widget.vehicleId2,
                                            if(widget.vehicleId3 !="null" )  "3":widget.vehicleId3,
                                          },
                                          if(widget.pickupHotel1 !="null")  "pickup_hotel":widget.pickupHotel1,
                                          if(widget.dropOffHotel1 !="null")  "dropoff_hotel":widget.dropOffHotel1,
                                          "booked_fare": widget.totalFare1,
                                          "agent_fare":widget.totalFare1,
                                          "actual_fare":widget.totalFare1,
                                          "flight_number":widget.flightNmbr1,
                                          "flight_companies_id":widget.flightCompaniesId1,
                                          "flight_date": widget.pickUpData1,
                                          "flight_time":widget.pickUpTime1,
                                          "flight_details": widget.flightDetails1
                                          // "flight_code": widget.flightCode1
                                        };
                                        var response = await DioClient().editBookingAgent(
                                            mapData,context
                                        );
                                        print("hiiii data: ${response.data}");
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Booking Update successfull")));
                                        Navigator.pushReplacement(
                                            context, MaterialPageRoute(builder: (context) =>  NavBar()));
                                                                            },
                                      child: dialogButton('OK', context),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }


                    },
                    child: button('Submit', context),
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
