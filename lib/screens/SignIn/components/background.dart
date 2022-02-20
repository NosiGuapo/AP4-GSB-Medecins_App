import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget bg;

  const Background({
    Key? key,
    required this.bg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
                "assets/images/signin_bottom.png",
                width: size.width * 0.3),
          ),
          bg,
        ],
      ),
    );
  }
}
