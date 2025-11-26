import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BagItem {
  final String id;
  final String name;
  final String? imagePath;
  final DateTime addedAt;
  final String storeName;
  final String? size;
  final String? color;
  final int? quantity;
  final String? storeUrl;

  BagItem({
    required this.id,
    required this.name,
    this.imagePath,
    required this.addedAt,
    required this.storeName,
    this.size,
    this.color,
    this.quantity,
    this.storeUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'addedAt': addedAt.toIso8601String(),
      'storeName': storeName,
      'size': size,
      'color': color,
      'quantity': quantity,
      'storeUrl': storeUrl,
    };
  }

  factory BagItem.fromJson(Map<String, dynamic> json) {
    return BagItem(
      id: json['id'],
      name: json['name'],
      imagePath: json['imagePath'],
      addedAt: DateTime.parse(json['addedAt']),
      storeName: json['storeName'],
      size: json['size'],
      color: json['color'],
      quantity: json['quantity'],
      storeUrl: json['storeUrl'],
    );
  }

  BagItem copyWith({
    String? id,
    String? name,
    String? imagePath,
    DateTime? addedAt,
    String? storeName,
    String? size,
    String? color,
    int? quantity,
    String? storeUrl,
  }) {
    return BagItem(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      addedAt: addedAt ?? this.addedAt,
      storeName: storeName ?? this.storeName,
      size: size ?? this.size,
      color: color ?? this.color,
      quantity: quantity ?? this.quantity,
      storeUrl: storeUrl ?? this.storeUrl,
    );
  }
}

class BagService with ChangeNotifier {
  List<BagItem> _bagItems = [];
  static const String _bagKey = 'bag_items';

  List<BagItem> get bagItems => _bagItems;

  int get itemCount => _bagItems.length;

  BagService() {
    _loadBagItems();
  }

  Future<void> _loadBagItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bagData = prefs.getString(_bagKey);

      if (bagData != null) {
        final List<dynamic> jsonList = json.decode(bagData);
        _bagItems = jsonList.map((json) => BagItem.fromJson(json)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error loading bag items: $e');
    }
  }

  Future<void> _saveBagItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = _bagItems.map((item) => item.toJson()).toList();
      await prefs.setString(_bagKey, json.encode(jsonList));
    } catch (e) {
      print('Error saving bag items: $e');
    }
  }

  Future<void> addToBag({
    required String name,
    String? imagePath,
    String storeName = 'Store',
    String? size,
    String? color,
    int? quantity,
    String? storeUrl,
  }) async {
    try {
      final bagItem = BagItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        imagePath: imagePath,
        addedAt: DateTime.now(),
        storeName: storeName,
        size: size,
        color: color,
        quantity: quantity,
        storeUrl: storeUrl,
      );

      _bagItems.add(bagItem);
      await _saveBagItems();
      notifyListeners();
    } catch (e) {
      print('Error adding to bag: $e');
      rethrow;
    }
  }

  Future<void> removeFromBag(String itemId) async {
    try {
      _bagItems.removeWhere((item) => item.id == itemId);
      await _saveBagItems();
      notifyListeners();
    } catch (e) {
      print('Error removing from bag: $e');
      rethrow;
    }
  }

  Future<void> updateQuantity(String itemId, int newQuantity) async {
    try {
      final index = _bagItems.indexWhere((item) => item.id == itemId);
      if (index != -1) {
        _bagItems[index] = _bagItems[index].copyWith(quantity: newQuantity);
        await _saveBagItems();
        notifyListeners();
      }
    } catch (e) {
      print('Error updating quantity: $e');
      rethrow;
    }
  }

  Future<void> clearBag() async {
    try {
      _bagItems.clear();
      await _saveBagItems();
      notifyListeners();
    } catch (e) {
      print('Error clearing bag: $e');
      rethrow;
    }
  }

  bool isImageFile(String? path) {
    if (path == null) return false;
    final file = File(path);
    return file.existsSync();
  }

  Future<String?> getImagePath(String? path) async {
    if (path == null) return null;
    final file = File(path);
    if (file.existsSync()) {
      return path;
    }
    return null;
  }
}
