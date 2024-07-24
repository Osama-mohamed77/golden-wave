import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:golden_wave/utils/user_const.dart';

class MyUser {
  UserModel userModel = UserModel();

  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<UserModel> getUserProfile() async {
    final result =
        await _fireStore.collection('Users').doc(_auth.currentUser!.uid).get();

    final user = UserModel.fromMap(result.data()!);
    UserConst.fullName = user.fullName!;
    UserConst.email = user.email!;
    UserConst.phoneNumber = user.phoneNumber!;
    UserConst.id = user.uid!;
    userModel = user;
    return user;
  }
}

class UserModel {
  String? fullName;
  String? phoneNumber;
  String? email;
  String? uid;

  UserModel({
    this.fullName,
    this.phoneNumber,
    this.email,
    this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'FullName': fullName,
      'phoneNumer': phoneNumber,
      'email': email,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['FullName'] != null ? map['FullName'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }
}
