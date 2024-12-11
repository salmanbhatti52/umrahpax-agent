import 'package:flutter/material.dart';
import 'package:umrahcar/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:umrahcar/screens/wallet_screen.dart';
import 'package:umrahcar/screens/profile_screen.dart';
import 'package:umrahcar/screens/homepage_screen.dart';
import 'package:umrahcar/screens/booking_process/bookings_screen.dart';
import 'package:umrahcar/screens/create_booking_process/create_bookings_screen.dart';

class NavBar extends StatefulWidget {
  int? indexNmbr;
  bool? updateBooking = false;
  String? bookingId = "0";
  int? walletPage;
  NavBar(
      {super.key,
      this.indexNmbr,
      this.updateBooking,
      this.bookingId,
      this.walletPage});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;

  @override
  void initState() {
    if (widget.indexNmbr != null) {
      index = widget.indexNmbr!;
    }
    print("update allow; ${widget.updateBooking}");
    print("booking Id; ${widget.bookingId}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomePage(),
      const BookingsPage(),
      CreateBookingsPage(
          updateBooking: widget.updateBooking, bookingId: widget.bookingId),
      WalletPage(
        indexNmbr: widget.walletPage,
      ),
      const ProfilePage(),
    ];
    widget.bookingId = null;
    widget.indexNmbr = null;
    return Scaffold(
      backgroundColor: mainColor,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.15),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorShape: const CircleBorder(),
              indicatorColor: Colors.transparent,
              labelTextStyle: MaterialStateProperty.all(
                TextStyle(
                  color: primaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat-Regular',
                ),
              ),
            ),
            child: NavigationBar(
              backgroundColor: mainColor,
              selectedIndex: index,
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              onDestinationSelected: (index) => setState(() {
                this.index = index;
              }),
              destinations: [
                NavigationDestination(
                  icon: SvgPicture.asset('assets/images/home-icon.svg'),
                  selectedIcon: SvgPicture.asset(
                    'assets/images/active-home-icon.svg',
                    width: 24,
                    height: 24,
                    color: buttonColor,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: SvgPicture.asset('assets/images/bookings-icon.svg'),
                  selectedIcon: SvgPicture.asset(
                    'assets/images/active-bookings-icon.svg',
                    width: 24,
                    height: 24,
                    color: buttonColor,
                  ),
                  label: 'Bookings',
                ),
                NavigationDestination(
                  icon: SvgPicture.asset(
                    'assets/images/create-bookings-icon.svg',
                    width: 34,
                    height: 34,
                    color: ConstantColor.lightgreyColor,
                  ),
                  selectedIcon: SvgPicture.asset(
                    'assets/images/create-bookings-icon.svg',
                    width: 34,
                    height: 34,
                    color: buttonColor,
                  ),
                  label: ' Create\nBooking',
                ),
                NavigationDestination(
                  icon: SvgPicture.asset(
                    'assets/images/wallet-icon.svg',
                  ),
                  selectedIcon: SvgPicture.asset(
                    'assets/images/active-wallet-icon.svg',
                    width: 24,
                    height: 24,
                    color: buttonColor,
                  ),
                  label: 'Wallet',
                ),
                NavigationDestination(
                  icon: SvgPicture.asset('assets/images/profile-icon.svg'),
                  selectedIcon: SvgPicture.asset(
                    'assets/images/active-profile-icon.svg',
                    width: 24,
                    height: 24,
                    color: buttonColor,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
      body: screens[index],
    );
  }
}
