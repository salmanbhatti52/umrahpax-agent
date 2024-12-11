import 'package:flutter/material.dart';
import 'package:umrahcar/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar/widgets/button.dart';

import '../../../models/get_all_system_data_model.dart';
import '../../../service/rest_api_serivice.dart';

class OtherInfoPage extends StatefulWidget {
  final TabController? tabController;
  String? visaType;
  String? pickupLocation;
  String? pickupHotel;
  String? dropOffLocation;
  String? dropOffHotel;
  String? pickUpData;
  String? pickUpTime;
  String? serviceType;
  int? routesDropOffId;
  int? routesPickUpId;

  final Function({
    String visaType,
    String serviceType,
    String pickupLocation,
    String? pickupHotel,
    String dropOffLocation,
    String? dropOffHotel,
    String pickUpData,
    int? routesDropOffId,
    int? routesPickUpId,
    int? tabbarIndex,
    String? pickUpTime,
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
    String? vehicleName,
    String? totalNumberOfPassengers,
    String? selectedPaymentMethod,
    String? cashFromGuest,
  }) onDataReceived;

  OtherInfoPage(
      {super.key,
      this.tabController,
      this.visaType,
      this.serviceType,
      this.routesPickUpId,
      this.routesDropOffId,
      this.pickUpTime,
      this.pickUpData,
      this.dropOffHotel,
      this.dropOffLocation,
      this.pickupHotel,
      this.pickupLocation,
      required this.onDataReceived});

  @override
  State<OtherInfoPage> createState() => _OtherInfoPageState();
}

class _OtherInfoPageState extends State<OtherInfoPage> {
  TextEditingController flightnumberController = TextEditingController();
  TextEditingController flightdetailsController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();
  TextEditingController numberOfChilds = TextEditingController();
  TextEditingController numberOfinfants = TextEditingController();
  TextEditingController numberOfAdults = TextEditingController();
  TextEditingController nmbrOfLuggage = TextEditingController();
  TextEditingController cashAmountController = TextEditingController();
  final GlobalKey<FormState> guestInfoFormKey = GlobalKey<FormState>();
  int totalPassengers = 0;
  int childs = 0;
  int adult = 0;
  // int infants=0;
  String? routesId;
  double? fare;
  double? fare1;
  double? fare2;
  double? fare3;
  double? totalFare = 0.0;

  List<String> paymentMethod = ["credit", "cash"];
  String? selectedPaymentMethod;
  List<Widget> addDropdowns = [];
  String? selectedVehicle;
  String? selectedVehicle1;
  String? selectedVehicle2;
  String? selectedVehicle3;
  int? selectedVehiclePassengers;
  int? selectedVehicle1Passengers;
  int? selectedVehicle2Passengers;
  int? selectedVehicle3Passengers;
  int totalNumberOfPassengers = 0;
  int? selectedVehicleId;
  int? selectedVehicle1Id;
  int? selectedVehicle2Id;
  int? selectedVehicle3Id;

  String? selectedChildren;
  String? selectedAdult;
  String? selectedLuggage;
  String? airlineName;
  String? flightComapniesId;

  late List<String> pickVehicleData = [];
  late List<String> airLineComapny = [];

  GetAllSystemData getAllSystemData = GetAllSystemData();
  getSystemAllData() async {
    getAllSystemData = await DioClient().getSystemAllData(context);
    if (getAllSystemData != null) {
      getVehicleData();
      getAirLineDataa();

      print("GETSystemAllData: ${getAllSystemData.data}");
      setState(() {});
    }
  }

  getVehicleData() {
    if (getAllSystemData!.data! != null) {
      for (int i = 0; i < getAllSystemData!.data!.vehicles!.length; i++) {
        pickVehicleData.add(getAllSystemData!.data!.vehicles![i].name!);
        print("vehicle items= $pickVehicleData");
      }
    }
  }

  getAirLineDataa() {
    if (getAllSystemData!.data! != null) {
      for (int i = 0;
          i < getAllSystemData!.data!.flightCompanies!.length;
          i++) {
        airLineComapny.add(getAllSystemData!.data!.flightCompanies![i].name!);
        print("Airline items= $airLineComapny");
      }
    }
  }

