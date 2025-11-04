import 'package:flutter/material.dart';
import 'package:x_express/core/config/network/network.dart';
import 'package:x_express/features/home/advertisement/advertisement_detail.dart';
import 'dart:async';

class AdvertisementModel {
  final String id;
  final String title;
  final String type;
  final String? description;
  final String? url;
  final String image;

  AdvertisementModel({
    required this.id,
    required this.title,
    required this.type,
    this.description,
    this.url,
    required this.image,
  });

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) {
    return AdvertisementModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      description: json['description'],
      url: json['url'],
      image: json['image'] ?? '',
    );
  }
}

class Advertisement extends StatefulWidget {
  const Advertisement({super.key});

  @override
  State<Advertisement> createState() => _AdvertisementState();
}

class _AdvertisementState extends State<Advertisement> {
  List<AdvertisementModel> advertisements = [];
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _loadAdvertisements();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadAdvertisements() async {
    try {
      final response = await Request.get('advertisements');
      if (response != null && response['data'] != null) {
        final List<dynamic> data = response['data'];
        setState(() {
          advertisements = data
              .map((json) => AdvertisementModel.fromJson(json))
              .toList();
        });
        if (advertisements.isNotEmpty && advertisements.length > 1) {
          _startAutoScroll();
        }
      }
    } catch (e) {
      print('Error loading advertisements: $e');
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_pageController.hasClients && advertisements.isNotEmpty) {
        _currentPage = (_currentPage + 1) % advertisements.length;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (advertisements.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.all(16),
      height: 170,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: advertisements.length,
            itemBuilder: (context, index) {
              final ad = advertisements[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdvertisementDetailScreen(
                        advertisement: ad,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(ad.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Column(
                            children: [
                              Text(
                                '31',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'OCAK\nSON',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          if (advertisements.length > 1)
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  advertisements.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index ? Colors.white : Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
