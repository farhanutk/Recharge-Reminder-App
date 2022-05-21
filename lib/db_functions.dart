import 'package:flutter/material.dart';
import 'package:flutter_application_1/recharge.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'notification_functions.dart';

Future<List<Recharge>> getValues(List<Recharge> recharges) async {
  final rechargeDB = await Hive.openBox('recharge_db');
  if (rechargeDB.isEmpty) {
    recharges.clear();
    return recharges;
  } else {
    recharges.clear();
    int i;
    for (i = 0; i < rechargeDB.length; i++) {
      recharges.add(await rechargeDB.getAt(i));
    }
    return recharges;
  }
}

Future putValues(
    String nameController,
    String numberController,
    String amountController,
    String date,
    String infoController,
    String operator,
    BuildContext context) async {
  final rechargeDB = await Hive.openBox('recharge_db');

  Recharge recharge = Recharge(
      name: nameController,
      number: numberController,
      amount: amountController,
      date: date,
      info: infoController,
      operator: operator);

  int _id = await rechargeDB.add(recharge);

  // recharge.id = _id;
  // recharge.name = "far";

  // rechargeDB.putAt(_id, recharge);

  int lastIndex = rechargeDB.toMap().length - 1;

  recharge = rechargeDB.values.toList()[lastIndex];
  recharge.id = _id;
  rechargeDB.putAt(lastIndex, recharge);

  showNotification(_id, nameController, numberController, date);

  Navigator.pop(context);
}

Future deleteValues(int? rechargeId) async {
  final rechargeDB = await Hive.openBox('recharge_db');
  await rechargeDB.delete(rechargeId);
  deleteNotificationSchedule(rechargeId as int);
}
