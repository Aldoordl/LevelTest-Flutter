import 'package:flutter/material.dart';
import 'package:ul_kelas11/components/button.dart';
import 'package:ul_kelas11/theme/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 15),

            // shop name
            Text(
              "SUSHI MAN", 
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 32,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 0),
            
            // icon
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Image.asset('lib/images/sushi.png'),
            ),

            const SizedBox(height: 0),

            // title
            Text(
              "THE TASTE OF JAPANESE FOOD", 
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 46,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            // subtitle
            Text(
              "Feel the taste of the most popular Japanese food from anywhere and anytime", 
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 15,
                height: 2,
              ),
            ),

            const SizedBox(height: 20),
            
            // get started button
            MyButton(
              text: "Get Started",
              onTap: () {
                // go to menu page
                Navigator.pushNamed(context, '/menupage');
              },
            )
          ]
        ),
      ),
    );
  }
}
