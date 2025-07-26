import 'package:flutter/material.dart';
import 'package:gusto/Cartpage.dart';
import 'package:gusto/provider_cart.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with TickerProviderStateMixin {
  late TabController _tabController;
  

 final List<Map<String, dynamic>> foodItems = [
  // Pizza 
  {
    'name': 'Margherita Pizza',
    'price': 60,
    'image': 'pictures/pizza.jpg',
    'category': 'Pizza',
  },
  {
    'name': 'Pepperoni Pizza',
    'price': 70,
    'image': 'pictures/pep_pizza.jpg',
    'category': 'Pizza',
  },
  {
    'name': 'Vegetarian Pizza',
    'price': 65,
    'image': 'pictures/veg_pizza.jpg',
    'category': 'Pizza',
  },
  {
    'name': 'BBQ Chicken Pizza',
    'price': 75,
    'image': 'pictures/BBQ_pizza.jpg',
    'category': 'Pizza',
  },

  // Burger 
  {
    'name': 'Beef Burger',
    'price': 45,
    'image': 'pictures/beef_burger.jpg',
    'category': 'Burger',
  },
  {
    'name': 'Chicken Burger',
    'price': 40,
    'image': 'pictures/chicken_burger.jpg',
    'category': 'Burger',
  },
  {
    'name': 'Double Beef Burger',
    'price': 55,
    'image': 'pictures/double_burger.jpg',
    'category': 'Burger',
  },
  {
    'name': 'Mushroom Burger',
    'price': 50,
    'image': 'pictures/mashroom_burger.jpg',
    'category': 'Burger',
  },

  // Traditional 
  {
    'name': 'Egyptian Koshari',
    'price': 25,
    'image': 'pictures/Egyptian_Koshari.jpg',
    'category': 'Traditional',
  },
  {
    'name': 'Molokhia with Chicken',
    'price': 35,
    'image': 'pictures/mliukhaia.jpg',
    'category': 'Traditional',
  },
  {
    'name': 'Stuffed Vine Leaves',
    'price': 30,
    'image': 'pictures/mahshi.jpg',
    'category': 'Traditional',
  },
  {
    'name': 'Grilled Kofta',
    'price': 50,
    'image': 'pictures/kufta.jpg',
    'category': 'Traditional',
  },

  // Sweets 
  {
    'name': 'Cheesecake',
    'price': 35,
    'image': 'pictures/cheece_cake.jpg',
    'category': 'Sweets',
  },
  {
    'name': 'Kunafa',
    'price': 25,
    'image': 'pictures/kunafa.jpg',
    'category': 'Sweets',
  },
  {
    'name': 'Chocolate Cake',
    'price': 40,
    'image': 'pictures/choco_cake.jpg',
    'category': 'Sweets',
  },
  {
    'name': 'Baklava',
    'price': 35,
    'image': 'pictures/Baklava.jpg',
    'category': 'Sweets',
  },

  // Drinks 
  {
    'name': 'Pepsi',
    'price': 20,
    'image': 'pictures/pepsi.jpg',
    'category': 'Drinks',
  },
  {
    'name': 'Sprite',
    'price': 20,
    'image': 'pictures/sprite.jpg',
    'category': 'Drinks',
  },
  {
    'name': 'Orange Juice',
    'price': 25,
    'image': 'pictures/orange_juice.jpg',
    'category': 'Drinks',
  },
  {
    'name': 'Mango Smoothie',
    'price': 30,
    'image': 'pictures/mango.jpg',
    'category': 'Drinks',
  },
];


  final List<String> categories = ['Pizza', 'Burger', 'Traditional', 'Sweets', 'Drinks'];

  @override
  void initState() {
    _tabController = TabController(length: categories.length, vsync: this);
    super.initState();
  }



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.orange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Row(
          children: [
            const Icon(Icons.restaurant_menu, color: Colors.white),
            const SizedBox(width: 10),
            const Text("Gusto Restaurant", style: TextStyle(color: Colors.white)),
            const Spacer(),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  },
                ),
                if (context.watch<CartProvider>().items.isNotEmpty)

                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${context.watch<CartProvider>().items.length}',
                        style: const TextStyle(color: Colors.deepOrange, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: categories.map((e) => Tab(text: e)).toList(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      backgroundColor: Colors.orange.shade50,
      body: TabBarView(
        controller: _tabController,
        children: categories.map((category) {
          final filteredItems =
              foodItems.where((item) => item['category'] == category).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredItems.length,
            itemBuilder: (context, index) {
              final item = filteredItems[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Column(
                  children: [
                    if ((item['image'] as String).isNotEmpty)
                      Image.asset(
                        item['image'],
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                    ListTile(
                      title: Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Price: ${item['price']} EGP'),
                      trailing: IconButton(
                        icon: const Icon(Icons.add_shopping_cart, color: Colors.deepOrange),
                        onPressed:(){
                           Provider.of<CartProvider>(context, listen: false).addItem(item);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${item['name']} added to cart')),
                            );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
