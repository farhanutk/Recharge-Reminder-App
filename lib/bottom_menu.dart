import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BottomMenu extends StatefulWidget {
  final Function(String, String, String, String, String, String) addRecharge;
  BottomMenu(this.addRecharge);

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  final nameController = TextEditingController();

  final numberController = TextEditingController();

  final amountController = TextEditingController();

  DateTime? date;

  late String stringDate;

  String dateButtonText = 'Expiry date';

  final infoController = TextEditingController();

  String operator = 'Jio';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 30, 20, MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Text(
              'Add details of the recharge below',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter the name';
                } else
                  return null;
              },
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: numberController,
                    decoration: InputDecoration(
                      labelText: 'Phone number',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter the phone number';
                      } else if (!RegExp(r'^(?:[+0]9)?[0-9]{10}$')
                          .hasMatch(value)) {
                        return 'Enter a valid phone number';
                      } else
                        return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 18.0,
                ),
                TextButton.icon(
                  onPressed: () async {
                    date = await showDatePicker(
                      context: context,
                      initialDate:
                          date == null ? DateTime.now() : date as DateTime,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2222),
                    );
                    stringDate = date.toString();
                    setState(() {
                      if (date == null) {
                        dateButtonText = 'Expiry date';
                      } else
                        dateButtonText =
                            DateFormat('dd MMMM yyyy').format(date as DateTime);
                    });
                  },
                  icon: Icon(Icons.calendar_today_sharp),
                  label: Text(dateButtonText),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: TextFormField(
                    controller: amountController,
                    decoration: InputDecoration(
                      labelText: 'Recharge amount',
                      hintText: 'in rupees',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter the recharge amount';
                      } else if ((int.tryParse(value)) == null ||
                          (int.tryParse(value))! < 0) {
                        return 'Enter a valid recharge amount';
                      } else
                        return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 18.0,
                ),
                Text(
                  'Operator',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[600],
                  ),
                ),
                Flexible(
                  // child: TextField(
                  //   controller: validityController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Recharge validity',
                  //     hintText: 'in days',
                  //   ),
                  //   keyboardType: TextInputType.number,
                  // ),
                  child: DropdownButton<String>(
                    value: operator,
                    items: <String>[
                      'Jio',
                      'Airtel',
                      'Vi',
                      'BSNL',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        operator = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            TextField(
              controller: infoController,
              decoration: InputDecoration(
                labelText: 'Additional info',
                hintText: 'e.g., 3GB/day',
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (date == null) {
                    setState(() {
                      dateButtonText = 'Select expiry date';
                    });
                    return;
                  }
                  return widget.addRecharge(
                    nameController.text,
                    numberController.text,
                    amountController.text,
                    stringDate,
                    infoController.text,
                    operator,
                  );
                }
              },
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
