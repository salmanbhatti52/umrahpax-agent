import 'package:flutter/material.dart';
import 'package:umrahcar/screens/booking_process/tab_screens/ongoing_screen.dart';
import 'package:umrahcar/screens/booking_process/tab_screens/upcoming_screen.dart';
import 'package:umrahcar/screens/booking_process/tab_screens/completed_screen.dart';
import 'package:umrahcar/utils/colors.dart';

import '../screens/booking_process/tab_screens/pending_screen.dart';

class TabbarBookings extends StatefulWidget {
  const TabbarBookings({super.key});

  @override
  State<TabbarBookings> createState() => _TabbarBookingsState();
}

abstract class TickerProvider {}

class _TabbarBookingsState extends State<TabbarBookings>
    with TickerProviderStateMixin {
  List<String> tabs = ["On Going", "Upcoming", "Completed", "Pending"];

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.94,
              height: MediaQuery.of(context).size.height * 0.065,
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
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  indicatorColor: buttonColor,
                  isScrollable: false,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w900,
                  ),
                  unselectedLabelColor: const Color(0xFF929292),
                  unselectedLabelStyle: const TextStyle(
                    color: Color(0xFF929292),
                    fontSize: 9,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(text: "On Going"),
                    Tab(text: "Upcoming"),
                    Tab(text: "Completed"),
                    Tab(text: "Pending"),
                  ],
                ),
              )),
        ),
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height,
          child: TabBarView(
            controller: tabController,
            children: const [
              OnGoingPage(),
              UpcomingPage(),
              CompletedPage(),
              PendingPage(),
            ],
          ),
        ),
      ],
    );
  }
}
