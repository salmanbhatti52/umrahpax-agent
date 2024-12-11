
class PendingTransactiontModel {
  String? status;
  List<Datum>? data;

  PendingTransactiontModel({
    this.status,
    this.data,
  });

  factory PendingTransactiontModel.fromJson(Map<String, dynamic> json) => PendingTransactiontModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? usersAgentsAccountsId;
  UsersAgentsId? usersAgentsId;
  AccountsHeadsId? accountsHeadsId;
  String? description;
  String? txnType;
  String? txnDate;
  String? amount;
  String? image;
  String? status;

  Datum({
    this.usersAgentsAccountsId,
    this.usersAgentsId,
    this.accountsHeadsId,
    this.description,
    this.txnType,
    this.txnDate,
    this.amount,
    this.image,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    usersAgentsAccountsId: json["users_agents_accounts_id"],
    usersAgentsId: UsersAgentsId.fromJson(json["users_agents_id"]),
    accountsHeadsId: AccountsHeadsId.fromJson(json["accounts_heads_id"]),
    description: json["description"],
    txnType: json["txn_type"],
    txnDate: json["txn_date"],
    amount: json["amount"],
    image: json["image"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "users_agents_accounts_id": usersAgentsAccountsId,
    "users_agents_id": usersAgentsId!.toJson(),
    "accounts_heads_id": accountsHeadsId!.toJson(),
    "description": description,
    "txn_type": txnType,
    "txn_date": txnDate,
    "amount": amount,
    "image": image,
    "status": status,
  };
}

class AccountsHeadsId {
  String? accountsHeadsId;
  String? name;
  String? roles;
  String? status;

  AccountsHeadsId({
    this.accountsHeadsId,
    this.name,
    this.roles,
    this.status,
  });

  factory AccountsHeadsId.fromJson(Map<String, dynamic> json) => AccountsHeadsId(
    accountsHeadsId: json["accounts_heads_id"],
    name: json["name"],
    roles: json["roles"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "accounts_heads_id": accountsHeadsId,
    "name": name,
    "roles": roles,
    "status": status,
  };
}

class UsersAgentsId {
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

  UsersAgentsId({
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

  factory UsersAgentsId.fromJson(Map<String, dynamic> json) => UsersAgentsId(
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
