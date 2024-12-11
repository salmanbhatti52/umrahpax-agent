import 'package:flutter/material.dart';
import 'package:umrahcar/utils/colors.dart';
import 'package:umrahcar/widgets/top_boxes.dart';
import '../service/rest_api_serivice.dart';
import 'booking_process/tab_screens/add_card_page.dart';
import 'wallet_tab/wallet_tabbar.dart';
import 'homepage_screen.dart';

class WalletPage extends StatefulWidget {
  int? indexNmbr = 0;
  WalletPage({super.key, this.indexNmbr});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  var getAgentsWidgetData;

  getAgentWidgetData() async {
    print("userIdId $userId");
    var mapData = {"users_agents_id": userId.toString()};
    getAgentsWidgetData =
        await DioClient().getAgentsWidgetsData(mapData, context);
    print("response id: ${getAgentsWidgetData.data}");
    setState(() {});
  }

  @override
  void initState() {
    getAgentWidgetData();
    print(" widget.indexNmbr: ${widget.indexNmbr}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: ConstantColor.primaryColor,
        appBar: AppBar(
          backgroundColor: ConstantColor.primaryColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            'My Wallet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: getAgentsWidgetData != null
            ? Container(
                decoration: const BoxDecoration(
                  color: ConstantColor.primaryColor,
                ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          bignoimagebox(
                              '${getAgentsWidgetData.data.bookingsTotalDeposit}',
                              'Wallet Amount',
                              context),
                          SizedBox(width: size.width * 0.04),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddCardPage()));
                                setState(() {});
                              },
                              child: bignoimageredbox(
                                  'Debit/Credit', 'Transactions', context)),
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),
                      widget.indexNmbr == null
                          ? WalletTabBarScreen(indexNmbr: 0)
                          : WalletTabBarScreen(indexNmbr: 1),
                    ],
                  ),
                ),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height / 1,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }
}
