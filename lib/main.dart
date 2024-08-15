import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/firebase_options.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/presentation/AuthManagement/forgot_password.dart';
import 'package:golden_wave/presentation/AuthManagement/sign_in.dart';
import 'package:golden_wave/presentation/AuthManagement/sign_up.dart';
import 'package:golden_wave/presentation/screens/account_details.dart';
import 'package:golden_wave/presentation/screens/booking_screen.dart'
    as booking_screen;
import 'package:golden_wave/presentation/screens/help.dart';
import 'package:golden_wave/presentation/screens/home.dart' as home;
import 'package:golden_wave/presentation/screens/notifications.dart';
import 'package:golden_wave/presentation/screens/settings.dart'
    as settings_screen;
import 'package:golden_wave/presentation/widgets/nav_bar.dart';
import 'package:golden_wave/provider/auth_provider.dart';
import 'package:golden_wave/provider/language_provider.dart';
import 'package:golden_wave/provider/page_index_provider.dart';
import 'package:golden_wave/provider/home_provider.dart';
import 'package:golden_wave/provider/booking_provider.dart';
import 'package:golden_wave/provider/history_provider.dart';
import 'package:golden_wave/provider/fetch_data_provider.dart';
import 'package:golden_wave/stripe_payment/stripe_keys.dart';
import 'package:golden_wave/utils/splash_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = ApiKeys.pusblishablKeys;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await AwesomeNotifications().initialize(
    null, // Use null if you're not setting a custom icon
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: MyColors.myYellow,
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        icon: null, // Set this to null if the icon is causing issues
      ),
    ],
  );

  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageIndexProvider()),
        ChangeNotifierProvider(create: (_) => AuthProviderOS()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => FetchDataProvider()),
      ],
      child: const GoldenWave(),
    ),
  );
}

class GoldenWave extends StatefulWidget {
  const GoldenWave({super.key});

  @override
  State<GoldenWave> createState() => _GoldenWaveState();
}

class _GoldenWaveState extends State<GoldenWave> {
  Timer? _timer;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    startPeriodicFetch();

    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        currentUser = user;
      });
      if (user != null) {
        fetchAndHandleAppointmentStatus(user.uid);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startPeriodicFetch() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (currentUser != null) {
        fetchAndHandleAppointmentStatus(currentUser!.uid);
      }
    });
  }

  Future<void> fetchAndHandleAppointmentStatus(String userId) async {
    try {
      QuerySnapshot appointmentSnapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: true)
          .get();

      for (var doc in appointmentSnapshot.docs) {
        var appointmentData = doc.data() as Map<String, dynamic>;
        var appointmentId = doc.id;

        // Convert the Timestamp to DateTime
        Timestamp timestamp = appointmentData['appointmentDate'] as Timestamp;
        DateTime appointmentDateTime = timestamp.toDate();

        // Format the DateTime to a readable string
        String formattedDate =
            DateFormat('MMMM d, yyyy h:mm a').format(appointmentDateTime);

        // Generate a unique notification ID for each appointment
        int notificationId = DateTime.now().millisecondsSinceEpoch % (1 << 31);

        Provider.of<LanguageProvider>(context, listen: false).language == 'en'
            ?

            // Send and save the notification
            sendAndSaveNotification(
                userId,
                notificationId,
                'Appointment Confirmed',
                'Your appointment on $formattedDate is confirmed.',
              )
            : sendAndSaveNotification(
                userId,
                notificationId,
                'تم تأكيد الموعد',
                'تم تأكيد موعدك في $formattedDate',
              );
        // Update the status in Firestore to prevent duplicate notifications
        await FirebaseFirestore.instance
            .collection('appointments')
            .doc(appointmentId)
            .update({'status': false});
      }
    } catch (e) {
      print('Error fetching appointment status: $e');
    }
  }

  void sendNotification(int id, String title, String body) {
    print(
        'Sending notification: ID=$id, Title=$title, Body=$body'); // Debugging

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }

  void sendAndSaveNotification(
      String userId, int id, String title, String body) async {
    // Ensure the ID is within the 32-bit integer range
    int validId = id % (1 << 31); // Limit the ID to 32-bit integer range
    sendNotification(validId, title, body);
    await NotificationManager.saveNotification(userId, validId, title, body);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return ScreenUtilInit(
          designSize: const Size(393, 852),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (BuildContext context, child) {
            return MaterialApp(
              locale: Locale(languageProvider.language),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              routes: {
                home.Home.id: (context) => const home.Home(),
                SignIn.id: (context) => const SignIn(),
                SignUp.id: (context) => const SignUp(),
                NavBar.id: (context) => const NavBar(),
                ForgotPassword.id: (context) => const ForgotPassword(),
                booking_screen.BookingScreen.id: (context) =>
                    const booking_screen.BookingScreen(),
                Help.id: (context) => const Help(),
                settings_screen.Settings.id: (context) =>
                    const settings_screen.Settings(),
                AccountDetails.id: (context) => const AccountDetails(),
                NotificationsScreen.id: (context) =>
                    const NotificationsScreen(),
              },
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}

class NotificationController {
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Handle when a notification is created
    print('Notification Created: ${receivedNotification.title}');
  }

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Handle when a notification is displayed
    print('Notification Displayed: ${receivedNotification.title}');
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Handle when a notification is dismissed
    print('Notification Dismissed: ${receivedAction.title}');
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Handle when a notification action is received (e.g., user taps on a notification)
    print('Notification Action Received: ${receivedAction.title}');

    // Perform actions based on the notification here
  }
}
