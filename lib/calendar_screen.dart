import 'package:calender_booking/view_slots_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'models.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool isHoliday = DateTime.now().weekday == 2
      ? DateTime.now().weekday == 3
          ? true
          : true
      : false;
  bool dateChanged = false;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    super.dispose();
  }

  getCalendarDataSource() {}

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        selectedSlotsList.clear();
        if (selectedDay.weekday == 2 || selectedDay.weekday == 3) {
          isHoliday = true;
        } else {
          isHoliday = false;
        }
        _focusedDay = focusedDay;
      });
    }
  }

  final CalendarController _controller = CalendarController();

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    print(calendarTapDetails.date);
    _onDaySelected(calendarTapDetails.date!, _focusedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewSlotsScreen(
                isHoliday: isHoliday,
                selectedDay: _selectedDay!,
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Book your counseling session'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: SfCalendar(
          view: CalendarView.month,
          allowedViews: [
            CalendarView.day,
            CalendarView.week,
            CalendarView.month,
          ],
          firstDayOfWeek: 1,
          minDate: DateTime.now(),
          headerStyle: CalendarHeaderStyle(
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          controller: _controller,
          initialDisplayDate: DateTime.now(),
          dataSource: MeetingDataSource(getAppointments()),
          onTap: calendarTapped,
          timeSlotViewSettings: TimeSlotViewSettings(
              timeTextStyle:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
              timeIntervalHeight: 50,
              startHour: 8,
              endHour: 18),
          monthViewSettings: MonthViewSettings(
              navigationDirection: MonthNavigationDirection.horizontal,
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        ),
      ),
    );
  }
}

List<Appointment> getAppointments() {
  Map<String, int> time = {
    "9 AM": 9,
    "10 AM": 10,
    "11 AM": 11,
    "12 PM": 12,
    "1 PM": 13,
    "2 PM": 14,
    "3 PM": 15,
    "4 PM": 16,
    "5 PM": 17
  };

  List<Appointment> meetings = <Appointment>[];
  for (var k in map.keys) {
    for (var v in map[k]) {
      final DateTime today = k;
      final DateTime startTime =
          DateTime(today.year, today.month, today.day, time[v]!, 0, 0);
      final DateTime endTime = startTime.add(Duration(hours: 1));
      meetings.add(Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: "${v.toString()} Booked",
          color: Colors.blue));
    }
  }

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
