import 'package:flutter/material.dart';

class AddSpendingComponents extends StatefulWidget {
  const AddSpendingComponents({super.key});

  @override
  State<AddSpendingComponents> createState() => _AddSpendingComponentsState();
}

class _AddSpendingComponentsState extends State<AddSpendingComponents> {
  DateTime initialDate = DateTime.now();
  TimeOfDay initialTime = TimeOfDay.now();
  TextEditingController spendingNameController = TextEditingController();
  TextEditingController spendingAmountController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? spending_name;
  String? spending_amount;
  String? spending_mode;
  String? spending_type;
  DateTime? date;
  TimeOfDay? time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Add"),
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Add Spending Category"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (val) {
                        spending_name = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter First Spending";
                        } else {}
                      },
                      controller: spendingNameController,
                      decoration: InputDecoration(
                        hintText: "Enter Spending Name..",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (val) {
                        spending_amount = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter First Spending Amount";
                        } else {}
                      },
                      controller: spendingAmountController,
                      decoration: InputDecoration(
                        hintText: "Enter Spending Amount..",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () async {
                          DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: initialDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3000),
                          );
                          setState(() {
                            date = dateTime;
                          });
                        },
                        icon: Icon(Icons.date_range),
                      ),
                      IconButton(
                        onPressed: () async {
                          TimeOfDay? timeofday = await showTimePicker(
                            context: context,
                            initialTime: initialTime,
                          );
                          setState(() {
                            time = timeofday;
                          });
                        },
                        icon: Icon(Icons.watch_later_outlined),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      (date == null)
                          ? Container()
                          : Text("${date?.day}/${date?.month}/${date?.year}"),
                      (time == null)
                          ? Container()
                          : Text("${time?.hour}:${time?.minute}"),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Select Spending Type"),
                      DropdownButton(
                        hint: Text("Select Type"),
                        value: spending_type,
                        items: [
                          DropdownMenuItem(
                              child: Text("Spending"), value: "Expense"),
                          DropdownMenuItem(
                              child: Text("Profit"), value: "Income"),
                        ],
                        onChanged: (value) {
                          setState(() {
                            spending_type = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Select Spending Mode"),
                      DropdownButton(
                        hint: Text("Select Type"),
                        value: spending_mode,
                        items: [
                          DropdownMenuItem(
                              child: Text("GPay"), value: "Online"),
                          DropdownMenuItem(
                              child: Text("Cash"), value: "Offline"),
                        ],
                        onChanged: (value) {
                          setState(() {
                            spending_mode = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
