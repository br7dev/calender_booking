import 'calendar_screen.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

Map map = Map<DateTime, List<String>>();
List<Item> timeSlots = [
  Item("9 AM"),
  Item("10 AM"),
  Item("11 AM"),
  Item("12 PM"),
  Item("1 PM"),
  Item("2 PM"),
  Item("3 PM"),
  Item("4 PM"),
  Item("5 PM"),
];

List<Item> selectedSlotsList = [];

void selectedTimeSlots(Item timeSlot) {
  selectedSlotsList.add(timeSlot);
}

class Item {
  final String slot;
  const Item(this.slot);
}
