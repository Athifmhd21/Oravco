import 'dart:convert';

import 'package:ecommerce/core/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends ChangeNotifier {
  List<ProductModel> products = [];
  bool isLoading = false;
  final Set<int> _favoriteIds = {};
  Set<int> get favoriteIds => _favoriteIds;

  Future<void> getProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products'),
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        products = data.map((item) => ProductModel.fromJson(item)).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> savedIds = prefs.getStringList('favorites') ?? [];

    _favoriteIds.clear();

    _favoriteIds.addAll(savedIds.map((id) => int.parse(id)));

    notifyListeners();
  }

  Future<void> toggleFavorite(int productId) async {
    final prefs = await SharedPreferences.getInstance();

    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }

    await prefs.setStringList(
      'favorites',
      _favoriteIds.map((e) => e.toString()).toList(),
    );

    notifyListeners();
  }

  bool isFavorite(int productId) {
    return _favoriteIds.contains(productId);
  }
}
