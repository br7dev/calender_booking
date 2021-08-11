import 'package:calender_booking/success_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'calendar_screen.dart';
import 'models.dart';

class FormBottomSheet extends StatefulWidget {
  final List<Item> selectedSlotsList;
  final DateTime selectedDay;
  FormBottomSheet(
      {Key? key, required this.selectedSlotsList, required this.selectedDay})
      : super(key: key);

  @override
  _FormBottomSheetState createState() => _FormBottomSheetState();
}

class _FormBottomSheetState extends State<FormBottomSheet> {
  late String name;

  late String email;

  late String comments;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _textController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Please confirm your slots for date:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              "${widget.selectedDay.day}-${widget.selectedDay.month}-${widget.selectedDay.year}",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue),
            ),
            SizedBox(
              height: 50,
            ),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.characters,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (a) {
                        name = a;
                      },
                      validator: (v) {
                        if (v!.isValidName) {
                          return null;
                        } else {
                          return 'Please enter a valid name';
                        }
                      },
                      cursorColor: Colors.grey,
                      keyboardType: TextInputType.name,
                      decoration: buildInputDecoration('Name'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (a) {
                        email = a;
                      },
                      validator: (v) {
                        if (v!.isValidEmail) {
                          return null;
                        } else {
                          return 'Please enter a valid email';
                        }
                      },
                      cursorColor: Colors.grey,
                      keyboardType: TextInputType.emailAddress,
                      decoration: buildInputDecoration('Email'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10),
                    child: TextField(
                      onChanged: (a) {
                        comments = a;
                      },
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.grey,
                      decoration: buildInputDecoration('Comments'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (map.containsKey(widget.selectedDay)) {
                          List<String> a = [];
                          for (int i = 0;
                              i < widget.selectedSlotsList.length;
                              i++) {
                            a.add(widget.selectedSlotsList[i].slot.toString());
                          }
                          print("a is : $a");
                          List<String> b = map[widget.selectedDay];
                          print("b is $b");
                          for (String x in b) {
                            a.add(x);
                          }
                          print('a is now: $a');

                          map[widget.selectedDay] = a;

                          print(map);
                        } else {
                          map.putIfAbsent(
                              widget.selectedDay,
                              () => widget.selectedSlotsList
                                  .map((e) => e.slot.toString())
                                  .toList());
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SuccessScreen()),
                        );
                      } else {}
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(
                        "Confirm",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

InputDecoration buildInputDecoration(String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: TextStyle(color: Colors.black54),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black26),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black26),
      borderRadius: BorderRadius.circular(10),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }
}
