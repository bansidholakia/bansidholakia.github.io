import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AnimatedRoleText extends StatefulWidget {
  const AnimatedRoleText({super.key, required this.roles});

  final List<String> roles;

  @override
  State<AnimatedRoleText> createState() => _AnimatedRoleTextState();
}

class _AnimatedRoleTextState extends State<AnimatedRoleText> {
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 2100), (_) {
      if (!mounted || widget.roles.isEmpty) return;
      setState(() => _index = (_index + 1) % widget.roles.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.roles.isEmpty) return const SizedBox.shrink();
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 420),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, .25),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
      child: Text(
        widget.roles[_index],
        key: ValueKey(_index),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.text,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
