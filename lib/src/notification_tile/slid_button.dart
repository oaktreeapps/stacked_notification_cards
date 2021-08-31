import 'package:flutter/material.dart';

typedef void OnTapSlidButton(BuildContext context);

/// This widget is shown when NotificationCard
/// is slide. Used to view or clear the notification.
class SlidButton extends StatelessWidget {
  final Color color;
  final double? leftCornerRadius;
  final double? rightCornerRadius;
  final List<BoxShadow>? shadow;
  final double height;
  final Widget child;
  final OnTapSlidButton onTapButton;
  final EdgeInsets padding;
  const SlidButton({
    Key? key,
    required this.color,
    this.leftCornerRadius,
    this.rightCornerRadius,
    required this.shadow,
    required this.height,
    required this.child,
    required this.onTapButton,
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
          onTap: () => onTapButton(context),
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