  getRoutesData(String? vehicleId) async {
    print("routes_pickup_id ${widget.routesPickUpId.toString()}");
    print("routes_dropoff_id ${widget.routesDropOffId.toString()}");
    print("vehicles_id ${vehicleId}");
    print("service_type ${widget.serviceType}");

    var mapData = {
      "routes_pickup_id": widget.routesPickUpId.toString(),
      "routes_dropoff_id": widget.routesDropOffId.toString(),
      "vehicles_id": vehicleId,
      "service_type": widget.serviceType
    };
    var response = await DioClient().getRoutesData(mapData, context);
    if (response != null) {
      print("object $response");
      routesId = response.data!.routesId;
      fare = double.parse(response.data!.fare!);
      totalFare = fare!;
      setState(() {});
    }
  }

  getRoutesData1(String? vehicleId) async {
    print("routes_pickup_id ${widget.routesPickUpId.toString()}");
    print("routes_dropoff_id ${widget.routesDropOffId.toString()}");
    print("vehicles_id ${vehicleId}");
    print("service_type ${widget.serviceType}");

    var mapData = {
      "routes_pickup_id": widget.routesPickUpId.toString(),
      "routes_dropoff_id": widget.routesDropOffId.toString(),
      "vehicles_id": vehicleId,
      "service_type": widget.serviceType
    };
    var response = await DioClient().getRoutesData(mapData, context);
    if (response != null) {
      print("object ${response.data!.fare!}");
      routesId = response.data!.routesId;
      fare1 = double.parse(response.data!.fare!);
      totalFare = fare! + fare1!;

      setState(() {});
    }
  }

  getRoutesData2(String? vehicleId) async {
    print("routes_pickup_id ${widget.routesPickUpId.toString()}");
    print("routes_dropoff_id ${widget.routesDropOffId.toString()}");
    print("vehicles_id ${vehicleId}");
    print("service_type ${widget.serviceType}");

    var mapData = {
      "routes_pickup_id": widget.routesPickUpId.toString(),
      "routes_dropoff_id": widget.routesDropOffId.toString(),
      "vehicles_id": vehicleId,
      "service_type": widget.serviceType
    };
    var response = await DioClient().getRoutesData(mapData, context);
    if (response != null) {
      print("object $response");
      routesId = response.data!.routesId;
      fare2 = double.parse(response.data!.fare!);
      if (fare1 != null) totalFare = fare! + fare1! + fare2!;

      setState(() {});
    }
  }

  getRoutesData3(String? vehicleId) async {
    print("routes_pickup_id ${widget.routesPickUpId.toString()}");
    print("routes_dropoff_id ${widget.routesDropOffId.toString()}");
    print("vehicles_id ${vehicleId}");
    print("service_type ${widget.serviceType}");

    var mapData = {
      "routes_pickup_id": widget.routesPickUpId.toString(),
      "routes_dropoff_id": widget.routesDropOffId.toString(),
      "vehicles_id": vehicleId,
      "service_type": widget.serviceType
    };
    var response = await DioClient().getRoutesData(mapData, context);
    if (response != null) {
      print("object $response");
      routesId = response.data!.routesId;
      fare3 = double.parse(response.data!.fare!);
      totalFare = fare! + fare1! + fare2! + fare3!;

      setState(() {});
    }
  }

