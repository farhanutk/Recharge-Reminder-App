import 'package:flutter/material.dart';

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

  final infoController = TextEditingController();

  String operator = 'Jio';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 30, 20, MediaQuery.of(context).viewInsets.bottom),
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
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name',
            ),
          ),
          Row(
            children: [
              Flexible(
                child: TextField(
                  controller: numberController,
                  decoration: InputDecoration(
                    labelText: 'Phone number',
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              SizedBox(
                width: 18.0,
              ),
              TextButton.icon(
                onPressed: () async {
                  date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2222),
                  );
                  stringDate = date.toString();
                },
                icon: Icon(Icons.calendar_today),
                label: Text('Expiry date'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: 'Recharge amount',
                    hintText: 'in rupees',
                  ),
                  keyboardType: TextInputType.number,
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
                child: Container(
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
            onPressed: () => widget.addRecharge(
              nameController.text,
              numberController.text,
              amountController.text,
              stringDate,
              infoController.text,
              operator,
            ),
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
    );
  }
}
