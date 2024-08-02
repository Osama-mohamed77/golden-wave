import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/presentation/widgets/error_message.dart';
import 'package:golden_wave/provider/booking_provider.dart';
import 'package:golden_wave/provider/language_provider.dart'; // Import LanguageProvider
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:golden_wave/presentation/widgets/nav_bar.dart';
import 'package:golden_wave/utils/button.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});
  static const String id = 'BookingScreen';

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  bool _initialized = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (FirebaseAuth.instance.currentUser != null) {
        final bookingProvider =
            Provider.of<BookingProvider>(context, listen: false);
        await bookingProvider.fetchReservedTimes();
        if (!_initialized) {
          bookingProvider.updateCurrentIndex(
              null); 
          setState(() {
            _initialized = true;
            _loading = false; 
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: MyColors.myWhite,
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: Consumer<BookingProvider>(
          builder: (context, value, child) => Row(
            children: [
              const Spacer(),
              Text(
                value.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'inter',
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: _loading
            ? _buildShimmer()
            : CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _tableCalendar(bookingProvider),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 25),
                          child: Center(
                            child: Text(
                              S.of(context).selectTime,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  bookingProvider.isWeekend
                      ? SliverToBoxAdapter(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 30,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              S.of(context).WeekendText,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      : SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final now = DateTime.now();
                              final selectedDay = bookingProvider.currentDay;
                              final time = DateTime(
                                  selectedDay.year,
                                  selectedDay.month,
                                  selectedDay.day,
                                  index + 9);

                              final bool isReserved = bookingProvider
                                  .reservedTimes
                                  .any((reservedTime) =>
                                      reservedTime.year == time.year &&
                                      reservedTime.month == time.month &&
                                      reservedTime.day == time.day &&
                                      reservedTime.hour == time.hour);

                              final bool isPastHour =
                                  (selectedDay.year == now.year &&
                                      selectedDay.month == now.month &&
                                      selectedDay.day == now.day &&
                                      time.isBefore(now));

                              return InkWell(
                                splashColor: Colors.transparent,
                                onTap: isReserved || isPastHour
                                    ? null
                                    : () {
                                        bookingProvider
                                            .updateCurrentIndex(index);
                                      },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          bookingProvider.currentIndex == index
                                              ? Colors.white
                                              : MyColors.myYellow,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                    color: isReserved || isPastHour
                                        ? Colors.grey
                                        : (bookingProvider.currentIndex == index
                                            ? MyColors.myYellow
                                            : null),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    _formatTime(
                                        time, languageProvider.language),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          bookingProvider.currentIndex == index
                                              ? Colors.white
                                              : (isReserved || isPastHour
                                                  ? MyColors.myWhite
                                                  : null),
                                      decoration: isReserved || isPastHour
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: 10,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 1.5,
                          ),
                        ),
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 40),
                      child: Button(
                        width: double.infinity,
                        title: S.of(context).AppointmentButton,
                        onPressed: () async {
                          if (bookingProvider.currentIndex != null) {
                            DateTime selectedTime = DateTime(
                                bookingProvider.currentDay.year,
                                bookingProvider.currentDay.month,
                                bookingProvider.currentDay.day,
                                bookingProvider.currentIndex! + 9);

                            try {
                              await bookingProvider.bookAppointment(
                                  FirebaseAuth.instance.currentUser!.uid,
                                  selectedTime);

                              showMessage(context,
                                  title: S.of(context).Success,
                                  desText: S.of(context).booked,
                                  icon: Icons.done_all_outlined,
                                  iconColor: Colors.green,
                                  backgroundColor: MyColors.myGrey,
                                  textColor: Colors.black,
                                  alignment: Alignment.topLeft);

                              Navigator.pushNamed(context, NavBar.id);
                            } catch (e) {
                              showMessage(context,
                                  title: S.of(context).Error,
                                  desText: S.of(context).errorWhenBooking,
                                  icon: Icons.error,
                                  iconColor: Colors.red,
                                  backgroundColor: MyColors.myGrey,
                                  textColor: Colors.black,
                                  alignment: Alignment.topCenter);
                            }
                          } else {
                            showMessage(context,
                                title: S.of(context).Error,
                                desText: S.of(context).specifyATime,
                                icon: Icons.info,
                                iconColor: Colors.black,
                                backgroundColor: MyColors.myYellow,
                                textColor: Colors.black,
                                alignment: Alignment.topCenter);
                          }
                        },
                        height: 50,
                        text: S.of(context).AppointmentButton,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildShimmer() {
    return ListView(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 200,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 50,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 50,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime, String language) {
    if (language == 'en') {
      return '${dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12}:00 ${dateTime.hour >= 12 ? 'PM' : 'AM'}';
    } else if (language == 'ar') {
      return '${dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12}:00 ${dateTime.hour >= 12 ? 'م' : 'ص'}';
    }
    return '${dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12}:00 ${dateTime.hour >= 12 ? 'PM' : 'AM'}'; // Default to 'en' if language is unknown
  }

  Widget _tableCalendar(BookingProvider bookingProvider) {
    final now = DateTime.now();

    return TableCalendar(
      focusedDay: bookingProvider.focusDay.isBefore(now)
          ? now
          : bookingProvider.focusDay,
      firstDay: now,
      lastDay: now.add(const Duration(days: 365 * 2)),
      calendarFormat: bookingProvider.format,
      currentDay: bookingProvider.currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: MyColors.myYellow,
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(
          color: Colors.black,
        ),
        selectedDecoration: BoxDecoration(
          color: MyColors.myYellow,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(
          color: Colors.black,
        ),
        weekendTextStyle: TextStyle(
          color: Colors.black,
        ),
        defaultTextStyle: TextStyle(
          color: Colors.black,
        ),
      ),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
        bookingProvider.updateFormat(format);
      },
      onDaySelected: (selectedDay, focusedDay) {
        bookingProvider.updateFocusDay(focusedDay);
        bookingProvider.updateCurrentDay(selectedDay);
        // Reset selected index only if it is not initialized
        if (_initialized) {
          bookingProvider.updateCurrentIndex(null);
        }
      },
      onPageChanged: (focusedDay) {
        final now = DateTime.now();
        if (focusedDay.isBefore(now)) {
          // Allow navigating to previous months
          bookingProvider.updateFocusDay(focusedDay);
        } else {
          // Allow navigating to future months
          bookingProvider.updateFocusDay(focusedDay);
        }
      },
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, focusedDay) {
          final bool isAllSlotsBooked = bookingProvider.isAllSlotsBooked(date);

          return Container(
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: isAllSlotsBooked ? Colors.grey : null,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  color: isAllSlotsBooked ? Colors.white : Colors.black,
                  decoration: isAllSlotsBooked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
