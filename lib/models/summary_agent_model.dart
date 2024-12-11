

class SummaryAgentModel {
  String? status;
  Data? data;

  SummaryAgentModel({
    this.status,
    this.data,
  });

  factory SummaryAgentModel.fromJson(Map<String, dynamic> json) => SummaryAgentModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data!.toJson(),
  };
}

class Data {
  String? usersAgentsId;
  String? agencyName;
  String? status;
  int? totalCompletedTrips;
  int? totalAgentFare;
  int? totalAgentsReceivingsDebit;
  int? totalAgentsReceivingsCredit;
  int? totalAgentsBalance;

  Data({
    this.usersAgentsId,
    this.agencyName,
    this.status,
    this.totalCompletedTrips,
    this.totalAgentFare,
    this.totalAgentsReceivingsDebit,
    this.totalAgentsReceivingsCredit,
    this.totalAgentsBalance,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    usersAgentsId: json["users_agents_id"],
    agencyName: json["agency_name"],
    status: json["status"],
    totalCompletedTrips: json["total_completed_trips"],
    totalAgentFare: json["total_agent_fare"],
    totalAgentsReceivingsDebit: json["total_agents_receivings_debit"],
    totalAgentsReceivingsCredit: json["total_agents_receivings_credit"],
    totalAgentsBalance: json["total_agents_balance"],
  );

  Map<String, dynamic> toJson() => {
    "users_agents_id": usersAgentsId,
    "agency_name": agencyName,
    "status": status,
    "total_completed_trips": totalCompletedTrips,
    "total_agent_fare": totalAgentFare,
    "total_agents_receivings_debit": totalAgentsReceivingsDebit,
    "total_agents_receivings_credit": totalAgentsReceivingsCredit,
    "total_agents_balance": totalAgentsBalance,
  };
}
