import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:golden_wave/utils/user_const.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class BookingProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String title = '';

  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;

  Set<DateTime> _reservedTimes = {};

  CalendarFormat get format => _format;
  DateTime get focusDay => _focusDay;
  DateTime get currentDay => _currentDay;
  int? get currentIndex => _currentIndex;
  bool get isWeekend => _isWeekend;
  Set<DateTime> get reservedTimes => _reservedTimes;

  void updateFormat(CalendarFormat format) {
    _format = format;
    notifyListeners();
  }

  void updateFocusDay(DateTime focusDay) {
    _focusDay = focusDay;
    notifyListeners();
  }

  void updateCurrentDay(DateTime currentDay) {
    _currentDay = currentDay;
    _isWeekend = currentDay.weekday == 6 || currentDay.weekday == 7;
    notifyListeners();
  }

  void updateSelectedDay(DateTime selectedDay) {
    _currentDay = selectedDay;
    _isWeekend = selectedDay.weekday == 6 || selectedDay.weekday == 7;
    notifyListeners();
  }

  void updateCurrentIndex(int? index) {
    _currentIndex = index;
    notifyListeners();
  }

  String getFormattedDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('MMMM d, yyyy \'at\' h:mm a');
    return formatter.format(dateTime);
  }

  Future<void> bookAppointment(String userId, DateTime dateTime) async {
    String formattedTime = getFormattedDateTime(dateTime);
    DateTime currentDateTime =
        DateTime.now().toUtc(); 

    try {
      await _firestore.collection('appointments').add({
        'userId': userId,
        'Booking time': formattedTime,
        'date': currentDateTime, 
        'appointmentDate': dateTime.toUtc(), 
        'fullName': UserConst.fullName,
        'phoneNumber': UserConst.phoneNumber,
        'service name': title
      });
      _reservedTimes.add(dateTime.toUtc());
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchReservedTimes() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('appointments')
          .where('service name', isEqualTo: title) 
          .get();

      Set<DateTime> reserved = {};

      for (var doc in querySnapshot.docs) {
        Timestamp timestamp = doc['appointmentDate'];
        reserved.add(timestamp.toDate().toLocal());
      }

      _reservedTimes = reserved;
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  void getTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  bool isAllSlotsBooked(DateTime date) {
    for (int i = 0; i < 10; i++) {
      final time = DateTime(date.year, date.month, date.day, i + 9);
      if (!_reservedTimes.contains(time.toUtc())) {
        return false;
      }
    }
    return true; 
  }
}
