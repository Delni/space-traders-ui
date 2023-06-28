class Payment {
  final int onAccepted;
  final int onFulfilled;

  Payment({
    required this.onAccepted,
    required this.onFulfilled,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        onAccepted: json["onAccepted"],
        onFulfilled: json["onFulfilled"],
      );

  Map<String, dynamic> toJson() => {
        "onAccepted": onAccepted,
        "onFulfilled": onFulfilled,
      };
}
