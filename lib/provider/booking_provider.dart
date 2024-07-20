import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class BookingProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String title = '';
  String fullName = '';

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
        DateTime.now().toUtc(); // Current date and time in UTC

    try {
      await _firestore.collection('appointments').doc(userId).set({
        'userId': userId,
        'Booking time': formattedTime,
        'date': currentDateTime, // Store current time in UTC
        'appointmentDate': dateTime.toUtc(), // Store appointment date in UTC
        'fullName': fullName,
        'service name': title
      });
      _reservedTimes.add(dateTime.toUtc()); // Ensure reserved times are in UTC
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchFullName() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (documentSnapshot.exists) {
        fullName = documentSnapshot['fullName'];
      }
    } catch (e) {
      print('Error fetching full name: $e');
    }
    notifyListeners();
  }

  Future<void> fetchReservedTimes() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('appointments').get();
      Set<DateTime> reserved = {};

      for (var doc in querySnapshot.docs) {
        Timestamp timestamp = doc['appointmentDate'];
        reserved.add(timestamp
            .toDate()
            .toLocal()); // Convert to local time for comparison
      }

      _reservedTimes = reserved;
      notifyListeners();
    } catch (e) {
      print('Error fetching reserved times: $e');
    }
  }

  void getTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  bool isAllSlotsBooked(DateTime date) {
    // Assuming 10 time slots per day (from 9 AM to 6 PM)
    for (int i = 0; i < 10; i++) {
      final time = DateTime(date.year, date.month, date.day, i + 9);
      if (!_reservedTimes.contains(time.toUtc())) {
        return false; // If any slot is not booked, return false
      }
    }
    return true; // All slots are booked
  }
}
