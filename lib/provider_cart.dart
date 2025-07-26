import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addItem(Map<String, dynamic> newItem) {
    
    final index = _items.indexWhere((item) => item['name'] == newItem['name']);

    if (index != -1) {
     
      _items[index]['quantity'] += 1;
    } else {
     
      final itemWithQuantity = Map<String, dynamic>.from(newItem);
      itemWithQuantity['quantity'] = 1;
      _items.add(itemWithQuantity);
    }

    notifyListeners();
  }

  void increaseQuantity(int index) {
    _items[index]['quantity'] += 1;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_items[index]['quantity'] > 1) {
      _items[index]['quantity'] -= 1;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  double get totalPrice {
    return _items.fold(
      0,
      (total, item) => total + (item['price'] * item['quantity']),
    );
  }

  bool get isEmpty => _items.isEmpty;

  int get count => _items.fold<int>(0, (total, item) => total + (item['quantity'] as int));

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
