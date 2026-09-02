import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive.dart';
import '../widgets/section_heading.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: AppColors.background,
        child: ContentWidth(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 96),
            child: Column(
              children: [
                const SectionHeading(
                  eyebrow: 'Contact',
                  title: "I'd love to hear from you.",
                  subtitle: 'Have a role, project or product idea in mind? Reach out and let’s build something useful.',
                ),
                const SizedBox(height: 40),
                const Icon(Icons.mail_outline, color: AppColors.accent, size: 32),
                const SizedBox(height: 14),
                const Text('EMAIL ME AT', style: TextStyle(fontSize: 12, letterSpacing: 1.8, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => _open('mailto:${PortfolioData.email}'),
                  child: const Text(PortfolioData.email, style: TextStyle(color: AppColors.muted, fontSize: 16)),
                ),
                const SizedBox(height: 34),
                Wrap(
                  spacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    IconButton(onPressed: () => _open(PortfolioData.github), icon: const FaIcon(FontAwesomeIcons.github)),
                    IconButton(onPressed: () => _open(PortfolioData.linkedin), icon: const FaIcon(FontAwesomeIcons.linkedinIn)),
                  ],
                ),
                const SizedBox(height: 42),
                const Divider(),
                const SizedBox(height: 24),
                Wrap(
                  children: [
                    Text(
                      'Developed By ',
                      style: const TextStyle(color: AppColors.muted, fontSize: 13),
                    ),
                    Text(
                      '${PortfolioData.fullName} ',
                      style: const TextStyle(color: AppColors.accent, fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '© 2026 • Built with Flutter',
                      style: const TextStyle(color: AppColors.muted, fontSize: 13),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
