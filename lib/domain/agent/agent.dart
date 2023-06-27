class Agent {
    final String accountId;
    final String symbol;
    final String headquarters;
    final int credits;

    Agent({
        required this.accountId,
        required this.symbol,
        required this.headquarters,
        required this.credits,
    });

    factory Agent.fromJson(Map<String, dynamic> json) => Agent(
        accountId: json["accountId"],
        symbol: json["symbol"],
        headquarters: json["headquarters"],
        credits: json["credits"],
    );

    Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "symbol": symbol,
        "headquarters": headquarters,
        "credits": credits,
    };

  Agent copyWith({
    String? accountId,
    String? symbol,
    String? headquarters,
    int? credits,
  }) =>
      Agent(
        accountId: accountId ?? this.accountId,
        symbol: symbol ?? this.symbol,
        headquarters: headquarters ?? this.headquarters,
        credits: credits ?? this.credits,
      );
    
}