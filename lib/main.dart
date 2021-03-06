import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bottom_menu.dart';
import 'package:flutter_application_1/recharge.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'db_functions.dart';
import 'notification_functions.dart';

main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RechargeAdapter());
  runApp(RechargeReminderApp());
}

class RechargeReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recharge Reminder',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        dialogTheme: const DialogTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)))),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Recharge> recharges = [
    // Recharge(
    //     name: 'Farhan',
    //     number: '9061253087',
    //     amount: '599',
    //     date: '56',
    //     info: '2GB/day'),
    // Recharge('Uvais', '9061253087', '599', '56', '2GB/day'),
    // Recharge('Farhan', '9061253087', '599', '56', '2GB/day'),
    // Recharge('Uvais', '9061253087', '599', '56', '2GB/day')
  ];

  @override
  void initState() {
    initialiseNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getValues(recharges),
        builder: (context, AsyncSnapshot<List<Recharge>> snapshot) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: (snapshot.hasData && recharges.isNotEmpty)
                ? SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 75.0),
                      child: SafeArea(
                        top: true,
                        bottom: true,
                        child: Column(
                          children: [
                            Text(
                              'Your frequent recharges',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Column(
                              children: sortByDate(recharges).map((recharge) {
                                return Card(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  recharge.name,
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      recharge.number,
                                                      style: TextStyle(
                                                        fontSize: 22.0,
                                                        color: Colors.grey[800],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 5),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 3,
                                                              horizontal: 7),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: Colors.amber[50],
                                                      ),
                                                      child: Text(
                                                        recharge.operator,
                                                        style: TextStyle(
                                                          color: Colors.amber,
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    deleteValues(recharge.id);
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ))
                                          ],
                                        ),
                                        Divider(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '???${recharge.amount}',
                                              style: TextStyle(
                                                fontSize: 24.0,
                                              ),
                                            ),
                                            Text(
                                              getDaysToExpiry(recharge.date),
                                              style: TextStyle(
                                                fontSize: 22.0,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              recharge.info,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                            Text(
                                              beautifyDate(recharge.date),
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 60),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hi there ????',
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Add your frequent recharges to see them here.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[600],
                              ),
                            )
                          ],
                        )),
                  ),
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(15.0),
                            topRight: const Radius.circular(15.0))),
                    builder: (context) {
                      return BottomMenu((String nameController,
                          String numberController,
                          String amountController,
                          String date,
                          String infoController,
                          String operator) {
                        setState(() {
                          putValues(
                              nameController,
                              numberController,
                              amountController,
                              date,
                              infoController,
                              operator,
                              context);
                        });
                      });
                    });
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        });
  }

  //Custom date functions for the UI

  String getDaysToExpiry(String date) {
    int difference =
        (DateTime.parse(date).difference(DateTime.now()).inHours / 24).ceil();
    if (difference == 0) {
      return 'Expiring today';
    } else if (difference == 1) {
      return 'Expiring tomorrow';
    } else if (difference > 1) {
      return '$difference days left';
    } else {
      return 'Expired';
    }
  }

  List<Recharge> sortByDate(List<Recharge> recharges) {
    recharges.sort((a, b) {
      final adate = a.date;
      final bdate = b.date;
      return adate.compareTo(bdate);
    });
    return recharges;
  }

  String beautifyDate(String date) {
    DateTime rawDate = DateTime.parse(date);
    return DateFormat('dd MMMM yyyy').format(rawDate);
  }
}
