import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class HistoryProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  List<Booking> _bookings = [];
  
  List<Booking> get bookings => _bookings;

  Future<void> fetchBookingDate() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('appointments')
          .where('userId', isEqualTo: uid)
          .get();

      _bookings = querySnapshot.docs.map((doc) {
        Timestamp timestamp = doc['appointmentDate'];
        String formattedDate = DateFormat('MM/dd/yyyy hh:mm a')
            .format(timestamp.toDate());
        return Booking(
          bookingDate: formattedDate,
          serviceName: doc['service name'],
          phoneNumber: doc['phoneNumber'],
        );
      }).toList();

      notifyListeners();
    } catch (e) {
     return;
    }
  }
}

class Booking {
  final String bookingDate;
  final String serviceName;
  final String phoneNumber;

  Booking({
    required this.bookingDate,
    required this.serviceName,
    required this.phoneNumber,
  });
}