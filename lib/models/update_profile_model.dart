

class UpdateProfileModel {
  String? status;
  Data? data;

  UpdateProfileModel({
    this.status,
    this.data,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  UserData? userData;

  Data({
    this.userData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userData: UserData.fromJson(json["user_data"]),
  );

  Map<String, dynamic> toJson() => {
    "user_data": userData!.toJson(),
  };
}

class UserData {
  String? usersAgentsId;
  String? usersRolesId;
  String? onesignalId;
  String? walletAmount;
  String? username;
  String? name;
  String? email;
  String? password;
  String? agency;
  String? address;
  String? city;
  String? state;
  String? country;
  String? contact;
  String? mobile;
  String? whatsapp;
  String? landline;
  String? iataNumber;
  String? localLicenseNumber;
  String? serviceType;
  String? notificationSwitch;
  String? resetOtp;
  String? dateAdded;
  String? dateModified;
  String? status;

  UserData({
    this.usersAgentsId,
    this.usersRolesId,
    this.onesignalId,
    this.walletAmount,
    this.username,
    this.name,
    this.email,
    this.password,
    this.agency,
    this.address,
    this.city,
    this.state,
    this.country,
    this.contact,
    this.mobile,
    this.whatsapp,
    this.landline,
    this.iataNumber,
    this.localLicenseNumber,
    this.serviceType,
    this.notificationSwitch,
    this.resetOtp,
    this.dateAdded,
    this.dateModified,
    this.status,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    usersAgentsId: json["users_agents_id"],
    usersRolesId: json["users_roles_id"],
    onesignalId: json["onesignal_id"],
    walletAmount: json["wallet_amount"],
    username: json["username"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    agency: json["agency"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    contact: json["contact"],
    mobile: json["mobile"],
    whatsapp: json["whatsapp"],
    landline: json["landline"],
    iataNumber: json["iata_number"],
    localLicenseNumber: json["local_license_number"],
    serviceType: json["service_type"],
    notificationSwitch: json["notification_switch"],
    resetOtp: json["reset_otp"],
    dateAdded: json["date_added"],
    dateModified: json["date_modified"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "users_agents_id": usersAgentsId,
    "users_roles_id": usersRolesId,
    "onesignal_id": onesignalId,
    "wallet_amount": walletAmount,
    "username": username,
    "name": name,
    "email": email,
    "password": password,
    "agency": agency,
    "address": address,
    "city": city,
    "state": state,
    "country": country,
    "contact": contact,
    "mobile": mobile,
    "whatsapp": whatsapp,
    "landline": landline,
    "iata_number": iataNumber,
    "local_license_number": localLicenseNumber,
    "service_type": serviceType,
    "notification_switch": notificationSwitch,
    "reset_otp": resetOtp,
    "date_added": dateAdded,
    "date_modified": dateModified,
    "status": status,
  };
}
