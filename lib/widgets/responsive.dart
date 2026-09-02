import 'package:flutter/material.dart';

abstract final class Breakpoints {
  static const double mobile = 700;
  static const double tablet = 1000;
  static const double contentMax = 1180;
}

class ContentWidth extends StatelessWidget {
  const ContentWidth({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontal = width < Breakpoints.mobile ? 22.0 : 40.0;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: Breakpoints.contentMax),
        child: Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: horizontal),
          child: child,
        ),
      ),
    );
  }
}
