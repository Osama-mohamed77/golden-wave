import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:golden_wave/provider/fetch_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class BookingProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String title = '';
  int? serviceNumber; 

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

  Future<void> bookAppointment(
      String userId, DateTime dateTime, context) async {
    DateTime currentDateTime = DateTime.now().toUtc();

    try {
      await _firestore.collection('appointments').add({
        'userId': userId,
        'date': currentDateTime,
        'appointmentDate': dateTime,
        'fullName':
            Provider.of<FetchDataProvider>(context, listen: false).fullName,
        'phoneNumber':
            Provider.of<FetchDataProvider>(context, listen: false).phoneNumber,
        'service name': title,
        'service number': serviceNumber, // Add service number
        'status': true
      });
      _reservedTimes.add(dateTime);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchReservedTimes() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('appointments')
          .where('service number',
              isEqualTo: serviceNumber) // Ensure the field name is correct
          .get();

      Set<DateTime> reserved = {};

      for (var doc in querySnapshot.docs) {
        Timestamp timestamp = doc['appointmentDate'];
        reserved.add(timestamp.toDate().toLocal());
      }

      _reservedTimes = reserved;
      notifyListeners();
    } catch (e) {
      // Add error handling
    }
  }

  void getTitle(String title) {
    this.title = title;
    serviceNumber = _serviceNumbers[title];
    // Check if this is correctly set
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

  final Map<String, int> _serviceNumbers = {
    'Audio effects': 1,
    'تأثيرات الصوت': 1,
    'Audiobook recording': 2,
    'تسجيل الكتب الصوتية': 2,
    'Dubbing': 3,
    'الدبلجة': 3,
    'Music production': 4,
    'إنتاج الموسيقى': 4,
    'Soundtrack composing': 5,
    'تأليف الموسيقى التصويرية': 5,
    'Music mixing': 6,
    'مزج الموسيقى': 6,
    'Music orchestration': 7,
    'تنسيق الموسيقى': 7,
    'Voiceover': 8,
    'التعليق الصوتي': 8,
    'IVR': 9,
    'الرد الآلي': 9,
    'Radio podcast': 10,
    'البودكاست الإذاعي': 10,
    'Photography': 11,
    'التصوير الفوتوغرافي': 11,
    'Video recording': 12,
    'تسجيل الفيديو': 12,
    'Montage': 13,
    'المونتاج': 13,
    'Lighting': 14,
    'الإضاءة': 14,
    'Motion graphics': 15,
    'الرسوم المتحركة': 15,
    'TV programs': 16,
    'البرامج التلفزيونية': 16,
    '2D/3D graphic designs': 17,
    'تصاميم الجرافيك ثلاثية وثنائية الأبعاد': 17,
    'TV advertisements': 18,
    'الإعلانات التلفزيونية': 18,
    'Documents and films': 19,
    'الوثائق والأفلام': 19,
    'Writing the scenario': 20,
    'كتابة السيناريو': 20,
    'Story crafting': 21,
    'صياغة القصص': 21,
    'Poetry and thoughts': 22,
    'الشعر والأفكار': 22,
    'Writing autobiographies': 23,
    'كتابة السيرة الذاتية': 23,
    'Writing advertisements': 24,
    'كتابة الإعلانات': 24,
    'Preparation': 25,
    'التحضير': 25,
    'Public speaking': 26,
    'التحدث أمام الجمهور': 26,
    'Presentation': 27,
    'التقديم': 27,
    'Editing': 28,
    'التحرير': 28,
    'Sound engineering': 29,
    'الهندسة الصوتية': 29,
    'Directing': 30,
    'الإخراج': 30,
    'Music workshop': 31,
    'ورشة الموسيقى': 31,
  };
}
