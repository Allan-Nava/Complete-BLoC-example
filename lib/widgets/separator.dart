import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  final double height;
  const Separator(this.height);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}