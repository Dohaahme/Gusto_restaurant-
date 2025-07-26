import 'package:flutter/material.dart';
import 'package:gusto/provider_cart.dart';
import 'package:provider/provider.dart';


class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.shopping_cart, color: Colors.orange.shade50),
        title: Text('Shopping Cart', style: TextStyle(color: Colors.orange.shade50)),
        backgroundColor: Colors.deepOrange,
      ),
      backgroundColor: Colors.orange.shade50,
      body: cart.items.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 20, color: Colors.deepOrange),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: ListTile(
                          leading: item['image'] != null && item['image'].isNotEmpty
                              ? Image.asset(item['image'], width: 60, height: 60, fit: BoxFit.cover)
                              : const Icon(Icons.fastfood, size: 40, color: Colors.deepOrange),
                          title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Price: ${item['price']} EGP'),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => cart.decreaseQuantity(index),
                                    icon: const Icon(Icons.remove_circle_outline),
                                  ),
                                  Text('${item['quantity']}'),
                                  IconButton(
                                    onPressed: () => cart.increaseQuantity(index),
                                    icon: const Icon(Icons.add_circle_outline),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Total: ${cart.totalPrice.toStringAsFixed(0)} EGP',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.end,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Order has been placed!')),
                          );
                          
                        },
                        icon: const Icon(Icons.check_circle, color: Colors.white),
                        label: const Text(
                          'Place Order',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
