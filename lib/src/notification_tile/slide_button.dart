import 'package:flutter/material.dart';

typedef void OnTapSlideButton(BuildContext context);

/// This widget is shown when [NotificationCard]
/// is slid. Used to view or clear the [NotificationCard].
class SlideButton extends StatelessWidget {
  final Color color;
  final double? leftCornerRadius;
  final double? rightCornerRadius;
  final List<BoxShadow>? boxShadow;
  final double height;
  final Widget child;
  final OnTapSlideButton onTap;
  final EdgeInsets padding;
  const SlideButton({
    Key? key,
    required this.color,
    this.leftCornerRadius,
    this.rightCornerRadius,
    required this.boxShadow,
    required this.height,
    required this.child,
    required this.onTap,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leftRadius = leftCornerRadius != null
        ? Radius.circular(leftCornerRadius!)
        : Radius.zero;
    final rightRadius = rightCornerRadius != null
        ? Radius.circular(rightCornerRadius!)
        : Radius.zero;
    return Expanded(
      flex: 1,
      child: SizedBox.expand(
        child: GestureDetector(
          onTap: () => onTap(context),
          child: Container(
            margin: padding,
            height: height,
            alignment: Alignment.center,
            child: child,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.horizontal(
                left: leftRadius,
                right: rightRadius,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