  @override
  void initState() {
    // print("get service type: ${widget.serviceType}");
    print("get visa type: ${widget.visaType}");
    // print("get pickup location: ${widget.pickupLocation}");
    // print("get  pickup hotel: ${widget.pickupHotel}");
    // print("get dropoff location:: ${widget.dropOffLocation}");
    // print("get dropoff hotel:: ${widget.dropOffHotel}");
    // print("pick up date:: ${widget.pickUpData}");
    // print("pick up time::${widget.pickUpTime}");
    // print("get routes Pick Id::${widget.routesPickUpId}");
    // print("get Drop Off Pick Id:: ${widget.routesDropOffId}");
    getSystemAllData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<String> selectedValues = List.filled(addDropdowns.length, '');

    print(childs);
    print(adult);
    // print(infants);
    totalPassengers = childs + adult;
    print("total passengers ${totalPassengers}");
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: mainColor,
        body: getAllSystemData != null
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IconButton(onPressed: (){
                      //   final newIndex = widget.tabController!.index -1;
                      //    widget.tabController!.animateTo(newIndex);
                      //    setState(() {
                      //
                      //    });
                      // }, icon: Icon(Icons.arrow_back)),
                      SizedBox(height: size.height * 0.04),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField(
                                    icon: SvgPicture.asset(
                                      'assets/images/dropdown-icon.svg',
                                    ),
                                    iconSize: 5,
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
                                        'assets/images/big-black-car-icon.svg',
                                        width: 35,
                                        height: 35,
                                        fit: BoxFit.scaleDown,
                                      ),
                                      // suffixIcon: SvgPicture.asset(
                                      //   'assets/images/dropdown-icon.svg',
                                      //   width: 10,
                                      //   height: 10,
                                      //   fit: BoxFit.scaleDown,
                                      // ),
                                      hintText: 'Select Vehicle',
                                      hintStyle: const TextStyle(
                                        color: Color(0xFF929292),
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    items: pickVehicleData
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
                                    value: selectedVehicle,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedVehicle = value;
                                        if (value != null) {
                                          for (int i = 0;
                                              i <
                                                  getAllSystemData
                                                      .data!.vehicles!.length;
                                              i++) {
                                            if (selectedVehicle ==
                                                getAllSystemData
                                                    .data!.vehicles![i].name) {
                                              selectedVehiclePassengers =
                                                  int.parse(getAllSystemData
                                                      .data!
                                                      .vehicles![i]
                                                      .noOfPassengers!);
                                              selectedVehicleId = int.parse(
                                                  getAllSystemData
                                                      .data!
                                                      .vehicles![i]
                                                      .vehiclesId!);
                                              print(
                                                  "no of passengers: ${selectedVehiclePassengers}");
                                              totalNumberOfPassengers =
                                                  selectedVehiclePassengers!;
                                              print(
                                                  "Vehicle Id: ${selectedVehicleId}");
                                              if (selectedVehicleId != null) {
                                                getRoutesData(selectedVehicleId
                                                    .toString());
                                              }
                                            }
                                          }
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * 0.02),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (addDropdowns.length >= 3) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "You can not add more vaheicles")));
                                  } else {
                                    print("length: ${addDropdowns.length}");
                                    addDropdowns.add(
                                        additem(length: addDropdowns.length));
                                  }
                                });
                              },
                              child: Container(
                                width: size.width * 0.18,
                                height: size.height * 0.08,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    width: 1,
                                    color: const Color(0xFF000000)
                                        .withOpacity(0.15),
                                  ),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/images/plus-icon.svg',
                                    color: buttonColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: addDropdowns,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.transparent,
                                width: size.width * 0.43,
                                child: TextFormField(
                                  controller: numberOfChilds,
                                  keyboardType: TextInputType.text,
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'Number of Child field is required!';
                                  //   }
                                  //   return null;
                                  // },
                                  onChanged: (v) {
                                    childs = int.parse(numberOfChilds.text);
                                    if (childs > totalNumberOfPassengers) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Your childs are greater then total passengers")));
                                    }

                                    setState(() {});
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
                                    errorBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    hintText: "Number of Childs",
                                    hintStyle: const TextStyle(
                                      color: Color(0xFF929292),
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    prefixIcon: SvgPicture.asset(
                                      'assets/images/adult-icon.svg',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: size.width * 0.02),
                            Expanded(
                              child: Container(
                                color: Colors.transparent,
                                width: size.width * 0.43,
                                child: TextFormField(
                                  controller: numberOfAdults,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Number of Adults field is required!';
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
                                    errorBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    hintText: "No of Adults",
                                    hintStyle: const TextStyle(
                                      color: Color(0xFF929292),
                                      fontSize: 10,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    prefixIcon: SvgPicture.asset(
                                      'assets/images/adult-icon.svg',
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  onChanged: (v) {
                                    adult = int.parse(numberOfAdults.text);

                                    if (childs + adult >
                                        totalNumberOfPassengers) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Your childs are greater then total passengers")));
                                    }
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: numberOfinfants,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Number of Infants field is required!';
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
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            hintText: "Number of Infants",
                            hintStyle: const TextStyle(
                              color: Color(0xFF929292),
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: SvgPicture.asset(
                              'assets/images/adult-icon.svg',
                              width: 25,
                              height: 25,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          // onChanged: (v){
                          //
                          //   if(childs+adult > totalNumberOfPassengers){
                          //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Your children or adults are greater then total passengers")));
                          //   }
                          //   setState(() {
                          //
                          //   });
                          //
                          // },
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Total Passengers',
                          style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Center(
                        child: Text(
                          totalNumberOfPassengers != null
                              ? '$totalNumberOfPassengers'
                              : "0",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
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
                                    'assets/images/wallet-icon.svg',
                                    width: 10,
                                    height: 10,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  hintText: 'Payment Type',
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF929292),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(16),
                                items: paymentMethod
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
                                value: selectedPaymentMethod,
                                onChanged: (value) {
                                  setState(() {
                                    selectedPaymentMethod = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (selectedPaymentMethod == "cash")
                        SizedBox(height: size.height * 0.03),
                      if (selectedPaymentMethod == "cash")
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: cashAmountController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Cash Amount field is required!';
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
                                  color:
                                      const Color(0xFF000000).withOpacity(0.15),
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                borderSide: BorderSide(
                                  color:
                                      const Color(0xFF000000).withOpacity(0.15),
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                borderSide: BorderSide(
                                  color:
                                      const Color(0xFF000000).withOpacity(0.15),
                                  width: 1,
                                ),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              hintText: "Enter Cash From Guest",
                              hintStyle: const TextStyle(
                                color: Color(0xFF929292),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                              prefixIcon: SvgPicture.asset(
                                'assets/images/wallet-icon.svg',
                                width: 25,
                                height: 25,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: size.height * 0.03),
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
                                  hintText: 'Airline Name',
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF929292),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(16),
                                items: airLineComapny
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
                                value: airlineName,
                                onChanged: (value) {
                                  setState(() {
                                    airlineName = value;
                                    if (value != null) {
                                      for (int i = 0;
                                          i <
                                              getAllSystemData.data!
                                                  .flightCompanies!.length;
                                          i++) {
                                        if (airlineName ==
                                            getAllSystemData.data!
                                                .flightCompanies![i].name!) {
                                          flightComapniesId = getAllSystemData
                                              .data!
                                              .flightCompanies![i]
                                              .flightCompaniesId;
                                          print(
                                              "company of airline: ${flightComapniesId}");
                                          setState(() {});
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
                        child: TextFormField(
                          controller: flightnumberController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Flight Number field is required!';
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
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            hintText: "Flight Number",
                            hintStyle: const TextStyle(
                              color: Color(0xFF929292),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: SvgPicture.asset(
                              'assets/images/flight-icon.svg',
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
                          controller: flightdetailsController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Flight Details field is required!';
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
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            hintText: "Flight Details",
                            hintStyle: const TextStyle(
                              color: Color(0xFF929292),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: SvgPicture.asset(
                              'assets/images/flight-icon.svg',
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
                          controller: instructionsController,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 4,
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Instructions for Driver field is required!';
                          //   }
                          //   return null;
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
                                  const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color:
                                    const Color(0xFF000000).withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 1,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            hintText: "Instructions for Driver",
                            hintStyle: const TextStyle(
                              color: Color(0xFF929292),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      const Center(
                        child: Text(
                          'Total Fare',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Center(
                        child: Text(
                          "${totalFare!}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 50,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      GestureDetector(
                        onTap: () {
                          final newIndex = widget.tabController!.index + 1;
                          // widget.tabController!.animateTo(newIndex);
                          print('newIndex $newIndex');
                          if (selectedVehicle != null &&
                              numberOfinfants != null &&
                              numberOfChilds != null &&
                              numberOfAdults != null &&
                              totalFare != null &&
                              totalNumberOfPassengers != null &&
                              routesId != null &&
                              flightnumberController != null &&
                              flightComapniesId != null &&
                              flightdetailsController != null &&
                              totalNumberOfPassengers != null &&
                              selectedPaymentMethod != null) {
                            if (totalPassengers > totalNumberOfPassengers) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "your children and adults are greater then total passengers")));
                            } else if (selectedPaymentMethod == "cash" &&
                                cashAmountController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Enter guest amount")));
                            } else {
                              widget.onDataReceived(
                                  visaType: widget.visaType!,
                                  serviceType: widget.serviceType!,
                                  dropOffHotel: widget.dropOffHotel ?? "null",
                                  dropOffLocation: widget.dropOffLocation!,
                                  pickUpData: widget.pickUpData!,
                                  pickupHotel: widget.pickupHotel ?? "null",
                                  pickupLocation: widget.pickupLocation!,
                                  pickUpTime: widget.pickUpTime!,
                                  routesDropOffId: widget.routesDropOffId,
                                  routesPickUpId: widget.routesPickUpId,
                                  extraInformation: instructionsController.text,
                                  flightCode: "123",
                                  flightCompaniesId: flightComapniesId,
                                  flightDetails: flightdetailsController.text,
                                  flightNmbr: flightnumberController.text,
                                  numberOfAdults: numberOfAdults.text,
                                  numberOfChilds: numberOfChilds.text,
                                  numberOfInfants: numberOfinfants.text,
                                  routesId: routesId,
                                  tabbarIndex: newIndex,
                                  totalFare: totalFare.toString(),
                                  vehicleId: selectedVehicleId.toString(),
                                  vehicleId1: selectedVehicle1Id.toString(),
                                  vehicleId2: selectedVehicle2Id.toString(),
                                  vehicleId3: selectedVehicle2Id.toString(),
                                  totalNumberOfPassengers:
                                      totalNumberOfPassengers.toString(),
                                  vehicleName: selectedVehicle,
                                  selectedPaymentMethod: selectedPaymentMethod,
                                  cashFromGuest: cashAmountController.text);
                            }
                          } else if (selectedVehicle == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Vehicle is missing")));
                          } else if (numberOfinfants.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Infants are not selected")));
                          } else if (numberOfChilds.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Children are not selected")));
                          } else if (numberOfAdults.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Adults are not selected")));
                          } else if (flightnumberController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Flight Number is not selected")));
                          } else if (flightdetailsController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Flight Details is not selected")));
                          } else if (airlineName == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Airline is not selected")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Payment Type is not selected")));
                          }
                        },
                        child: button('Next', context),
                      ),
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

  Widget additem({int? length}) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField(
                    icon: SvgPicture.asset(
                      'assets/images/dropdown-icon.svg',
                    ),
                    iconSize: 5,
                    decoration: InputDecoration(
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
                      prefixIcon: SvgPicture.asset(
                        'assets/images/big-black-car-icon.svg',
                        width: 35,
                        height: 35,
                        fit: BoxFit.scaleDown,
                      ),
                      // suffixIcon: SvgPicture.asset(
                      //   'assets/images/dropdown-icon.svg',
                      //   width: 10,
                      //   height: 10,
                      //   fit: BoxFit.scaleDown,
                      // ),
                      hintText: 'Select Vehicle',
                      hintStyle: const TextStyle(
                        color: Color(0xFF929292),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(16),
                    items: pickVehicleData
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
                    value: length == 0
                        ? selectedVehicle1
                        : length == 1
                            ? selectedVehicle2
                            : selectedVehicle3,
                    onChanged: (value) {
                      setState(() {
                        if (length == 0) {
                          selectedVehicle1 = value;
                          print("value$selectedVehicle1");
                          if (value != null) {
                            for (int i = 0;
                                i < getAllSystemData.data!.vehicles!.length;
                                i++) {
                              if (selectedVehicle1 ==
                                  getAllSystemData.data!.vehicles![i].name) {
                                selectedVehicle1Passengers = int.parse(
                                    getAllSystemData
                                        .data!.vehicles![i].noOfPassengers!);
                                totalNumberOfPassengers =
                                    selectedVehiclePassengers! +
                                        selectedVehicle1Passengers!;
                                selectedVehicle1Id = int.parse(getAllSystemData
                                    .data!.vehicles![i].vehiclesId!);
                                print(
                                    "no of passengers: ${selectedVehicle1Passengers}");
                                print("Vehicle Id: ${selectedVehicle1Id}");
                                if (selectedVehicle1Id != null) {
                                  getRoutesData1(selectedVehicle1Id.toString());
                                }
                              }
                            }
                          }
                        } else if (length == 1) {
                          selectedVehicle2 = value;
                          print("value${selectedVehicle2}");
                          if (value != null) {
                            for (int i = 0;
                                i < getAllSystemData.data!.vehicles!.length;
                                i++) {
                              if (selectedVehicle2 ==
                                  getAllSystemData.data!.vehicles![i].name) {
                                selectedVehicle2Passengers = int.parse(
                                    getAllSystemData
                                        .data!.vehicles![i].noOfPassengers!);
                                totalNumberOfPassengers =
                                    selectedVehiclePassengers! +
                                        selectedVehicle1Passengers! +
                                        selectedVehicle2Passengers!;

                                selectedVehicle2Id = int.parse(getAllSystemData
                                    .data!.vehicles![i].vehiclesId!);
                                print(
                                    "no of passengers: ${selectedVehicle2Passengers}");
                                print("Vehicle Id: ${selectedVehicle2Id}");
                                if (selectedVehicle2Id != null) {
                                  getRoutesData2(selectedVehicle2Id.toString());
                                }
                              }
                            }
                          }
                        } else {
                          selectedVehicle3 = value;
                          print("value${selectedVehicle3}");
                          if (value != null) {
                            for (int i = 0;
                                i < getAllSystemData.data!.vehicles!.length;
                                i++) {
                              if (selectedVehicle3 ==
                                  getAllSystemData.data!.vehicles![i].name) {
                                selectedVehicle3Passengers = int.parse(
                                    getAllSystemData
                                        .data!.vehicles![i].noOfPassengers!);
                                totalNumberOfPassengers =
                                    selectedVehiclePassengers! +
                                        selectedVehicle1Passengers! +
                                        selectedVehicle2Passengers! +
                                        selectedVehicle3Passengers!;

                                selectedVehicle3Id = int.parse(getAllSystemData
                                    .data!.vehicles![i].vehiclesId!);
                                print(
                                    "no of passengers: ${selectedVehicle3Passengers}");
                                print("Vehicle Id: ${selectedVehicle3Id}");
                                if (selectedVehicle3Id != null) {
                                  getRoutesData3(selectedVehicle3Id.toString());
                                }
                              }
                            }
                          }
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: size.width * 0.02),
            GestureDetector(
              onTap: () {
                setState(() {
                  addDropdowns.removeAt(0);
                  print("index: ${addDropdowns.length}");
                  if (addDropdowns.isEmpty) {
                    fare1 = 0.0;
                    selectedVehicle1Id = null;
                    totalFare = fare! + fare1!;
                    print("total fair: ${totalFare}");
                    selectedVehicle1Passengers = 0;
                    totalNumberOfPassengers = selectedVehiclePassengers! +
                        selectedVehicle1Passengers!;
                  } else if (addDropdowns.length == 1) {
                    fare2 = 0.0;
                    selectedVehicle2Id = null;

                    totalFare = fare! + fare1! + fare2!;
                    print("total fair: $totalFare");
                    selectedVehicle2Passengers = 0;
                    totalNumberOfPassengers = selectedVehiclePassengers! +
                        selectedVehicle1Passengers! +
                        selectedVehicle2Passengers!;
                  } else {
                    fare3 = 0.0;
                    selectedVehicle3Id = null;
                    totalFare = fare! + fare1! + fare2! + fare3!;
                    print("total fair: ${totalFare}");
                    selectedVehicle3Passengers = 0;
                    totalNumberOfPassengers = selectedVehiclePassengers! +
                        selectedVehicle1Passengers! +
                        selectedVehicle2Passengers! +
                        selectedVehicle3Passengers!;
                  }
                });
              },
              child: Container(
                width: size.width * 0.18,
                height: size.height * 0.08,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 1,
                    color: const Color(0xFF000000).withOpacity(0.15),
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/minus-icon.svg',
                    color: buttonColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.02),
      ],
    );
  }
}
