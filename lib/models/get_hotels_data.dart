

class GetHotelsData {
  String? status;
  List<Hotels>? data;

  GetHotelsData({
    this.status,
    this.data,
  });

  factory GetHotelsData.fromJson(Map<String, dynamic> json) => GetHotelsData(
    status: json["status"],
    data: List<Hotels>.from(json["data"].map((x) => Hotels.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Hotels {
  String? hotelsId;
  String? citiesId;
  String? name;
  String? city;
  String? status;

  Hotels({
    this.hotelsId,
    this.citiesId,
    this.name,
    this.city,
    this.status,
  });

  factory Hotels.fromJson(Map<String, dynamic> json) => Hotels(
    hotelsId: json["hotels_id"],
    citiesId: json["cities_id"],
    name: json["name"],
    city: json["city"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "hotels_id": hotelsId,
    "cities_id": citiesId,
    "name": name,
    "city": city,
    "status": status,
  };
}



