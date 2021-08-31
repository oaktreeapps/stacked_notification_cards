import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final AnimationController controller;
  final VoidCallback onTapShowLess;
  final double padding;
  final double spacing;
  final Widget showLess;
  final Widget title;
  final Widget clearAll;
  final VoidCallback onTapClearAll;
  final int notificationCount;

  const Header({
    Key? key,
    required this.controller,
    required this.onTapShowLess,
    required this.padding,
    required this.spacing,
    required this.title,
    required this.showLess,
    required this.clearAll,
    required this.onTapClearAll,
    required this.notificationCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Animation<double> opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.4, 0.6),
      ),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        padding,
        padding,
        padding,
        spacing,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title,
          Expanded(
            child: SizedBox(),
          ),
          GestureDetector(
            onTap: onTapShowLess,
            child: Visibility(
              visible: notificationCount > 1,
              child: Opacity(
                opacity: opacity.value,
                child: showLess,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTapClearAll,
            // padding: const EdgeInsets.all(8.0),
            child: Visibility(
              visible: notificationCount > 1,
              child: Opacity(
                opacity: opacity.value,
                child: clearAll,
              ),
            ),
          )
        ],
      ),
    );
  }
}
