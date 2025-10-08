import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Screens/Welcom/onboarding.dart';

class OnboardingService with ChangeNotifier {
  bool _isOnboardingComplete = false;

  bool get isOnboardingComplete => _isOnboardingComplete;

  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      image: "assets/images/o_first.jpg",
      text: "WELCOM TO KAL",
      description: "Kal Company General Trading and International Transportation Company",
    ),
    OnboardingItem(
      image: "assets/images/o_second.jpg",
      text: "WHAT WE CAN DO",
      description: "proxy in China, Transportation, interpreters, Remittances, Transportation, Metric transfer",
    ),
    OnboardingItem(
      image: "assets/images/o_third.jpg",
      text: "THROUGH OUR SERVICES",
      description: "You can monitor the transportation of your goods",
    ),
  ];

  Future<void> initOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    _isOnboardingComplete = prefs.getBool("isOnboardingComplete") ?? false;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isOnboardingComplete", true);
    _isOnboardingComplete = true;
    notifyListeners();
  }

  Future<void> setOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isOnboardingComplete", true);
    _isOnboardingComplete = true;
    notifyListeners();
  }

  int _currentPage = 0;

  int get currentPage => _currentPage;

  void setPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void nextPage(PageController pageController) {
    if (_currentPage < 2) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
