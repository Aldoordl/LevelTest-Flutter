import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ul_kelas11/components/button.dart';
import 'package:ul_kelas11/components/food_bar.dart';
import 'package:ul_kelas11/components/food_tile.dart';
import 'package:ul_kelas11/models/shop.dart';
import 'package:ul_kelas11/pages/food_details_page.dart';
import 'package:ul_kelas11/theme/colors.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();

    // Simulate loading for 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void navigateToFoodDetails(int index) {
    final shop = context.read<Shop>();
    final foodMenu = shop.foodMenu;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsPage(
          food: foodMenu[index],
        ),
      ),
    );
  }

  void navigateToPFoodDetails(int index) {
    final shop = context.read<Shop>();
    final popularFoods = shop.popularFoods;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsPage(
          food: popularFoods[index],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shop = context.read<Shop>();
    final foodMenu = shop.foodMenu;
    final popularFoods = shop.popularFoods;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[50],
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Search here...",
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cartpage');
                },
                icon: const CircleAvatar(
                  backgroundImage: AssetImage('lib/images/profile.png'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fullscreen Banner
              SizedBox(
                height: 200,
                width: double.infinity,
                child: PageView(
                  children: [
                    Image.network(
                      'https://i0.wp.com/www.dafontfree.io/wp-content/uploads/2020/07/Anjelica-Bold-Script-Font-3.jpg?resize=1200%2C800&ssl=1',
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/sushi-ads-design-template-d184ab7b0c6c1911b6146cef17334202_screen.jpg?ts=1690988910',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Food Menu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "Food Menu",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _isLoading ? 3 : foodMenu.length,
                  itemBuilder: (context, index) => AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      final delay = index * 0.1;
                      final delayedAnimation = CurvedAnimation(
                        parent: _animationController,
                        curve: Interval(
                          delay,
                          1.0,
                          curve: Curves.easeInOut,
                        ),
                      );
                      return Transform.translate(
                        offset: Offset(
                          (1 - delayedAnimation.value) * 200,
                          0,
                        ),
                        child: Opacity(
                          opacity: delayedAnimation.value,
                          child: _isLoading
                              ? Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: 200,
                                    margin: const EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                )
                              : FoodTile(
                                  food: foodMenu[index],
                                  onTap: () => navigateToFoodDetails(index),
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 25),
              // Promo banner with animation and shimmer              
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, (1 - _animation.value) * -20),
                    child: Opacity(
                      opacity: _animation.value,
                      child: _isLoading
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 150,
                                margin: const EdgeInsets.symmetric(horizontal: 25),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 25),
                              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Promo message
                                      Text(
                                        'Get 32% Promo',
                                        style: GoogleFonts.dmSerifDisplay(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      // Redeem button
                                      MyButton(
                                        text: "Redeem",
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                  // Image
                                  Image.asset(
                                    'lib/images/salmon.png',
                                    height: 100,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 25),
              // Popular food list with animation and skeleton loading effect
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  "Popular Food",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _isLoading ? 3 : popularFoods.length,
                itemBuilder: (context, index) => AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    final delay = index * 0.1;
                    final delayedAnimation = CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(
                        delay,
                        1.0,
                        curve: Curves.easeInOut,
                      ),
                    );
                    return Transform.translate(
                      offset: Offset(
                        (1 - delayedAnimation.value) * 200,
                        0,
                      ),
                      child: Opacity(
                        opacity: delayedAnimation.value,
                        child: _isLoading
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: 100,
                                  margin: const EdgeInsets.only(bottom: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              )
                            : FoodBar(
                                food: popularFoods[index],
                                onTap: () => navigateToPFoodDetails(index),
                              ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
