import 'package:flutter/material.dart';
import 'package:umrahcar/models/get_all_system_data_model.dart';
import 'package:umrahcar/screens/create_booking_process/tab_screens/guest_info_screen.dart';
import 'package:umrahcar/screens/create_booking_process/tab_screens/other_info_screen.dart';
import 'package:umrahcar/screens/create_booking_process/tab_screens/pickup_info_screen.dart';
import 'package:umrahcar/screens/wallet_tab/pending_transaction_page.dart';
import 'package:umrahcar/screens/wallet_tab/summary_agent_page.dart';
import 'package:umrahcar/service/rest_api_serivice.dart';
import 'package:umrahcar/utils/colors.dart';

class WalletTabBarScreen extends StatefulWidget {
  int? indexNmbr = 0;
  WalletTabBarScreen({super.key, this.indexNmbr});

  @override
  State<WalletTabBarScreen> createState() => _WalletTabBarScreenState();
}

abstract class TickerProvider {}

class _WalletTabBarScreenState extends State<WalletTabBarScreen>
    with TickerProviderStateMixin {
  int index = 0;
  @override
  void initState() {
    print("indexxxx: ${widget.indexNmbr}");
    index = widget.indexNmbr!;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController =
        TabController(length: 2, vsync: this, initialIndex: index);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.064,
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
                  // onTap: (index) {
                  //   if (tabController.indexIsChanging) {
                  //     tabController.index = tabController.previousIndex;
                  //   } else {
                  //     return;
                  //   }
                  // },
                  indicatorColor: ConstantColor.primaryColor,
                  isScrollable: false,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
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
                    Tab(text: "Account Summary"),
                    Tab(text: "Pending Transactions"),
                  ],
                ),
              )),
        ),
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.55,
          child: TabBarView(
            controller: tabController,
            children: const [
              SummaryAgentPage(),
              PendingTransactionPage(),
            ],
          ),
        ),
      ],
    );
  }
}
