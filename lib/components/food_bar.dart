import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ul_kelas11/models/food.dart';

class FoodBar extends StatefulWidget {
  final Food food;
  final VoidCallback onTap;

  const FoodBar({required this.food, required this.onTap, Key? key}) : super(key: key);

  @override
  _FoodBarState createState() => _FoodBarState();
}

class _FoodBarState extends State<FoodBar> {
  bool isFavorited = false;

  void toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(20),
        ),
        width: double.infinity, // Set width to fill the available space
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Image
                Image.asset(
                  widget.food.imagePath,
                  height: 60,
                ),
                const SizedBox(width: 20),
                // Name and price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      widget.food.name,
                      style: GoogleFonts.dmSerifDisplay(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    // Price
                    Text(
                      '\$${widget.food.price}',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ],
            ),
            // Heart icon
            GestureDetector(
              onTap: toggleFavorite,
              child: Icon(
                isFavorited ? Icons.favorite : Icons.favorite_outline,
                color: isFavorited ? Colors.red : Colors.grey,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
