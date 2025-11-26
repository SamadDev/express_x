import 'package:flutter/material.dart';
import 'package:x_express/core/config/network/network.dart' show Request;
import 'package:x_express/features/Advertisement/view/advertisement_detail.dart';
import 'dart:async';

class AdvertisementModel {
  final String id;
  final String title;
  final String image;
  final String type;
  final String? url;
  final String? description;

  AdvertisementModel({
    required this.id,
    required this.title,
    required this.image,
    required this.type,
    this.url,
    this.description,
  });

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) {
    return AdvertisementModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      image: json['image']?.toString() ?? json['image_url']?.toString() ?? '',
      type: json['type']?.toString() ?? 'image',
      url: json['url']?.toString(),
      description:
          json['description']?.toString() ?? json['content']?.toString(),
    );
  }
}

class Advertisement extends StatefulWidget {
  const Advertisement({super.key});

  @override
  State<Advertisement> createState() => _AdvertisementState();
}

class _AdvertisementState extends State<Advertisement> {
  List<AdvertisementModel> _advertisements = [];
  bool _isLoading = true;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _fetchAdvertisements();
  }

  Future<void> _fetchAdvertisements() async {
    try {
      final response = await Request.get('advertisements');
      if (response != null && response['data'] != null) {
        final List<dynamic> ads = response['data'];
        setState(() {
          _advertisements =
              ads.map((ad) => AdvertisementModel.fromJson(ad)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching advertisements: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox.shrink();
    }

    if (_advertisements.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 180,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _advertisements.length,
        itemBuilder: (context, index) {
          final ad = _advertisements[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AdvertisementDetailScreen(advertisement: ad),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(ad.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
