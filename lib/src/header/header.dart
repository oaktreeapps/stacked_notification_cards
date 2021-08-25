import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final AnimationController controller;
  final VoidCallback onTapShowLess;
  final double padding;
  final double spacing;

  const Header({
    Key? key,
    required this.controller,
    required this.onTapShowLess,
    required this.padding,
    required this.spacing,
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
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Notifications',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          GestureDetector(
            onTap: onTapShowLess,
            child: Opacity(
              opacity: opacity.value,
              child: Text(
                'Show less',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Icon(Icons.close_rounded),
          // )
        ],
      ),
    );
  }
}
