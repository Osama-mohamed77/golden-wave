import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:golden_wave/firebase_options.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/presentation/AuthManagement/forgot_password.dart';
import 'package:golden_wave/presentation/AuthManagement/sign_in.dart';
import 'package:golden_wave/presentation/AuthManagement/sign_up.dart';
import 'package:golden_wave/presentation/screens/booking_screen.dart'
    as booking_screen;
import 'package:golden_wave/presentation/screens/home.dart' as home;
import 'package:golden_wave/presentation/widgets/nav_bar.dart';
import 'package:golden_wave/provider/auth_provider.dart';
import 'package:golden_wave/provider/booking_provider.dart';
import 'package:golden_wave/provider/history_provider.dart';
import 'package:golden_wave/provider/home_provider.dart';
import 'package:golden_wave/provider/language_provider.dart';
import 'package:golden_wave/provider/page_index_provider.dart';
import 'package:golden_wave/stripe_payment/stripe_keys.dart';
import 'package:golden_wave/utils/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  Stripe.publishableKey = ApiKeys.pusblishablKeys;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final languageProvider = LanguageProvider();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageIndexProvider()),
        ChangeNotifierProvider(create: (_) => AuthProviderOS()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider.value(value: languageProvider),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: const GoldenWave(),
    ),
  );
}

class GoldenWave extends StatelessWidget {
  const GoldenWave({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
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
          },
          home: const SplashScreen(),
        );
      },
    );
  }
}
