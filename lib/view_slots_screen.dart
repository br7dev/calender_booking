import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'form_bottom_sheet.dart';
import 'grid_item.dart';
import 'models.dart';

class ViewSlotsScreen extends StatefulWidget {
  bool isHoliday;
  DateTime? selectedDay;

  ViewSlotsScreen(
      {Key? key, required this.isHoliday, required this.selectedDay})
      : super(key: key);

  @override
  _ViewSlotsScreenState createState() => _ViewSlotsScreenState();
}

class _ViewSlotsScreenState extends State<ViewSlotsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Time Slots"),
        ),
        body: Material(
          child: widget.isHoliday
              ? Center(
                  child: Text(
                    'Hey!! I am on a break today.\nPlease choose any other day.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Available time slots for ${widget.selectedDay!.day}-${widget.selectedDay!.month}-${widget.selectedDay!.year} are:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: widget.isHoliday
                          ? SizedBox()
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 2.0,
                                mainAxisSpacing: 2.0,
                                childAspectRatio: (2 / 1),
                              ),
                              itemCount: timeSlots.length,
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 4.0,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: GridItem(
                                      selectedDate: widget.selectedDay!,
                                      map: map,
                                      isSelected: (bool value) {
                                        print("Printing Map: $map");
                                        var timing = map[widget.selectedDay!];
                                        print(
                                            "From GRIDITEM: 1.${widget.selectedDay} 2.${timing}");
                                        setState(() {
                                          if (value) {
                                            selectedSlotsList
                                                .add(timeSlots[index]);
                                          } else {
                                            selectedSlotsList
                                                .remove(timeSlots[index]);
                                          }
                                        });
                                      },
                                      item: timeSlots[index],
                                      dateChanged: (bool value) {
                                        if (value) {}
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (selectedSlotsList.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                'Please choose a slot!!',
                                style: TextStyle(fontSize: 18),
                              ),
                            ));
                          } else {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => GestureDetector(
                                onTap: () {
                                  print("Hello");
                                  FocusScope.of(context).unfocus();
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: FormBottomSheet(
                                    selectedSlotsList: selectedSlotsList,
                                    selectedDay: widget.selectedDay!,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Book Slots",
                            style: TextStyle(fontSize: 20),
                          ),
                        )),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
