import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:golden_wave/constants/my_colors.dart';
import 'package:golden_wave/presentation/screens/booking_screen.dart';
import 'package:golden_wave/provider/booking_provider.dart';
import 'package:golden_wave/provider/home_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static String id = 'Home';

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  Future<void>? _fetchDataFuture;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _fetchDataFuture = _fetchData().then((_) {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  Future<void> _fetchData() async {
    try {
      await Provider.of<HomeProvider>(context, listen: false).fetchData();
    } catch (e) {
      // Handle error if needed
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(103),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.myYellow,
            toolbarHeight: 103,
            title: FutureBuilder<void>(
              future: _fetchDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Row(
                    children: [
                      const Gap(30),
                      const Spacer(
                        flex: 1,
                      ),
                      Center(
                          child: LoadingAnimationWidget.threeArchedCircle(
                        color: Colors.black,
                        size: 30,
                      )),
                      const Spacer(
                        flex: 1,
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                return FadeTransition(
                  opacity: _animation,
                  child: Consumer<HomeProvider>(
                    builder: (context, provider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, ${provider.firstName} 🎶',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'inter',
                            ),
                          ),
                          const Text(
                            'Golden wave is ready to receive you at any time!!',
                            style: TextStyle(
                                fontSize: 14,
                                color: MyColors.myGrey,
                                fontFamily: 'inter',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                color: Colors.black,
                iconSize: 30,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const Gap(20),
          Row(
            children: [
              Container(
                height: 1.5,
                width: 50,
                color: Colors.black,
              ),
              const Text(
                'Sections',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: MyColors.myYellow),
              ),
              Expanded(
                child: Container(
                  height: 1.5,
                  width: 0,
                  color: Colors.black,
                ),
              ),
              const Icon(Icons.code),
              Container(
                height: 1.5,
                width: 20,
                color: Colors.black,
              ),
            ],
          ),
          const Gap(10),
          const SectionTabs(),
          const Gap(20),
          Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height *
                  0.3, // Adjust this to control the minimum height
              maxHeight: MediaQuery.of(context).size.height *
                  0.63, // Adjust this to control the maximum height
            ),
            decoration: BoxDecoration(
              color: const Color(0xffEEEEEE),
              border: Border.all(color: MyColors.myGrey),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const Gap(20),
                Consumer<HomeProvider>(
                  builder: (context, provider, child) {
                    return Center(
                      child: Text(
                        'Services within ${provider.selectedSectionName}',
                        style: const TextStyle(
                          fontFamily: 'inter',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
                const Gap(10),
                const Divider(
                  thickness: 1.5,
                  color: Color(0xff818181),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: Consumer<HomeProvider>(
                      builder: (context, provider, child) {
                        return ServiceList(provider.selectedSectionIndex);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTabs extends StatelessWidget {
  const SectionTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const Gap(10),
          SectionForm(
              title: 'Audio production',
              isSelected: provider.selectedSectionIndex == 0,
              onTap: () {
                provider.showLoading();
                provider.updateSelectedSection(0, 'Audio production');
              }),
          const Gap(10),
          SectionForm(
            title: 'Video production',
            isSelected: provider.selectedSectionIndex == 1,
            onTap: () => provider.updateSelectedSection(1, 'Video production'),
          ),
          const Gap(10),
          SectionForm(
            title: 'Creative writing',
            isSelected: provider.selectedSectionIndex == 2,
            onTap: () => provider.updateSelectedSection(2, 'Creative writing'),
          ),
          const Gap(10),
          SectionForm(
            title: 'Music workshop',
            isSelected: provider.selectedSectionIndex == 3,
            onTap: () => provider.updateSelectedSection(3, 'Music workshop'),
          ),
          const Gap(10),
          SectionForm(
            title: 'Media qualification',
            isSelected: provider.selectedSectionIndex == 4,
            onTap: () =>
                provider.updateSelectedSection(4, 'Media qualification'),
          ),
          const Gap(10),
        ],
      ),
    );
  }
}

class SectionForm extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SectionForm({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 43,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? MyColors.myYellow : MyColors.myGrey,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? MyColors.myYellow : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceList extends StatelessWidget {
  final int sectionIndex;

  const ServiceList(this.sectionIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    List<String> services;
    switch (sectionIndex) {
      case 0:
        services = [
          'Audio Effects',
          'Audiobook Recording',
          'Dubbing',
          'Music production',
          'Soundtrack composing',
          'Music mixing',
          'Music orchestration',
          'Voiceover',
          'IVR',
          'Radio podcast',
        ];
        break;
      case 1:
        services = [
          'Photography',
          'Video recording',
          'Editing',
          'Lighting',
          'Motion graphics',
          'TV programs',
          '2D/3D graphic designs',
          'TV advertisements',
          'Documents and films'
        ];
        break;
      case 2:
        services = [
          'Writing the scenario',
          'Story crafting',
          'Poetry and thoughts',
          'Writing autobiographies',
          'Writing advertisements'
        ];
        break;
      case 4:
        services = [
          'Preparation',
          'Public speaking',
          'Presentation',
          'Editing',
          'Sound engineering',
          'Directing'
        ];
        break;
      default:
        services = [];
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return ServiceCard(services[index]);
      },
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;

  const ServiceCard(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<BookingProvider>(context, listen: false).getTitle(title);

        Navigator.pushNamed(context, BookingScreen.id);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: MyColors.myYellow),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'inter',
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
