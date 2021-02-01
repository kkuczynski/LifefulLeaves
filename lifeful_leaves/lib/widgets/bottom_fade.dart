import 'package:flutter/material.dart';

class BottomFade extends StatelessWidget {
  final double height;
  const BottomFade({
    this.height,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white.withOpacity(0.01), Colors.white],
            ),
          ),
        ),
      ),
    );
  }
}
