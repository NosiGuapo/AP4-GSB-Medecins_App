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
          bg,
        ],
      ),
    );
  }
}
