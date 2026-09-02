import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.dark = true,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final textColor = dark ? AppColors.text : const Color(0xFF18181B);
    final muted = dark ? AppColors.muted : const Color(0xFF71717A);
    return Column(
      children: [
        Text(
          eyebrow.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.accent,
            fontSize: 13,
            letterSpacing: 2.3,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 34,
            height: 1.15,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: TextStyle(color: muted, fontSize: 16, height: 1.7),
            ),
          ),
        ],
      ],
    );
  }
}
