

import 'dart:convert';


class ForgotPasswordOtpModel {
  String? status;
  Data? data;

  ForgotPasswordOtpModel({
    this.status,
    this.data,
  });

  factory ForgotPasswordOtpModel.fromJson(Map<String, dynamic> json) => ForgotPasswordOtpModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  int? otp;
  String? usersAgentsId;
  String? message;

  Data({
    this.otp,
    this.usersAgentsId,
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    otp: json["otp"],
    usersAgentsId: json["users_agents_id"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "otp": otp,
    "users_agents_id": usersAgentsId,
    "message": message,
  };
}
