import 'package:flutter/material.dart';
import 'package:ul_kelas11/models/food.dart';
import 'package:ul_kelas11/models/shop.dart';
import 'package:ul_kelas11/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:ul_kelas11/components/button.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final shop = context.read<Shop>();
    final cart = shop.cart;

    // Calculate total price
    double totalPrice = 0;
    for (var food in cart) {
      totalPrice += double.parse(food.price);
    }

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text("Checkout", style: TextStyle(color: Colors.white)),
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final Food food = cart[index];
                final String foodName = food.name;
                final String foodPrice = food.price;

                return Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: ListTile(
                    title: Text(
                      foodName,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      foodPrice,
                      style: TextStyle(
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyButton(
              text: "Confirm Purchase",
              onTap: () {
                // Handle purchase confirmation logic
                shop.clearCart();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
