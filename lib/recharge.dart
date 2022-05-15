import 'package:hive_flutter/adapters.dart';
part 'recharge.g.dart';

@HiveType(typeId: 0)
class Recharge {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String number;

  @HiveField(3)
  String amount;

  @HiveField(4)
  String date;

  @HiveField(5)
  String info;

  Recharge(
      {this.id,
      required this.name,
      required this.number,
      required this.amount,
      required this.date,
      required this.info});
  showRecharge() {
    print(name);
  }
}
