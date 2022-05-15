import 'package:flutter/material.dart';

class BottomMenu extends StatefulWidget {
  final Function(String, String, String, String, String) addRecharge;
  BottomMenu(this.addRecharge);

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  final nameController = TextEditingController();

  final numberController = TextEditingController();

  final amountController = TextEditingController();

  final validityController = TextEditingController();

  final infoController = TextEditingController();

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
          TextField(
            controller: numberController,
            decoration: InputDecoration(
              labelText: 'Phone number',
            ),
            keyboardType: TextInputType.phone,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Flexible(
                child: TextField(
                  controller: validityController,
                  decoration: InputDecoration(
                    labelText: 'Recharge validity',
                    hintText: 'in days',
                  ),
                  keyboardType: TextInputType.number,
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
                validityController.text,
                infoController.text),
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
          )
        ],
      ),
    );
  }
}
