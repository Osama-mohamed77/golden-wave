// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Overview`
  String get Overview {
    return Intl.message(
      'Overview',
      name: 'Overview',
      desc: '',
      args: [],
    );
  }

  /// `We started from Dammam on 4/13/1440 with a commitment to high-quality visual and audio media production. Our elite team uses modern technology to deliver innovative solutions and execute media projects with integrity, tailored to the needs of our audience.`
  String get overviewHint {
    return Intl.message(
      'We started from Dammam on 4/13/1440 with a commitment to high-quality visual and audio media production. Our elite team uses modern technology to deliver innovative solutions and execute media projects with integrity, tailored to the needs of our audience.',
      name: 'overviewHint',
      desc: '',
      args: [],
    );
  }

  /// `Audio production`
  String get AudioTitel {
    return Intl.message(
      'Audio production',
      name: 'AudioTitel',
      desc: '',
      args: [],
    );
  }

  /// `We deliver top-quality audio experiences through unique technologies and expert voice artists. Our services cover audio engineering, audiobook and poetry recording, dubbing, podcasting, music and artistic recordings, wedding zaffa, voice-over, IVR, and cinematic music composition.`
  String get AudioHint {
    return Intl.message(
      'We deliver top-quality audio experiences through unique technologies and expert voice artists. Our services cover audio engineering, audiobook and poetry recording, dubbing, podcasting, music and artistic recordings, wedding zaffa, voice-over, IVR, and cinematic music composition.',
      name: 'AudioHint',
      desc: '',
      args: [],
    );
  }

  /// `Video production`
  String get VideoTitel {
    return Intl.message(
      'Video production',
      name: 'VideoTitel',
      desc: '',
      args: [],
    );
  }

  /// `We provide comprehensive video production services, transforming clients’ visions into creative and engaging visual works with advanced talents and techniques. Our services include photography, video recording, editing, lighting, motion graphics, TV programs, commercials, visual effects, graphic design, and 2D/3D documentaries and films.`
  String get VideoHint {
    return Intl.message(
      'We provide comprehensive video production services, transforming clients’ visions into creative and engaging visual works with advanced talents and techniques. Our services include photography, video recording, editing, lighting, motion graphics, TV programs, commercials, visual effects, graphic design, and 2D/3D documentaries and films.',
      name: 'VideoHint',
      desc: '',
      args: [],
    );
  }

  /// `Creative writing`
  String get writingTitel {
    return Intl.message(
      'Creative writing',
      name: 'writingTitel',
      desc: '',
      args: [],
    );
  }

  /// `We strive to provide distinguished and engaging content that effectively delivers the intended message to the target audience. Our creative writing services include poetry and prose composition, scriptwriting, story and novel writing, biography writing, and ad writing.`
  String get writingHint {
    return Intl.message(
      'We strive to provide distinguished and engaging content that effectively delivers the intended message to the target audience. Our creative writing services include poetry and prose composition, scriptwriting, story and novel writing, biography writing, and ad writing.',
      name: 'writingHint',
      desc: '',
      args: [],
    );
  }

  /// `Music workshop`
  String get MusicTitel {
    return Intl.message(
      'Music workshop',
      name: 'MusicTitel',
      desc: '',
      args: [],
    );
  }

  /// `We see music education as an inspiring journey. Our skilled professionals offer personalized instruction in instrument learning, music production, and arrangement. Whether you’re a beginner or experienced, we aim to help you achieve your musical goals and artistic aspirations.`
  String get MusicHint {
    return Intl.message(
      'We see music education as an inspiring journey. Our skilled professionals offer personalized instruction in instrument learning, music production, and arrangement. Whether you’re a beginner or experienced, we aim to help you achieve your musical goals and artistic aspirations.',
      name: 'MusicHint',
      desc: '',
      args: [],
    );
  }

  /// `Media qualification`
  String get MediaTitel {
    return Intl.message(
      'Media qualification',
      name: 'MediaTitel',
      desc: '',
      args: [],
    );
  }

  /// `We recognize the impact of media on shaping society. Our specialized training programs, led by experts and academics, help individuals develop media skills in areas like preparation, presentation, hosting, editing, audio engineering, and directing.`
  String get MediaHint {
    return Intl.message(
      'We recognize the impact of media on shaping society. Our specialized training programs, led by experts and academics, help individuals develop media skills in areas like preparation, presentation, hosting, editing, audio engineering, and directing.',
      name: 'MediaHint',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get Skip {
    return Intl.message(
      'Skip',
      name: 'Skip',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get GetStarted {
    return Intl.message(
      'Get Started',
      name: 'GetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Golden wave`
  String get LogoTitel {
    return Intl.message(
      'Golden wave',
      name: 'LogoTitel',
      desc: '',
      args: [],
    );
  }

  /// `Media innovators`
  String get LogoHint {
    return Intl.message(
      'Media innovators',
      name: 'LogoHint',
      desc: '',
      args: [],
    );
  }

  /// `Please login to use the app`
  String get loginHint {
    return Intl.message(
      'Please login to use the app',
      name: 'loginHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get emptyEmail {
    return Intl.message(
      'Enter your email',
      name: 'emptyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get validEmail {
    return Intl.message(
      'Enter a valid email',
      name: 'validEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get hintEmail {
    return Intl.message(
      'Enter your email',
      name: 'hintEmail',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get labelEmail {
    return Intl.message(
      'Email',
      name: 'labelEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get emptyPassword {
    return Intl.message(
      'Please enter your password',
      name: 'emptyPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid password`
  String get validPassword {
    return Intl.message(
      'Enter a valid password',
      name: 'validPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get hintPassword {
    return Intl.message(
      'Enter your password',
      name: 'hintPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get labelPassword {
    return Intl.message(
      'Password',
      name: 'labelPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotText {
    return Intl.message(
      'Forgot password?',
      name: 'forgotText',
      desc: '',
      args: [],
    );
  }

  /// `Verify account!`
  String get verifyTitel {
    return Intl.message(
      'Verify account!',
      name: 'verifyTitel',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your account to log in!`
  String get verifyDes {
    return Intl.message(
      'Please verify your account to log in!',
      name: 'verifyDes',
      desc: '',
      args: [],
    );
  }

  /// `Sign-in Error`
  String get signInErrorTitel {
    return Intl.message(
      'Sign-in Error',
      name: 'signInErrorTitel',
      desc: '',
      args: [],
    );
  }

  /// `Wrong email or password`
  String get signInErrorDes {
    return Intl.message(
      'Wrong email or password',
      name: 'signInErrorDes',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signInButton {
    return Intl.message(
      'Sign in',
      name: 'signInButton',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get askForSignUp {
    return Intl.message(
      'Don’t have an account?',
      name: 'askForSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUpText {
    return Intl.message(
      'Sign up',
      name: 'signUpText',
      desc: '',
      args: [],
    );
  }

  /// `Forgot\npassword`
  String get forgotScreenTitel {
    return Intl.message(
      'Forgot\npassword',
      name: 'forgotScreenTitel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address below, and we will send a password reset link to your inbox.`
  String get fogotScreenDes {
    return Intl.message(
      'Please enter your email address below, and we will send a password reset link to your inbox.',
      name: 'fogotScreenDes',
      desc: '',
      args: [],
    );
  }

  /// `Email not found`
  String get notFound {
    return Intl.message(
      'Email not found',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get Success {
    return Intl.message(
      'Success',
      name: 'Success',
      desc: '',
      args: [],
    );
  }

  /// `Password reset link sent! Check your email`
  String get sendLink {
    return Intl.message(
      'Password reset link sent! Check your email',
      name: 'sendLink',
      desc: '',
      args: [],
    );
  }

  /// `Email not found. Please check your email address and try again.`
  String get emailNotFoundDes {
    return Intl.message(
      'Email not found. Please check your email address and try again.',
      name: 'emailNotFoundDes',
      desc: '',
      args: [],
    );
  }

  /// `Failed to send reset link. Please check your email address and try again.`
  String get failedSendLink {
    return Intl.message(
      'Failed to send reset link. Please check your email address and try again.',
      name: 'failedSendLink',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get Error {
    return Intl.message(
      'Error',
      name: 'Error',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while creating the account`
  String get ErrorDes {
    return Intl.message(
      'An error occurred while creating the account',
      name: 'ErrorDes',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get sendText {
    return Intl.message(
      'Send',
      name: 'sendText',
      desc: '',
      args: [],
    );
  }

  /// `Create new\nAccount`
  String get signUpTitel {
    return Intl.message(
      'Create new\nAccount',
      name: 'signUpTitel',
      desc: '',
      args: [],
    );
  }

  /// `Please type full information below and we can create your account`
  String get signUpHint {
    return Intl.message(
      'Please type full information below and we can create your account',
      name: 'signUpHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get emptyName {
    return Intl.message(
      'Enter your name',
      name: 'emptyName',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid name`
  String get validName {
    return Intl.message(
      'Enter a valid name',
      name: 'validName',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get labelName {
    return Intl.message(
      'Full name',
      name: 'labelName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your confirm password`
  String get emptyConfirm {
    return Intl.message(
      'Enter your confirm password',
      name: 'emptyConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Not match`
  String get notMatchConfirm {
    return Intl.message(
      'Not match',
      name: 'notMatchConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get labelConfirm {
    return Intl.message(
      'Confirm password',
      name: 'labelConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Hi`
  String get hi {
    return Intl.message(
      'Hi',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Golden wave is ready to receive you at any time!`
  String get appBarHint {
    return Intl.message(
      'Golden wave is ready to receive you at any time!',
      name: 'appBarHint',
      desc: '',
      args: [],
    );
  }

  /// `Sections`
  String get Sections {
    return Intl.message(
      'Sections',
      name: 'Sections',
      desc: '',
      args: [],
    );
  }

  /// `Audio production`
  String get homeAudio {
    return Intl.message(
      'Audio production',
      name: 'homeAudio',
      desc: '',
      args: [],
    );
  }

  /// `Video production`
  String get homeVideo {
    return Intl.message(
      'Video production',
      name: 'homeVideo',
      desc: '',
      args: [],
    );
  }

  /// `Creative writing`
  String get homewriting {
    return Intl.message(
      'Creative writing',
      name: 'homewriting',
      desc: '',
      args: [],
    );
  }

  /// `Music workshop`
  String get homeMusic {
    return Intl.message(
      'Music workshop',
      name: 'homeMusic',
      desc: '',
      args: [],
    );
  }

  /// `Media qualification`
  String get homeMedia {
    return Intl.message(
      'Media qualification',
      name: 'homeMedia',
      desc: '',
      args: [],
    );
  }

  /// `Audio effects`
  String get AudioEffects {
    return Intl.message(
      'Audio effects',
      name: 'AudioEffects',
      desc: '',
      args: [],
    );
  }

  /// `Audiobook recording`
  String get AudiobookRecording {
    return Intl.message(
      'Audiobook recording',
      name: 'AudiobookRecording',
      desc: '',
      args: [],
    );
  }

  /// `Dubbing`
  String get Dubbing {
    return Intl.message(
      'Dubbing',
      name: 'Dubbing',
      desc: '',
      args: [],
    );
  }

  /// `Music production`
  String get MusicProduction {
    return Intl.message(
      'Music production',
      name: 'MusicProduction',
      desc: '',
      args: [],
    );
  }

  /// `Soundtrack composing`
  String get SoundtrackComposing {
    return Intl.message(
      'Soundtrack composing',
      name: 'SoundtrackComposing',
      desc: '',
      args: [],
    );
  }

  /// `Music mixing`
  String get MusicMixing {
    return Intl.message(
      'Music mixing',
      name: 'MusicMixing',
      desc: '',
      args: [],
    );
  }

  /// `Music orchestration`
  String get MusicOrchestration {
    return Intl.message(
      'Music orchestration',
      name: 'MusicOrchestration',
      desc: '',
      args: [],
    );
  }

  /// `Voiceover`
  String get voiceover {
    return Intl.message(
      'Voiceover',
      name: 'voiceover',
      desc: '',
      args: [],
    );
  }

  /// `IVR`
  String get IVR {
    return Intl.message(
      'IVR',
      name: 'IVR',
      desc: '',
      args: [],
    );
  }

  /// `Radio podcast`
  String get RadioPodcast {
    return Intl.message(
      'Radio podcast',
      name: 'RadioPodcast',
      desc: '',
      args: [],
    );
  }

  /// `Photography`
  String get Photography {
    return Intl.message(
      'Photography',
      name: 'Photography',
      desc: '',
      args: [],
    );
  }

  /// `Video recording`
  String get VideoRecording {
    return Intl.message(
      'Video recording',
      name: 'VideoRecording',
      desc: '',
      args: [],
    );
  }

  /// `Montage`
  String get Montage {
    return Intl.message(
      'Montage',
      name: 'Montage',
      desc: '',
      args: [],
    );
  }

  /// `Lighting`
  String get Lighting {
    return Intl.message(
      'Lighting',
      name: 'Lighting',
      desc: '',
      args: [],
    );
  }

  /// `Motion graphics`
  String get MotionGraphics {
    return Intl.message(
      'Motion graphics',
      name: 'MotionGraphics',
      desc: '',
      args: [],
    );
  }

  /// `TV programs`
  String get TVPrograms {
    return Intl.message(
      'TV programs',
      name: 'TVPrograms',
      desc: '',
      args: [],
    );
  }

  /// `2D/3D graphic designs`
  String get GraphicDesigns {
    return Intl.message(
      '2D/3D graphic designs',
      name: 'GraphicDesigns',
      desc: '',
      args: [],
    );
  }

  /// `TV advertisements`
  String get TVAdvertisements {
    return Intl.message(
      'TV advertisements',
      name: 'TVAdvertisements',
      desc: '',
      args: [],
    );
  }

  /// `Documents and films`
  String get DocumentsAndFilms {
    return Intl.message(
      'Documents and films',
      name: 'DocumentsAndFilms',
      desc: '',
      args: [],
    );
  }

  /// `Writing the scenario`
  String get ScenarioWriting {
    return Intl.message(
      'Writing the scenario',
      name: 'ScenarioWriting',
      desc: '',
      args: [],
    );
  }

  /// `Story crafting`
  String get StoryCrafting {
    return Intl.message(
      'Story crafting',
      name: 'StoryCrafting',
      desc: '',
      args: [],
    );
  }

  /// `Poetry and thoughts`
  String get PoetryAndThoughts {
    return Intl.message(
      'Poetry and thoughts',
      name: 'PoetryAndThoughts',
      desc: '',
      args: [],
    );
  }

  /// `Writing autobiographies`
  String get Autobiographies {
    return Intl.message(
      'Writing autobiographies',
      name: 'Autobiographies',
      desc: '',
      args: [],
    );
  }

  /// `Writing advertisements`
  String get AdWriting {
    return Intl.message(
      'Writing advertisements',
      name: 'AdWriting',
      desc: '',
      args: [],
    );
  }

  /// `Preparation`
  String get Preparation {
    return Intl.message(
      'Preparation',
      name: 'Preparation',
      desc: '',
      args: [],
    );
  }

  /// `Public speaking`
  String get PublicSpeaking {
    return Intl.message(
      'Public speaking',
      name: 'PublicSpeaking',
      desc: '',
      args: [],
    );
  }

  /// `Presentation`
  String get Presentation {
    return Intl.message(
      'Presentation',
      name: 'Presentation',
      desc: '',
      args: [],
    );
  }

  /// `Editing`
  String get Editing {
    return Intl.message(
      'Editing',
      name: 'Editing',
      desc: '',
      args: [],
    );
  }

  /// `Sound engineering`
  String get SoundEngineering {
    return Intl.message(
      'Sound engineering',
      name: 'SoundEngineering',
      desc: '',
      args: [],
    );
  }

  /// `Directing`
  String get Directing {
    return Intl.message(
      'Directing',
      name: 'Directing',
      desc: '',
      args: [],
    );
  }

  /// `Services within`
  String get ServicesWithin {
    return Intl.message(
      'Services within',
      name: 'ServicesWithin',
      desc: '',
      args: [],
    );
  }

  /// `Please select the section to view our services`
  String get titelForSelectSection {
    return Intl.message(
      'Please select the section to view our services',
      name: 'titelForSelectSection',
      desc: '',
      args: [],
    );
  }

  /// `Please select a section above`
  String get hintForSelectSection {
    return Intl.message(
      'Please select a section above',
      name: 'hintForSelectSection',
      desc: '',
      args: [],
    );
  }

  /// `Pay Now`
  String get AppointmentButton {
    return Intl.message(
      'Pay Now',
      name: 'AppointmentButton',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while booking the appointment.`
  String get errorWhenBooking {
    return Intl.message(
      'An error occurred while booking the appointment.',
      name: 'errorWhenBooking',
      desc: '',
      args: [],
    );
  }

  /// `Appointment booked successfully!`
  String get booked {
    return Intl.message(
      'Appointment booked successfully!',
      name: 'booked',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get Warning {
    return Intl.message(
      'Warning',
      name: 'Warning',
      desc: '',
      args: [],
    );
  }

  /// `Please specify a time!`
  String get specifyATime {
    return Intl.message(
      'Please specify a time!',
      name: 'specifyATime',
      desc: '',
      args: [],
    );
  }

  /// `Weekend is not available, please select another date`
  String get WeekendText {
    return Intl.message(
      'Weekend is not available, please select another date',
      name: 'WeekendText',
      desc: '',
      args: [],
    );
  }

  /// `Select Booking Time`
  String get selectTime {
    return Intl.message(
      'Select Booking Time',
      name: 'selectTime',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get labelPhone {
    return Intl.message(
      'Phone number',
      name: 'labelPhone',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Phone Number`
  String get emptyPhone {
    return Intl.message(
      'Enter Your Phone Number',
      name: 'emptyPhone',
      desc: '',
      args: [],
    );
  }

  /// `Booking history`
  String get bookingHistory {
    return Intl.message(
      'Booking history',
      name: 'bookingHistory',
      desc: '',
      args: [],
    );
  }

  /// `Booking Date`
  String get bookingDate {
    return Intl.message(
      'Booking Date',
      name: 'bookingDate',
      desc: '',
      args: [],
    );
  }

  /// `Service name`
  String get serviceName {
    return Intl.message(
      'Service name',
      name: 'serviceName',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Account details`
  String get accountDetails {
    return Intl.message(
      'Account details',
      name: 'accountDetails',
      desc: '',
      args: [],
    );
  }

  /// `log out`
  String get logout {
    return Intl.message(
      'log out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to log out`
  String get askToLogOut {
    return Intl.message(
      'Do you want to log out',
      name: 'askToLogOut',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Changes have been saved successfully`
  String get changesDone {
    return Intl.message(
      'Changes have been saved successfully',
      name: 'changesDone',
      desc: '',
      args: [],
    );
  }

  /// `Email already exists`
  String get exists {
    return Intl.message(
      'Email already exists',
      name: 'exists',
      desc: '',
      args: [],
    );
  }

  /// `You haven’t received any notifications`
  String get noNotifications {
    return Intl.message(
      'You haven’t received any notifications',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  get existDes => null;

  
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
