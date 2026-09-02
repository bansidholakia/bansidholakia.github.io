import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive.dart';
import '../widgets/section_heading.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < Breakpoints.mobile;

    return ColoredBox(
      color: const Color(0xFFF8F8F8),
      child: ContentWidth(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 96),
          child: Column(
            children: [
              const SectionHeading(
                eyebrow: 'About',
                title: 'Let me introduce myself.',
                dark: false,
              ),
              const SizedBox(height: 58),
              Flex(
                direction: mobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 148,
                    height: 148,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.accent, Color(0xFF3F3F46)],
                      ),
                      border: Border.all(color: Colors.white, width: 6),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 30,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      PortfolioData.shortName,
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(width: mobile ? 0 : 54, height: mobile ? 34 : 0),
                  if (mobile)
                    const _AboutContent(centered: true)
                  else
                    const Expanded(child: _AboutContent(centered: false)),
                ],
              ),
              const SizedBox(height: 72),
              const Text(
                'KEY SKILLS',
                style: TextStyle(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  letterSpacing: 2.2,
                ),
              ),
              const SizedBox(height: 36),
              ...PortfolioData.skillGroups.map(
                (group) => Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: _SkillGroup(
                    title: group.title,
                    skills: group.skills,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  FilledButton(
                    onPressed: () => _open('mailto:${PortfolioData.email}'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF18181B),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 18,
                      ),
                    ),
                    child: const Text('HIRE ME', style: TextStyle(color: Colors.white),),
                  ),
                  /*OutlinedButton(
                    onPressed: () => _open(PortfolioData.resumeUrl),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF18181B),
                      side: const BorderSide(color: Color(0xFFD4D4D8)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 18,
                      ),
                    ),
                    child: const Text('DOWNLOAD RESUME'),
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent({required this.centered});

  final bool centered;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment:
            centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          const Text(
            PortfolioData.about,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Color(0xFF52525B),
              fontSize: 17,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            alignment: centered ? WrapAlignment.center : WrapAlignment.start,
            spacing: 8,
            runSpacing: 8,
            children: PortfolioData.hashtags
                .map(
                  (tag) => Text(
                    tag,
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 28),
          Wrap(
            alignment: WrapAlignment.start,
            direction: centered ? Axis.vertical : Axis.horizontal,
            spacing: 34,
            runSpacing: 18,
            children: const [
              _Fact(label: 'FULL NAME', value: PortfolioData.fullName),
              _Fact(label: 'EMAIL', value: PortfolioData.email),
              _Fact(label: 'LOCATION', value: PortfolioData.location),
            ],
          ),
        ],
      );
}

class _Fact extends StatelessWidget {
  const _Fact({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF18181B),
              fontWeight: FontWeight.w900,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(color: Color(0xFF71717A), fontSize: 14),
          ),
        ],
      );
}

class _SkillGroup extends StatelessWidget {
  const _SkillGroup({required this.title, required this.skills});

  final String title;
  final List<String> skills;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF313131),
              fontSize: 17,
              fontWeight: FontWeight.w800,
              letterSpacing: .2,
            ),
          ),
          const SizedBox(height: 22),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 18,
            runSpacing: 24,
            children: skills.map((skill) => _SkillLogo(skill)).toList(),
          ),
        ],
      );
}

class _SkillLogo extends StatelessWidget {
  const _SkillLogo(this.skill);

  final String skill;

  dynamic get _icon {
    final value = skill.toLowerCase();
    if (value.contains('kotlin')) return FontAwesomeIcons.android;
    if (value.contains('xcode')) return SimpleIcons.xcode;
    if (value.contains('dart') || value.contains('provider')) return FontAwesomeIcons.dartLang;
    if (value.contains('android studio')) return SimpleIcons.androidstudio;
    if (value.contains('android')) return FontAwesomeIcons.android;
    if (value.contains('ios')) return FontAwesomeIcons.apple;
    if (value.contains('react native')) return FontAwesomeIcons.react;
    if (value.contains('flutter') || value.contains('riverpod')) return FontAwesomeIcons.flutter;
    if (value.contains('firebase')) return FontAwesomeIcons.fire;
    if (value.contains('room') || value.contains('gson')) return Icons.storage_rounded;
    if (value.contains('room')) return FontAwesomeIcons.database;
    if (value.contains('mongodb')) return FontAwesomeIcons.leaf;
    if (value.contains('github copilot')) return SimpleIcons.githubcopilot;
    if (value.contains('github actions')) return SimpleIcons.githubactions;
    if (value.contains('github')) return SimpleIcons.github;
    if (value.contains('git')) return SimpleIcons.git;
    if (value.contains('figma')) return FontAwesomeIcons.figma;
    if (value.contains('clean architecture')) return FontAwesomeIcons.hexagonNodes;
    if (value.contains('oauth 2.0')) return FontAwesomeIcons.lock;
    if (value.contains('postman')) return SimpleIcons.postman;
    if (value.contains('retrofit') || value.contains('dio')) {
      return Icons.http_rounded;
    }
    if (value.contains('confluence')) return FontAwesomeIcons.confluence;
    if (value.contains('jira')) return SimpleIcons.jira;
    if (value.contains('bitbucket')) return SimpleIcons.bitbucket;
    if (value.contains('studio') || value.contains('code')) return FontAwesomeIcons.code;
    if (value.contains('graph') || value.contains('odata')) return Icons.hub_outlined;
    if (value.contains('compose') || value.contains('material')) return Icons.widgets_outlined;
    if (value.contains('architecture') || value == 'mvvm' || value == 'mvi') {
      return Icons.account_tree_rounded;
    }
    if (value.contains('coroutine') || value.contains('flow')) return Icons.sync_alt_rounded;
    if (value.contains('javascript')) return FontAwesomeIcons.squareJs;
    if (value.contains('java')) return FontAwesomeIcons.java;
    if (value.contains('swift')) return FontAwesomeIcons.swift;
    if (value.contains('typescript')) return FontAwesomeIcons.typescript;
    if (value.contains('node.js')) return FontAwesomeIcons.node;
    if (value.contains('bloc')) return FontAwesomeIcons.hexagon;
    if (value.contains('getx')) return SimpleIcons.getx;
    if (value.contains('gson')) return SimpleIcons.swagger;
    if (value.contains('sourcetree')) return SimpleIcons.sourcetree;
    if (value.contains('aws')) return FontAwesomeIcons.aws;
    if (value.contains('slack')) return FontAwesomeIcons.slack;
    if (value.contains('ci/cd')) return FontAwesomeIcons.arrowsSpin;


    return Icons.code_rounded;
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 102,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 58,
              height: 58,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE4E4E7)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 14,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
             // child: Icon(_icon, color: AppColors.accent, size: 30),
              child: buildIcon(_icon),
            ),
            const SizedBox(height: 9),
            Text(
              skill,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF52525B),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
          ],
        ),
      );
}

// Check the type and return the correct widget
Widget buildIcon(dynamic iconData) {
  if (iconData is IconData) {
    return Icon(iconData, color: AppColors.accent, size: 30);
  } else if (iconData is FaIconData) {
    return FaIcon(iconData, color: AppColors.accent, size: 30,);
  }
  return const SizedBox.shrink(); // Return empty widget if null or unknown
}
