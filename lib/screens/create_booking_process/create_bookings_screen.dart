import 'package:flutter/material.dart';
import 'package:umrahcar/utils/colors.dart';
import 'package:umrahcar/widgets/navbar.dart';
import 'package:umrahcar/widgets/tabbar_create_bookings.dart';

import '../../widgets/tabbar_update_bookings .dart';

class CreateBookingsPage extends StatefulWidget {
  bool? updateBooking;
  String? bookingId;
  CreateBookingsPage({super.key, this.updateBooking, this.bookingId});

  @override
  State<CreateBookingsPage> createState() => _CreateBookingsPageState();
}

class _CreateBookingsPageState extends State<CreateBookingsPage> {
  back() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NavBar()));
    setState(() {});
  }

  @override
  void initState() {
    print("update: ${widget.updateBooking}");
    print("biikingId: ${widget.bookingId}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return back();
      },
      child: Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            widget.updateBooking == true ? "Edit Booking" : 'Create Booking',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          // physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),
              widget.updateBooking == true
                  ? TabbarUpdateBookings(
                      bookingId: widget.bookingId,
                    )
                  : const TabbarCreateBookings(),
            ],
          ),
        ),
      ),
    );
  }
}
