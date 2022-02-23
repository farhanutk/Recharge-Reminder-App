import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/bottom_menu.dart';
import 'package:flutter_application_1/recharge.dart';

main() => runApp(RechargeReminderApp());

class RechargeReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recharge Reminder App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
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
    // Recharge('Farhan', '9061253087', '599', '56', '2GB/day'),
    // Recharge('Uvais', '9061253087', '599', '56', '2GB/day'),
    // Recharge('Farhan', '9061253087', '599', '56', '2GB/day'),
    // Recharge('Uvais', '9061253087', '599', '56', '2GB/day')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: recharges.isEmpty
          ? Center(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hi there 👋',
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
            )
          : SingleChildScrollView(
              child: Padding(
                // padding: const EdgeInsets.symmetric(
                //     vertical: 30.0, horizontal: 15.0),
                padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 75.0),
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
                        children: recharges.map((recharge) {
                          return Card(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Text(
                                    recharge.number,
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  Divider(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '₹${recharge.amount}',
                                        style: TextStyle(
                                          fontSize: 24.0,
                                        ),
                                      ),
                                      Text(
                                        '${recharge.date} days',
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
                                  Text(
                                    recharge.info,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey[700],
                                    ),
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
            ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              // isScrollControlled: true,
              builder: (context) {
                return BottomMenu((String nameController,
                    String numberController,
                    String amountController,
                    String validityController,
                    String infoController) {
                  setState(() {
                    recharges.add(Recharge(nameController, numberController,
                        amountController, validityController, infoController));
                    print({recharges.isEmpty});
                    print(
                        'got $nameController , $numberController , $amountController, $validityController,$infoController');
                    Navigator.pop(context);
                  });
                  // show new home code here
                });
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
