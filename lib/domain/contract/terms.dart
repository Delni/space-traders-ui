import 'cargo_to_deliver.dart';
import 'payment.dart';

class Terms {
  final DateTime deadline;
  final Payment payment;
  final List<CargoToDeliver> deliver;

  Terms({
    required this.deadline,
    required this.payment,
    required this.deliver,
  });

  factory Terms.fromJson(Map<String, dynamic> json) => Terms(
        deadline: DateTime.parse(json["deadline"]),
        payment: Payment.fromJson(json["payment"]),
        deliver: List<CargoToDeliver>.from(
            json["deliver"].map((x) => CargoToDeliver.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "deadline": deadline.toIso8601String(),
        "payment": payment.toJson(),
        "deliver": List<dynamic>.from(deliver.map((x) => x.toJson())),
      };
}
