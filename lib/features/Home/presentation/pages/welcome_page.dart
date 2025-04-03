import 'dart:async';
import 'package:chambas/components/footer.dart';
import 'package:chambas/features/Auth/presentation/pages/auth_page.dart';
import 'package:chambas/features/Business_Account/presentation/pages/business_account_page.dart';
import 'package:chambas/features/Home/presentation/pages/home_page.dart';
import 'package:chambas/features/Premium_user/presentation/pages/premium_plans_page.dart';
import 'package:chambas/features/Premium_user/presentation/pages/premium_user_page.dart';
import 'package:flutter/material.dart';
import 'package:chambas/features/Home/presentation/components/home_drawer.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // Original images
  final List<String> _realImages = [
    'assets/images/developer.jpg',
    'assets/images/painting.jpg',
    'assets/images/interiordesigner.jpg',
    'assets/images/hometutor.jpg',
    'assets/images/wallpainting.jpg',
    'assets/images/tvmounting.jpg',
    'assets/images/cleaner.jpg',
    'assets/images/wallfixing.jpg',
  ];

  // Extended list for infinite loop
  late final List<String> _extendedImages;
  late final PageController _pageController;
  Timer? _carouselTimer;

  int _currentIndex = 1;

  int get _realLength => _realImages.length;
  int get _extendedLength => _realLength + 2;

  final List<Map<String, String>> popularServices = [
    {
      'image': 'assets/images/developer.jpg',
      'title': 'Developer for simple App',
      'subtitle': 'Projects starting at \$67',
    },
    {
      'image': 'assets/images/painter.jpg',
      'title': 'Aesthetic Painting',
      'subtitle': 'Projects starting at \$55',
    },
    {
      'image': 'assets/images/interiordesigner.jpg',
      'title': 'Interior Designer',
      'subtitle': 'Projects starting at \$65',
    },
    {
      'image': 'assets/images/hometutor.jpg',
      'title': 'Home tutor for kids',
      'subtitle': 'Projects starting at \$67',
    },
    {
      'image': 'assets/images/wallpainting.jpg',
      'title': 'Indoor wall painting',
      'subtitle': 'Projects starting at \$67',
    },
    {
      'image': 'assets/images/tvmounting.jpg',
      'title': 'Mount a TV, Art or Shelves',
      'subtitle': 'Projects starting at \$56',
    },
    {
      'image': 'assets/images/cleaner.jpg',
      'title': 'Home & Apartment Cleaning',
      'subtitle': 'Projects starting at \$40',
    },
    {
      'image': 'assets/images/carpentry.jpg',
      'title': 'Carpenter',
      'subtitle': 'Projects starting at \$65',
    },
    {
      'image': 'assets/images/electrician.jpg',
      'title': 'Electrician',
      'subtitle': 'Projects starting at \$40',
    },
    {
      'image': 'assets/images/wallfixing.jpg',
      'title': 'Wall fixing',
      'subtitle': 'Projects starting at \$40',
    },
  ];

  @override
  void initState() {
    super.initState();

    _extendedImages = [
      _realImages.last,
      ..._realImages,
      _realImages.first,
    ];

    _pageController = PageController(initialPage: 1);

    // Auto-scroll every 5s
    _carouselTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _autoScroll();
    });
  }

  void _autoScroll() {
    final nextIndex = _currentIndex + 1;
    if (nextIndex > _realLength) {
      _currentIndex = 1;
      _pageController.jumpToPage(1);
    } else {
      _currentIndex = nextIndex;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'CHAMBAS',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        actions: [
          // circular image
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ClipOval(
              child: Image.asset(
                'assets/images/carpentry.jpg',
                height: 50,
                width: 50, //width same as height for a perfect circle
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
      drawer: const HomeDrawer(),

      // Wrap everything in LayoutBuilder for responsive decisions
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;

          // 1) banner height
          //    For bigger screens 400 or 500
          double bannerHeight = 300;
          if (maxWidth >= 1000) {
            bannerHeight = 500; // Large desktop
          } else if (maxWidth >= 600) {
            bannerHeight = 400; // Tablet
          }

          // columns for the popular services
          //    and child aspect ratio
          int crossAxisCount;
          double childAspectRatio;
          if (maxWidth >= 1200) {
            crossAxisCount = 5;
            childAspectRatio = 0.9;
          } else if (maxWidth >= 800) {
            crossAxisCount = 4;
            childAspectRatio = 0.8;
          } else if (maxWidth >= 600) {
            crossAxisCount = 3;
            childAspectRatio = 0.7;
          } else {
            crossAxisCount = 2;
            childAspectRatio = 0.7;
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                //Banner with infinite carousel
                SizedBox(
                  height: bannerHeight,
                  child: Stack(
                    children: [
                      // Carousel background
                      PageView.builder(
                        controller: _pageController,
                        itemCount: _extendedLength,
                        onPageChanged: (index) {
                          _currentIndex = index;
                          if (index == 0) {
                            Future.microtask(() {
                              _pageController.jumpToPage(_realLength);
                            });
                          } else if (index == _extendedLength - 1) {
                            Future.microtask(() {
                              _pageController.jumpToPage(1);
                            });
                          }
                        },
                        itemBuilder: (context, index) {
                          final imagePath = _extendedImages[index];
                          return Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        },
                      ),

                      // optional overlay
                      Container(
                        color: Colors.black.withOpacity(0.3),
                      ),

                      // Banner text + buttons
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Get help with tasks',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 8.0),
                                const Text(
                                  'Book trusted Taskers nearby for any job you need done.',
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AuthPage(),
                                      ),
                                    );
                                  },
                                  child: const Text('Post a Task'),
                                ),
                                const SizedBox(height: 8.0),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomePage(),
                                      ),
                                    );
                                  },
                                  child: const Text('Browse all posts'),
                                ),
                                const SizedBox(height: 8.0),
                                ElevatedButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const PremiumPlansPage()),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 227, 226, 227)),
                                  child: const Text('Go Premium'),
                                ),
                                const SizedBox(height: 8.0),
                                ElevatedButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BusinessAccountPage()),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 227, 226, 227)),
                                  child: const Text('Business Account'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Extra vertical space before the highlight
                const SizedBox(height: 40),

                // Highlighted heading container
                Container(
                  width: double.infinity,
                  color: Colors.blueGrey.shade50, // subtle highlight background
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: const Color.fromARGB(255, 152, 140, 211),
                      ),
                      Icon(
                        Icons.star,
                        color: const Color.fromARGB(255, 152, 140, 211),
                      ),
                      Icon(
                        Icons.star,
                        color: const Color.fromARGB(255, 152, 140, 211),
                      ),
                      Icon(
                        Icons.star,
                        color: const Color.fromARGB(255, 152, 140, 211),
                      ),
                      Icon(
                        Icons.star,
                        color: const Color.fromARGB(255, 152, 140, 211),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Popular Services',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8.0),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: popularServices.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemBuilder: (context, index) {
                    final service = popularServices[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.asset(
                                service['image']!,
                                fit: BoxFit.cover,
                                height: 100,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                service['title'] ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                service['subtitle'] ?? '',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Extra vertical space before the highlight
                const SizedBox(height: 40),

                //Highlighted heading container
                Container(
                  width: double.infinity,
                  color: Colors.blueGrey.shade50, // subtle highlight background
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: const Color.fromARGB(255, 152, 140, 211),
                      ),
                      Icon(
                        Icons.star,
                        color: const Color.fromARGB(255, 152, 140, 211),
                      ),
                      Icon(
                        Icons.star,
                        color: const Color.fromARGB(255, 152, 140, 211),
                      ),
                      Icon(
                        Icons.star,
                        color: const Color.fromARGB(255, 152, 140, 211),
                      ),
                      Icon(
                        Icons.star,
                        color: const Color.fromARGB(255, 152, 140, 211),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Recommended Taskers',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8.0),
                SizedBox(
                  height: 160.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 140,
                        margin: const EdgeInsets.only(left: 16.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Icon(Icons.person, size: 40),
                            ),
                            const SizedBox(height: 8.0),
                            Text('Tasker ${index + 1}'),
                            Text('⭐ 4.${index + 1}/5'),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24.0),
                // Footer
                const FooterWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
