import 'package:flutter/material.dart';


class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

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
            // Placing the element on top-left of the screen
            top: 0,
            left: 0,
            // Defining element (img) properties
            child: Image.asset("assets/images/main_top.png",
                // Reducing image size
                width: size.width * 0.3),
          ),
          child,
        ],
      ),
    );
  }
}
