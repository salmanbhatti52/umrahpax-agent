

class GetDropOffLocation {
  String? status;
  List<DropOff>? data;

  GetDropOffLocation({
    this.status,
    this.data,
  });

  factory GetDropOffLocation.fromJson(Map<String, dynamic> json) => GetDropOffLocation(
    status: json["status"],
    data: List<DropOff>.from(json["data"].map((x) => DropOff.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DropOff {
  String? routesDropoffId;
  String? routesPickupId;
  String? name;
  String? type;
  String? status;

  DropOff({
    this.routesDropoffId,
    this.routesPickupId,
    this.name,
    this.type,
    this.status,
  });

  factory DropOff.fromJson(Map<String, dynamic> json) => DropOff(
    routesDropoffId: json["routes_dropoff_id"],
    routesPickupId: json["routes_pickup_id"],
    name: json["name"],
    type: json["type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "routes_dropoff_id": routesDropoffId,
    "routes_pickup_id": routesPickupId,
    "name": name,
    "type": type,
    "status": status,
  };
}
