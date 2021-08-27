import 'package:flutter/material.dart';

class StackedContainer extends StatelessWidget {
  final double horizontalPadding;
  final Color color;
  final AnimationController controller;
  final double height;
  final double offset;
  final Color shadeColor;
  final double cornerRadius;
  final List<BoxShadow>? shadow;

  const StackedContainer({
    Key? key,
    required this.horizontalPadding,
    required this.color,
    required this.controller,
    required this.height,
    required this.offset,
    required this.shadeColor,
    required this.cornerRadius,
    required this.shadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final opacity = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.2, 0.4),
      ),
    );
    return Opacity(
      opacity: opacity.value,
      child: Transform.translate(
        offset: Offset(0, offset),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: color,
                // border: Border.all(
                //   color: Color(0xFFDADADA),
                //   width: 1.4,
                // ),
                boxShadow: shadow,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(cornerRadius),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
              height: height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: shadeColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(cornerRadius),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
