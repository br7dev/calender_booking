import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models.dart';

class GridItem extends StatefulWidget {
  final Item item;
  final ValueChanged<bool> isSelected;
  final Map map;
  final DateTime selectedDate;
  ValueChanged<bool> dateChanged;

  GridItem({
    required this.item,
    required this.isSelected,
    required this.dateChanged,
    required this.map,
    required this.selectedDate,
  });

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;
  bool isDateChanged = false;
  bool isTodayBooked = false;
  bool isSlotBooked = false;
  List<String> timing = [];

  @override
  Widget build(BuildContext context) {
    if (widget.map.containsKey(widget.selectedDate)) {
      setState(() {
        isTodayBooked = true;
        timing = widget.map[widget.selectedDate];
        timing.contains(widget.item.slot.toString())
            ? isSlotBooked = true
            : isSlotBooked = false;
      });
    } else {
      setState(() {
        isTodayBooked = false;
        timing.clear();
      });
    }

    return InkWell(
      onTap: () {
        isSlotBooked
            ? {}
            : setState(() {
                isSelected = !isSelected;
                widget.isSelected(isSelected);
              });
      },
      child: Stack(
        children: <Widget>[
          Center(
            child: isSlotBooked
                ? Text(
                    "Booked",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w500),
                  )
                : Text(
                    widget.item.slot.toString(),
                  ),
          ),
          isSelected
              ? isSlotBooked
                  ? Container()
                  : Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                        ),
                      ),
                    )
              : Container()
        ],
      ),
    );
  }
}
