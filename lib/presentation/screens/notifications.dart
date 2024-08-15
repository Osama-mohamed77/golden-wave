import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/provider/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gap/gap.dart'; // Assuming this is a package you are using

class NotificationManager {
  static String _notificationKey(String userId) => 'savedNotifications_$userId';

  static Future<int> getNotificationCount(String userId) async {
    final notifications = await getSavedNotifications(userId);
    return notifications.length;
  }

  static Future<void> saveNotification(
      String userId, int id, String title, String body) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> existingNotifications =
        prefs.getStringList(_notificationKey(userId)) ?? [];

    bool notificationExists = false;
    for (int i = 0; i < existingNotifications.length; i++) {
      Map<String, dynamic> notification = jsonDecode(existingNotifications[i]);
      if (notification['id'] == id) {
        notification['title'] = title;
        notification['body'] = body;
        existingNotifications[i] = jsonEncode(notification);
        notificationExists = true;
        break;
      }
    }

    if (!notificationExists) {
      final notificationMap = {'id': id, 'title': title, 'body': body};
      existingNotifications.add(jsonEncode(notificationMap));
    }

    await prefs.setStringList(_notificationKey(userId), existingNotifications);
  }

  static Future<List<Map<String, dynamic>>> getSavedNotifications(
      String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final notificationStrings =
        prefs.getStringList(_notificationKey(userId)) ?? [];

    List<Map<String, dynamic>> notifications = notificationStrings
        .map((notificationString) => jsonDecode(notificationString))
        .cast<Map<String, dynamic>>()
        .toList();

    return notifications;
  }

  static Future<void> clearSavedNotification(String userId, int id) async {
    final prefs = await SharedPreferences.getInstance();
    final savedNotifications = await getSavedNotifications(userId);

    final filteredNotifications = savedNotifications
        .where((notification) => notification['id'] != id)
        .toList();

    final filteredNotificationsJson = filteredNotifications
        .map((notification) => jsonEncode(notification))
        .toList();

    await prefs.setStringList(
        _notificationKey(userId), filteredNotificationsJson);
  }
}

class NotificationsScreen extends StatefulWidget {
  static String id = '';
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>> _savedNotifications = [];
  User? currentUser;

  @override
  void initState() {
    super.initState();

    currentUser = FirebaseAuth.instance.currentUser;

    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    if (currentUser != null) {
      final notifications =
          await NotificationManager.getSavedNotifications(currentUser!.uid);
      setState(() {
        _savedNotifications = notifications;
      });
    }
  }

  Future<void> _deleteNotification(int id) async {
    if (currentUser != null) {
      await NotificationManager.clearSavedNotification(currentUser!.uid, id);
      _fetchNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myWhite,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffC9C9C9),
                MyColors.myYellow,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          children: [
            const Spacer(),
            Text(
              S.of(context).notifications,
              style: TextStyle(fontFamily: 'inter', fontSize: 23.sp),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
      body: _savedNotifications.isNotEmpty
          ? ListView.builder(
              itemCount: _savedNotifications.length,
              itemBuilder: (context, index) {
                final notification = _savedNotifications[index];
                final title = notification['title'];
                final body = notification['body'];
                final id = notification['id'];
                final timestamp = notification['timestamp'];

                return Dismissible(
                  key: Key(id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) async {
                    await _deleteNotification(id);
                  },
                  background: Container(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30.r,
                        ),
                        Gap(20.w),
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Gap(15.h),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 20.h),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: const Color(0xffE4E4E4),
                              borderRadius: BorderRadius.circular(20.r)),
                          child: ListTile(
                            title: Text(
                              title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(body),
                            trailing: timestamp != null
                                ? Text(timestamp)
                                : null, // Display timestamp if available
                          ),
                        ),
                      ),
                      Gap(15.h),
                    ],
                  ),
                );
              },
            )
          : Provider.of<LanguageProvider>(context).language == 'en'
              ? const Center(
                  child: Text("You haven't received any notifications."),
                )
              : const Center(
                  child: Text("لم تتلقي أي إشعارات"),
                ),
    );
  }
}
