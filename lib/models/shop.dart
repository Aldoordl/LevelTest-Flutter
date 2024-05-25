import 'package:flutter/material.dart';
import 'package:ul_kelas11/models/food.dart';
import 'package:ul_kelas11/data/food_data.dart'; // Import data foodMenu

class Shop extends ChangeNotifier {
  final List<Food> _foodMenu = foodMenuData; // Use imported data

  // Define popular foods
  final List<Food> _popularFoods = popularFoodsData; // Use imported data

  // customer cart
  final List<Food> _cart = [];

  // getter methods
  List<Food> get foodMenu => _foodMenu;
  List<Food> get cart => _cart;
  List<Food> get popularFoods => _popularFoods;

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // add to cart
  void addToCart(Food foodItem, int quantity) {
    for (int i = 0; i < quantity; i++) {
      _cart.add(foodItem);
    }
    notifyListeners();
  }

  // remove from cart
  void removeFromCart(Food food) {
    _cart.remove(food);
    notifyListeners();
  }
}
