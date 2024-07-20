import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/provider/booking_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:golden_wave/presentation/widgets/nav_bar.dart';
import 'package:golden_wave/utils/button.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});
  static const String id = 'BookingScreen';

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);

    // Ensure fullName and reserved times are fetched before using them
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (FirebaseAuth.instance.currentUser != null) {
        await bookingProvider.fetchFullName();
        await bookingProvider.fetchReservedTimes(); // Fetch reserved times
      }
    });

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
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _tableCalendar(bookingProvider),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                    child: Center(
                      child: Text(
                        'Select Consultation Time',
                        style: TextStyle(
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
                      child: const Text(
                        'Weekend is not available, please select another date',
                        style: TextStyle(
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
                        final time = DateTime(
                            bookingProvider.currentDay.year,
                            bookingProvider.currentDay.month,
                            bookingProvider.currentDay.day,
                            index + 9);

                        final bool isReserved = bookingProvider.reservedTimes
                            .any((reservedTime) =>
                                reservedTime.year == time.year &&
                                reservedTime.month == time.month &&
                                reservedTime.day == time.day &&
                                reservedTime.hour == time.hour);

                        // Check if the current time is past the available time slots on the current day
                        final now = DateTime.now();
                        final bool isPastHour =
                            bookingProvider.currentDay.isAtSameMomentAs(now) &&
                                time.isBefore(now);

                        return InkWell(
                          splashColor: Colors.transparent,
                          onTap: isReserved || isPastHour
                              ? null
                              : () {
                                  bookingProvider.updateCurrentIndex(index);
                                },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: bookingProvider.currentIndex == index
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
                              _formatTime(DateTime(
                                  bookingProvider.currentDay.year,
                                  bookingProvider.currentDay.month,
                                  bookingProvider.currentDay.day,
                                  index + 9)),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: bookingProvider.currentIndex == index
                                    ? Colors.white
                                    : (isReserved || isPastHour
                                        ? Colors.black54
                                        : null),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: Button(
                  width: double.infinity,
                  title: 'Appointment confirmation',
                  onPressed: () async {
                    if (bookingProvider.currentIndex != null) {
                      // Create DateTime based on the selected hour
                      DateTime selectedTime = DateTime(
                          bookingProvider.currentDay.year,
                          bookingProvider.currentDay.month,
                          bookingProvider.currentDay.day,
                          bookingProvider.currentIndex! +
                              9); // Add hours to 9 AM

                      try {
                        await bookingProvider.bookAppointment(
                            FirebaseAuth.instance.currentUser!.uid,
                            selectedTime);

                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'Success',
                          desc: 'Appointment booked successfully!',
                          btnOkOnPress: () {
                            Navigator.pushNamed(context, NavBar.id);
                          },
                        ).show();
                      } catch (e) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc:
                              'An error occurred while booking the appointment.',
                          btnOkOnPress: () {},
                        ).show();
                      }
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title: 'Warning',
                        desc: 'Please specify a time!',
                        btnOkOnPress: () {},
                      ).show();
                    }
                  },
                  height: 50,
                  text: 'Appointment confirmation',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12}:00 ${dateTime.hour >= 12 ? 'PM' : 'AM'}';
  }

  Widget _tableCalendar(BookingProvider bookingProvider) {
    return TableCalendar(
      focusedDay: bookingProvider.focusDay,
      firstDay: DateTime.now().subtract(
          const Duration(days: 365)), // Set the first day to a year before now
      lastDay: DateTime.now().add(const Duration(
          days: 365 * 2)), // Set the last day to two years from now
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
        bookingProvider
            .updateCurrentIndex(null); // Reset selected index when date changes
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
