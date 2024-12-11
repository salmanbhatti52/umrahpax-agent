import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:searchfield/searchfield.dart';

import '../../../models/get_booking_list_model.dart';
import '../../../service/rest_api_serivice.dart';
import '../../../utils/colors.dart';
import '../../../widgets/ongoing_list.dart';
import '../../../widgets/pending_list.dart';
import '../../homepage_screen.dart';

class PendingPage extends StatefulWidget {
  const PendingPage({super.key});

  @override
  State<PendingPage> createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();

  List<String> suggestions = [
    // 'apple',
    // 'apple red',
    // 'ball',
    // 'call green',
    // 'cat',
    // 'cat blue',
  ];

  bool isFocused = false;

  GetBookingListModel getBookingResponse = GetBookingListModel();

  getBookingList() async {
    print("userIdId $userId");
    var mapData = {"users_agents_id": userId.toString()};
    getBookingResponse = await DioClient().getBookingList(mapData, context);
    print("response id: ${getBookingResponse.data}");
    setState(() {});
  }

  GetBookingListModel getBookingPendingResponseForSearch =
      GetBookingListModel();
  getBookingListOngoingSearch(String? searchText) async {
    print("userIdId $userId");
    getBookingPendingResponseForSearch.data = [];
    var mapData = {
      "users_agents_id": userId.toString(),
      "bookings_id": searchText
    };
    getBookingPendingResponseForSearch =
        await DioClient().getBookingList(mapData, context);
    print("response id: ${getBookingPendingResponseForSearch.data}");
    setState(() {
      getBookingResponse.data = [];
    });
  }

  @override
  void initState() {
    getBookingList();
    // TODO: implement initState
    super.initState();
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
        body: Column(
          children: [
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ButtonTheme(
                alignedDropdown: true,
                child: SearchField(
                  controller: searchController,
                  inputType: TextInputType.text,
                  marginColor: mainColor,
                  suggestionsDecoration: SuggestionDecoration(
                    color: mainColor,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 5, bottom: 5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFF000000).withOpacity(0.15),
                    ),
                  ),
                  offset: const Offset(0, 46),
                  suggestionItemDecoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: const Color(0xFFFFFFFF),
                    ),
                  ),
                  searchInputDecoration: InputDecoration(
                    prefixIcon: SvgPicture.asset(
                      'assets/images/search-icon.svg',
                      width: 25,
                      height: 25,
                      fit: BoxFit.scaleDown,
                    ),
                    suffixIcon: isFocused == true
                        ? GestureDetector(
                            onTap: () {
                              isFocused = false;
                              searchController.clear();
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.close,
                              size: 20,
                              color: Color(0xFF565656),
                            ),
                            // SvgPicture.asset(
                            //   'assets/images/close-icon.svg',
                            //   width: 10,
                            //   height: 10,
                            //   fit: BoxFit.scaleDown,
                            // ),
                          )
                        : null,
                    hintText: "Search",
                    hintStyle: const TextStyle(
                      color: Color(0xFF929292),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: const Color(0xFF000000).withOpacity(0.15),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: const Color(0xFF000000).withOpacity(0.15),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  itemHeight: 40,
                  maxSuggestionsInViewPort: 4,
                  onSearchTextChanged: (value) {
                    setState(() {
                      isFocused = true;
                      if (value.isNotEmpty) {
                        getBookingListOngoingSearch(value);
                      } else {
                        getBookingList();
                      }
                    });
                    return null;
                  },
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Please enter a search term';
                  //   }
                  //   return null;
                  // },
                  // scrollbarAlwaysVisible: false,
                  scrollbarDecoration: ScrollbarDecoration(
                    thumbVisibility: false,
                  ),
                  suggestionState: Suggestion.hidden,
                  suggestions: suggestions
                      .map((e) => SearchFieldListItem<String>(e))
                      .toList(),
                  suggestionStyle: const TextStyle(
                    color: Color(0xFF929292),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                  searchStyle: const TextStyle(
                    color: Color(0xFF929292),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            getBookingPendingResponseForSearch.data == null &&
                        searchController.text.isEmpty ||
                    searchController.text == ""
                ? Container(
                    color: Colors.transparent,
                    height: size.height * 0.6,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        getBookingList();
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: getBookingResponse != null
                            ? onPendingList(context, getBookingResponse)
                            : const Column(
                                children: [
                                  SizedBox(
                                    height: 250,
                                  ),
                                  Text("No Pending Booking"),
                                ],
                              ),
                      ),
                    ),
                  )
                : Container(
                    color: Colors.transparent,
                    height: size.height * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: getBookingPendingResponseForSearch != null
                          ? onPendingList(
                              context, getBookingPendingResponseForSearch)
                          : const Column(
                              children: [
                                SizedBox(
                                  height: 250,
                                ),
                                Text("No Pending Booking"),
                              ],
                            ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
