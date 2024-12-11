import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umrahcar/models/add_card_model.dart';
import 'package:umrahcar/models/forgot_password_otp_model.dart';
import 'package:umrahcar/models/get_agent_widget_data_model.dart';
import 'package:umrahcar/models/get_all_system_data_model.dart';
import 'package:umrahcar/models/get_hotels_data.dart';
import 'package:umrahcar/models/get_profile_model.dart';
import 'package:umrahcar/models/gets_routes_data_model.dart';
import 'package:umrahcar/models/login_model.dart';
import 'package:umrahcar/models/pending_transaction_model.dart';
import 'package:umrahcar/models/summary_agent_model.dart';
import 'package:umrahcar/models/update_profile_model.dart';
import '../models/add_booking_agent_model.dart';
import '../models/driver_status_model.dart';
import '../models/forgot_verify_otp_model.dart';
import '../models/ge_bookings_pending_by_id_model.dart';
import '../models/get_booking_list_model.dart';
import '../models/get_driver_profile.dart';
import '../models/get_drop_off_location_model.dart';
import '../utils/const.dart';

class DioClient {
  final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) async {
        final sharedPref = await SharedPreferences.getInstance();
        if (sharedPref.containsKey('userId')) {
          options.headers["Authorization"] =
              "Bearer ${sharedPref.getString('userId')}";
        }
        return handler.next(options);
      }),
    );

  Future<LoginModel> login(
      Map<String, dynamic> model, BuildContext context) async {
    final sharedPref = await SharedPreferences.getInstance();
    var uid = sharedPref.getString('userId');
    print("uiduid: $uid");

    try {
      final response = await _dio.post('$baseUrl/login_agents', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = LoginModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email or Password is incorrect")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgotPasswordOtpModel> forgotPasswordOtp(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response =
          await _dio.post('$baseUrl/reset_password_agents', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = ForgotPasswordOtpModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email does not exists.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgotOtpVerifyModel> verifyForgotPasswordOtp(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response =
          await _dio.post('$baseUrl/verify_otp_agents', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = ForgotOtpVerifyModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("OTP is incorrect.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgotOtpVerifyModel> resetNewPassword(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response =
          await _dio.post('$baseUrl/reset_password_set_agents', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = ForgotOtpVerifyModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("OTP is incorrect.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UpdateProfileModel> updateProfile(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response =
          await _dio.post('$baseUrl/update_profile_agents', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = UpdateProfileModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("All Fields are needed")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgotOtpVerifyModel> changeUserPassword(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response =
          await _dio.post('$baseUrl/change_user_password_agents', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = ForgotOtpVerifyModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Old password is wrong")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetBookingListModel> getBookingList(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response =
          await _dio.post('$baseUrl/get_bookings_agents', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetBookingListModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No data received")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetBookingListModel> getBookingupcoming(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response =
          await _dio.post('$baseUrl/get_bookings_agents_upcoming', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetBookingListModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No UpComing Bookings")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetBookingListModel> getBookingOngoing(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response =
          await _dio.post('$baseUrl/get_bookings_agents_ongoing', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetBookingListModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No OnGoing Bookings")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetBookingListModel> getBookingCompleted(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response = await _dio.post('$baseUrl/get_bookings_agents_completed',
          data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetBookingListModel.fromJson(response.data);
        return res;
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No data received")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetBookingListModel> getBookingById(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response =
          await _dio.post('$baseUrl/get_bookings_by_id', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetBookingListModel.fromJson(response.data);
        return res;
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No data received")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetAgentsWidgetsData> getAgentsWidgetsData(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response =
          await _dio.post('$baseUrl/get_all_widgets_data_agents', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetAgentsWidgetsData.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No data received")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetProfileModel> getProfile(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response = await _dio.post('$baseUrl/get_agents_data', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetProfileModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No data received")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetAllSystemData> getSystemAllData(BuildContext context) async {
    try {
      final response = await _dio.post(
        '$baseUrl/get_all_system_data',
      );
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetAllSystemData.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No data received")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetDriverProfile> getProfileDriver(
      String? uid, BuildContext context) async {
    print("mapData: $uid");
    String url = "$baseUrl/get_details_drivers/$uid";
    print("url: $url");

    try {
      final response = await _dio.post(url);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetDriverProfile.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No Data Found")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No Data Found")));

      rethrow;
    }
  }

  Future<GetHotelsData> getHotelsData(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response =
          await _dio.post('$baseUrl/get_dependent_bookings_data', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetHotelsData.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No hotel found.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetDropOffLocation> getDropOffData(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response =
          await _dio.post('$baseUrl/get_dependent_bookings_data', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetDropOffLocation.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No hotel found.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetHotelsData> getDropOffHotelData(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      final response =
          await _dio.post('$baseUrl/get_dependent_bookings_data', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetHotelsData.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No hotel found.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetRoutesDataModel> getRoutesData(
      Map<String, dynamic> model, BuildContext context) async {
    try {
      print("Hiiii");
      final response = await _dio.post('$baseUrl/get_routes_data', data: model);
      print("code Status: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetRoutesDataModel.fromJson(response.data);
        return res;
      } else {
        print("hooo");
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No route found.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "There is No Route Against Your selected vehicle. Please Try with another Vehicle")));

      print("hooo1");

      rethrow;
    }
  }

  Future<AddBookingAgentModel> addBookingAgent(
      Map<String?, dynamic> model, BuildContext context) async {
    print("data: $model");
    try {
      final response =
          await _dio.post('$baseUrl/bookings_add_agents', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = AddBookingAgentModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("All Fields are Required!")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("All Fields are Required!")));

      rethrow;
    }
  }

  Future<AddBookingAgentModel> editBookingAgent(
      Map<String?, dynamic> model, BuildContext context) async {
    print("data: $model");
    try {
      final response =
          await _dio.post('$baseUrl/bookings_edit_agents', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = AddBookingAgentModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("All Fields are Required!")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<GetBookingPendingById> getBookingPendingById(
      Map<String?, dynamic> model, BuildContext context) async {
    print("data: $model");
    try {
      final response =
          await _dio.post('$baseUrl/get_bookings_pending_by_id', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = GetBookingPendingById.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No data received.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<SummaryAgentModel> summaryAgent(
      Map<String?, dynamic> model, BuildContext context) async {
    print("data: $model");
    try {
      final response = await _dio.post('$baseUrl/summary_agents', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = SummaryAgentModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No data received.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No data received.")));

      rethrow;
    }
  }

  Future<PendingTransactiontModel> pendingTransactions(
      Map<String?, dynamic> model, BuildContext context) async {
    print("data: $model");
    try {
      final response =
          await _dio.post('$baseUrl/transactions_agents', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = PendingTransactiontModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No data received.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No data received.")));

      rethrow;
    }
  }

  Future<AddCardModel> addCard(
      Map<String?, dynamic> model, BuildContext context) async {
    print("data: $model");
    try {
      final response =
          await _dio.post('$baseUrl/transactions_agents_add', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = AddCardModel.fromJson(response.data);
        return res;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No data received.")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("No data received.")));

      rethrow;
    }
  }

  Future<DriverStatusModel> deleteTransaction(
      Map<String?, dynamic> model, BuildContext context) async {
    print("data: $model");
    try {
      final response =
          await _dio.post('$baseUrl/transactions_agents_delete', data: model);
      if (response.statusCode == 200) {
        print("hiiii ${response.data}");
        var res = DriverStatusModel.fromJson(response.data);
        return res;
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Unable To Delete Transaction. Only Pending transactions can be deleted")));
        throw 'SomeThing Missing';
      }
    } catch (e) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Unable To Delete Transaction. Only Pending transactions can be deleted")));

      rethrow;
    }
  }
}
