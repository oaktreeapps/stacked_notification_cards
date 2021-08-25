import 'package:flutter/material.dart';

class WidgetStructure extends StatelessWidget {
  final Widget child;
  const WidgetStructure({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: child,
    ));
  }
}
