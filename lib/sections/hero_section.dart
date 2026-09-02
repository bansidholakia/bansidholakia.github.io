import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_role_text.dart';
import '../widgets/responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onAboutTap});

  final VoidCallback onAboutTap;

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final mobile = width < Breakpoints.mobile;
    return Container(
      constraints: BoxConstraints(minHeight: MediaQuery.sizeOf(context).height),
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(.65, -.65),
          radius: 1.15,
          colors: [Color(0xFF252127), AppColors.background],
          stops: [.0, .62],
        ),
      ),
      child: ContentWidth(
        child: Padding(
          padding: EdgeInsets.only(top: mobile ? 130 : 170, bottom: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '❤️  ${PortfolioData.greeting}  👋🏻',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.7,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                "I'm ${PortfolioData.name}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: mobile ? 46 : 72,
                  height: 1,
                  letterSpacing: -2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 24),
              const AnimatedRoleText(roles: PortfolioData.roles),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: const Text(
                  PortfolioData.heroLine,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 17,
                    height: 1.7,
                  ),
                ),
              ),
              const SizedBox(height: 36),
              OutlinedButton.icon(
                onPressed: onAboutTap,
                icon: const Icon(Icons.keyboard_arrow_down),
                label: const Text('MORE ABOUT ME'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.text,
                  side: const BorderSide(color: Color(0xFF52525B)),
                  padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 52),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                children: [
                  IconButton(
                    tooltip: 'GitHub',
                    onPressed: () => _open(PortfolioData.github),
                    icon: const FaIcon(FontAwesomeIcons.github),
                  ),
                  IconButton(
                    tooltip: 'LinkedIn',
                    onPressed: () => _open(PortfolioData.linkedin),
                    icon: const FaIcon(FontAwesomeIcons.linkedinIn),
                  ),
                  IconButton(
                    tooltip: 'Email',
                    onPressed: () => _open('mailto:${PortfolioData.email}'),
                    icon: const Icon(Icons.mail_outline),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
