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
}