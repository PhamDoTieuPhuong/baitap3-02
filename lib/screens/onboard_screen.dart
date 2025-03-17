import 'package:flutter/material.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Map<String, String>> onboardData = [
    {
      'image': 'assets/images/onboard_1.png',
      'title': 'Easy Time Management',
      'description':
      'With management based on priority and daily tastes, it will give you convenience in managing and determining the tasks that must be done first',
    },
    {
      'image': 'assets/images/onboard_2.png',
      'title': 'Increase Work Effectiveness',
      'description':
      'Time management and the determination of more important tasks will give your job statistics better and always improve',
    },
    {
      'image': 'assets/images/onboard_3.png',
      'title': 'Reminder Notification',
      'description':
      "The advantage of this application is that it also provides reminders for you so you don't forget to keep doing your assignments well and according to the time you have set",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              // Xử lý sự kiện khi nhấn Skip
            },
            child: const Text('Skip'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardData.length,
              physics: const BouncingScrollPhysics(), // Hiệu ứng vuốt trang
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return _buildPage(index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0), // Padding tương tự cho cả trang đầu và các trang sau
            child: _currentPage == 0
                ? ElevatedButton( // Trang đầu chỉ có nút Next
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: StadiumBorder(),
                minimumSize: const Size(150, 48),
              ),
              child: const Text('Next', style: TextStyle(color: Colors.white)),
            )
                : _buildNavigation(), // Các trang sau có nút điều hướng
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          onboardData[index]['image']!,
          width: 200,
          height: 200,
        ),
        const SizedBox(height: 20),
        Text(
          onboardData[index]['title']!,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            onboardData[index]['description']!,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (_currentPage > 0)
          ElevatedButton(
            onPressed: () {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16.0),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ElevatedButton(
          onPressed: () {
            if (_currentPage < onboardData.length - 1) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            } else {
              // Xử lý sự kiện khi đến trang cuối cùng và nhấn Get Started
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: StadiumBorder(),
            minimumSize: const Size(150, 48),
          ),
          child: Text(_currentPage < onboardData.length - 1 ? 'Next' : 'Get Started', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}