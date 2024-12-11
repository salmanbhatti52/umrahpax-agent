

class GetRoutesDataModel {
  String? status;
  Data? data;

  GetRoutesDataModel({
    this.status,
    this.data,
  });

  factory GetRoutesDataModel.fromJson(Map<String, dynamic> json) => GetRoutesDataModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  String? routesId;
  String? routesPickupId;
  String? routesDropoffId;
  String? vehiclesId;
  String? fare;
  String? serviceType;
  String? status;

  Data({
    this.routesId,
    this.routesPickupId,
    this.routesDropoffId,
    this.vehiclesId,
    this.fare,
    this.serviceType,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    routesId: json["routes_id"],
    routesPickupId: json["routes_pickup_id"],
    routesDropoffId: json["routes_dropoff_id"],
    vehiclesId: json["vehicles_id"],
    fare: json["fare"],
    serviceType: json["service_type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "routes_id": routesId,
    "routes_pickup_id": routesPickupId,
    "routes_dropoff_id": routesDropoffId,
    "vehicles_id": vehiclesId,
    "fare": fare,
    "service_type": serviceType,
    "status": status,
  };
}
