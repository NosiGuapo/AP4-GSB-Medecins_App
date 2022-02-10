import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set up full w/h of our screen
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        // Placing image in the middle of the screen
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            child: Image.asset(
                "assets/images/main_top.png",
                width: size.width * 0.3
            ),
          ),
        ],
      ),
    );
  }
}
