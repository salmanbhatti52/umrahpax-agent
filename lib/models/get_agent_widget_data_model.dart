

class GetAgentsWidgetsData {
  String? status;
  Data? data;

  GetAgentsWidgetsData({
    this.status,
    this.data,
  });

  factory GetAgentsWidgetsData.fromJson(Map<String, dynamic> json) => GetAgentsWidgetsData(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  int? bookingsPending;
  int? bookingsAll;
  int? bookingsCompleted;
  String? bookingsTotalDeposit;
  String? bookingsTotalReamining;

  Data({
    this.bookingsPending,
    this.bookingsAll,
    this.bookingsCompleted,
    this.bookingsTotalDeposit,
    this.bookingsTotalReamining,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bookingsPending: json["bookings_pending"],
    bookingsAll: json["bookings_all"],
    bookingsCompleted: json["bookings_completed"],
    bookingsTotalDeposit: json["bookings_total_deposit"],
    bookingsTotalReamining: json["bookings_total_reamining"],
  );

  Map<String, dynamic> toJson() => {
    "bookings_pending": bookingsPending,
    "bookings_all": bookingsAll,
    "bookings_completed": bookingsCompleted,
    "bookings_total_deposit": bookingsTotalDeposit,
    "bookings_total_reamining": bookingsTotalReamining,
  };
}
