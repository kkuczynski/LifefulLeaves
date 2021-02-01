import 'package:flutter/material.dart';

class TopFade extends StatelessWidget {
  final double height;
  const TopFade({
    this.height,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.white.withOpacity(0.01), Colors.white],
            ),
          ),
        ),
      ),
    );
  }
}
