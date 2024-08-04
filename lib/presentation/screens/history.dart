import 'package:flutter/material.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/generated/l10n.dart';
import 'package:golden_wave/provider/history_provider.dart';
import 'package:provider/provider.dart';

class History extends StatefulWidget {
  static String id = 'History';
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    
    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this, // Corrected this line
    );

    // Define the slide animation from right to left

    // Fetch booking data
    Future.microtask(() =>
        Provider.of<HistoryProvider>(context, listen: false).fetchBookingDate());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF0F0F0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
       flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [MyColors.myGrey,MyColors.myYellow, ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Center(
          child: Text(
            S.of(context).bookingHistory,
            style: const TextStyle(
              fontFamily: 'alata',
              fontSize: 23,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
        child: Consumer<HistoryProvider>(
          builder: (context, historyProvider, child) {
            // Start the animation when the widget builds
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _controller.forward();
            });

            return ListView.builder(
              itemCount: historyProvider.bookings.length,
              itemBuilder: (context, index) {
                final booking = historyProvider.bookings[index];

                // Create an animation for each item
                final itemAnimation = Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _controller,
                  curve: Interval(
                    (1 / historyProvider.bookings.length) * index,
                    1.0,
                    curve: Curves.easeInOut,
                  ),
                ));

                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return SlideTransition(
                      position: itemAnimation,
                      child: child,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [Colors.brown,MyColors.myGrey],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.date_range_sharp,
                                  color: MyColors.myWhite),
                              const SizedBox(width: 10),
                              Text(
                                '${S.of(context).bookingDate}: ${booking.bookingDate}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.myWhite,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.music_note,
                                  color: MyColors.myWhite),
                              const SizedBox(width: 10),
                              Text(
                                '${S.of(context).serviceName}: ${booking.serviceName}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.myWhite,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.phone, color: MyColors.myWhite),
                              const SizedBox(width: 10),
                              Text(
                                '${S.of(context).phoneNumber}: ${booking.phoneNumber}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.myWhite,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
