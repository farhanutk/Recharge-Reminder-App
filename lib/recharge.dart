import 'package:flutter/material.dart';

class Recharge {
  String name;
  String number;
  String amount;
  String date;
  String info;

  Recharge(this.name, this.number, this.amount, this.date, this.info);
  showRecharge() {
    print(name);
  }
}
